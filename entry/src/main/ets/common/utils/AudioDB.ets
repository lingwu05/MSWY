import { relationalStore, ValuesBucket } from "@kit.ArkData"

// 1. 改造类型
export interface InterviewAudioItem extends ValuesBucket {
  id: number | null
  user_id: string
  name: string
  path: string
  duration: number
  size: number
  create_time: number
}

class AudioDB {
  //   创建数据库

  tableName = 'interview_audio'
  store?: relationalStore.RdbStore

  async createStore() {
    this.store = await relationalStore.getRdbStore(
      getContext(),
      { name: 'interview_audio.db', securityLevel: relationalStore.SecurityLevel.S1 })

    this.store.executeSql(`
    CREATE TABLE IF NOT EXISTS ${this.tableName} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id TEXT NOT NULL,
          name TEXT NOT NULL,
          path TEXT NOT NULL,
          duration INTEGER NOT NULL,
          size INTEGER NOT NULL,
          create_time INTEGER NOT NULL
        )
    `)
  }

  //   新增一条数据
  // 2. 改造新增方法
  add(newItem: InterviewAudioItem) {
    const res = this.store?.insertSync(this.tableName, newItem)
    if (!res || res < 1) {
      AlertDialog.show({ message: '数据库新增错误' })
    }
  }

  //   获取数据
  getAllData() {

    const pre = new relationalStore.RdbPredicates(this.tableName)
    const res = this.store?.querySync(pre)
    const list: InterviewAudioItem[] = []

    while (res?.goToNextRow()) {
      // 3. 改造查询数据方法
      const row = res.getRow() as InterviewAudioItem
      list.push(row)
    }

    res?.close()

    return list
  }


  //   删除一条数据
  delById(id: number) {
    const pre = new relationalStore.RdbPredicates(this.tableName)
    pre.equalTo('id', id)
    const res = this.store?.deleteSync(pre)

    if (!res || res < 1) {
      AlertDialog.show({ message: '数据库删除错误' })
    }
  }


  //   更新一条数据
  update(newItem: InterviewAudioItem) {
    const pre = new relationalStore.RdbPredicates(this.tableName)
    pre.equalTo('id', newItem.id)
    const res = this.store?.updateSync(newItem, pre)

    if (!res || res < 1) {
      AlertDialog.show({ message: '数据库更新错误' })
    }

  }
}

export const audioDB = new AudioDB()