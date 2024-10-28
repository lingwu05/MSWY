import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct UserAgreement {
  webViewController:webview.WebviewController = new webview.WebviewController()
  build() {
    Navigation(){
      Web({
        src: 'http://110.41.143.89/privacy',
        controller:this.webViewController
      })
    }
    .titleMode(NavigationTitleMode.Mini)
    .title('用户协议')
  }
}