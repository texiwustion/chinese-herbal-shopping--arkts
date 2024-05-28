import { ColorConstants } from '../constants/ColorConstants'
import PurchasedList from '../features/PurchasedList'
import { fakeOrderItems } from '../models/DataModel'
import { IOrderModel } from '../models/ViewModel'
import { getPurchasedItems } from '../utils/cartUtil'


@Component
struct Mine {
  private username = AppStorage.Link('username').get()
  @StorageLink('orders') orders: IOrderModel[] = []

  build() {
    Row() {
      Flex({direction: FlexDirection.Column, justifyContent: FlexAlign.Start}) {
        Column() {
          Text(`${this.username}, 欢迎来到中药材商城 !`)
            .fontSize('21fp')
        }
        .padding('20vp')
        .margin('10vp')
        .width('100%')
        .margin({
          top: '20vp'
        })
        .border({
          color: ColorConstants.GREEN_LIGHT,
          width: '2vp',
          style: BorderStyle.Dotted
        })

        Text('已购药材列表')
          .fontSize('21fp')
          .fontColor(ColorConstants.GREEN_DEEP)
          .margin('10vp')

        PurchasedList()
      }

    }
    .height('100%')
  }
}

@Builder
export default function MineRender() {
  Mine()
}