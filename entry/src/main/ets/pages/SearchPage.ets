import { searchHistory } from '../common/utils/SearchHistory';
import { LengthMetrics, promptAction, router } from '@kit.ArkUI';
import { OptionalList } from '../views/mine/OptionalList';
import { ContentType } from './OptionalPage';

@Entry
@Component
struct SearchPage {
  @State message: string = 'Hello World';
  @State activeIndex: number = 0
  @State keywordList: string[] = []
  @State inputText: string = ''
  @State isRefresh: boolean = false

  aboutToAppear(): void {
    this.keywordList = searchHistory.read('keyword')
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
        this.activeIndex = index
      }
    })
  }

  build() {
    Column() {
      Row({space: 10}) {
        TextInput({placeholder: '请输入关键词', text: $$this.inputText})
          .layoutWeight(1)
          .padding({left: 30})
          .onSubmit(() => {
            if (!this.keywordList.includes(this.inputText)) {
              this.keywordList.push(this.inputText)
            }
            // promptAction.showToast({message: JSON.stringify(this.keywordList)})
            searchHistory.update('keyword', this.keywordList)
          })
          .onChange(() => {
            this.isRefresh = true
          })
        Text('取消')
          .fontColor(Color.Black)
          .onClick(() => {
            router.back()
          })
        Image($r('app.media.icon_public_search'))
          .width(16)
          .aspectRatio(1)
          .zIndex(1)
          .position({x: 10, y: 12})
          .fillColor('#696e71')
      }
      .width('100%')
      .padding({left: 16, right: 16})
      .margin({bottom: 10})
      Row({space: 10}) {
        this.tabBarBuilder('试题', 0)
        this.tabBarBuilder('面经', 1)
      }
      .padding({left: 16, right: 16})
      .width('100%')
      Divider()
        .strokeWidth(0.5)
        .color($r('app.color.common_gray_border'))
      if (!this.inputText) {
        Row() {
          Text('搜索记录')
            .fontColor($r('app.color.common_gray_01'))
            .fontSize(15)
          Image($r('app.media.ic_common_delete'))
            .width(15)
            .height(15)
            .fillColor($r('app.color.common_gray_01'))
            .onClick(() => {
              this.keywordList = []
              searchHistory.delete('keyword')
            })
        }
        .padding(16)
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Flex({
          direction: FlexDirection.Row,
          wrap: FlexWrap.Wrap,
          justifyContent: FlexAlign.Start,
          space: {main:LengthMetrics.vp(10), cross:LengthMetrics.vp(10)}
        }) {
          ForEach(this.keywordList, (item: string, index) => {
            Text(item)
              .fontSize(13)
              .fontColor('#97989a')
              .backgroundColor('#f3f4f6')
              .padding({left: 10, right: 10})
              .height(30)
              .borderRadius(15)
              .onClick(() => {
                this.inputText = item
              })
          })
        }
        .padding({left: 16, right: 16})
      } else {
        OptionalList({
          isRefreshing: this.isRefresh,
          keyword: this.inputText,
          questionBankType: this.activeIndex == 0 ? ContentType.Question : ContentType.Interview
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}