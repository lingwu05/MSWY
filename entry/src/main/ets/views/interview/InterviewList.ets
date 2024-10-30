import { http } from '../../common/utils/HttpRequest'
import { InterviewItem, PageData, SortType } from '../../models'
import promptAction from '@ohos.promptAction'

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

  @Builder contentBuilder(item: InterviewItem) {
    Column({space: 10}) {
      Row() {
        Image(item.creatorAvatar)
          .width(35)
          .margin({right: 10})
        Column({space: 5}) {
          Text(item.stem)
            .fontSize(15)
            .fontWeight(600)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(2)
          Text(item.creatorName + ' . ' + item.createdAt)
            .fontSize(12)
            .fontColor('#9c9c9c')
        }
        .alignItems(HorizontalAlign.Start)
        Blank()
          .layoutWeight(1)
        Image($r('app.media.ic_interview_more'))
          .width(20)
      }
      .alignItems(VerticalAlign.Top)
      Text(item.content)
        .fontSize(13)
        .fontWeight(500)
        .textOverflow({overflow: TextOverflow.Ellipsis})
        .maxLines(2)
        .fontColor('#666')
      Row({space: 3}) {
        ForEach(['大厂', '面经'], (tag: string) => {
          Text(tag)
            .fontColor('#79bca4')
            .fontSize(12)
            .width(36)
            .height(20)
            .backgroundColor('#f3f4f6')
            .textAlign(TextAlign.Center)
            .borderRadius(4)
        })
      }
      .width('100%')
      Row() {
        Text('点赞 ' + item.likeCount + ' · 浏览 ' + item.views)
          .fontColor('#9c9c9c')
          .fontSize(12)
      }
      .width('100%')
    }
    .width('100%')
    .padding(10)
    .borderWidth({
      bottom: 1
    })
    .borderColor('#f6f6f6')
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
            this.contentBuilder(item)
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