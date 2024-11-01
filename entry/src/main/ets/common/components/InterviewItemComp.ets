import { InterviewItem } from '../../models'

@Component
export struct InterviewItemComp {
  @Prop item: InterviewItem = { } as InterviewItem

  build() {
    Column({space: 10}) {
      Row() {
        Image(this.item.creatorAvatar)
          .width(35)
          .margin({right: 10})
        Column({space: 5}) {
          Text(this.item.stem)
            .fontSize(15)
            .fontWeight(600)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(2)
          Text(this.item.creatorName + ' . ' + this.item.createdAt)
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
      Text(this.item.content)
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
        Text('点赞 ' + this.item.likeCount + ' · 浏览 ' + this.item.views)
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
}