import { router } from '@kit.ArkUI'

class MyTextTimerModifier implements ContentModifier<TextTimerConfiguration> {
  constructor() {}
  applyContent() : WrappedBuilder<[TextTimerConfiguration]>
  {
    return wrapBuilder(buildTextTimer)
  }
}

@Builder function buildTextTimer(config: TextTimerConfiguration) {
  Column() {
    Text((Math.max(config.count / 1000 - config.elapsedTime / 100,0)).toFixed(0) + 's')
      .fontSize(20)
      .fontColor($r('app.color.light_white'))
      .textAlign(TextAlign.Center)
      .width('100%')
  }
  .width(60)
  .height(30)
  .backgroundColor('#c8c4c1')
  .borderRadius(15)
  .justifyContent(FlexAlign.Center)
}

@Entry
@Component
struct Welcome {
  @State count: number = 2000
  @State myTimerModifier: MyTextTimerModifier = new MyTextTimerModifier()
  countDownTextTimerController: TextTimerController = new TextTimerController()

  onPageShow(): void {
    this.countDownTextTimerController.start()
    setTimeout(()=> {
      router.replaceUrl({
        url: 'pages/Index'
      })
    }, 2000)
  }

  build() {
    Column() {
      Row() {
        TextTimer({ isCountDown: true, count: this.count, controller: this.countDownTextTimerController })
          .contentModifier(this.myTimerModifier)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({
        right: 10,
        top: 10
      })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.boot'))
    .backgroundImageSize({ width: '100%', height: '100%' })
  }
}