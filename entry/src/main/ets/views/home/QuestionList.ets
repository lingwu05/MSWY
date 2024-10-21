export interface IQuestionItem {
  title: string
  tag: string
  likes: number
  views: number
}

@Preview
@Component
export struct QuestionList {
  @Prop list: IQuestionItem[] = [
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },
    {
      title: '如何删除Record中的元素',
      tag: '困难',
      likes: 9999,
      views: 10000
    },

  ]

  @Builder questionBuilder(item: IQuestionItem) {
    Column({space: 10}) {
      Row({space: 5}) {
        Text(item.tag)
          .backgroundColor('#F3F4F6')
          .fontColor('#F08641')
          .padding(5)
          .fontSize(12)
        Text(item.title)
          .fontSize(15)
          .fontWeight(500)
      }
      .width('100%')
      Text('点赞 ' + item.likes + '   |   浏览 ' + item.views)
        .fontColor('#B1B1B1')
        .fontSize(13)
        .width('100%')
    }
    .width('100%')
    .height(80)
    .borderWidth({
      bottom: 1
    })
    .borderColor('#F6F6F6')
    .padding({
      bottom: 10,
      top: 10,
      left:20
    })
  }

  build() {
    Refresh({ refreshing: true}) {
      List() {
        ForEach(this.list, (item: IQuestionItem) => {
          ListItem() {
            this.questionBuilder(item)
          }
        })
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}