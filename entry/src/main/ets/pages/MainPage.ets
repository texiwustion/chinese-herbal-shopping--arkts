import { StyleConstants } from '../constants/StyleConstants'
@Entry
@Component
struct Main {
  /**
   * Tabs 的控制器
   */
  private controller: TabsController = new TabsController()

  build() {
    Row() {
      Tabs({barPosition: BarPosition.End}) {
        TabContent() {
          Column()
            .columnDemo(Color.White)
        }
        .tabBar('主页')

        TabContent() {
          Column()
            .columnDemo(Color.Pink)
        }
        .tabBar('购物车')

        TabContent() {
          Column()
            .columnDemo(Color.Orange)
        }
        .tabBar('我的')
      }
      .vertical(false)
      .barWidth(StyleConstants.WIDTH_FULL)
      .barHeight('60vp')
      .animationDuration(200)
    }
    .height('100%')
  }
}

@Extend(Column) function columnDemo(color: Color) {
  .width('100%')
  .height('100%')
  .backgroundColor(color)
}