import router from '@ohos.router'
@Component
export struct Header {
  // 组件的成员变量 相当于react中的props
  private title: ResourceStr // 类型别名
  build() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(28)
        .interpolation(ImageInterpolation.High)
        .onClick(() => {
          router.back()
        }).margin({left:20,right:10})
      Text(this.title)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)

      Blank() // 其余空间使用空白占满
      Image($r('app.media.reload'))
        .width(28)
        .interpolation(ImageInterpolation.High)
        .margin({right:10})
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .height(30)
  }
}