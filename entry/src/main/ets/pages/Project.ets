import { Tag } from "../common/components/Index"
import { auth, http } from "../common/utils/Index"
import { ProjectItem, TagParams } from "../models"

@Component
@Entry
export struct Project {
  @State projects: ProjectItem[] = [] as ProjectItem[]

  @Builder projectItemBuilder(item: ProjectItem)
  {
    Row({space: 10}) {
      Image(item.icon)
        .width(60)
        .height(80)

      Column({space: 5}) {
        Text(item.name)
          .fontSize(13)
          .fontWeight(700)
          .margin({top: 10})
        Text(item.describeInfo)
          .fontSize(12)
          .fontColor('#666')
          .margin({
            bottom: 30
          })
        Row({ space: 5}) {
          ForEach(item.tags, (tag: TagParams) => {
            Tag({text: tag.tagName})
          })
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .borderWidth({
      top: 2
    })
    .borderColor('#f5f5f5')
    .justifyContent(FlexAlign.Start)
    .padding(20)
  }

  async aboutToAppear() {
    this.projects = await this.getProjectData()
  }

  async getProjectData() {
    return await http.request<ProjectItem[]>({
      url: 'question/type?type=items',
      params: {
        type: 'items'
      }
    })
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
          ListItem() {
            this.projectItemBuilder(p)
          }
          .onClick(() => {
            auth.checkAuth({
              url: '/pages/ProjectPage'.slice(1),
              params: p
            })
          })
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