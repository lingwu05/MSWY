import { MyNavBar } from "../../common/components/MyNavBar"
import { InterviewAudioItem } from "../../common/utils/AudioDB"
import { AudioItemComp } from "./AudioItemComp"
import { AudioRecordComp } from "./AudioRecordComp"

@Component
export struct AudioView {
  @State list: InterviewAudioItem[] = [{} as InterviewAudioItem, {} as InterviewAudioItem ]

  build() {
    Column() {
      MyNavBar({ title: '面试录音', showRightIcon: false })
      Column() {
        List() {
          ForEach(this.list, (item: InterviewAudioItem) => {
            ListItem() {
              AudioItemComp({
                item: {
                  id: 1,
                  name: '2024年10月01日_10点10分10秒',
                  path: '/data/el/xxx',
                  user_id: '100',
                  duration: 10000,
                  size: 10000,
                  create_time: 10000
                }
              })
            }
          })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)

      AudioRecordComp()
    }
    .width('100%')
    .height('100%')
  }
}