import { ColorConstants } from '../constants/ColorConstants'
import { StyleConstants } from '../constants/StyleConstants'
import { classifyTitle } from '../models/DataModel'
@Component
struct Home {
  @State titleIndex: number = 0
  @State activityTitleIndex: number = 0

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

  @Builder
  ClassifyTitle() {
    Flex({ justifyContent: FlexAlign.Start, wrap: FlexWrap.Wrap }) {
      ForEach(classifyTitle, (item: string, index?: number) => {
        Text(item)
          .fontSize('18fp')
          .opacity(this.titleIndex === index ? 100 :  80)
          .fontWeight(this.titleIndex === index ? 700 : 400)
          .fontColor(ColorConstants.GREEN_DEEP)
          .margin({
            left: StyleConstants.MARGIN_LESS,
            right: StyleConstants.MARGIN_LESS
          })
          .onClick(() => {
            if (index !== undefined) {
              this.titleIndex = index;
            }
          })
      }, (item: Resource) => JSON.stringify(item))
    }
    .margin({ top: '8vp' })
    .width(StyleConstants.WIDTH_FULL)
  }

  build() {
    Row() {
      Flex({direction: FlexDirection.Column}) {
        this.SearchBox()
        this.ClassifyTitle()
        Scroll() {
          Column() {
          }
          .backgroundColor(Color.Orange)
          .height('800vp')
        }
        .scrollBar(BarState.Off)
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