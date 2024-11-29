import { MyNavBar } from "../../common/components/MyNavBar"
import { audioDB, InterviewAudioItem } from "../../common/utils/AudioDB"
import { AudioItemComp } from "./AudioItemComp"
import { AudioPlayer } from "./AudioPlayer"
import { AudioRecordComp } from "./AudioRecordComp"
import { InputDialog } from "./InputDialog"

@Component
export struct AudioView {
  @State list: InterviewAudioItem[] = [{} as InterviewAudioItem, {} as InterviewAudioItem ]

  currentItem: InterviewAudioItem = {} as InterviewAudioItem

  dialog = new CustomDialogController({
    builder: InputDialog({
      name: this.currentItem.name,
      onSubmit: async (name) => {
        this.currentItem.name = name
        audioDB.update(this.currentItem)
        this.list = audioDB.getAllData()
        this.dialog.close()
      }
    }),
    customStyle: true,
    alignment: DialogAlignment.Center
  })

  @State isShow: boolean = false


  @Builder
  PlayerBuilder() {
    Column() {
      AudioPlayer({ item: this.currentItem })
    }
  }

  async aboutToAppear() {
    await audioDB.createStore()
    this.list = audioDB.getAllData()
  }


  @Builder
  ListItemSwiperBuilder(item: InterviewAudioItem) {
    Row() {
      Text('编辑')
        .actionButton($r('app.color.common_blue'))
        .onClick(() => {
          this.currentItem = item
          this.dialog.open()
        })
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
            .onClick(() => {
              this.currentItem = item
              this.isShow = true
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
    .bindContentCover($$this.isShow, this.PlayerBuilder())
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