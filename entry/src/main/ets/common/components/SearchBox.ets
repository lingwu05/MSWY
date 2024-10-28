@Preview
@Component
export struct SearchBox {
  @Prop boxWidth: number = 100
  @Prop boxHeight: number = 32
  @Prop ph: ResourceStr = '搜索题目'
  @Prop phColor: ResourceColor = $r('app.color.common_gray_02')
  @Prop bgColor: ResourceColor = $r('app.color.common_gray_border')
  @Prop layoutWeightValue: number = 0


  build() {
    Row({space: 4}) {
      Image($r('app.media.icon_public_search'))
        .fillColor(this.phColor)
        .width(14)
        .aspectRatio(1)
      Text(this.ph)
        .fontSize(14)
        .fontColor(this.phColor)
    }
    .width(this.boxWidth)
    .height(this.boxHeight)
    .borderRadius(this.boxHeight / 2)
    .backgroundColor(this.bgColor)
    .justifyContent(FlexAlign.Center)
    .layoutWeight(this.layoutWeightValue)
  }
}