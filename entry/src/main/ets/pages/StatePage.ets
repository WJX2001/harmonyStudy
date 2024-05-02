// 复杂类型
class Person {
  name: string
  age: number
  gf: Person

  constructor(name: string, age: number, gf?: Person) {
    this.name = name
    this.age = age
    this.gf = gf
  }
}


@Entry
@Component
struct StatePage {
  @State message: string = 'jack'
  @State age: number = 21
  // 声明一个变量 嵌套结构
  @State p: Person = new Person('jack', 21, new Person('Rose', 19))
  // 声明一个数组
  @State gfs: Person[] = [
    new Person('rose', 18),
    new Person('lucy', 20)
  ]

  build() {
    Column() {
      Row() {
        Button('添加').onClick(() => {
          this.gfs.push(new Person('sb', 29))
        })
      }

      Text('=女友列表=').fontSize(50)
        .fontWeight(FontWeight.Bold)
      ForEach(
        this.gfs, (p, index) => {
        Row() {
          Text(`${p.name}:${p.age} `)
            .fontSize(30)
            .onClick(() => {
              // 对嵌套类型中的对象属性数值相加 这种写法不会生效
              // 需要重新赋值(不是最优秀解)
              this.p.age++
              this.gfs[index] = new Person(p.name,p.age++)
            })
          Button('删除').onClick(() => {
            this.gfs.splice(index,1)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

      }
      )
    }
    .width('100%')
    .height('100%')

  }




}