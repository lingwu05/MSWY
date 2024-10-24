import { Clock } from "../common/Clock"
import { SearchBar } from "../common/SearchBar"
import  {IQuestionItem, QuestionList} from "../views/home/QuestionList"

interface IHomeProjectItem {
  title: string
  desc: string
  img: Resource
  bcolor: string
  tcolor: string
}

interface ITagItem {
  name: string
  questionList: IQuestionItem[]
}

@Preview
@Entry
@Component
export struct Home {

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
  @State tagsList: ITagItem[] = [
    {
      name: 'ArtTS', questionList: [
      {
        title: '如何删除Record中的元素',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '如何删除Record中的元素',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '如何删除Record中的元素',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '如何删除Record中的元素',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '如何删除Record中的元素',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
    ]
    },
    {
      name: 'ArtUI', questionList: [
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
    ]
    },
    {
      name: 'JavaScript', questionList: [
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
    ]
    },
    {
      name: 'TypeScript', questionList: [
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
    ]
    },
    {
      name: 'Vue3', questionList: [
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
    ]
    },
    {
      name: 'Harmony Next混合开发', questionList: [
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
      {
        title: '你知道哪些提高ArtTS性能的写法',
        tag: '困难',
        likes: 9999,
        views: 10000
      },
    ]
    }
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

  @Builder
  tabBarBuilder(item: ITagItem, index: number) {
    Row() {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(item.name)
          .fontSize(15)
          .height(43)
          .fontColor(this.index === index ? Color.Black : Color.Gray)
        Text()
          .width(this.index === index ? 20 : 0)
          .height(2)
          .backgroundColor(Color.Black)
          .animation({ duration: this.index === index ? 300 : 0 })
      }
      .padding({ left: index === 0 ? 16 : 0})
    }
    .padding({ right: this.tagsList.length === index + 1 ? 54 : 16 })
  }

  build() {
    Scroll() {
      Column() {
        // 搜索部分
        Row({ space: 10 }) {
          Image($r('app.media.ic_scan_code'))
            .width(30)
          SearchBar()
          Clock()
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 10, bottom: 20 })

        // 项目轮播1
        Swiper() {
          Image($r('app.media.banner_pj'))
            .width('100%')
        }
        .indicator( // 设置圆点导航点样式
          new DotIndicator()
            .itemWidth(15)
            .itemHeight(5)
            .selectedItemWidth(20)
            .selectedItemHeight(5)
            .color(Color.White)
            .selectedColor('#F3F4F6')
            .bottom(5))
        .margin({ left: 20, right: 20 })


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
        Stack() {
          Tabs({index: $$this.index}) {
            ForEach(this.tagsList, (item: ITagItem, index) => {
              TabContent() {
                QuestionList()
              }
              .tabBar(this.tabBarBuilder(item, index))
            })
          }
          .barMode(BarMode.Scrollable)
          .divider({
            strokeWidth: 1,
            color: '#F8F8F8'
          })
          .height(720)
          .barHeight(40)
          .onChange(i => this.index = i)
          .barBackgroundColor('#FFFFFF')

          Row() {
            Image($r('app.media.ic_home_filter'))
              .width(22)
              .height(44)
              .objectFit(ImageFit.Contain)
          }
          .width(54)
          .height(40)
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#FFFFFF')
          .position({top: 0, right: 0})
        }
      }
      .width('100%')
      .backgroundColor('#F3F4F6')
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}