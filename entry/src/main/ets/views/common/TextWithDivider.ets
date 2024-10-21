@Preview
@Component
export struct TextWithDivider {
  @State text: string = '测试文本'
  @State tcolor: string = '#34404A'
  @State dcolor: string = '#666'
  @State space: number = 5

  build() {
    Stack() {
      Text(this.text)
        .margin({
          bottom: this.space
        })
      Divider().strokeWidth(2).color('#666').width('10%')
    }
    .alignContent(Alignment.Bottom)
  }
}