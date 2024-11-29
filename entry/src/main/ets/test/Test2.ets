import { relationalStore } from '@kit.ArkData'

interface ArticleItem {
  id: number
  title: string
  content: string
  create_time: number
}

@Entry
@Component
struct Test2 {
  store?: relationalStore.RdbStore
  tableName = 'article'
  @State total: number = 0
  @State list: ArticleItem[] = []

  async createStore () {
    const store = await relationalStore.getRdbStore(getContext(this), {
      name: 'interview.db',
      securityLevel: relationalStore.SecurityLevel.S1
    })
    store.executeSql(`
        CREATE TABLE IF NOT EXISTS ${this.tableName} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          create_time INTEGER NOT NULL
        )
      `)
    this.store = store
  }

  aboutToAppear(): void {
    this.createStore()
  }

  build() {
    Column() {
      Button('添加')
        .onClick(() => {
          this.store?.insert(this.tableName, {
            id: null,
            title: '测试' + Math.random(),
            content: '我是一篇测试文章' + Math.random(),
            create_time: Date.now()
          })
        })
      Button('查询总条数')
        .onClick(async () => {
          const predicates = new relationalStore.RdbPredicates(this.tableName)
          const resultSet = await this.store?.query(predicates)
          this.total = resultSet?.rowCount || 0
        })

      Text('总条数' + this.total)

      Button('查询所有数据')
        .onClick(async () => {
          const predicates = new relationalStore.RdbPredicates(this.tableName)
          const resultSet = await this.store?.query(predicates)
          const list: ArticleItem[] = []
          while (resultSet?.goToNextRow()) {
            list.push({
              id: resultSet.getLong(resultSet.getColumnIndex('id')),
              title: resultSet.getString(resultSet.getColumnIndex('title')),
              content: resultSet.getString(resultSet.getColumnIndex('content')),
              create_time: resultSet.getLong(resultSet.getColumnIndex('create_time'))
            })
          }
          resultSet?.close()

          this.list = list
        })

      Text(JSON.stringify(this.list))
    }
    .height('100%')
    .width('100%')
  }
}