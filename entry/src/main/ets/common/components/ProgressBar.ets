@Preview
@Component
export struct ProgressBar {
  @Prop barWidth: number | string =  100
  @Prop barLength: string = '75%'
  @Prop barColor: string = '#7ee2cd'
  build() {
    Column() {
      Column().width(this.barLength).height(3).position({x: 0, y: 0}).backgroundColor(this.barColor).borderRadius(5)
    }
    .width('100%').height(3).borderRadius(5)
  }
}