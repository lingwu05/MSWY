import { router } from "@kit.ArkUI"
import { Clock } from "../common/Clock"

interface Item {
  img: Resource
  text: string
}

@Preview
@Component
export struct Me {
  @State barItems: Item[] = [
    {img: $r('app.media.ic_mine_history'), text: '历史记录'},
    {img: $r('app.media.ic_mine_collect'), text: '我的收藏'},
    {img: $r('app.media.ic_mine_like'), text: '我的点赞'},
    {img: $r('app.media.ic_mine_study'), text: '累计学时'},
  ]

  @State settingItems: Item[] = [
    {img: $r('app.media.ic_mine_notes'), text: '开发常用词'},
    {img: $r('app.media.ic_mine_file'), text: '面试录音'},
    {img: $r('app.media.ic_mine_invite'), text: '推荐分享'},
    {img: $r('app.media.ic_mine_info'), text: '关于我们'},
    {img: $r('app.media.ic_mine_setting'), text: '设置'},
  ]

  @Builder funcBarBuilder(img: Resource, text: string) {
    Column({space: 5}) {
      Image(img)
        .width(30)
      Text(text)
        .fontSize(12)
        .fontColor('#666')
        .zIndex(1)
      if (text == '累计学时') {
        Text('0 分钟 >')
          .zIndex(2)
          .position({
            bottom: -12,
            left: 5
          })
          .fontSize(10)
          .fontColor(Color.Gray)
      }
    }
    .margin({
      bottom: 10
    })
  }

  @Builder settingBarBuilder(img: Resource, text: string) {
    Row({space: 5}) {
      Image(img)
        .width(28)
      Text(text)
        .fontSize(12)
        .fontColor('#4e4e4e')
        .zIndex(1)
      Blank()
        .layoutWeight(1)
      Image($r('app.media.icon_my_arrow'))
        .width(20)
        .fillColor('#c2c2c2')
    }
  }

  build() {
    Column() {
      // 头部
      Row() {
        Row({space: 20}) {
          Image($r('app.media.ic_mine_dog'))
            .width(50)
            .height(50)
            .borderRadius(25)
          Text('立即登录')
            .fontSize(18)
            .fontWeight(700)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/Login'
              })
              console.log('121331123')
            })

        }

        Clock()
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({
        top: 40,
        bottom: 20
      })

      // 导航区
      Row() {
        ForEach(this.barItems, (it: Item) => {
          this.funcBarBuilder(it.img, it.text)
        })
      }
      .width('100%')
      .height(80)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({
        top: 20,
      })
      .borderRadius(10)

      // 设置列表
      Column() {
        ForEach(this.settingItems, (it: Item) => {
          this.settingBarBuilder(it.img, it.text)
        })
      }
      .width('100%')
      .height(250)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({
        top: 20,
        bottom: 20
      })
      .borderRadius(10)
      .padding({
        left: 10,
        right: 10
      })


    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Top,
      colors: [['#f3f4f6', 0.7], ['#ff8434', 1]]
    })
    .padding(10)
  }
}