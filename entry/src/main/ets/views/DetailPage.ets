import router from '@ohos.router'
import { ColorConstants } from '../constants/ColorConstants'
import { IHerbalModel } from '../models/ViewModel'
import { filterCommentsByHerbalId } from '../utils/commentUtil'
import CommentList from '../features/CommentList'
import { fakeComments } from '../models/DataModel'

@Entry
@Component
struct Detail {
  private info: IHerbalModel

  aboutToAppear() {
    this.info = router.getParams() as IHerbalModel
    console.info('药材详情页收到参数: ', JSON.stringify(this.info))
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
                Text(`${this.info.price} 元 / 1000 g`)
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
            Button('加入购物车', { type: ButtonType.Normal, stateEffect: true })
              .margin({
                left: '10vp'
              })
              .backgroundColor(ColorConstants.GREEN_DEEP)
            Button('直接购买', { type: ButtonType.Normal, stateEffect: true })
              .margin('10vp')
              .backgroundColor(ColorConstants.GREEN_DEEP)
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