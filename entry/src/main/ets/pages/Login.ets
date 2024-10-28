import { promptAction, router } from '@kit.ArkUI';
import { http } from '../common/utils/Index';
import { User } from '../models';
import { emitter } from '@kit.BasicServicesKit';
import { LOGIN_EVENT } from '../constants';
import { auth } from '../common/utils/Auth';

interface LoginParam {
  username: string
  password: string
}

@Entry
@Component
struct Login {
  @State loginParam: LoginParam = {
    username: 'hmheima',
    password: 'Hmheima%123',
  }

  @State isAgree: boolean = true
  @State isVerify: boolean = false

  build() {
    Column() {
      // 头部状态栏
      Row() {
        Image($r('app.media.ic_left_arrow'))
          .width(30)
          .aspectRatio(1)
          .onClick(() => {
            router.back()
          })
        Blank()
        .layoutWeight(1)
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
        TextInput({placeholder: '请输入用户名', text: $$this.loginParam.username})
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
        TextInput({placeholder: '请输入密码', text: $$this.loginParam.password})
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
            .select($$this.isAgree)
            .width(15)
            .selectedColor('#f6701a')
            .onChange((val) => {
              this.isAgree = val
            })
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
        .onClick(async () => {
          if (this.isVerify) {
            return
          }
          if (!this.loginParam.username || !this.loginParam.password) {
            promptAction.showToast({message: '请输入用户名或密码'})
            return
          }
          if (!this.isAgree) {
            promptAction.showToast({message: '请勾选已阅读并同意'})
            return
          }
          try {
            this.isVerify = true
            const user = await http.request<User, LoginParam>({
              url: 'login', method: 'post', data: {
                username: this.loginParam.username,
                password: this.loginParam.password
              }
            })
            this.isVerify = false
            auth.setUser(user)
            emitter.emit(LOGIN_EVENT)
            // 有 return_url 就回跳
            const params = router.getParams() as Record<string, string>
            if (params?.return_url) {
              router.replaceUrl({ url: params.return_url, params })
            } else {
              router.back()
            }
          } catch (e) {
            this.isVerify = false
            promptAction.showToast({ message: e.message })
          }

        })
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