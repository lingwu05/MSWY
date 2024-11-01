// 1. 将单位保存起来待使用
enum Unit {
  PriceU = '元',
  WeightU = '斤'
}
// 2. 水果店库存罗列 苹果 -- 20斤 香蕉 -- 20斤 橘子 -- 20斤
const origilFruits: number[] = [20, 20, 20]
const fruits: number[] = [20, 20, 20]
const price: number[] = [10, 5, 8]

function consume(...weights: number[]): number {
  let totalConsume: number = 0
  for (let i = 0; i < weights.length; ++i) {
    totalConsume += price[i] * weights[i]
    fruits[i] -= weights[i]
  }
  return totalConsume
}


// 3.消费总额, 顾客购买了5斤苹果, 每斤10元; 4斤橘子,每斤8元
console.log('---------消费总额----------')
console.log('消费： ' + consume(5, 0, 4) + Unit.PriceU)
// 4. 输出剩余库存
console.log('---------商店库存----------')
console.log('苹果：' + fruits[0] + Unit.WeightU)
console.log('香蕉：' + fruits[1] + Unit.WeightU)
console.log('橘子：' + fruits[2] + Unit.WeightU)

// 5. 消费明细打印
// 5.1 封装函数,进行统一处理

// 5.2 调用函数输出 单品消费明细
console.log('----------消费明细----------')
for (let i = 0; i < fruits.length; ++i) {
  if (origilFruits[i] - fruits[i] > 0) {
    let text = ''
    if (price[i] == 10) {
      text = '苹果'
    } else if (price[i] == 8) {
      text = '橘子'
    } else {
      text = '香蕉'
    }
    let w = origilFruits[i] - fruits[i];
    let p = w * price[i]
    console.log(text + '：单价 ' + price[i] + '元 重量 ' + w + ' 小计 ' + p + Unit.PriceU)
  }
}

@Entry
@Component
struct TextPage {

  build() {


  }

}


