import { MyNavBar } from '../common/components/MyNavBar'
import { auth, UserStoreKey } from '../common/utils/Auth'
import { http } from '../common/utils/Index'
import { User } from '../models'
import { promptAction } from '@kit.ArkUI'
import { LoadingDialog } from '../common/components/LoadingDialog'
import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { fileIo } from '@kit.CoreFileKit'
import { FormData } from '@ohos/axios'

@Preview
@Entry
@Component
struct Profile {
  @StorageProp
  (UserStoreKey) user: User = {} as User
  dialog: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({ message: '更新中...' }),
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  build() {
    Column() {
      MyNavBar({title: '编辑资料', showRightIcon: false})
      List() {
        ListItem() {
          Row() {
            Text('头像')
            Image(this.user.avatar || $r('app.media.ic_mine_avatar'))
              .width(30)
              .aspectRatio(1)
              .onClick(async () => {
                const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions()
                photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE
                photoSelectOptions.maxSelectNumber = 1
                // 选择照片对象
                const photoPicker = new photoAccessHelper.PhotoViewPicker()
                const photoResult = await photoPicker.select(photoSelectOptions)
                const uri = photoResult.photoUris[0]

                this.dialog.open()
                // 2. 拷贝选择的图片到应用沙箱
                const file = fileIo.openSync(uri, fileIo.OpenMode.READ_ONLY)
                const filePath = getContext(this).cacheDir + '/' + file.name
                fileIo.copyFileSync(file.fd, filePath)
                fileIo.closeSync(file.fd)
                const formData = new FormData()
                formData.append('file', `internal://cache/${file.name}`)

                const url = await http.request<string>({
                  url: 'userInfo/avatar',
                  method: 'post',
                  data: formData,
                  headers: { 'Content-Type': 'multipart/form-data' },
                  context: getContext(this)
                })
                const user = await http.request<User>({ url: 'userInfo' })
                this.user.avatar = user.avatar
                auth.setUser(this.user)
                promptAction.showToast({ message: '更新头像成功' })
                this.dialog.close()
              })
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .height(50)
        }
        ListItem() {
          Row() {
            Text('昵称')
            TextInput({text: this.user.username})
              .backgroundColor(Color.Transparent)
              .textAlign(TextAlign.End)
              .height(60)
              .layoutWeight(1)
              .padding(0)
              .onChange((value) => {
                this.user.username = value
              })
              .onSubmit(async () => {
                await http.request<User, User>({
                  url: 'userInfo/profile',
                  method: 'post',
                  data: {
                    nickName: this.user.nickName
                  } as User
                })
                promptAction.showToast({ message: '更新昵称成功' })
                auth.setUser(this.user)
              })
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .height(50)

        }
      }
      .padding({
        left: 35,
        right: 35,
        top: 15,
        bottom: 15
      })
      .width('100%')
      .height('100%')
      .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_bg') })

    }
    .height('100%')
    .width('100%')
  }
}