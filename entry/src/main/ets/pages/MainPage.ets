import { StyleConstants } from '../constants/StyleConstants'
import { ITabItem } from '../models/ViewModel'
import Home from '../views/HomePage'
import Cart from '../views/CartPage'
import Mine from '../views/MinePage'
import RenderComponent from '../components/RenderComponent'

@Entry
@Component
struct Main {
  /**
   * Tabs 的控制器
   */
  private controller: TabsController = new TabsController()
  private tabItems: Array<ITabItem> = [
    {title: '主页', render: Home},
    {title: '购物车', render: Cart},
    {title: '我的', render: Mine}
  ]

  build() {
    Row() {
      Tabs({barPosition: BarPosition.End}) {
        /**
         * 数据抽象上升到 tabItems, 用 ForEach 渲染
         */
        ForEach(this.tabItems, (tabItem: ITabItem) => {
          TabContent() {
            Column() {
              RenderComponent({content: tabItem.render})
            }
              .columnDemo(Color.Pink)
          }
          .tabBar(tabItem.title)
        }, (tabItem: ITabItem) => JSON.stringify(tabItem))
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
