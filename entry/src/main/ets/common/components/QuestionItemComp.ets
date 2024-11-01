import { QuestionItem, SortType} from '../../models/index'
import { auth } from '../utils/Index'
import { Tag } from './Tag'

@Preview
@Component
export struct QuestionItemComp {
  @Prop item: QuestionItem = {} as QuestionItem

  build() {
    Column({space: 10}) {
      Row({space: 5}) {
        Tag({difficulty: this.item.difficulty})
        Text(this.item.stem)
          .fontSize(15)
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontWeight(500)
      }
      RowSplit() {
        Text('点赞 ' + this.item.likeCount)
          .grayText(true)
        Text('浏览 ' + this.item.views)
          .grayText()

        if (this.item.readFlag == 1) {
          Text('已阅读')
            .grayText()

        }
      }
    }
    .width('100%')
    .padding({ left: $r('app.string.padding_normal'), right: $r('app.string.padding_normal') })
    .width('100%')
    .height(80)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
  }
}

@Extend(Text)
function grayText(isStart: boolean = false) {
  .fontSize(13)
    .fontColor($r('app.color.common_gray_01'))
    .padding({ left: isStart ? 0 : 12, right: 12 })
}