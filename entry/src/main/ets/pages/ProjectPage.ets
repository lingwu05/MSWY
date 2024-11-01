import { ProjectItem } from '../models'
import { QuestionList } from '../views/home/QuestionList'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct ProjectPage {
  @Prop item: ProjectItem = {} as ProjectItem
  @State sortValue: number = 0
  @State isRefresh: boolean = false

  aboutToAppear(): void {
    this.item = router.getParams() as ProjectItem
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Top }) {
        Image($r('app.media.project_bg'))
          .width('100%')
          .opacity(0.2)
        Column() {
          Row() {
            Image($r('app.media.ic_left_arrow'))
              .size({ width: 24, height: 24 })
              .fillColor(Color.White)
            Blank()
              .layoutWeight(1)

          }
          .height(56)
          .width('100%')

          Row({ space: 16 }) {
            Image(this.item.icon)
              .width(86)
              .height(114)
              .sharedTransition('标记', { duration: 300 })
            Column({ space: 16 }) {
              Text(this.item.name)
                .fontWeight(500)
                .fontColor(Color.White)
              Text(this.item.describeInfo)
                .fontSize(14)
                .fontColor(Color.White)
              Blank()
              Text('学习进度：10%')
                .fontColor('#979797')
                .fontSize(14)
            }
            .layoutWeight(1)
            .height(114)
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ top: 20 })
          .alignItems(VerticalAlign.Top)
          .width('100%')
        }
        .padding({ left: 16, right: 16 })
      }
      .height(210)

      Column() {
        Row({ space: 14 }) {
          Text('问题列表')
            .fontWeight(500)

          Row() {
            Text('浏览量')
              .fontSize(14)
              .fontColor(this.sortValue != 0 ? $r('app.color.common_main_color') : Color.Black)
            Column() {
              Image($r('sys.media.ohos_ic_public_arrow_up'))
                .size({ width: 12, height: 6 })
                .fillColor(this.sortValue === 20 ? $r('app.color.common_main_color') : Color.Black)
              Image($r('sys.media.ohos_ic_public_arrow_down'))
                .size({ width: 12, height: 6 })
                .fillColor(this.sortValue === 21 ? $r('app.color.common_main_color') : Color.Black)
            }
          }
          .onClick(() => {
            this.isRefresh = true
            if (this.sortValue == 0) {
              this.sortValue = 20
            }
            else if (this.sortValue == 20) {
              this.sortValue = 21
            }
            else if (this.sortValue == 21) {
              this.sortValue = 20
            }
          })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .height(44)
        .width('100%')
        .padding({ left: 16, right: 16 })
        .border({
          width: { bottom: 0.5 },
          color: '#e8e7ee'
        })

        Column() {
          QuestionList({
            typeId: this.item.id,
            isRefreshing: this.isRefresh
          })
        }
        .layoutWeight(1)
      }
      .layoutWeight(1)
      .backgroundColor(Color.White)
      .width('100%')
      .borderRadius({ topLeft: 16, topRight: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#5D2B05')
  }
}