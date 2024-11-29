import { media } from '@kit.MediaKit'
import { fileIo } from '@kit.CoreFileKit'
import { logger } from '../common/utils/Logger'
import { promptAction, router } from '@kit.ArkUI'

import { abilityAccessCtrl, bundleManager, common, Permissions } from '@kit.AbilityKit';

class PermissionManager {
  // 检查是否授权
  checkPermissions(permissions: Permissions[]) {
    // 程序访问控制管理
    const atManager = abilityAccessCtrl.createAtManager();
    // 获取 bundle 信息
    const bundleInfo = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
    // 提取 tokenID 标识
    const tokenID = bundleInfo.appInfo.accessTokenId
    // 校验应用是否被授予权限
    const authResults = permissions.map((item) => atManager.checkAccessTokenSync(tokenID, item))
    // 返回是否已授权结果
    return authResults.every(v => v === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
  }
  // 动态申请授权（首次弹窗申请）
  async requestPermissions(permissions: Permissions[]) {
    // 程序访问控制管理
    const atManager = abilityAccessCtrl.createAtManager();
    // 拉起弹框请求用户授权
    const grantStatus = await atManager.requestPermissionsFromUser(getContext(), permissions)
    // 获取请求权限的结果
    const isAuth = grantStatus.authResults.every(v => v === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
    // 返回 Promise 授权结果
    return isAuth ? Promise.resolve(true) : Promise.reject(false)
  }

  // 打开系统设置的权限管理页（处理授权结果）
  openPermissionSettingsPage() {
    // 获取上下文
    const context = getContext() as common.UIAbilityContext
    // 获取包信息
    const bundleInfo = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
    // 打开系统设置页
    context.startAbility({
      bundleName: 'com.huawei.hmos.settings',
      abilityName: 'com.huawei.hmos.settings.MainAbility',
      uri: 'application_info_entry',
      parameters: {
        // 按照包名打开对应设置页
        pushParams: bundleInfo.name
      }
    })
  }
}

// 导出类的实例
export const permissionManager = new PermissionManager()

@Entry
@Component
struct TestPage {
  avRecorder?: media.AVRecorder
  fd?: number
  filePath?: string
  timer?: number
  @State maxAmplitude: number = 0
  avPlayer?: media.AVPlayer
  @State total: number = 0
  @State value: number = 0

  permissions: Permissions[] = ['ohos.permission.MICROPHONE']
  confirmConfig:  promptAction.ShowDialogOptions = {
    title: "温馨提示",
    message: "未授权使用麦克风将无法使用该面试录音功能，是否前往设置进行授权？",
    buttons: [
      { text: '离开', color: $r('app.color.common_gray_01') },
      { text: '去授权', color: $r('app.color.black') }
    ]
  }

  async getPermission () {
    try {
      // 第一请求授权
      const isOk = await permissionManager.requestPermissions(this.permissions)
      if (isOk) return
      // 弹窗提示
      const confirm = await promptAction.showDialog(this.confirmConfig)
      if (confirm.index === 1) {
        permissionManager.openPermissionSettingsPage()
      }
      router.back()
    } catch (e) {
      promptAction.showToast({ message: '未授权' })
      router.back()
    }
  }

  aboutToAppear(): void {
    this.getPermission()
  }

  // 开始音频录制
  async startRecord() {
    this.filePath = getContext().filesDir + '/' + Date.now() + '.m4a'
    const file = fileIo.openSync(this.filePath, fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE)
    this.fd = file.fd

    const config: media.AVRecorderConfig = {
      audioSourceType: media.AudioSourceType.AUDIO_SOURCE_TYPE_MIC,
      profile: {
        audioBitrate: 100000, // 音频比特率
        audioChannels: 1, // 音频声道数
        audioCodec: media.CodecMimeType.AUDIO_AAC, // 音频编码格式，当前只支持aac
        audioSampleRate: 48000, // 音频采样率
        fileFormat: media.ContainerFormatType.CFT_MPEG_4A, // 封装格式，当前只支持m4a
      },
      url: `fd://${file.fd}`
    }

    const avRecorder = await media.createAVRecorder()
    await avRecorder.prepare(config)
    await avRecorder.start()
    this.avRecorder = avRecorder

    this.timer = setInterval(async () => {
      this.maxAmplitude = await avRecorder.getAudioCapturerMaxAmplitude()
      logger.debug('startRecord', this.maxAmplitude.toString())
    }, 100)
  }

  async stopRecord() {
    if (this.avRecorder) {
      clearInterval(this.timer)
      await this.avRecorder.stop()
      await this.avRecorder.release()
      fileIo.closeSync(this.fd)
    }
  }

  async startPlay() {
    try {
      const file = fileIo.openSync(this.filePath, fileIo.OpenMode.READ_ONLY)
      const avPlayer = await media.createAVPlayer()
      avPlayer.on('stateChange', state => {
        if (state === 'initialized') {
          avPlayer.prepare()
        } else if ( state === 'prepared') {
          avPlayer.loop = true
          this.total = avPlayer.duration
          avPlayer.play()
        }
      })
      // 当前播放时间改变
      avPlayer.on('timeUpdate', (time) => {
        this.value = time
      })
      avPlayer.url = `fd://${file.fd}`
      this.avPlayer = avPlayer
    } catch (e) {
      logger.error('startPlay', JSON.stringify(e))
    }
  }

  stopPlay() {
    if (this.avPlayer) {
      this.avPlayer.stop()
      this.avPlayer.release()
    }
  }


  build() {
    Column() {
      AudioBoComp({ maxAmplitude: this.maxAmplitude })
      Button('开始录音')
        .onClick(() => {
          this.startRecord()
        })
      Button('结束录音')
        .onClick(() => {
          this.stopRecord()
        })
      Button('开始播放')
        .onClick(() => {
          this.startPlay()
        })
      Button('停止播放')
        .onClick(() => {
          this.stopPlay()
        })
      Progress({ total: this.total, value: this.value })
        .width('100%')
    }
  }
}

@Component
struct AudioBoComp {
  @Prop @Watch('onChange') maxAmplitude: number
  @State per: number = 0

  onChange() {
    animateTo({ duration: 100 }, () => {
      if (this.maxAmplitude < 500) {
        this.per = 0
      } else if (this.maxAmplitude > 30000) {
        this.per = 1
      } else {
        this.per = this.maxAmplitude / 30000
      }
    })
  }

  build() {
    Row({ space: 5 }) {
      ForEach(Array.from({ length: 30 }), () => {
        Column()
          .layoutWeight(1)
          .height(this.per * 100 * Math.random())
          .backgroundColor($r('app.color.common_blue'))
      })
    }
    .width('100%')
    .height(100)
  }
}