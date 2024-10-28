import { router } from '@kit.ArkUI'

@Preview
@Component
export struct MyNavBar {
  @Prop title: string = '默认标题'
  @Prop showBorder: boolean = false
  // 左边图标
  @Prop leftIcon: ResourceStr = $r('sys.media.ohos_ic_public_arrow_left')
  // 右边图标
  @Prop rightIcon: ResourceStr = $r('sys.media.ohos_ic_public_more')
  // 是否显示右边图标
  @Prop
  showRightIcon: boolean = true
  build() {
    Row() {
      Image(this.leftIcon)
        .width(24)
        .aspectRatio(1)
        .fillColor($r('app.color.black'))
        .onClick(() => router.back())
      Row() {
        if (this.title) {
          Text(this.title)
            .fontWeight(700)
            .textAlign(TextAlign.Center)
            .fontSize(18)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
        }
      }
      .height(56)
      .layoutWeight(1)
      if (this.showBorder) {
        Image(this.rightIcon)
          .width(24)
          .aspectRatio(1)
          .fillColor($r('app.color.black'))
      } else {
        Blank()
          .width(24)
      }
    }
    .width('100%')
    .padding({ left: $r('app.string.padding_normal'), right: $r('app.string.padding_normal')})
    .height(56)
    .border({
      width: { bottom: this.showBorder ? 0.5 : 0 },
      color: $r('app.color.common_gray_bg')
    })
  }
}