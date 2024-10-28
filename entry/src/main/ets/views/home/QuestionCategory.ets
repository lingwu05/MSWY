import { QuestionList } from './QuestionList'
import { QuestionType } from '../../models'
import { http, logger } from '../../common/utils/Index'
import { FilterButton } from './FilterButton'
import { HcSkeleton, HcSkeletonItem } from '../../common/components/Skeleton'
import { emitter } from '@kit.BasicServicesKit'
import { LOGIN_EVENT } from '../../constants'
import { promptAction } from '@kit.ArkUI'

interface FilterParam {
  index: number
  difficulty: number
  sortValue: number
}

@Preview
@Component
export struct QuestionCategory {
  @State questionTypeList: QuestionType[] = []
  @State activeIndex: number = 0
  @State isShow: boolean = false
  @State filterParam: FilterParam = {
    index: 0,
    difficulty: 0,
    sortValue: 0
  }

  // 加载
  @State loading: boolean = false

  aboutToAppear(): void {
    this.getQuestionTypeList()
    emitter.on(LOGIN_EVENT, () => {
      this.getQuestionTypeList()
      promptAction.showToast({message: '登录成功后刷新首页'})
    })
  }

  async getQuestionTypeList () {
    this.loading = true
    const res = await http.request<QuestionType[]>({ url: 'question/type' })
    this.questionTypeList = res
    this.loading = false
  }

  @Builder
  SkeletonBuilder() {
    HcSkeleton() {
      Column() {
        Row({ space: 16 }) {
          HcSkeletonItem({ widthValue: 60 })
          HcSkeletonItem({ widthValue: 100 })
          HcSkeletonItem({ widthValue: 80 })
          HcSkeletonItem({ widthValue: 40 })
        }
        .height(44)
        .width('100%')

        ForEach([1, 2, 3, 4, 5, 6], () => {
          Column({ space: 10 }) {
            HcSkeletonItem({ widthValue: '90%' })
            HcSkeletonItem({ widthValue: '45%' })
          }
          .height(80)
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
        })
      }
      .padding({ left: 16, right: 16 })
    }
  }

  @Builder
  tabBarBuilder(item: QuestionType, index: number) {
    Row() {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(item.name)
          .fontSize(15)
          .height(44)
          .fontColor(this.activeIndex === index ? $r('app.color.black'): $r('app.color.common_gray_01'))
        Text()
          .width(this.activeIndex === index ? 20 : 0)
          .height(2)
          .backgroundColor($r('app.color.black'))
          .animation({ duration: this.activeIndex === index ? 200 : 0 })
      }
      .padding({ left: index === 0 ? 16 : 0})

      if (item.displayNewestFlag === 1) {
        Image($r('app.media.ic_home_new'))
          .width(32)
          .height(14)
          .objectFit(ImageFit.Contain)
          .margin({ left: 4 })
      }
    }
    .padding({ right: this.questionTypeList.length === index + 1 ? 54 : 16 })
  }

  @Builder selectQuestionBuilder() {
    Column({space: 10}) {
      Row() {
        Text('重置')
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('app.color.common_gray_03'))
          .onClick(() => {
            this.filterParam = {
              index: 0,
              difficulty: 0,
              sortValue: 0
            }
          })
        Text('筛选题目')
          .fontSize(18)
          .fontWeight(500)
          .fontColor($r('app.color.black'))
          Text('完成')
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('app.color.common_main_color'))
          .onClick(()=>{
            this.isShow = false
            this.activeIndex = this.filterParam.index
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({bottom: 10})
      Text('题目排序')
        .fontSize(16)
        .width('100%')
      Row() {
        FilterButton({
          name: '默认',
          isSelect: this.filterParam.sortValue == 0,
        })
          .onClick(() => {
            this.filterParam.sortValue = 0
          })
        FilterButton({
          name: '浏览量',
          isSelect: this.filterParam.sortValue > 0,
          sortValue: this.filterParam.sortValue
        })
          .onClick(() => {
            if (this.filterParam.sortValue == 0) {
              this.filterParam.sortValue = 20
            }
            else if (this.filterParam.sortValue == 20) {
              this.filterParam.sortValue = 21
            }
            else if (this.filterParam.sortValue == 21) {
              this.filterParam.sortValue = 20
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({bottom: 10})
      Text('题目难度')
        .fontSize(16)
        .width('100%')
      Row() {
        ForEach(['全部', '简单', '中等', '困难'], (item: string, index) => {
          FilterButton({
            name: item,
            isSelect: index == this.filterParam.difficulty
          })
            .onClick(() => {
              this.filterParam.difficulty = index
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({bottom: 10})
      Text('选择阶段')
        .fontSize(16)
        .width('100%')
      Flex({wrap: FlexWrap.Wrap}) {
        ForEach(this.questionTypeList, (item: QuestionType, index) => {
          FilterButton({
            name: item.name,
            isNew: item.displayNewestFlag == 1 ? true : false,
            isSelect: index == this.filterParam.index
          })
            .onClick(() => {
              this.filterParam.index = index
            })
        })
      }

    }
    .width('100%')
    .padding($r('app.string.padding_normal'))
    .backgroundColor($r('app.color.white'))
  }

  build() {
    if (this.loading) {
      this.SkeletonBuilder()
    }
    else {
      Stack() {
        Tabs({index: this.activeIndex}) {
          ForEach(this.questionTypeList, (item: QuestionType, index) => {
            TabContent() {
              QuestionList({
                typeId: item.id,
                sort: this.filterParam.sortValue
              })
            }
            .tabBar(this.tabBarBuilder(item, index))
          })

        }
        .barMode(BarMode.Scrollable)
        .divider({
          strokeWidth: 0.5,
          color: $r('app.color.common_gray_border')
        })
        .barHeight(44)
        .onChange(i => this.activeIndex = i)
        .barBackgroundColor('#FFFFFF')
        .scrollable(false)

        Row() {
          Image($r('app.media.ic_home_filter'))
            .width(22)
            .height(44)
            .objectFit(ImageFit.Contain)
            .bindSheet($$this.isShow, this.selectQuestionBuilder(),
              {
                height: SheetSize.MEDIUM,
                showClose: false,
              })
            .onClick(() => {
              // 4.控制显示
              this.isShow = true
            })
        }
        .width(54)
        .height(40)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')
        .position({top: 0, right: 0})
      }
    }
  }
}