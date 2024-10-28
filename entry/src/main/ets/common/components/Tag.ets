interface ITagInfo {
  text: string;
  color: ResourceColor;
}

const infoMap: Record<number, ITagInfo> = {
  1: { text: "简单", color: $r("app.color.common_green") },
  2: { text: "简单", color: $r("app.color.common_green") },
  3: { text: "一般", color: $r("app.color.common_blue") },
  4: { text: "一般", color: $r("app.color.common_blue") },
  5: { text: "困难", color: $r("app.color.common_main_color") },
};

@Preview
@Component
export struct Tag {
  @Prop text: string = ''
  @Prop difficulty: number = 1   // 1-2简单 3-4中等 5困难
  @Prop color: ResourceColor = ''
  build() {
    Text(this.text || infoMap[this.difficulty].text)
      .fontColor(this.color || infoMap[this.difficulty].color)
      .backgroundColor($r('app.color.common_gray_bg'))
      .textAlign(TextAlign.Center)
      .padding({left: $r('app.string.padding_small'), right: $r('app.string.padding_small')})
      .borderRadius(2)
      .fontSize(10)
      .height(18)
      .constraintSize({ minWidth: 34 })

  }
}