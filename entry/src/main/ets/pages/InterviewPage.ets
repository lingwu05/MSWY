import { Tag } from '../common/components/Index'
import { MyNavBar } from '../common/components/MyNavBar'
import { InterviewItem, InterviewPageParams } from '../models'
import { webview } from '@kit.ArkWeb'
import { LoadingDialog } from '../common/components/LoadingDialog'
import { router } from '@kit.ArkUI'
import { http } from '../common/utils/Index'

@Entry
@Component
struct InterviewPage {
  @Prop item: InterviewItem = { } as InterviewItem
  @State isLoading: boolean = false

  controller = new webview.WebviewController()

  loadingdialog: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({ message: '加载中...' }),
    customStyle: true,
    alignment:DialogAlignment.Center
  })

  async aboutToAppear() {
    const params = router.getParams() as InterviewPageParams
    if (params) {
      this.item = params.item as InterviewItem
      this.isLoading = true
      this.loadingdialog.open()
      this.item = await this.getInterviewDetail(this.item.id)
      this.loadingdialog.close()
      this.isLoading = false
    }
  }

  async getInterviewDetail (id: string) {
    return await http.request<InterviewItem>({ url: `question/${id}` })
  }

  build() {
    Column() {
      MyNavBar({title: '面经详情', showRightIcon: true})
      Text(this.item.stem)
        .fontSize(18)
        .fontWeight(700)
        .margin({bottom: 20})
      Row({space: 5}){
        Image(this.item.creatorAvatar)
          .width(36)
          .aspectRatio(1)
        Column() {
          Text(this.item.creatorName)
            .fontSize(15)
          Text(`浏览 ${this.item.views} · 点赞 ${this.item.likeCount} · ${this.item.createdAt}`)
            .fontSize(12)
            .fontColor('#999')
        }
        .alignItems(HorizontalAlign.Start)
        Blank().layoutWeight(1)
      }
      .width('100%')
      .padding(16)

      Row({space: 2}) {
        ForEach(this.item.stage, (tag: string) => {
          Tag({text: tag})
        })
      }
      .width('100%')
      .padding(16)
      Scroll() {
        Web({ src: $rawfile('question.html'), controller: this.controller })
          .width('100%')
          .layoutWeight(1)
          .onPageEnd(() => {
            if (this.item.content) {
              this.controller.runJavaScript(`writeHtml(\`${this.item.content}\`)`)
            }
          })
      }
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }
}