import { CounterProduct } from '../components/CounterProduct';
import { ColorConstants } from '../constants/ColorConstants';
import { StyleConstants } from '../constants/StyleConstants';
import { IOrderModel } from '../models/ViewModel'
@Component
struct CartList {
  private cartData: IOrderModel[];

  aboutToAppear() {
    console.info('购物车列表数据: ', JSON.stringify(this.cartData))
  }

  handleDelete(item: IOrderModel) {
    console.info(`购物车列表 -- 点击了删除 -- 项id = ${item.id}`)
  }

  build() {
    List() {
      ForEach(this.cartData, (item: IOrderModel) => {
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
                  count: 5,
                  onNumberChange: (num: number) => {
                    console.info(`触发了 onNumberChange 事件, 把改变后的 count = ${num} 持久化存储`)
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