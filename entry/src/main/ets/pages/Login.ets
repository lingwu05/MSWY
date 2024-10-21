import { router } from '@kit.ArkUI';

@Entry
@Component
struct Login {
  @State message: string = 'Hello World';

  build() {
    Column() {
      // 头部状态栏
      Row() {
        Image($r('app.media.ic_left_arrow'))
          .width(30)
          .aspectRatio(1)
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Index'
            })
          })
        Row() {

        }
        .layoutWeight(1)
        Blank()
      }
      .width('100%')
      .margin({
        left: 20
      })

      Column({space: 10}) {
        // logo 区域
        Image($r('app.media.icon'))
          .width(100)
          .aspectRatio(1)
        Text('面试无忧')
          .fontSize(30)
          .fontColor($r('app.color.title_gray'))
        Text('搞定企业面试真题，就用面试无忧')
          .fontSize(15)
          .fontColor($r('app.color.gray'))
      }
      .margin({
        bottom: 40
      })

      // 登录区域
      Column({space: 15}) {
        TextInput({placeholder: '请输入用户名'})
          .backgroundColor(Color.Transparent)
          .border({
            color: $r('app.color.line_gray'),
            width: {
              bottom: 2
            }
          })
          .borderRadius(0)
          .fontColor($r('app.color.gray'))
          .margin({
            left: 30,
            right: 30
          })
        TextInput({placeholder: '请输入密码'})
          .backgroundColor(Color.Transparent)
          .type(InputType.Password)
          .border({
            color: $r('app.color.line_gray'),
            width: {
              bottom: 2
            }
          })
          .borderRadius(0)
          .fontColor($r('app.color.gray'))
          .margin({
            left: 30,
            right: 30
          })
        Row() {
          Checkbox()
            .select(true)
            .width(15)
            .selectedColor('#f6701a')
          Text('已阅读并同意')
            .fontColor($r('app.color.gray'))
          Text(' 用户协议')
            .fontColor($r('app.color.black'))
            .onClick(() => {
              router.pushUrl({
                url: 'pages/UserAgreement'
              })
            })
          Text(' 和 ')
            .fontColor($r('app.color.gray'))
          Text('隐私政策')
            .fontColor($r('app.color.black'))
            .onClick(() => {
              router.pushUrl({
                url: 'pages/PrivacyAgreement'
              })
            })
        }
        .width('100%')
        .margin({
          left: 50
        })
        Button({ type: ButtonType.Normal }) {
          Text('立即登录')
            .fontColor($r('app.color.light_white'))
            .fontSize(20)
        }
        .width('90%')
        .height(50)
        .linearGradient({
          angle: 135,
          colors: [
            ['#FCA21C', 0],
            ['#FA6D1D', 1]
          ]
        })
        .borderRadius(4)
      }

      Column({space: 20}) {
        Text('其他登录方式')
          .fontColor($r('app.color.gray'))
        Image($r('app.media.ic_logo_huawei'))
          .width(30)
      }
      .margin({
        top: 110
      })
    }
    .width('100%')
    .height('100%')
    .padding(5)
  }
}