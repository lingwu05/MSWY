interface InterviewItem {
  id: string
  stem: string
  content: string
  likeCount: number
  views: number
  creatorName: string
  creatorAvatar: ResourceStr
  createdAt: string
  tags: string[]
  likeFlag: 0 | 1 | null
}

@Preview
@Component
export struct Interview {

  @State isSelected: boolean = true

  @State list: InterviewItem[] = [
  {
    id: '10001',
    stem: '微软谷歌面试算法难度 | 你想象不到的简单',
    content: '内推 候选人可以找到认识的微软员工,员工会把简历提交到微软人才库。这样微软HR就可以在人才库的系统中查看到你的简历。',
    likeCount: 13,
    views: 347,
    creatorName: '凡人的积累',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '一周前',
    tags: ['大厂', '算法'],
    likeFlag: 1
  },
  {
    id: '10002',
    stem: '美团-工程效能组-开发工程师实习生(工程基建方向)-一面',
    content: '项目介绍网页音视频项目项目代码量多少？是一个人完成的吗？介绍SaaS视频项目SpringSpring框架有什么特性？(不知道这个问题要问什么，答的扩展性、封装性啥的)控制反转了解吗？',
    likeCount: 32,
    views: 503,
    creatorName: '响亮的名字',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '10 小时前',
    tags: ['大厂', 'Java'],
    likeFlag: 0
  },
  {
    id: '10003',
    stem: '美团-工程效能组-开发工程师实习生(工程基建方向)-一面',
    content: '项目介绍网页音视频项目项目代码量多少？是一个人完成的吗？介绍SaaS视频项目SpringSpring框架有什么特性？(不知道这个问题要问什么，答的扩展性、封装性啥的)控制反转了解吗？',
    likeCount: 32,
    views: 503,
    creatorName: '响亮的名字',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '10 小时前',
    tags: ['大厂', 'Java'],
    likeFlag: 0
  },
  {
    id: '10004',
    stem: '美团-工程效能组-开发工程师实习生(工程基建方向)-一面',
    content: '项目介绍网页音视频项目项目代码量多少？是一个人完成的吗？介绍SaaS视频项目SpringSpring框架有什么特性？(不知道这个问题要问什么，答的扩展性、封装性啥的)控制反转了解吗？',
    likeCount: 32,
    views: 503,
    creatorName: '响亮的名字',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '10 小时前',
    tags: ['大厂', 'Java'],
    likeFlag: 0
  },
  {
    id: '10005',
    stem: '美团-工程效能组-开发工程师实习生(工程基建方向)-一面',
    content: '项目介绍网页音视频项目项目代码量多少？是一个人完成的吗？介绍SaaS视频项目SpringSpring框架有什么特性？(不知道这个问题要问什么，答的扩展性、封装性啥的)控制反转了解吗？',
    likeCount: 32,
    views: 503,
    creatorName: '响亮的名字',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '10 小时前',
    tags: ['大厂', 'Java'],
    likeFlag: 0
  },
  {
    id: '10006',
    stem: '美团-工程效能组-开发工程师实习生(工程基建方向)-一面',
    content: '项目介绍网页音视频项目项目代码量多少？是一个人完成的吗？介绍SaaS视频项目SpringSpring框架有什么特性？(不知道这个问题要问什么，答的扩展性、封装性啥的)控制反转了解吗？',
    likeCount: 32,
    views: 503,
    creatorName: '响亮的名字',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '10 小时前',
    tags: ['大厂', 'Java'],
    likeFlag: 0
  },
  {
    id: '10007',
    stem: '美团-工程效能组-开发工程师实习生(工程基建方向)-一面',
    content: '项目介绍网页音视频项目项目代码量多少？是一个人完成的吗？介绍SaaS视频项目SpringSpring框架有什么特性？(不知道这个问题要问什么，答的扩展性、封装性啥的)控制反转了解吗？',
    likeCount: 32,
    views: 503,
    creatorName: '响亮的名字',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '10 小时前',
    tags: ['大厂', 'Java'],
    likeFlag: 0
  },
  {
    id: '10008',
    stem: '美团-工程效能组-开发工程师实习生(工程基建方向)-一面',
    content: '项目介绍网页音视频项目项目代码量多少？是一个人完成的吗？介绍SaaS视频项目SpringSpring框架有什么特性？(不知道这个问题要问什么，答的扩展性、封装性啥的)控制反转了解吗？',
    likeCount: 32,
    views: 503,
    creatorName: '响亮的名字',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '10 小时前',
    tags: ['大厂', 'Java'],
    likeFlag: 0
  },
  {
    id: '10009',
    stem: '中邮消费金融AI算法工程师（实习生）',
    content: '这个是在猎聘上投递的 能收到面试属实是意外之喜面试官是nlp方向的，主要是问nlp相关 首先自我介绍说一个在上段实习中的项目 这里说了一个搭建智能客服对话助手',
    likeCount: 10,
    views: 98,
    creatorName: '不想秃头的夜猫子',
    creatorAvatar: $r('app.media.ic_interview_avatar'),
    createdAt: '23 分钟前',
    tags: ['国企', '实习'],
    likeFlag: 1
  }
  ]

