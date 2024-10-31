import {Home, RouterParams} from './Home'
import {Interview} from './Interview'
import {Project} from './Project'
import {Mine} from './Mine'
import { User } from '../models'
import { router, window } from '@kit.ArkUI'

interface ITarBarItem {
  icon: Resource
  activeIcon: Resource
  name: string
}

// 初始化
PersistentStorage.persistProp<User>('user', {} as User)

@Entry
@Component
struct Index {
  @StorageProp('bottomHeight') bottomHeight: number = 0
  tarBarList: ITarBarItem[] = [
    {
      icon: $r('app.media.tabbar_home'),
      activeIcon: $r('app.media.tabbar_home_fill'),
      name: '首页'
    },
    {
      icon: $r('app.media.tabbar_project'),
      activeIcon: $r('app.media.tabbar_project_fill'),
      name: '项目'
    },
    {
      icon: $r('app.media.tabbar_interview'),
      activeIcon: $r('app.media.tabbar_interview_fill'),
      name: '面经'
    },
    {
      icon: $r('app.media.tabbar_mine'),
      activeIcon: $r('app.media.tabbar_mine_fill'),
      name: '我的'
    }
  ]

  @State currentTabBarIndex: number = 0

  @Builder tabBarBuild(item: ITarBarItem, index: number) {
    Column({space: 5}) {
      Image(this.currentTabBarIndex == index ? item.activeIcon : item.icon)
        .width(24)
        .aspectRatio(1)
      Text(item.name)
        .fontSize(12)
        .fontColor(this.currentTabBarIndex == index ? $r('app.color.black') : $r('app.color.common_gray_01'))
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  aboutToAppear(): void {
    const res = router.getParams() as RouterParams
    if (res) {
      this.currentTabBarIndex = res.index
    }
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      index: this.currentTabBarIndex
    }) {
      ForEach(this.tarBarList, (item: ITarBarItem, index) => {
        TabContent() {
          if (index == 0) {
            Home()
          }
          else if (index == 1) {
            Project()
          }
          else  if (index == 2) {
            Interview()
          }
          else {
            Mine()
          }
        }
        .tabBar(this.tabBarBuild(item, index))
      })
    }
    .height('100%')
    .width('100%')
    .onChange((index) => {
      this.currentTabBarIndex = index
    })
    .animationDuration(0)
    .scrollable(false)
    .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_border') })
    .margin({ bottom: this.bottomHeight })
  }
}