import { QuestionItemComp } from "../../common/components/QuestionItemComp"
import { http } from "../../common/utils/Index"
import { PageData, QuestionItem, QuestionListParams, SortType} from "../../models/index"
import { promptAction } from "@kit.ArkUI"

@Preview
@Component
export struct QuestionList {
  @Prop isRefreshing: boolean = false
  @Prop isLoading: boolean = false // 正在加载内容
  @Prop isFinish: boolean = false // 加载完成
  @Prop list: QuestionItem[] = []

  @Prop typeId: number = 0
  @Prop sort: SortType = SortType.Default
  @State page: number = 1

  getQuestionList(): Promise<PageData<QuestionItem>> {
    return http.request<PageData<QuestionItem>>({
      url: 'question/list',
      params: {
        type: this.typeId,
        questionBankType: 10,
        sort: this.sort,
        page: this.page,
        pageSize: 10
      } as QuestionListParams
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
  }

  async onLoad() {
    const res = await this.getQuestionList()
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
    const res = await this.getQuestionList()
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
      List() {
        ForEach(this.list, (item: QuestionItem) => {
          ListItem() {
            QuestionItemComp({item: item})
          }
        })
        this.loadingMoreBuilder()
      }
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
      .scrollBar(BarState.Off)
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_border'),
        startMargin: 16,
        endMargin: 16
      })
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
    .backgroundColor('#FFFFFF')
    .onRefreshing(async () => {
      await this.onRefresh()
    })

  }
}