  @Builder contentBuilder(item: InterviewItem) {
    Column({space: 10}) {
      Row() {
        Image(item.creatorAvatar)
          .width(35)
          .margin({right: 10})
        Column({space: 5}) {
          Text(item.stem)
            .fontSize(15)
            .fontWeight(600)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .maxLines(2)
          Row() {
            Text(item.creatorName + ' . ' + item.createdAt)
              .fontSize(12)
              .fontColor('#9c9c9c')
          }
          .width('100%')
        }
        .width('70%')
        Blank()
          .layoutWeight(1)
        Image($r('app.media.ic_interview_more'))
          .width(20)
      }
      .alignItems(VerticalAlign.Top)
      Text(item.content)
        .fontSize(13)
        .fontWeight(500)
        .textOverflow({overflow: TextOverflow.Ellipsis})
        .maxLines(2)
        .fontColor('#666')
      Row({space: 3}) {
        ForEach(item.tags, (tag: string) => {
          Text(tag)
            .fontColor('#79bca4')
            .fontSize(12)
            .width(36)
            .height(20)
            .backgroundColor('#f3f4f6')
            .textAlign(TextAlign.Center)
            .borderRadius(4)
        })
      }
      .width('100%')
      Row() {
        Text('点赞 ' + item.likeCount + ' · 浏览 ' + item.views)
          .fontColor('#9c9c9c')
          .fontSize(12)
      }
      .width('100%')
    }
    .width('100%')
    .padding(10)
    .borderWidth({
      bottom: 1
    })
    .borderColor('#f6f6f6')
  }

  build() {
    Column() {
      Row({space: 10}) {
        Text('面试无忧')
          .fontSize(22)
          .fontWeight(900)
        TextInput({placeholder: '请输入关键词'})
      }
      .width('100%')
      .padding({
        left:10
      })
      Row({space: 10}) {
        Button('默认', {stateEffect: false})
          .fontSize(14)
          .backgroundColor(Color.Transparent)
          .fontColor(this.isSelected ? '#2b2b2b' : '#9c9c9c')
          .padding(0)
          .onClick(() => {
            this.isSelected = true
          })
        Button('最新', {stateEffect: false})
          .fontSize(14)
          .backgroundColor(Color.Transparent)
          .fontColor(!this.isSelected ? '#2b2b2b' : '#9c9c9c')
          .padding(0)
          .onClick(() => {
            this.isSelected = false
          })
        Column(){}.borderWidth({bottom: 2}).width(10).zIndex(1)
        .position({left: 5, bottom: 5}).borderColor(this.isSelected ? '#2b2b2b' : Color.Transparent)
        Column(){}.borderWidth({bottom: 2}).width(10).zIndex(1)
        .position({left: 40, bottom: 5}).borderColor(!this.isSelected ? '#2b2b2b' : Color.Transparent)
      }
      .width('100%')
      .borderWidth({
        bottom: 1
      })
      .borderColor('#f6f6f6')
      .padding({
        left:10
      })

      Refresh({ refreshing: true}) {
        List() {
          ForEach(this.list, (item: InterviewItem) => {
            ListItem() {
              this.contentBuilder(item)
            }
          })
        }
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}