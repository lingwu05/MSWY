import { MyNavBar } from '../common/components/MyNavBar';
import { http } from '../common/utils/Index';
import { StudyCard } from '../views/mine/StudyCard';
import { promptAction } from '@kit.ArkUI';

interface StudyItem {
  id: string
  name: string
  total: number
  done: number
  undone: number
}

interface StudyData {
  type: string
  list: StudyItem[]
}

interface  ResStudyInfo {
  totalTime: number
  studyData: StudyData[]
}

@Entry
@Component
struct StudyInfo {
  aboutToAppear(): void {
    this.getData()
  }

  async getData() {
    this.studyInfo = await http.request<ResStudyInfo>({ url: 'studyInfo' })
    this.totalStudyTime = this.studyInfo.totalTime
  }

  @State studyInfo: ResStudyInfo = {
    totalTime: 0,
    studyData: []
  }

  @Builder knowCardBuilder() {
    Column() {
      GridRow({
        columns: 2,
        gutter: 20,
      }) {
        if (this.studyInfo.studyData.length > 0) {
          ForEach(this.studyInfo.studyData[0].list, (item: StudyItem, index) => {
            GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 }, offset: 0, order: 0 }) {
              Column() {
                Text(item.name)
              }
            }
          })
        }
      }
    }
    .width('100%')
  }

  @Builder projectCardBuilder() {

  }

  @State totalStudyTime: number = 40

  build() {
    Column() {
      MyNavBar({title: '学习数据'})
        .width('100%')
        .onClick(()=>{
          promptAction.showToast({message: JSON.stringify(this.studyInfo)})
        })
      Scroll() {
        Column() {
          // 头部信息
          Row({space: 5}) {
            Text('累计学习时长')
              .font({
                family: 'PingFang SC',
                size: 15,
                weight: 400,
              })
              .fontColor('#3e555f')
            Image($r('app.media.icon_my_time'))
              .width(12)
              .aspectRatio(1)
              .fillColor('#41B8B1')
          }
          .width('100%')
          .margin({bottom: 7})
          Row({space: 5}) {
            Text(this.totalStudyTime.toString())
              .font({
                family: 'DIN',
                size: 38.4,
                weight: 700
              })
              .fontColor('#41B8B1')
              .padding(0)
            Text('小时')
              .font({
                family: 'PingFang SC',
                size: 11.52,
                weight: 400
              })
              .fontColor('#41B8B1')
              .width('100%')
              .margin({bottom: 10})
          }
          .width('100%')
          .alignItems(VerticalAlign.Bottom)
          // 卡片信息
          StudyCard({studyCardBuilder: () => { this.knowCardBuilder() }})
          StudyCard({studyCardBuilder: () => { this.projectCardBuilder() }})
        }
        .width('100%')
        .height('100%')
        .padding({left: $r('app.string.padding_normal'), right: $r('app.string.padding_normal')})
      }
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.study_time_bg'))
  }
}