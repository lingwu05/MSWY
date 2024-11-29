import { MyNavBar } from "../../common/components/MyNavBar"
import { audioDB, InterviewAudioItem } from "../../common/utils/AudioDB"
import { AudioItemComp } from "./AudioItemComp"
import { AudioRecordComp } from "./AudioRecordComp"

@Component
export struct AudioView {
  @State list: InterviewAudioItem[] = [{} as InterviewAudioItem, {} as InterviewAudioItem ]

  async aboutToAppear() {
    await audioDB.createStore()

    this.list = audioDB.getAllData()
  }


  @Builder
  ListItemSwiperBuilder(item: InterviewAudioItem) {
    Row() {
      Text('编辑')
        .actionButton($r('app.color.common_blue'))
      Text('删除')
        .actionButton('#FF0033')
        .onClick(async () => {
          audioDB.delById(item.id!)
          this.list = audioDB.getAllData()
        })
    }
    .height('100%')
  }

  build() {
    Column() {
      MyNavBar({ title: '面试录音', showRightIcon: false })
      Column() {
        List() {
          ForEach(this.list, (item: InterviewAudioItem) => {
            ListItem() {
              AudioItemComp({
                item: item
              })
            }
            .swipeAction({
              end: this.ListItemSwiperBuilder(item)
            })
          })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)

      AudioRecordComp({
        onRecordEnd: (item: InterviewAudioItem) => {
          this.list.push(item)
          audioDB.add(item)
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}


@Extend(Text)
function actionButton(color: ResourceColor) {
  .width(80)
  .aspectRatio(1)
  .backgroundColor(color)
  .textAlign(TextAlign.Center)
  .fontColor('#fffff')
}