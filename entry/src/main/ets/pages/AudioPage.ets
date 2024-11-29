import { promptAction, router } from '@kit.ArkUI'
import { Permissions } from '@kit.AbilityKit'
import { permissionManager } from '../common/utils/PermissionManager'
import { AudioView } from '../views/mine/AudioView'

@Entry
@Component
struct AudioPage {
  permissions: Permissions[] = ['ohos.permission.MICROPHONE']

  // 请求权限
  async requestPermission() {
    try {
      await permissionManager.requestPermissions(this.permissions)
    } catch (error) {
      // 禁止的话引导用户打开设置页面开启权限
      // 如果禁止授权，先弹窗询问，用户点击按钮后打开设置页面
      promptAction.showDialog({
        alignment: DialogAlignment.Center,
        title: '温馨提示',
        message: '未授权使用麦克风将无法使用该面试录音功能，是否前往设置进行授权？',
        buttons: [
          {text: '取消', color: '#89939C'},
          {text: '去设置', color: '#0A59F7'}
        ]
      })
        .then((res) => {
          // 如果用户点击了设置
          if (res.index == 1) {
            permissionManager.openPermissionSettingsPage()
          } else {
            router.back()
          }
        })
    }
  }

  aboutToAppear(): void {
    this.requestPermission()
  }

  build() {
    Column() {
      AudioView()
    }
  }
}