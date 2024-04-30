class Item {
  name: string
  image: ResourceStr
  price: number
  discount: number

  constructor(name: string, image: ResourceStr, price: number, discount: number = 0) {
    this.name = name
    this.image = image
    this.price = price
    this.discount = discount
  }
}

import { Header } from '../components/CommonComponents'

// 全局自定义构建函数 在全局范围内定义函数 用于逻辑的抽取
@Builder function ItemCard1(item: Item) {

}


// 全局公共样式函数
@Styles function fillScreen() {
  .padding(20)
  .width('100%')
  .height('100%')
  .backgroundColor('#f2f3f4')
}
// extend 不能写在组件内部 继承模式，只能写在全局使用
// 组件特有属性，要使用继承
@Extend(Text) function priceText() {
  .fontColor('#F36')
  .fontSize(18)
}

@Entry // 加了entry 之后变为页面 如果没有entry则是一个组件
@Component
struct ItemPage {
  // 商品数据 定义一个成员变量
  private items: Array<Item> = [
    new Item('华为Mate60', $r('app.media.mate60'), 6999, 500),
    new Item('MateBookProX', $r('app.media.mate60'), 139999),
    new Item('WatchGT4', $r('app.media.mate60'), 1438),
    new Item('Mate X5', $r('app.media.mate60'), 12999),
    new Item('华为Mate60', $r('app.media.mate60'), 6999, 500),
    new Item('MateBookProX', $r('app.media.mate60'), 139999),
    new Item('WatchGT4', $r('app.media.mate60'), 1438),
    new Item('Mate X5', $r('app.media.mate60'), 12999),
  ]

  // 入口文件
  build() {
    Column({ space: 8 }) {
      // 标题部分
      Header({ title: '商品列表' })
      // 使用List组件
      List({ space: 8 }) {
        ForEach(
          this.items,
          (item: Item) => {
            ListItem() {
              // 全局自定义构建函数
              // ItemCard(item)
              // 局部自定义构建函数
              this.ItemCard(item)
            }
          }
        )
      }
      .width('100%')
      .layoutWeight(1) // 权重 权重高的默认占领 其余所有空间
      .margin({top:'45px'})
    }
    .fillScreen()
  }

  // 局部自定义构建函数 内部页面逻辑的抽取
  @Builder ItemCard(item: Item) {
    Row({ space: 10 }) {
      Image(item.image)
        .width(100)
      Column({ space: 4 }) {
        // 判断是否有折扣
        if (item.discount) {
          // 作出渲染
          Text(item.name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('原价：$' + item.price)
            .fontColor('#CCC')
            .fontSize(14)
            .decoration({ type: TextDecorationType.LineThrough })
          Text('折扣价：$' + (item.price - item.discount))
            .priceText()
          Text('补贴价格：$' + item.discount)
            .priceText()
        } else {
          Text(item.name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('$' + item.price)
            .priceText()
        }

      }
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor('#fff')
    .borderRadius(20)
    .height(120)
    .padding(10)
  }
}