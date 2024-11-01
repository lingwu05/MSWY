import { http } from '../../common/utils/HttpRequest'
import { InterviewItem, InterviewPageParams, PageData, SortType } from '../../models'
import promptAction from '@ohos.promptAction'
import { InterviewItemComp } from '../../common/components/InterviewItemComp'
import { auth } from '../../common/utils/Index'

@Component
export struct InterviewList {
  @State list: InterviewItem[] = []
  @Prop sort: SortType = SortType.Default
  @State page: number = 1
  @Link isRefreshing: boolean
  @Prop isLoading: boolean = false
  @Prop isFinish: boolean = false
  @State activeIndex: number = 0

  scroller: Scroller = new Scroller()

  async getData() {
    return await http.request<PageData<InterviewItem>>({
      url: 'question/list',
      params: {
        questionBankType: 9
      }
    })
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
    this.list.push(...res.rows)
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
        ForEach(this.list, (item: InterviewItem, index) => {
          ListItem() {
            InterviewItemComp({
              item: item
            })
              .onClick(() => {
                auth.checkAuth({
                  url: '/pages/InterviewPage'.slice(1),
                  params: {
                    item: item
                  } as InterviewPageParams
                })
              })
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