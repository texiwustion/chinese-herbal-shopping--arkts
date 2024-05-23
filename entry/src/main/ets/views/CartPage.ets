import { fakeOrderItems } from '../models/DataModel'
import CartList from '../features/CartList'
import { getCartItems } from '../utils/cartUtil'
import { ColorConstants } from '../constants/ColorConstants'

@Component
struct Cart {
  @State totalPrice: number = 666

  build() {
    Row() {
      Flex({direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceBetween}) {
        CartList({cartData: getCartItems(fakeOrderItems)})

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