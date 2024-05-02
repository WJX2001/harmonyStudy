import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import { Header } from '../../components/CommonComponents'

@Entry
@Component
struct DocumentListPage {
  @State message: string = 'Hello World'
  @State docs: number[] = []
  private index: number = 1

  private context = getContext(this) as common.UIAbilityContext

  build() {
    Row() {
      Column({ space: 10 }) {
        Header({ title: '文档列表' })
        Divider()
        Button('新建文档')
          .onClick(() => {
            // 添加文档
            this.docs.push(this.index++)
            // 跳转到文档编辑的 UIAbility

            // 跳转目的地 want
            let want: Want = {
              deviceId: '',
              bundleName: 'com.example.myapplication2',
              moduleName:'entry',
              abilityName:'DocumentAbility',
              parameters: {
                instanceKey: 'idx_' + this.index++
              }
            }
            // 跳转
            this.context.startAbility(want)
          })

        ForEach(this.docs, id => {
          Row({ space: 10 }) {
            Image($r('app.media.document'))
              .width(20)
            Text(`文档${id}`)
              .fontSize(18)
              .onClick(() => {
                // 跳转到文档编辑的UIAbility
                let want: Want = {
                  deviceId: '',
                  bundleName: 'com.example.myapplication2',
                  moduleName:'entry',
                  abilityName:'DocumentAbility',
                  parameters: {
                    instanceKey: 'idx_' + id
                  }
                }
                // 跳转
                this.context.startAbility(want)
              })
          }
          .width('100%')
        })

      }
      .height('100%')
    }
    .height('100%')
  }
}