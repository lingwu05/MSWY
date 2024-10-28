import { router } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct PrivacyAgreement {
  webViewController:webview.WebviewController = new webview.WebviewController()
  build() {
    Navigation(){
      Web({
        src: 'http://110.41.143.89/privacy',
        controller:this.webViewController
      })
    }
    .titleMode(NavigationTitleMode.Mini)
    .title('隐私协议')
  }
}