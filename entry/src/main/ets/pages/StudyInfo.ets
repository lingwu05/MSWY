import { MyNavBar } from '../common/components/MyNavBar';
import { formatTime, http } from '../common/utils/Index';
import { StudyCard } from '../views/mine/StudyCard';
import { promptAction } from '@kit.ArkUI';
import { ProgressBar } from '../common/components/ProgressBar';

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
            GridCol() {
              Column() {
                Row() {
                  Text(item.name)
                    .font({
                      family: 'PingFang SC',
                      size: 11,
                      weight: 400
                    })
                    .fontColor('#3C3E42')
                    .margin({bottom: 7.6})
                  Text((item.done > item.total ? 100 : ((item.done / item.total) * 100)) + '%')
                    .font({
                      family: 'PingFang SC',
                      size: 11,
                      weight: 400
                    })
                    .fontColor('#3C3E42')
                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width('100%')
                ProgressBar({barWidth: '100%', barLength: (item.done > item.total ? 100 : ((item.done / item.total) * 100)) + '%'})
              }
              .width('100%')
            }
            .width('50%')
          })
        }
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder projectCardBuilder() {
    Column() {
      GridRow({
        columns: 1,
        gutter: 20,
      }) {
        if (this.studyInfo.studyData.length > 1) {
          ForEach(this.studyInfo.studyData[1].list, (item: StudyItem, index) => {
            GridCol() {
              Column() {
                Row() {
                  Text(item.name)
                    .font({
                      family: 'PingFang SC',
                      size: 11,
                      weight: 400
                    })
                    .fontColor('#3C3E42')
                    .margin({bottom: 7.6})
                  Text(((item.done / item.total) * 100) + "%")
                    .font({
                      family: 'PingFang SC',
                      size: 11,
                      weight: 400
                    })
                    .fontColor('#3C3E42')
                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width('100%')
                ProgressBar({barColor: '#C7B5ED', barWidth: '100%', barLength: (item.done > item.total ? 100 : (item.done / item.total) * 100) + "%"})
              }
              .width('100%')
            }
            .width('50%')
          })
        }
      }
      .width('100%')
    }
    .width('100%')
  }

  @State totalStudyTime: number = 40

  build() {
    Column() {
      MyNavBar({title: '学习数据'})
        .width('100%')
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
            Text(formatTime(this.totalStudyTime))
              .font({
                family: 'DIN',
                size: 38.4,
                weight: 700
              })
              .fontColor('#41B8B1')
              .padding(0)
          }
          .width('100%')
          .alignItems(VerticalAlign.Bottom)
          .margin({bottom: 24})
          // 卡片信息
          if (this.studyInfo.studyData.length >= 1) {
            StudyCard({studyCardBuilder: () => { this.knowCardBuilder() }, title: this.studyInfo.studyData[0].type})
          }
          if (this.studyInfo.studyData.length >= 2) {
            StudyCard({studyCardBuilder: () => { this.projectCardBuilder()}, title: this.studyInfo.studyData[1].type})
          }
        }
        .width('100%')
        .padding({left: $r('app.string.padding_normal'), right: $r('app.string.padding_normal')})
        .justifyContent(FlexAlign.Start)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.study_time_bg'))
    .backgroundImageSize(ImageSize.Cover)
    .backgroundColor('#f6f7f9')
  }
}