import { fakeOrderItems } from '../models/DataModel'
import CartList from '../features/CartList'
import { getCartItems } from '../utils/cartUtil'
import { ColorConstants } from '../constants/ColorConstants'
import { IOrderModel } from '../models/ViewModel'
import promptAction from '@ohos.promptAction'

@Component
struct Cart {
  @StorageLink('orders') orders: IOrderModel[] = []
  @StorageLink('test') @Watch('ordersChanged') test: number = 1

  @State totalPrice: number = this.calculateTotalPrice();

  // 计算订单总价的方法
  calculateTotalPrice() {
    return this.orders.reduce((sum, order) => {
      console.info('订单: 状态 ', order.status === 'added')
      return sum + (order.status === 'added' ? (order.herbal.price * order.quantity) : 0);
    }, 0);
  }

  ordersChanged() {
    console.info('订单: 全局变动, 数量 -> ', this.orders.length)
    this.totalPrice = this.calculateTotalPrice();
  }

  build() {
    Row() {
      Flex({direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceBetween}) {
        CartList()
        Flex({direction: FlexDirection.Row, justifyContent: FlexAlign.End, alignItems: ItemAlign.Center}) {
          Text() {
            Span('￥')
              .fontSize('12fp')
              .fontColor(ColorConstants.RED)
            Span(`${this.totalPrice}`)
              .fontSize('16fp')
              .fontColor(ColorConstants.RED)
          }
          Button('支付', { type: ButtonType.Normal, stateEffect: true })
            .margin('10vp')
            .backgroundColor(ColorConstants.GREEN_DEEP)
            .onClick(() => {
              this.orders = this.orders.map(order => ({
                ...order,
                status: 'purchased'
              }));
              promptAction.showToast({
                message: '支付成功',
                duration: 3000,
                bottom: '60vp'
              });
              this.test += 1
            })
        }

      }
      .height('100%')
      .width('100%')
    }
    .height('100%')
  }
}

@Builder
export default function CartRender() {
  Cart()
}