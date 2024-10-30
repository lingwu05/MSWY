import { MyNavBar } from '../common/components/MyNavBar'
import { InterviewItem, QuestionItem } from '../models'
import { QuestionList } from '../views/home/QuestionList'
import { router } from '@kit.ArkUI'
import { http } from '../common/utils/Index'

export enum OptionalType {
  HistoryView = 1,
  Like,
  Collect
}

export enum ContentType {
  Interview = 9,
  Question = 10
}

export interface OptionalRequestParams {
  optType: OptionalType
  page: number
  questionBankType: ContentType
}

export interface OptionalResponseData {
  total: number
  pageTotal: number
  rows: (InterviewItem | QuestionItem)[]
}

@Entry
@Component
struct HistoryView {

  @State requestParam: OptionalRequestParams = {
    optType: OptionalType.Like,
    page: 1,
    questionBankType: ContentType.Question
  }
  @State title: string = ''
  @State activeIndex: number = 0

  aboutToAppear(): void {
    this.requestParam = router.getParams() as OptionalRequestParams
    switch (this.requestParam.optType) {
      case OptionalType.HistoryView: {
        this.title = '历史记录'
        break;
      }
      case OptionalType.Like: {
        this.title = '我的点赞'
        break;
      }
      case OptionalType.Collect: {
        this.title = '我的收藏'
        break;
      }
    }

  }

  @Builder
  tabBarBuilder(item: string, index: number) {
    Column() {
      Text(item)
        .fontSize(15)
        .height(44)
        .fontColor(this.activeIndex === index ? $r('app.color.black'): $r('app.color.common_gray_01'))
      Text()
        .width(this.activeIndex === index ? 20 : 0)
        .height(2)
        .backgroundColor($r('app.color.black'))
        .animation({ duration: this.activeIndex === index ? 200 : 0 })
    }
  }

  build() {
    Column() {
      MyNavBar({title: this.title })
      Tabs({index: this.activeIndex}) {
        ForEach(['试题', '面经'], (item: string, index) => {
          TabContent() {

          }
          .tabBar(this.tabBarBuilder(item, index))
        })

      }
      .barMode(BarMode.Scrollable)
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_border')
      })
      .barHeight(44)
      .onChange(i => this.activeIndex = i)
      .barBackgroundColor('#FFFFFF')
      .scrollable(false)
    }
    .height('100%')
    .width('100%')
  }
}