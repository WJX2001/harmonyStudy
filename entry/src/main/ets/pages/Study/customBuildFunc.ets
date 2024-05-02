// @Entry
// @Component
//
//   // 自定义构建函数
//   /**
//    * 允许在自定义组件内定义一个或多个@Builder方法，该方法被认为是该组件的私有、特殊类型的成员函数
//    * 自定义构建函数可以在所属组件的build方法和其他自定义构建函数中调用，但不允许在组件外调用
//    * 在自定义函数体中，this指代当前所属组件，组件的状态变量可以在自定义构建函数内访问，建议通过this访问自定义组件的状态变量而不是参数传递
//    */
//
//
//   // 自定义构建函数的参数传递规则：按值传递和按引用传递两种
//   /**
//    * 参数类型与声明类型一致，不允许undefined、null和返回undefined、null的表达式
//    * 按引用传递参数，传递的参数可为状态变量，切状态变量的该拜年会引起@Builder方法内UI刷新，使用$$作为按引用传递
//    */
//
//
// struct CustomPage {
//   @State message: string = 'Hello World'
//
//   build() {
//     Row() {
//       Column() {
//         // Text(this.message)
//         //   .fontSize(50)
//         //   .fontWeight(FontWeight.Bold)
//         // this.overBuilder({ param1: this.message })
//         // this.overBuilderNoChange(this.message)
//         Button('Click 我')
//           .onClick(() => {
//             this.message = 'sb11111'
//           })
//       }
//       .width('100%')
//
//       Child({ customBuilderParam: this.componentBuilder})
//
//     }
//     .height('100%')
//
//   }
//
//   // 按引用传递参数，传递的参数可为状态变量，状态变量的改变会引起@Builder方法内UI的刷新，使用$$传递参数的范式
//   @Builder overBuilder($$: { param1: string }) {
//     Row() {
//       Text(`这是自定义构建函数接受的变量: ${$$.param1}`)
//     }
//   }
//
//   // 按值传递参数，当传递的参数为状态变量时，状态变量的该拜年不会引起@Builder方法内的UI刷新
//   @Builder overBuilderNoChange(param1: string) {
//     Row() {
//       Text(`这是按值引用的结果,不会随着状态变化：${param1}`)
//     }
//   }
//
//   @Builder componentBuilder() {
//     Text(`Parent builder`)
//   }
//
//
//   // BuilderParam装饰器
//   /**
//    * 正常父子组件可以传递函数，参数，也可以传递UI元素，也就是自定义构建函数
//    * 传递后，子组件需要通过@BuilderParam拿到参数
//    */
//
//   /* 用父组件自定义构建函数初始化子组件@BuilderParam装饰的方法 */
//
// }
//
// @Component
// struct Child {
//   @BuilderParam customBuilderParam: () => void
//   build() {
//     this.customBuilderParam()
//   }
// }
//

@Component
struct Child {
  // 使用父组件@Builder装饰的方法初始化子组件@BuilderParam
  @BuilderParam customBuilderParam: () => void;

  build() {
    Column() {
      this.customBuilderParam()
    }
  }
}

@Entry
@Component
struct Parent {
  @Builder componentBuilder() {
    Text(`Parent builder `)
  }

  build() {
    Column() {
      Child({ customBuilderParam: this.componentBuilder })
    }
  }
}


