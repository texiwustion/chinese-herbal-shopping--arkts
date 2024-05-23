import { CounterProduct } from '../components/CounterProduct';
import { ColorConstants } from '../constants/ColorConstants';
import { StyleConstants } from '../constants/StyleConstants';
import { IOrderModel } from '../models/ViewModel'
@Component
struct PurchasedList {
  private purchasedData: IOrderModel[];

  aboutToAppear() {
    console.info('已购药材列表数据: ', JSON.stringify(this.purchasedData))
  }

  build() {
    List() {
      ForEach(this.purchasedData, (item: IOrderModel) => {
        ListItem() {
          Flex({alignItems: ItemAlign.Center}) {
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

                Text('5份')
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

export default PurchasedList