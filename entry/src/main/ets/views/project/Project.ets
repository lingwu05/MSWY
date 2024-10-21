import { it } from "@ohos/hypium"

interface ProjectItem {
  title: string
  desc: string
  tags: string[]
  img: Resource
}

@Preview
@Component
export struct Project {
  @State projects: ProjectItem[] = [
    {
      title: '在线问医平台',
      desc: '以Vue3+TS实现医疗问诊项目的相关问题',
      tags: ['在线医疗', 'Vue3', 'TS'],
      img: $r('app.media.project01')
    },
    {
      title: '后台管理系统',
      desc: '以Vue2实现后台管理系统的相关问题',
      tags: ['人资项目', 'Vue2'],
      img: $r('app.media.project02')
    },
    {
      title: '混合开发',
      desc: '鸿蒙混合开发相关的问题集合',
      tags: ['Harmony', 'Hybird'],
      img: $r('app.media.project03')
    },
  ]

  @Builder projectItemBuilder(item: ProjectItem)
  {
    Row({space: 10}) {
      Image(item.img)
        .width(60)
        .height(80)

      Column({space: 5}) {
        Text(item.title)
          .fontSize(13)
          .fontWeight(700)
          .margin({top: 10})
        Text(item.desc)
          .fontSize(12)
          .fontColor('#666')
          .margin({
            bottom: 30
          })
        Row({ space: 5}) {
          ForEach(item.tags, (tag: string) => {
            Text(tag)
              .fontColor('#61bd97')
              .fontSize(10)
              .backgroundColor('#f2f3f2')
              .borderRadius(2)
              .height(20)
              .padding(5)
          })
        }
      }
      .width('100%')
      .height(100)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .borderWidth({
      top: 2
    })
    .borderColor('#f5f5f5')
    .justifyContent(FlexAlign.Start)
    .padding(20)
  }

  build() {
    Column() {
      Text('项目')
        .fontSize(20)
        .fontWeight(500)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          bottom: 10
        })

      List() {
        ForEach(this.projects, (p: ProjectItem) => {
          this.projectItemBuilder(p)
        })
      }
      Blank()
      Text('----------------其他项目正在赶来的路上----------------')
        .fontSize(12)
        .fontColor('#666')
        .margin({bottom: 40})
    }
    .width('100%')
    .height('100%')
  }
}