import { promptAction, router } from '@kit.ArkUI'
import { auth } from './Auth'
import { http } from './HttpRequest'

interface ClockRes {
  clockinNumbers: number
}

export const requestClockIn = async () => {
  const user = auth.getUser()
  if (user.token) {
    if (user.clockinNumbers === 0) {
      const res = await http.request<ClockRes>({ url: 'clockin', method: 'post' })
      user.clockinNumbers = res.clockinNumbers
      auth.setUser(user)
      promptAction.showToast({ message: '打卡成功' })
    }
    router.pushUrl({ url: 'pages/ClockPage' })
  } else {
    router.pushUrl({ url: 'pages/Login' })
  }
}