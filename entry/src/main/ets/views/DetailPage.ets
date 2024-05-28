import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

import { ColorConstants } from '../constants/ColorConstants'
import { IHerbalModel, IOrderModel } from '../models/ViewModel'
import { filterCommentsByHerbalId } from '../utils/commentUtil'
import CommentList from '../features/CommentList'
import { fakeComments } from '../models/DataModel'
import { CounterProduct } from '../components/CounterProduct'

@Entry
@Component
struct Detail {
  private info: IHerbalModel
  private username = AppStorage.Link('username').get()

  @State count: number = 0
  @StorageLink('orders') _orders: IOrderModel[] = []
  @StorageLink('test') test: number = 1


  aboutToAppear() {
    this.info = router.getParams() as IHerbalModel
    console.info('药材详情页收到参数: ', JSON.stringify(this.info))
    console.info('用户名: ', this.username)
  }

  // 处理 "直接购买" 和 "加入购物车" 的点击事件
  handlePurchaseOrAddToCart(actionType: 'purchase' | 'addToCart') {
    if (this.count === 0) {
      // 显示提示消息
      promptAction.showToast({
        message: '购买数量不能为零',
        duration: 3000,
        bottom: '60vp'
      });
      return;
    }

    if (actionType === 'addToCart') {
      let existingOrder = this._orders.find(order => order.herbal.id === this.info.id && order.status === 'added');
      if (existingOrder) {
        // 如果该药材已存在于购物车中，增加数量
        existingOrder.quantity += this.count;
      } else {
        // 创建新的订单项
        this._orders.push({
          id: Date.now(),   // 使用时间戳作为唯一ID
          herbal: this.info,
          quantity: this.count,
          username: this.username,
          status: 'added'
        });
      }
      promptAction.showToast({
        message: '加入购物车成功',
        duration: 3000,
        bottom: '60vp'
      });
    } else if (actionType === 'purchase') {
      // 创建立即购买的订单项
      this._orders.push({
        id: Date.now(),
        herbal: this.info,
        quantity: this.count,
        username: this.username,
        status: 'purchased'
      });
      promptAction.showToast({
        message: '直接购买成功',
        duration: 3000,
        bottom: '60vp'
      });
    }
    this.test += 1;

    this.count = 1;
  }

  build() {
    Row() {
      Navigation() {
        Flex({direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceBetween}) {
          Scroll() {
            Column() {
              Image(this.info.image)
                .width('100%')
                .height('300vp')
                .objectFit(ImageFit.Cover)
                .backgroundColor(Color.White)

              Column() {
                Text(`${this.info.price} 元 / 1000 克`)
                  .fontSize('18fp')
                  .fontColor(ColorConstants.RED)

                Text(`${this.info.class}/${this.info.name}`)
                  .fontSize('18fp')
              }
              .alignItems(HorizontalAlign.Start)
              .backgroundColor(0xf8f8f8)
              .width("100%")
              .borderRadius('4vp')
              .margin('20vp')
              .padding('10vp')

              // 药材描述和剩余库存 -- 文字
              Column() {
                Text(`药材描述: ${this.info.description ? this.info.description : "无"}`)
                  .fontSize('15fp')

                Text(`剩余库存: ${this.info.count ? this.info.count : "无可用信息"}`)
                  .fontSize('15fp')
              }
              .alignItems(HorizontalAlign.Start)
              .backgroundColor(0xf8f8f8)
              .width("100%")
              .borderRadius('4vp')
              .padding('10vp')

              // 评价信息--列表
              Column() {
                Text('评价信息')
                  .fontSize('21fp')
                  .margin('10vp')
                CommentList({commentData: filterCommentsByHerbalId(fakeComments, this.info.id)})
              }
              .backgroundColor(0xf8f8f8)
              .borderRadius('4vp')
              .margin({
                top: '10vp'
              })
              .alignItems(HorizontalAlign.Start)
            }
            .padding('10vp')
          }

          Flex({direction: FlexDirection.Row, justifyContent: FlexAlign.End, alignItems: ItemAlign.Center}) {
            Image($r('app.media.cart_0'))
              .width('25vp')
              .height('25vp')
              .margin('10vp')
              .onClick(() => {
                console.info('用户点击了药材详情页的购物车图标')
                router.pushUrl({
                  url: 'views/CartEntry', // 目标url
                }, router.RouterMode.Standard, (err) => {
                  if (err) {
                    console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                    return;
                  }
                  console.info('Invoke pushUrl succeeded.');
                });
              })
            CounterProduct({
              count: this.count,
              onNumberChange: (num: number) => {
                this.count = num
              }
            })
            Button('加入购物车', { type: ButtonType.Normal, stateEffect: true })
              .margin({
                left: '10vp'
              })
              .backgroundColor(ColorConstants.GREEN_DEEP)
              .onClick(() => { this.handlePurchaseOrAddToCart('addToCart') })
            Button('直接购买', { type: ButtonType.Normal, stateEffect: true })
              .margin('10vp')
              .backgroundColor(ColorConstants.GREEN_DEEP)
              .onClick(() => { this.handlePurchaseOrAddToCart('purchase') })
          }
          .height('60vp')
        }
      }
      .title('药材详情')
      .titleMode(NavigationTitleMode.Mini)
    }
    .height('100%')
  }
}

export default Detail