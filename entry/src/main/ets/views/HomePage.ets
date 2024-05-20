import { ColorConstants } from '../constants/ColorConstants'
import { StyleConstants } from '../constants/StyleConstants'
import { classifyTitle, herbalInfo } from '../models/DataModel'
import { IHerbalItem } from '../models/ViewModel'
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

  @Builder
  HerbalItem(info: IHerbalItem) {
    Column() {
      Image(info.image)
        .width('132vp')
        .height('132vp')
        .objectFit(ImageFit.Cover)
        .margin({
          top: '16vp',
          bottom: '8vp'
        })
      Column() {
        Text(info.name)
          .fontColor(Color.Black)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontSize('18fp')
          .fontWeight(400)
          .lineHeight('20vp')
        Text(`${info.price} 元 / 1000g`)
          .fontColor(ColorConstants.RED)
          .fontSize('18fp')
          .margin({
            top: '4fp',
            bottom: '8fp'
          })
        Text(info.class)
          .fontSize('18fp')
          .fontColor(Color.White)
          .backgroundColor(ColorConstants.GREEN_DEEP)
          .borderRadius('4vp')
          .height('18vp')
          .padding({
            right: '8vp',
            left: '8vp'
          })
      }
      .width(StyleConstants.WIDTH_FULL)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(Color.White)
      .borderRadius('4vp')
    }
    .padding('12vp')
    .height('263vp')
    .width(StyleConstants.WIDTH_FULL)
    .backgroundColor(Color.White)
    .borderRadius('8vp')
  }

  build() {
    Row() {
      Flex({direction: FlexDirection.Column}) {
        this.SearchBox()
        this.ClassifyTitle()
        Scroll() {
          Grid() {
            ForEach(herbalInfo, (item: IHerbalItem) => {
              GridItem() {
                this.HerbalItem(item)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap('12vp')
          .columnsGap('8vp')
          .margin('12vp')
          .padding({
            top: '10vp',
            bottom: '10vp'
          })
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