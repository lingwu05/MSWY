import { http } from '../../common/utils/HttpRequest'
import { InterviewItem, InterviewPageParams, PageData, QuestionItem, QuestionPageParams, SortType } from '../../models'
import promptAction from '@ohos.promptAction'
import {ContentType } from '../../pages/OptionalPage'
import { QuestionItemComp } from '../../common/components/QuestionItemComp'
import { auth } from '../../common/utils/Index'
import { RouterOptions } from '@kit.ArkUI'
import { InterviewItemComp } from '../../common/components/InterviewItemComp'

@Component
export struct OptionalList {
  @Prop list: (InterviewItem | QuestionItem)[] = []
  @Prop questionBankType: ContentType = ContentType.Question
  @Prop optType: number
  @Prop sort: SortType = SortType.Default
  @State page: number = 1
  @Link isRefreshing: boolean
  @Prop isLoading: boolean = false
  @Prop isFinish: boolean = false
  @State activeIndex: number = 0
  @Prop keyword: string = ''

  scroller: Scroller = new Scroller()

  async getData() {
    if (this.keyword) {
      if (this.questionBankType == ContentType.Question) {
        return await http.request<PageData<QuestionItem>>({
          url: 'question/list',
          params: {
            questionBankType: ContentType.Question,
            keyword: this.keyword
          }
        })
      } else {
        return await http.request<PageData<InterviewItem>>({
          url: 'question/list',
          params: {
            questionBankType: ContentType.Interview,
            keyword: this.keyword
          }
        })
      }

    } else {
      if (this.questionBankType == ContentType.Question) {
        return await http.request<PageData<QuestionItem>>({
          url: 'question/opt/list',
          params: {
            optType: this.optType,
            questionBankType: ContentType.Question
          }
        })
      } else {
        return await http.request<PageData<InterviewItem>>({
          url: 'question/opt/list',
          params: {
            optType: this.optType,
            questionBankType: ContentType.Interview
          }
        })
      }

    }
  }

  @Builder loadingMoreBuilder() {
    ListItem() {
      if (this.isLoading) {
        Row({space: 5}) {
          LoadingProgress()
            .width(20)
          Text('正在加载...')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_03'))
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      else if (this.isFinish) {
        Row() {
          Text('没有更多了~')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_03'))
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
    }
    .height(80)
    .margin({bottom: 80})
  }

  async onLoad() {
    const res = await this.getData()
    for (let v of res.rows) {
      this.list.push(v)
    }
    this.isLoading = false
    if (this.page >= res.pageTotal) {
      this.isFinish = true
    } else {
      this.page++
    }
  }

  async onRefresh() {
    this.page = 1
    const res = await this.getData()
    this.list = res.rows
    this.isRefreshing = false
    // 下面代码是特殊情况处理
    // 若res.pageTotal == 1则需要在底部显示'没有更多的提示'
    // 其他情况则需要设置下一次加载的页码
    if (this.page >= res.pageTotal) {
      this.isFinish = true
    } else {
      this.isFinish = false
      this.page++
    }
    promptAction.showToast({ message: '更新成功' })
  }

  build() {
    Refresh({ refreshing: $$this.isRefreshing}) {
      List({
        scroller: this.scroller
      }) {
        ForEach(this.list, (item: InterviewItem | QuestionItem, index) => {
          ListItem() {
            if (this.questionBankType == ContentType.Question) {
              QuestionItemComp({item: item as QuestionItem})
                .onClick(() => {
                  auth.checkAuth({
                    url: '/pages/QuestionPage'.slice(1),
                    params: {
                      item: item as QuestionItem,
                      index: index,
                      list: this.list
                    } as QuestionPageParams
                  })
                })
            } else {
              InterviewItemComp({item: item as InterviewItem})
                .onClick(() => {
                  auth.checkAuth({
                    url: '/pages/InterviewPage'.slice(1),
                    params: {
                      item: item as InterviewItem,
                    } as InterviewPageParams
                  })
                })
            }
          }
        })
        this.loadingMoreBuilder()
      }
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_border'),
        startMargin: 16,
        endMargin: 16
      })
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .edgeEffect(EdgeEffect.None)
      .onReachEnd(() => {
        if (this.isLoading || this.isFinish || this.isRefreshing ) {
          return
        }
        this.isLoading = true
        this.onLoad()
      })
    }
    .width('100%')
    .height('100%')
    .onRefreshing(async () => {
      this.scroller.scrollTo({xOffset: 0, yOffset: 0})
      await this.onRefresh()
    })
  }
}