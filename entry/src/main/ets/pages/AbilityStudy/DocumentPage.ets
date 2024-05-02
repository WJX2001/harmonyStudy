import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'

@Entry
@Component
struct DocumentPage {
  @State title: string = '标题'
  @State content: string = ''
  @State message: string = 'Hello World'
  @State editTitle: boolean = true
  private context = getContext(this) as common.UIAbilityContext

  build() {
    Row() {
      Column({ space: 10 }) {
        Row({ space: 10 }) {
          Image($r('app.media.return'))
            .width(30)
            .onClick(() => {
              // 跳转到文档列表的 UIAbility
              let want: Want = {
                deviceId: '',
                bundleName: 'com.example.myapplication2',
                moduleName:'entry',
                abilityName:'EntryAbility',
              }
              // 跳转
              this.context.startAbility(want)
            })
          if (!this.editTitle) {
            Text(this.title)
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
          }else {
            TextInput({placeholder:'请输入'})
              .layoutWeight(1)
              .onChange((e) => {
                this.title = e
              })
            Button('确定')
              .onClick(() => {
                if(this.title) {
                  this.editTitle = !this.editTitle
                }
              })
          }


        }
        .width('100%')
        .height(50)
        .alignItems(VerticalAlign.Center)
        Divider()
        Row() {
          TextArea({placeholder:'请输入'})
            .height('100%')
        }.height('100%')
      }
      .width('100%')
      .height('100%')
    }
  }
}