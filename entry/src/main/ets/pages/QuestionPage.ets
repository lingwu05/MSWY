import { Tag } from '../common/components/Index';
import { MyNavBar } from '../common/components/MyNavBar';
import { webview } from '@kit.ArkWeb';
import { QuestionDetail, QuestionPageParams } from '../models';
import { router } from '@kit.ArkUI';
import { http } from '../common/utils/Index';
import { LoadingDialog } from '../common/components/LoadingDialog';

@Entry
@Component
struct QuestionPage {
  @State item: QuestionDetail = {} as QuestionDetail
  @State isLoading: boolean = false

  dialog: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({ message: '加载中...' }),
    customStyle: true,
    alignment:DialogAlignment.Center
  })
  controller = new webview.WebviewController()

  async aboutToAppear() {
    const params = router.getParams() as QuestionPageParams
    if (params) {
      this.item = params.item as QuestionDetail
      this.isLoading = true
      this.dialog.open()
      this.item = await this.getQuestionDetail(this.item.id)
      this.dialog.close()
      this.isLoading = false
    }
  }

  async getQuestionDetail (id: string) {
    return await http.request<QuestionDetail>({ url: `question/${id}` })
  }

  build() {
    Column() {
      MyNavBar({title: '试题详情'})
      if (!this.isLoading)  {
        Text('题目:')
          .fontSize(18)
          .fontWeight(900)
          .width('100%')
          .padding({left: 16})
        Text(this.item.stem)
          .width('100%')
          .padding(16)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Row() {
          Row({space: 10}) {
            ForEach(this.item.stage, (item: string, index) => {
              Tag({text: item})
            })
          }
          Image($r('sys.media.ohos_ic_public_more'))
            .width(15)
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .padding({left: 16, right: 16})

        Divider()
          .strokeWidth(8)
          .color($r('app.color.common_gray_bg'))
          .padding(16)

        Text('答案:')
          .fontSize(18)
          .fontWeight(900)
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 16 })

        // Web({ src: $rawfile('question.html'), controller: this.controller })
        //   .width('100%')
        //   .layoutWeight(1)
        //   .onPageEnd(() => {
        //     if (this.item.answer) {
        //       this.controller.runJavaScript(`writeHtml(\`${this.item.answer}\`)`)
        //     }
        //   })

        Column() {
          Scroll() {
            // RichText(this.question.answer)
            RichText(`
                      <html>
                      <body>
                        <div style="font-size:54px">${this.item.answer}</div>
                      <body>
                      </html>
                      `)
          }
          .padding((15))
          .layoutWeight(1)
        }.layoutWeight(1)

        Row({ space: 80 }) {
          Row() {
            Image($r('sys.media.ohos_ic_public_arrow_left'))
              .width(20)
              .aspectRatio(1)
              .fillColor($r('app.color.common_gray_01'))
            Text(' 上一题')
              .fontColor($r('app.color.common_gray_01'))
          }

          Row() {
            Text('下一题 ')
              .fontColor($r('app.color.common_gray_03'))
            Image($r('sys.media.ohos_ic_public_arrow_right'))
              .width(20)
              .aspectRatio(1)
              .fillColor($r('app.color.common_gray_03'))
          }
        }
        .height(44)
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .height('100%')
    .width('100%')
  }
}