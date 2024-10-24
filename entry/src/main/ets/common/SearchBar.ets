@Preview
@Component
export struct SearchBar {
  @State placeholder: string = '搜索题目'
  @State color: string = '#666'
  build() {
    Row({space: 3}) {
      Image($r('app.media.icon_public_search'))
        .fillColor(this.color)
        .width(15)
      Text(this.placeholder)
        .fontSize(15)
        .fontColor(this.color)
    }
    .width(200)
    .height(30)
    .borderRadius(15)
    .backgroundColor('#E8E7ED')
    .justifyContent(FlexAlign.Center)

  }
}