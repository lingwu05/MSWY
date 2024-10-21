import {Home} from '../views/home/Index'
import {Interview} from '../views/interview/Index'
import {Project} from '../views/project/Index'
import {Me} from '../views/me/Index'


@Entry
@Component
struct Index {
  @State currentTabBarIndex: number = 0

  @Builder tabBarBuild(img: Resource, selectedImg: Resource, text: string, index: number) {
    Column() {
      Image(this.currentTabBarIndex == index ? selectedImg : img)
        .width(28)
      Text(text)
        .fontSize(10)
        .fontColor(this.currentTabBarIndex == index ? '#1f1f1f' : '#919193')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({
      barPosition: BarPosition.End
    }) {
      TabContent() {
        Home()
      }
      .tabBar(this.tabBarBuild($r('app.media.tabbar_home'), $r('app.media.tabbar_home_fill'), '首页', 0))

      TabContent() {
        Project()
      }
      .tabBar(this.tabBarBuild($r('app.media.tabbar_project'), $r('app.media.tabbar_project_fill'), '项目', 1))

      TabContent() {
        Interview()
      }
      .tabBar(this.tabBarBuild($r('app.media.tabbar_interview'), $r('app.media.tabbar_interview_fill'), '面经', 2))

      TabContent() {
        Me()
      }
      .tabBar(this.tabBarBuild($r('app.media.tabbar_mine'), $r('app.media.tabbar_mine_fill'), '我的', 3))

    }
    .height('100%')
    .width('100%')
    .onChange((index) => {
      this.currentTabBarIndex = index
    })
    .animationDuration(0)
    .scrollable(false)
  }
}