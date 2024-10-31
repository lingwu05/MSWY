import { InterviewItem} from "../models"
import { InterviewList } from "../views/interview/InterviewList"

interface Person {
  name: string;
  age: number;
}

@Entry
@Component
export struct Interview {

  @State activeIndex: number = 0
  @State sort: number = 0
  @State isRefreshing: boolean = false

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


  @Builder tabBarBuilder(text: string, index: number) {
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
          this.sort = 0
        } else {
          this.sort = 30
        }
        this.activeIndex = index
        this.isRefreshing = true
      }
    })
  }

  build() {
    Column() {
      Row({space: 10}) {
        Text('面试无忧')
          .fontSize(22)
          .fontWeight(900)
        TextInput({placeholder: '请输入关键词'})
          .layoutWeight(1)
      }
      .width('100%')
      .padding({
        left:10, right: 10
      })
      Row({space: 10}) {
        this.tabBarBuilder('默认', 0)
        this.tabBarBuilder('推荐', 1)
      }
      .width('100%')
      .padding({left: 16, right: 16})
      .borderWidth({
        bottom: 0.5
      })
      .borderColor({
        bottom: $r('app.color.common_gray_border')
      })
      InterviewList({
        sort: this.sort,
        isRefreshing: this.isRefreshing
      })
    }
    .width('100%')
    .height('100%')
  }
}