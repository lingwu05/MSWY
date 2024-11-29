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