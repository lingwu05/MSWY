import { abilityAccessCtrl, Permissions } from '@kit.AbilityKit';

class Permission {
  // 请求用户授权
  static async requestPermissions(permissions: Permissions[]) {
    const atManager = abilityAccessCtrl.createAtManager()
    const ctx = getContext()
    const result = await atManager.requestPermissionsFromUser(ctx, permissions)
    return result.authResults.every(result => result === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
  }

  // 打开权限设置
  static async openPermissionSetting(permissions: Permissions[]) {
    const atManager = abilityAccessCtrl.createAtManager()
    const ctx = getContext()
    const authResults = await atManager.requestPermissionOnSetting(ctx, permissions)
    return authResults.every(result => result === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
  }
}

export { Permission }