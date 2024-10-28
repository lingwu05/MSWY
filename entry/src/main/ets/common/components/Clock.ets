@Preview
@Component
export struct Clock {
  @Prop clockCount: number = 0
  build() {
    Row(){
      if (this.clockCount > 0) {
        Column(){
          Text('已连续打卡')
            .fontColor($r('app.color.black'))
            .fontSize(8)
          Text(){
            Span(this.clockCount.toString())
              .fontSize(12)
              .fontWeight(600)
            Span('天')
              .fontSize(10)
          }
          .fontColor($r('app.color.black'))
        }
        .margin({ left: 30})
      } else {
        Text('打卡')
          .fontColor($r('app.color.black'))
          .fontSize(18)
          .fontWeight(500)
          .margin({ left: 30, top: -4 })
      }
    }
    .width(74)
    .height(28)
    .backgroundImage(this.clockCount > 0 ? $r('app.media.ic_common_clocked') : $r('app.media.ic_common_unclock'))
    .backgroundImageSize(ImageSize.Contain)
  }
}
