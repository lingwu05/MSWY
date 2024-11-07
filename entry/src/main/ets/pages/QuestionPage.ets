import { Tag } from '../common/components/Index';
import { MyNavBar } from '../common/components/MyNavBar';
import { webview } from '@kit.ArkWeb';
import { QuestionDetail, QuestionItem, QuestionPageParams } from '../models';
import { promptAction, router } from '@kit.ArkUI';
import { auth, http } from '../common/utils/Index';
import { LoadingDialog } from '../common/components/LoadingDialog';
import { ShareDialog } from '../common/components/ShareDialog';

export interface ResponseType {
  success: boolean
  code: number
  message: string
  data: object
}

export interface RequestParams {
  id: string
  type: number
  optType: number
}

// 访问时长数据埋点接口要求的数据格式
export interface iTimeItem {
  /** 结束时间（毫秒） */
  endTime: number;

  /** 试题id */
  questionId: string;

  /** 开始时间(毫秒) */
  startTime: number;
}

// 上报访问时长接口的body参数类型
export interface iTimeBody {
  timeList: iTimeItem[]
}

@Entry
@Component
struct QuestionPage {
  @State item: QuestionDetail = {} as QuestionDetail
  @State isLoading: boolean = false
  @State questionIdex: number = 0
  @State list: QuestionItem[] = []
  timeItem: iTimeItem = {} as iTimeItem

  loadingdialog: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({ message: '加载中...' }),
    customStyle: true,
    alignment:DialogAlignment.Center
  })

  shareDialog: CustomDialogController = new CustomDialogController({
    builder: ShareDialog({
      stem: this.item.stem,
      qid: this.item.id,
      username: auth.getUser().username
    }),
    customStyle: true,
    alignment:DialogAlignment.Center
  })
  controller = new webview.WebviewController()

  async aboutToAppear() {
    const params = router.getParams() as QuestionPageParams
    if (params) {
      this.item = params.item as QuestionDetail
      this.questionIdex = params.index
      this.list = params.list
      this.isLoading = true
      this.loadingdialog.open()
      this.item = await this.getQuestionDetail(this.item.id)
      this.loadingdialog.close()
      this.isLoading = false
    }
  }

  aboutToDisappear(): void {
    this.endRecordTime()
  }

  startRecordTime() {
    this.timeItem.questionId = this.item.id
    this.timeItem.startTime = Date.now()
  }

  async endRecordTime() {
    this.timeItem.endTime =Date.now()
    await http.request<QuestionDetail>({
      url: `time/tracking`,
      method: 'post',
      data: {
        timeList: [this.timeItem]
      }
    })
    promptAction.showToast({ message: '数据上报完成' })
  }

  async getQuestionDetail (id: string) {
    const res = await http.request<QuestionDetail>({ url: `question/${id}` })
    this.startRecordTime()
    return res
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
            .bindMenu([
              {
                value: this.item.collectFlag === 1 ? '取消收藏' : '收藏',
                action: async () => {
                  if (this.item.collectFlag == 0) {
                    await http.request<null, RequestParams>({
                      url: 'question/opt',
                      method: 'post',
                      data: {
                        id: this.item.id,
                        type: 0,
                        optType: 2
                      }
                    })
                    this.item.collectFlag = 1
                    promptAction.showToast({message: '收藏成功'})
                  } else {
                    await http.request<ResponseType, RequestParams>({
                      url: 'question/unOpt',
                      method: 'post',
                      data: {
                        id: this.item.id,
                        type: 0,
                        optType: 2
                      }
                    })
                    this.item.collectFlag = 0
                    promptAction.showToast({message: '取消收藏成功'})
                  }
                }
              },
              {
                value: this.item.likeFlag === 1 ? '取消点赞' : '点赞',
                action: async () => {
                  if (this.item.likeFlag === 0) {
                    await http.request<ResponseType, RequestParams>({
                      url: 'question/opt',
                      method: 'post',
                      data: {
                        id: this.item.id,
                        type: 0,
                        optType: 1
                      }
                    })
                    this.item.likeFlag = 1
                    promptAction.showToast({message: '点赞成功'})
                  } else {
                    await http.request<ResponseType, RequestParams>({
                      url: 'question/unOpt',
                      method: 'post',
                      data: {
                        id: this.item.id,
                        type: 0,
                        optType: 1
                      }
                    })
                    this.item.likeFlag = 0
                    promptAction.showToast({message: '取消点赞成功'})
                  }
                }
              },
              {
                value: '试题分享',
                action: () => {
                  this.shareDialog.open()
                }
              },
              {
                value: '点击反馈',
                action: () => {

                }
              }
            ])
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
              .fillColor(this.questionIdex == 0 ? $r('app.color.common_gray_01') :  $r('app.color.common_gray_03'))
            Text(' 上一题')
              .fontColor(this.questionIdex == 0 ? $r('app.color.common_gray_01') :  $r('app.color.common_gray_03'))
          }
          .onClick(async () => {
            if (this.questionIdex != 0) {
              this.loadingdialog.open()
              --this.questionIdex
              this.endRecordTime()
              this.item = await this.getQuestionDetail(this.list[this.questionIdex].id)
              this.loadingdialog.close()
            }
          })

          Row() {
            Text('下一题 ')
              .fontColor(this.questionIdex == this.list.length - 1 ? $r('app.color.common_gray_01') :  $r('app.color.common_gray_03'))
            Image($r('sys.media.ohos_ic_public_arrow_right'))
              .width(20)
              .aspectRatio(1)
              .fillColor(this.questionIdex == this.list.length - 1 ? $r('app.color.common_gray_01') :  $r('app.color.common_gray_03'))
          }
          .onClick(async () => {
            if (this.questionIdex != this.list.length - 1) {
              this.loadingdialog.open()
              ++this.questionIdex
              this.endRecordTime()
              this.item = await this.getQuestionDetail(this.list[this.questionIdex].id)
              this.loadingdialog.close()
            }
          })
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