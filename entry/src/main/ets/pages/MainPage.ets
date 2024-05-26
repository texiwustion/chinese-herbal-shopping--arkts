import { StyleConstants } from '../constants/StyleConstants'
import { ITabItem } from '../models/ViewModel'
import Home from '../views/HomePage'
import Cart from '../views/CartPage'
import Mine from '../views/MinePage'
import RenderComponent from '../components/RenderComponent'
import { ColorConstants } from '../constants/ColorConstants'
import { herbalTable } from '../database/HerbalTable'

@Entry
@Component
struct Main {
  /**
   * Tabs 的控制器
   */
  private controller: TabsController = new TabsController()
  private tabItems: Array<ITabItem> = [
    {title: '主页', render: Home, iconUnselected: $r('app.media.home_0'), iconSelected: $r('app.media.home_1')},
    {title: '购物车', render: Cart, iconUnselected: $r('app.media.cart_0'), iconSelected: $r('app.media.cart_1')},
    {title: '我的', render: Mine, iconUnselected: $r('app.media.mine_0'), iconSelected: $r('app.media.mine_1')}
  ]


  @State currentTabIndex: number = 0
  @Builder TabBuilder(tabItem: ITabItem, index) {
    Column() {
      Image(this.currentTabIndex === index ? tabItem.iconSelected : tabItem.iconUnselected)
        .width('25vp')
        .height('25vp')
      Text(tabItem.title)
        .fontSize('14fp')
        .fontWeight(500)
        .margin({top: StyleConstants.MARGIN_LESS})
    }
  }

  async aboutToAppear() {
    await herbalTable.loadData(() => {
      console.info('[herbalTable] 加载药材数据完成')
    })
  }

  build() {
    Row() {
      Tabs({barPosition: BarPosition.End, controller: this.controller}) {
        /**
         * 数据抽象上升到 tabItems, 用 ForEach 渲染
         */
        ForEach(this.tabItems, (tabItem: ITabItem, index: number) => {
          TabContent() {
            Column() {
              RenderComponent({content: tabItem.render})
            }
            .columnDemo(Color.White)
          }
          .tabBar(this.TabBuilder(tabItem, index))
        }, (tabItem: ITabItem) => JSON.stringify(tabItem))
      }
      .vertical(false)
      .barWidth(StyleConstants.WIDTH_FULL)
      .barHeight('60vp')
      .animationDuration(100)
      .onChange((index: number) => {
        this.currentTabIndex = index
      })
    }
    .height('100%')
  }
}

@Extend(Column) function columnDemo(color: Color) {
  .width('100%')
  .height('100%')
  .backgroundColor(color)
}
