import router from '@ohos.router';

class RouterInfo {
  // 页面路径
  url: string
  // 页面标题
  title: string

  constructor(url: string, title: string) {
    this.url = url;
    this.title = title;
  }
}


@Entry
@Component
struct Index {
  @State message: string = '页面列表'
  private routers: RouterInfo[] = [
    new RouterInfo('pages/StatePage', 'Jack和他女友案例'),
    new RouterInfo('pages/TaskManage', '任务列表案例'),
    new RouterInfo('pages/LifeCirclePage', '生命周期案例一'),
    new RouterInfo('pages/AbilityStudy/DocumentListPage','UIAbility启动模式案例')
  ]
  tag: string = 'index 声明文件'
  // 将所有的生命周期钩子声明出来
  aboutToAppear() {
    console.log(this.tag, 'about to appear')
  }

  onPageShow() {
    console.log(this.tag, 'on page show')
  }

  onBackPress() {
    console.log(this.tag, 'on back press')
  }

  onPageHide() {
    console.log(this.tag,'on page hide')
  }

  aboutToDisappear() {
    console.log(this.tag, 'about to dis')
  }


  build() {
    Column() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)

      List({ space: 15 }) {
        ForEach(
          this.routers,
          (item: RouterInfo, index) => {
            ListItem() {
              this.TaskItem(item, index + 1)
            }
          }
        )
      }
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
      .width('100%')

    }
    .width('100%')
    .height('100%')

  }

  @Builder TaskItem(item, index) {
    Row() {
      Text(index + '.')
        .fontSize(20)
        .fontColor(Color.White)
      Blank()
      Text(item.title)
        .fontSize(20)
        .fontColor(Color.White)
        .onClick((e) => {
          router.pushUrl(
            {
              url: item.url,
              params: {
                id: index
              }
            },
            router.RouterMode.Single,
            err => {
              if (err) {
                console.log(`路由失败，errCode:${err.code} errMsg:${err.message}`)
              }
            }

          )
        })
    }
    .backgroundColor('#38f')
    .padding(12)
    .width('90%')
    // .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(20)
    .shadow({ radius: 6, color: '#4F000000', offsetX: 2, offsetY: 4 })
    // .justifyContent(FlexAlign.Center)
  }
}