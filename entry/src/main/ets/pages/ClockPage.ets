import { HmCalendar, HmCalendarSelectedDay } from '@ohmos/calendar'
import { MyNavBar } from '../common/components/MyNavBar'
import { http } from '../common/utils/Index'
import { promptAction } from '@kit.ArkUI'

interface DayBuilderParams {
  totalDays: number
  text: string
}

interface RequestParams {
  month: string
  year: string
}

interface Clockin {
  id: string
  createdAt: string
}

interface ClockinInfo {
  flag: boolean
  clockinNumbers: number
  totalClockinNumber: number
  clockins: Clockin[]
}

@Entry
@Component
struct ClockPage {
  aboutToAppear(): void {
    this.getData('')
  }

  async getData(month: string) {
    if (month) {
      const arr = month.split('-')
      this.clockinInfo = await http.request<ClockinInfo>({
        url: 'clockinInfo',
        method: 'get',
        params: {
          month: arr[1],
          year: arr[0]
        }
      })
    } else {
      this.clockinInfo = await http.request<ClockinInfo, RequestParams>({
        url: 'clockinInfo',
        method: 'get'
      })
    }
    this.selectedDays = this.clockinInfo.clockins.map(item => ({ date: item.createdAt } as HmCalendarSelectedDay))
  }

  @State clockinInfo: ClockinInfo = {
    flag: false,
    clockinNumbers: 0,
    totalClockinNumber: 0,
    clockins: []
  }

  @State selectedDays: HmCalendarSelectedDay[] = []
  @Builder dayBuilder(params: DayBuilderParams) {
    Column({space: 5}) {
      Row({space: 10}) {
        Text(params.totalDays.toString())
          .fontWeight(FontWeight.Bold)
          .fontSize(40)
        Text('天')
          .fontSize(12)
          .fontColor($r('app.color.common_gray_01'))
          .margin({bottom: 8})
      }
      .alignItems(VerticalAlign.Bottom)
      Text(params.text)
        .fontSize(12)
        .fontColor($r('app.color.common_gray_01'))
    }
  }

  build() {
    Column() {
      MyNavBar({ title: '打卡页面', showRightIcon: false })
      Row({space: 40}) {
        this.dayBuilder({totalDays: this.clockinInfo.totalClockinNumber, text:  '累计打卡'})
        this.dayBuilder({totalDays: this.clockinInfo.clockinNumbers, text: '连续打卡'})
      }
      .width('100%')
      .padding({left: $r('app.string.padding_normal')})
      .margin({bottom: 80})
      HmCalendar({
        selectedDays: this.selectedDays,
        onChangeMonth: (month: string) => {
          this.getData(month)
        }
      })
        .borderRadius(8)
        .border({ width: 0.5, color: '#ededed' })
        .shadow({ color: '#ededed', radius: 16 })
        .backgroundColor($r('app.color.white'))
        .width('90%')
        .margin({bottom: 50})

      Button() {
        Row() {
          Text('分享成就 ')
            .fontColor(Color.White)
            .fontSize(16)
          Image($r('sys.media.ohos_ic_public_share'))
            .width(16)
            .aspectRatio(1)
            .fillColor(Color.White)
        }
      }
      .padding({ top: 8, bottom: 8, left: 16, right: 16 })
      .backgroundColor('#ffaa00')
      .shadow({ radius: 5, color: '#dddddd', offsetX: 5, offsetY: 5 })
    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.clocked_bg'))
    .backgroundImageSize({width: '100%'})
  }
}