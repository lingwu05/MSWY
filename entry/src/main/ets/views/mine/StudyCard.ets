@Preview
@Component
export struct StudyCard {
  @State title: string = '标题'
  @Builder defaultCardBuild() {}
  @BuilderParam studyCardBuilder: () => void = this.defaultCardBuild

  build() {
    Column() {
      Text(this.title)
        .width('100%')
      this.studyCardBuilder()
      Row({space: 30}) {
        Row({space: 3}) {
          Column() {}
          .width(6)
          .aspectRatio(1)
          .borderRadius(3)
          .backgroundColor('#90D8C8')
          Text('已学占比')
            .font({
              family: 'PingFang SC',
              size: 9.6,
              weight: 400
            })
            .fontColor('#6F6F6F')
        }
        Row({space: 2}) {
          Column() {}
          .width(6)
          .aspectRatio(1)
          .borderRadius(3)
          .backgroundColor('#C3C3C5')
          Text('未学占比')
            .font({
              family: 'PingFang SC',
              size: 9.6,
              weight: 400
            })
            .fontColor('#C3C3C5')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
  }
}