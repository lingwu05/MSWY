import { componentSnapshot, promptAction } from "@kit.ArkUI"
import { image } from "@kit.ImageKit"
import { photoAccessHelper } from "@kit.MediaLibraryKit"
import { fileIo, fileUri } from "@kit.CoreFileKit"

@Preview
@CustomDialog
export struct ShareDialog {
  @Prop stem: string = '大厂面试题'
  @Prop qid: string = '123'
  @Prop username: string = '华为用户007'
  controller: CustomDialogController
  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_interview_logo'))
          .width(50)
          .aspectRatio(1)
        Row() {}.layoutWeight(1)
      }
      .padding({left: 16, top: 16})
      .margin({bottom: 10})


      Text('面试通，搞定企业面试题')
        .fontSize(18)
        .margin({bottom: 10})
        .width('100%')
        .padding({left: 16, right: 16})
      Divider()
        .strokeWidth(1)
        .color('#efefef')
        .margin({bottom: 10})
        .padding({left: 16, right: 16})
      Text(this.stem)
        .fontSize(16)
        .maxLines(2)
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        })
        .fontWeight(700)
        .margin({bottom: 20})
        .width('100%')
        .padding({left: 16, right: 16})

      QRCode(this.qid)
        .width(100)
        .aspectRatio(1)
        .margin({bottom: 20})
      Text('扫码查看答案')
        .fontSize(15)
      Blank()
        .layoutWeight(1)
      Row() {
        Text('分享来自: ' + this.username)
          .fontSize(15)
          .layoutWeight(1)
          .padding({left: 16})
        SaveButton({
          icon: SaveIconStyle.FULL_FILLED,
          text: SaveDescription.SAVE_IMAGE,
          buttonType: ButtonType.Normal
        })
          .fontColor($r('app.color.white'))
          .fontSize(14)
          .padding(12)
          .backgroundColor($r('app.color.common_main_color'))
          .onClick(async (_event, result) => {
            if (result === SaveButtonOnClickResult.SUCCESS) {
              // 进行截图
              const pixelMap = await componentSnapshot.get('share')
              // 图片数据
              const imagePacker = image.createImagePacker()
              const arrayBuffer = await imagePacker.packing(pixelMap, { format: 'image/jpeg', quality: 98 })
              // 存储图片
              const ctx = getContext(this)
              const imagePath = ctx.cacheDir + '/' + Date.now() + '.jpeg'
              const file = fileIo.openSync(imagePath, fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE)
              fileIo.writeSync(file.fd, arrayBuffer)
              fileIo.closeSync(file.fd)

              const uri = fileUri.getUriFromPath(imagePath)
              const phAccessHelper = photoAccessHelper.getPhotoAccessHelper(ctx)
              const assetChangeRequest = photoAccessHelper.MediaAssetChangeRequest.createImageAssetRequest(ctx, uri)
              await phAccessHelper.applyChanges(assetChangeRequest)
              this.controller.close()

              promptAction.showToast({ message: '保存成功' })
            }
          })
      }

    }
    .width('80%')
    .height(400)
    .backgroundColor('#ffffff')
    .borderRadius(5)
    .id('share')
  }
}