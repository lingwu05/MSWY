@Component
export struct FilterButton {
  name: string = '测试按钮'
  isNew: boolean = false
  @Prop isSelect: boolean = false
  @Prop sortValue: number = 0

  build() {
    Button({buttonStyle: ButtonStyleMode.NORMAL}) {
      Row() {
        Text(this.name)
          .fontSize(12)
          .fontColor(this.isSelect ? $r('app.color.common_main_color') : $r('app.color.black'))
        if (this.isNew) {
          Image($r('app.media.ic_home_new'))
            .width(32)
            .height(14)
            .objectFit(ImageFit.Contain)
            .position({ right: -26, top: -10 })
        }
        if (this.sortValue > 0) {
          Column() {
            Image($r('sys.media.ohos_ic_public_arrow_up'))
              .size({ width: 12, height: 6 })
              .fillColor(this.sortValue === 20 ? $r('app.color.common_main_color') : Color.Black)
            Image($r('sys.media.ohos_ic_public_arrow_down'))
              .size({ width: 12, height: 6 })
              .fillColor(this.sortValue === 21 ? $r('app.color.common_main_color') : Color.Black)
          }
        }
      }
    }
    .height(30)
    .padding({ left: 10, right: 10 })
    .backgroundColor('#f3f4f6')
    .borderRadius(5)
    .margin({ top: 12, right: this.isNew ? 26 : 10 })
  }
}