import { CounterProduct } from '../components/CounterProduct';
import { ColorConstants } from '../constants/ColorConstants';
import { StyleConstants } from '../constants/StyleConstants';
import { IOrderModel } from '../models/ViewModel'
import { getCartItems } from '../utils/cartUtil';
@Component
struct CartList {
  @StorageLink('orders') orders: IOrderModel[] = []
  @StorageLink('test') test: number = 1

  handleDelete(item: IOrderModel) {
    console.info(`购物车列表 -- 点击了删除 -- 项id = ${item.id}`)
    this.orders = this.orders.filter(order => order.id !== item.id);
    this.test += 1
  }

  build() {
    List() {
      ForEach(getCartItems(this.orders), (item: IOrderModel) => {
        ListItem() {
          Flex({alignItems: ItemAlign.Center}) {
            Column() {
              Image($r('app.media.circle_x'))
                .width('24vp')
                .height('24vp')
                .onClick(() => {
                  this.handleDelete(item)
                })
            }
            .margin({
              left: '10vp',
              right: '20vp'
            })


            Image(item.herbal.image)
              .width('100vp')
              .objectFit(ImageFit.Contain)

            Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceAround }) {
              Text(item.herbal.name)
                .fontSize('14fp')
                .margin({ bottom: '8vp' })
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(2)
                .width(StyleConstants.WIDTH_FULL)
              Flex({ justifyContent: FlexAlign.SpaceBetween }) {
                Text() {
                  Span('￥')
                    .fontSize('12fp')
                    .fontColor(ColorConstants.RED)
                  Span(`${item.herbal.price}`)
                    .fontSize('16fp')
                    .fontColor(ColorConstants.RED)
                }

                CounterProduct({
                  count: item.quantity,
                  onNumberChange: (num: number) => {
                    this.orders = this.orders.map(order => {
                      if (order.id === item.id) {
                        return { ...order, quantity: num };
                      }
                    })
                    this.test += 1
                  }
                })
              }
            }
            .margin({
              left: '16vp',
              top: '12vp',
              bottom: '12vp'
            })
            .width(StyleConstants.WIDTH_FULL)
          }
          .padding('10vp')
          .borderRadius('16vp')
          .backgroundColor(0xfafafa)

        }
        .padding('10vp')
      }, (item: IOrderModel) => item.id.toString())
    }
    .width('100%')
  }
}

export default CartList