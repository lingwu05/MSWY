import { promptAction, router } from '@kit.ArkUI'
import { abilityAccessCtrl, Permissions } from '@kit.AbilityKit'
import { AudioView } from '../views/mine/AudioView'

@Entry
@Component
struct AudioPage {
  permissions: Permissions[] = ['ohos.permission.MICROPHONE']
  confirmConfig: promptAction.ShowDialogOptions = {
    title: "温馨提示",
    message: "未授权使用麦克风将无法使用该面试录音功能，是否前往设置进行授权？",
    buttons: [
      { text: '离开', color: $r('app.color.common_gray_01') },
      { text: '去授权', color: '#000000' }
    ]
  }

  /** 请求权限 */
  async getPermission() {
    //   . requestPermissionsFromUser()
    const mgr = abilityAccessCtrl.createAtManager()
    const ctx = getContext(this)
    const res = await mgr.requestPermissionsFromUser(ctx, this.permissions)

    if (res.authResults[0] === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      return
    }

    // 第一次没有授权
    const res2 = await promptAction.showDialog(this.confirmConfig)
    // 用户选了离开, 没有选二次授权
    if (res2.index === 0) {
      router.back()
      return
    }

    const res3 = await mgr.requestPermissionOnSetting(ctx, this.permissions)
    if (res3[0] === abilityAccessCtrl.GrantStatus.PERMISSION_DENIED) {
      router.back()
    }

  }

  aboutToAppear(): void {
    this.getPermission()
  }

  build() {
    Column() {
      AudioView()
    }
  }
}