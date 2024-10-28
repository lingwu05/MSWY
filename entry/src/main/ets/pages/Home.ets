import { Clock } from "../common/components/Clock"
import { SearchBox } from "../common/components/SearchBox"
import { http, requestClockIn } from "../common/utils/Index"
import { User } from "../models"
import {QuestionCategory} from '../views/home/QuestionCategory'

interface IHomeProjectItem {
  title: string
  desc: string
  img: Resource
  bcolor: string
  tcolor: string
}

@Preview
@Entry
@Component
export struct Home {
  @StorageProp('user') user: User = {} as User
  @State index: number = 0;
  @State hpItems: IHomeProjectItem[] = [
    {
      title: '鸿蒙Next',
      desc: '面试热门题单',
      img: $r('app.media.card01'),
      bcolor: '#68D5F6',
      tcolor: '#056BEE'
    },
    {
      title: '企业题库',
      desc: '2000+企业面试',
      img: $r('app.media.card02'),
      bcolor: '#F6EDDB',
      tcolor: '#F66A42'
    },
    {
      title: '程序员面试经典题库',
      desc: '独家授权',
      img: $r('app.media.card03'),
      bcolor: '#5FF077  ',
      tcolor: '#27DA11'
    },
    {
      title: '前端题库',
      desc: '面试热门题单',
      img: $r('app.media.card04'),
      bcolor: '#F8B185',
      tcolor: '#FE9545'
    },
  ]


  @Builder
  projectCardBuilder(item: IHomeProjectItem) {
    Column() {
      Text(item.title)
        .width(80)
        .fontColor('#FEFFFF')
        .fontSize(16)
        .margin({
          bottom: 5
        })
      Text(item.desc)
        .fontColor('#FEFFFF')
        .fontSize(12)
      Image(item.img)
        .width(40)
        .zIndex(1)
        .position({
          right: 0,
          bottom: 0
        })
    }
    .padding(10)
    .alignItems(HorizontalAlign.Start)
    .width(150)
    .height(100)
    .linearGradient({
      colors: [[item.bcolor, 0], [item.tcolor, 1]]
    })
    .borderRadius(8)
  }

  build() {
    Scroll() {
      Column() {
        // 搜索部分
        Row({ space: 16 }) {
          Image($r('app.media.ic_scan_code'))
            .width(24)
            .aspectRatio(1)
          SearchBox({layoutWeightValue: 1})
          Clock({clockCount: this.user.clockinNumbers})
            .onClick(() => {
              requestClockIn()
            })
        }
        .width('100%')
        .height(64)
        .backgroundColor($r('app.color.common_gray_bg'))
        .padding({left: $r('app.string.padding_normal'), right: $r('app.string.padding_normal')})

        // 项目轮播1
        Swiper() {
          ForEach([$r('app.media.banner_pj'), $r('app.media.banner_qa'), $r('app.media.banner_ai')], (item: Resource) => {
            Image(item)
              .width('100%')
              .aspectRatio(2.65)
              .objectFit(ImageFit.Fill)
          })
        }
        .indicator( // 设置圆点导航点样式
          new DotIndicator()
            .itemHeight(4)
            .selectedItemHeight(4)
            .color(Color.White)
            .selectedColor($r('app.color.white'))
            .bottom(4))
        .margin({ left: $r('app.string.padding_normal'), right: $r('app.string.padding_normal')})
        .autoPlay(true)


        // 每日一题
        Row() {
          Column({ space: 5 }) {
            Text('OCT')
              .fontColor('#FF2323')
              .fontSize(13)
            Text('21')
              .fontColor('#313131')
              .fontSize(20)
          }
          .zIndex(1)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .width(40)
          .height(60)
          .justifyContent(FlexAlign.Center)
          .position({
            left: 30,
            top: 5
          })
          .shadow({ radius: 10, color: Color.Gray })

          Column() {
            Text('每日一题')
              .width('50%')
              .margin({
                top: 10,
                bottom: 5
              })
              .fontSize(13)
            Text('ArtTS是否支持解构?')
              .width('50%')
              .fontWeight(700)
          }
          .width('90%')
          .height('70%')
          .backgroundColor('#EDECF2')
          .borderRadius(5)
        }
        .width('100%')
        .height(100)
        .justifyContent(FlexAlign.Center)

        // 热门题库
        Text('热门题库')
          .fontSize(20)
          .width('100%')
          .fontWeight(700)
          .margin({ left: 40, bottom: 5 })
        Scroll() {
          Row({ space: 10 }) {
            ForEach(this.hpItems, (item: IHomeProjectItem) => {
              this.projectCardBuilder(item)
            })
          }
          .margin({ left: 20, right: 20 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .margin({bottom: 10})

        // 题目区
        Column(){
          QuestionCategory()
        }
        .width('100%')
        .backgroundColor($r('app.color.white'))
      }
      .width('100%')
      .backgroundColor('#F3F4F6')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}