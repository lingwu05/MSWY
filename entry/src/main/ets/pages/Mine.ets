import { promptAction, router } from "@kit.ArkUI"
import { Clock } from "../common/components/Clock"
import { auth } from "../common/utils/Auth"
import { formatTime } from "../common/utils/formatTime"
import { requestClockIn } from "../common/utils/Index"
import { User } from "../models"
import { OptionalRequestParams } from "./OptionalPage"

interface Item {
  img: Resource
  text: string
}

@Preview
@Entry
@Component
export struct Mine {
  @StorageProp('user') user: User = {} as User
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
        Text(formatTime(this.user.totalTime))
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
      Row({space: 10}) {
        Image(this.user.avatar || $r('app.media.ic_mine_avatar'))
          .alt($r('app.media.ic_mine_avatar'))
          .width(55)
          .aspectRatio(1)
          .borderRadius(55)
        // 是否登录
        if (this.user.token) {
          Column({ space: 4 }) {
            Text(this.user.nickName || this.user.username)
              .fontSize(18)
              .fontWeight(500)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Row({ space: 4 }) {
              Text('编辑信息')
                .fontSize(12)
                .fontColor($r('app.color.common_gray_01'))
              Image($r('app.media.ic_mine_edit'))
                .width(12)
                .aspectRatio(1)
                .fillColor($r('app.color.common_gray_01'))
            }
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        } else {
          Text('立即登录')
            .fontSize(18)
            .fontWeight(500)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
            .onClick(() => {
              router.pushUrl({
                url: '/pages/Login'.slice(1)
              })
            })
        }

        Clock({clockCount: this.user.clockinNumbers})
          .onClick(() => {
            requestClockIn()
          })
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
          Column() {
            this.funcBarBuilder(it.img, it.text)
          }
          .onClick(() => {
            if (it.text == '历史记录') {
              auth.checkAuth({
                url: '/pages/OptionalPage'.slice(1),
                params: {
                  optType: 3,
                  page: 1,
                  questionBankType: 10
                } as OptionalRequestParams
              })
            } else if (it.text == '我的收藏') {
              auth.checkAuth({
                url: '/pages/OptionalPage'.slice(1),
                params: {
                  optType: 2,
                  page: 1,
                  questionBankType: 10
                } as OptionalRequestParams
              })
            } else if (it.text == '我的点赞') {
              auth.checkAuth({
                url: '/pages/OptionalPage'.slice(1),
                params: {
                  optType: 1,
                  page: 1,
                  questionBankType: 10
                } as OptionalRequestParams
              })
            } else if (it.text == '累计学时') {
              auth.checkAuth({
                url: '/pages/StudyInfo'.slice(1)
              })
            }
          })
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
          Column() {
            this.settingBarBuilder(it.img, it.text)
          }
          .onClick(() => {
            if (it.text == '开发常用词') {
              auth.checkAuth({
                url: '/pages/DevWord'.slice(1)
              })
            } else if (it.text == '面试录音') {
              auth.checkAuth({
                url: '/pages/AudioPage'.slice(1)
              })
            } else if (it.text == '推荐分享') {

            } else if (it.text == '关于我们') {

            } else if (it.text == '设置') {
              auth.checkAuth({
                url: '/pages/Settings'.slice(1)
              })
            }
          })
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