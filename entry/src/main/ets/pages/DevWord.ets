import { MyNavBar } from '../common/components/MyNavBar';
import { util } from '@kit.ArkTS';
import { promptAction } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';

interface WordItem {
  zh: string
  en: string
  code: string
}

type Words = Record<string, WordItem[]>

@Entry
@Component
struct DevWord {
  @State code:string = ''

  aboutToAppear(): void {
    this.initWords()
  }

  @Builder wordInfoBuilder() {
    Column() {
      Web({ src: $rawfile('word.html'), controller: this.webController })
        .width('100%')
        .height(400)
        .backgroundColor($r('app.color.common_gray_bg'))
        .onPageEnd(() => {
          this.webController.runJavaScript(`writeHtml(\`${this.code}\`)`)
        })
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 34 })
  }

  @Builder listItemBuilder(title: string, desc: string, code: string) {
    Column() {
      Row({space: 5}) {
        Image($r('app.media.volume'))
          .width(15)
          .aspectRatio(1)
          .fillColor($r('app.color.common_gray_01'))
        Text(title)
          .fontWeight(700)
          .fontSize(15)
      }
      .width('100%')
      .margin({bottom: 5})

      Row() {
        Text(desc)
          .fontSize(12)
          .fontColor($r('app.color.common_gray_01'))
        if (code) {
          Row() {
            Text('详细代码')
              .fontSize(12)
              .fontColor($r('app.color.common_gray_01'))
            Image($r('sys.media.ohos_ic_public_arrow_right'))
              .width(12)
              .aspectRatio(1)
              .fillColor($r('app.color.common_gray_01'))
          }
          .onClick(() => {
            this.code = code
            this.isShow = true
          })
        } else {
          Text('暂无代码')
            .fontSize(12)
            .fontColor($r('app.color.common_gray_03'))
        }

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({left: 16, right: code ? 16 : 25})
    }
    .width('100%')
    .borderWidth({
      bottom: 0.5
    })
    .borderColor($r('app.color.common_gray_01'))
    .padding({ left: 16, right: 16, top: 10, bottom: 10 })

  }

  webController = new webview.WebviewController()
  words: Words = {}
  @State currentTag: string = ''
  @State index: number = 0
  @State isShow: boolean = false

  initWords() {
    const ctx = getContext(this)
    // 获取二进制数据
    const uint8Array = ctx.resourceManager.getRawFileContentSync('word.json')
    // 实例化文本解析工具
    const textDecoder = util.TextDecoder.create('utf-8', {
      ignoreBOM: true
    });
    // 解析文本
    const jsonStr = textDecoder.decodeToString(uint8Array)
    // 转成对象
    this.words = JSON.parse(jsonStr) as Words
    this.currentTag = Object.keys(this.words)[this.index]

  }

  build() {
    Column() {
      MyNavBar({title: '常用单词'})
        .onClick(() => {
          const ctx = getContext(this)
          // 获取二进制数据
          const uint8Array = ctx.resourceManager.getRawFileContentSync('word.json')
          // 实例化文本解析工具
          const textDecoder = util.TextDecoder.create('utf-8', {
            ignoreBOM: true
          });
          // 解析文本
          const jsonStr = textDecoder.decodeToString(uint8Array)
          promptAction.showToast({message: jsonStr})
        })
      Row() {
        Column({space: 5}) {
          Text('开发常用词汇')
            .fontSize(16)
          Text('共' + this.words[this.currentTag].length + '个单词')
            .fontSize(13)
            .fontColor($r('app.color.common_gray_01'))
        }
        .alignItems(HorizontalAlign.Start)
        Select([
          {value: Object.keys(this.words)[0]},
          {value: Object.keys(this.words)[1]},
          {value: Object.keys(this.words)[2]},
          {value: Object.keys(this.words)[3]},
          {value: Object.keys(this.words)[4]},
          {value: Object.keys(this.words)[5]},
          {value: Object.keys(this.words)[6]},
          {value: Object.keys(this.words)[7]},
          {value: Object.keys(this.words)[8]},
        ])
          .selected(this.index)
          .value(Object.keys(this.words)[this.index])
          .onSelect((index, value) => {
            this.index = index
            this.currentTag = value
          })
          .backgroundColor($r('app.color.white'))
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding({left: 16, right: 16})
      .margin({bottom: 20})

      Row() {}.width('100%').height(10).backgroundColor('#fff3f3f3')

      List() {
        ForEach(this.words[this.currentTag], (item: WordItem, index) => {
          ListItem() {
            this.listItemBuilder(item.en, item.zh, item.code)
          }
        })
      }
      .margin({bottom: 40})
    }
    .height('100%')
    .width('100%')
    .bindSheet($$this.isShow, this.wordInfoBuilder(),
      {
        height: SheetSize.MEDIUM,
        backgroundColor: $r('app.color.white'),
        title: { title: '详细代码' }
      })
  }
}