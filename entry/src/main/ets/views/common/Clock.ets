@Preview
@Component
export struct Clock {
  build() {
    Stack() {
      Image($r('app.media.unclock'))
        .width(70)
      Text('打卡')
        .position({
          right: 6,
          top: 6
        })
        .fontWeight(700)
    }
  }
}