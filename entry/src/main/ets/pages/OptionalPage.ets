import { MyNavBar } from '../common/components/MyNavBar'
import { InterviewItem, QuestionItem } from '../models'
import { QuestionList } from '../views/home/QuestionList'
import { router } from '@kit.ArkUI'
import { http } from '../common/utils/Index'
import { InterviewList } from '../views/interview/InterviewList'
import { OptionalList } from '../views/mine/OptionalList'

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
  @State sort: number = 0
  @State isRefreshing: boolean = false

  private controller: TabsController = new TabsController();

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
  tabBarBuilder(text: string, index: number) {
    Column({space: 10}) {
      Text(text)
        .fontSize(15)
        .fontColor(this.activeIndex === index ? $r('app.color.black'): $r('app.color.common_gray_01'))
      Text()
        .width(this.activeIndex === index ? 20 : 0)
        .height(2)
        .backgroundColor($r('app.color.black'))
        .animation({ duration: this.activeIndex === index ? 200 : 0 })
    }
    .onClick(() => {
      if (this.activeIndex != index) {
        if (index === 0) {
          this.requestParam.questionBankType = ContentType.Question
        } else {
          this.requestParam.questionBankType = ContentType.Interview
        }
        this.activeIndex = index
        this.controller.changeIndex(index)
        this.isRefreshing = true
      }
    })
  }

  build() {
    Column() {
      MyNavBar({title: this.title })

      Row({space: 10}) {
        this.tabBarBuilder('试题', 0)
        this.tabBarBuilder('面经', 1)
      }
      .width('100%')
      .padding({left: 16, right: 16})
      .borderWidth({
        bottom: 0.5
      })
      .borderColor({
        bottom: $r('app.color.common_gray_border')
      })

      Tabs({index: this.activeIndex, controller: this.controller}) {
        ForEach(['试题', '面经'], (item: string, index) => {
          TabContent() {
            OptionalList({
              isRefreshing: this.isRefreshing,
              questionBankType: this.requestParam.questionBankType,
              optType: this.requestParam.optType,
            })
          }
        })
      }
      .barHeight(0)
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_border')
      })
      .onChange(i => this.activeIndex = i)
      .scrollable(false)
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }
}