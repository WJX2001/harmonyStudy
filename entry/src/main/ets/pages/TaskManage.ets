// 任务类
@Observed
class Task {
  // 静态变量（所有对象共享的变量）
  static id: number = 1
  // 任务名称
  name: string = `任务${Task.id++}`
  // 任务状态，是否完成
  finished: boolean = false
}

// 统一的卡片样式
@Styles function card() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

// 任务完成样式
@Extend(Text) function finishedTask() {
  .decoration({ type: TextDecorationType.LineThrough })
  .fontColor('#B1B2B1')
}


@Entry
@Component
struct PropPage {
  // 总任务数量
  @State totalTask: number = 0
  // 已完成任务数量
  @State finishTask: number = 0
  // 任务数组
  @State tasks: Task[] = []
  // 使用provide 和 consume来组件透传
  @Provide stat: number = 1

  // 任务修改触发函数
  handleTaskChange() {
    // 更新任务总数量
    this.totalTask = this.tasks.length
    // 更新已完成的任务数量
    this.finishTask = this.tasks.filter(item => item.finished).length
  }

  build() {
    Column({ space: 10 }) {
      // 1.任务进度卡片组件
      TaskStaticComp({
        finishTask: this.finishTask,
        totalTask: this.totalTask
      })
      // 2.调用子组件
      TaskList({
        totalTask: $totalTask,
        finishTask: $finishTask,
        tasks: $tasks
      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')

  }
}

// 抽离组件 最上面任务进度展示抽离
@Component
struct TaskStaticComp {
  // 总任务数量
  @Prop totalTask: number
  // 已完成任务数量
  @Prop finishTask: number
  // 跨组件声明
  @Consume stat: number

  build() {
    Row() {
      Text('任务进度：')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Stack() {
        Progress({
          value: this.finishTask,
          total: this.totalTask,
          type: ProgressType.Ring
        })
          .width(100)
        Row() {
          Text(this.finishTask.toString())
            .fontSize(24)
            .fontColor('#36D')
          Text(' / ' + this.totalTask.toString())
            .fontSize(24)
            .fontColor('#36D')
        }
      }
    }
    .card()
    .margin({ top: 20, bottom: 10 })
    .justifyContent(FlexAlign.SpaceEvenly)

  }
}


// 任务列表进行抽离
@Component
struct TaskList {
  @Link totalTask: number
  // 已完成任务数量
  @Link finishTask: number
  // 任务数组
  @Link tasks: Task[]
  // 任务修改触发函数
  handleTaskChange() {
    // 更新任务总数量
    this.totalTask = this.tasks.length
    // 更新已完成的任务数量
    this.finishTask = this.tasks.filter(item => item.finished).length
  }

  build() {
    Column() {
      Button('新增任务')
        .width(200)
        .margin({
          bottom: 10
        })
        .onClick(() => {
          this.tasks.push(new Task())
          // 更新任务数量
          this.totalTask = this.tasks.length
        })
      List({ space: 10 }) {
        ForEach(
          this.tasks,
          (item: Task, index) => {
            ListItem() {
              // 传递方法的时候将this永远绑定，防止子组件调用的时候修改this指向
              TaskItem({ item: item, onTaskChange: this.handleTaskChange.bind(this) })
            }
            .swipeAction({ end: this.DeleteButton(index) })
          }
        )
      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }

  }

  // 自定义构建函数
  @Builder DeleteButton(index: number) {
    Button() {
      Image($r('app.media.delete'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor('#FFF')
    .margin(5)
    .onClick(() => {
      this.tasks.splice(index, 1)
      this.handleTaskChange()
    })
  }
}

@Component
struct TaskItem {
  @ObjectLink item: Task
  onTaskChange: () => void

  build() {
    Row() {
      if (this.item.finished) {
        Text(this.item.name)
          .finishedTask()
      } else {
        Text(this.item.name)
      }
      // Text(item.name)
      //   .fontSize(20)
      Checkbox()
        .select(this.item.finished)
        .onChange((val) => {
          // 更新当前任务状态
          this.item.finished = val
          // 更新已完成的任务数量
          this.onTaskChange()
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}


