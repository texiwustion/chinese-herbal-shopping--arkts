import { ColorConstants } from '../constants/ColorConstants'
import { StyleConstants } from '../constants/StyleConstants'
@Component
struct Home {

  @Builder
  SearchBox() {
    Column() {
      Row() {
        Flex({alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround}) {
          TextInput({placeholder: '搜索药材/分类'})
            .backgroundColor(Color.White)
            .placeholderColor(ColorConstants.PLACEHOLDER)
            .maxLength(20)
          Image($r('app.media.search'))
            .width('20vp')
            .height('20vp')
            .margin({
              right: '8vp'
            })
        }

      }
      .height('40vp')
      .width(StyleConstants.WIDTH_FULL)
      .borderRadius('20vp')
      .backgroundColor(Color.White)
    }
    .width(StyleConstants.WIDTH_FULL)
    .padding({ top: '12vp', bottom: '12vp' })
  }

  build() {
    Row() {
      Flex({direction: FlexDirection.Column}) {
        this.SearchBox()
      }
      .padding({
        left: '12vp',
        right: '12vp'
      })
    }
    .height('100%')
  }
}

@Builder
export default function HomeRender() {
  Home()
}