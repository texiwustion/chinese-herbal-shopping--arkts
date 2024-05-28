import { ColorConstants } from '../constants/ColorConstants'
import { StyleConstants } from '../constants/StyleConstants'
import { classifyTitle, herbalInfo } from '../models/DataModel'
import { IHerbalModel } from '../models/ViewModel'
import router from '@ohos.router'
import groupByClass from '../utils/groupByClass'
import HerbalTable from '../database/HerbalTable'

@Component
struct Home {
  private HerbalTable = new HerbalTable(() => {})
  @State groupedHerbalInfo: { [key: string]: IHerbalModel[] } = {}

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
      ForEach(Object.keys(this.groupedHerbalInfo), (item: string, index?: number) => {
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
    .margin({ top: '8vp', bottom: '8vp' })
    .width(StyleConstants.WIDTH_FULL)
  }

  @Builder
  HerbalItem(info: IHerbalModel) {
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
      .borderRadius('4vp')
    }
    .padding('12vp')
    .height('263vp')
    .width(StyleConstants.WIDTH_FULL)
    .backgroundColor(0xf9f9f9)
    .borderRadius('8vp')
    .onClick(() => {
      console.info('用户点击了药材卡片, 该药材的 id = ' + info.id)
      router.pushUrl({
        url: 'views/DetailPage', // 目标url
        params: info
      }, router.RouterMode.Standard, (err) => {
        if (err) {
          console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
          return;
        }
        console.info('Invoke pushUrl succeeded.');
      });
    })
  }
  
  @Builder
  GroupView() {
      ForEach(Object.keys(this.groupedHerbalInfo), (_class: string) => {
        Text(_class)
          .fontSize('21fp')
          .fontColor(ColorConstants.GREEN_DEEP)
        List() {
          ForEach(this.groupedHerbalInfo[_class], (item: IHerbalModel) => {
            ListItem() {
              this.HerbalItem(item)
            }
            .margin('10vp')
          }, (item: IHerbalModel) => item.id.toString())
        }
        .lanes(2)
        .margin('12vp')
        .padding({
          top: '10vp',
          bottom: '10vp'
        })
        .constraintSize({minHeight: 100})

      }, (_class: string) => _class)
  }

  async aboutToAppear() {
    this.HerbalTable.getRdbStore(() => {
      this.HerbalTable.loadData(() => {
        this.HerbalTable.queryAll((result: IHerbalModel[]) => {
          this.groupedHerbalInfo = groupByClass(result)
        });
      })
    })
  }

  build() {
    Row() {
      Flex({direction: FlexDirection.Column}) {
        this.SearchBox()
        this.ClassifyTitle()
        Scroll() {
          Flex({direction: FlexDirection.Column}) {
            this.GroupView()
          }
        }
        .layoutWeight(1)
        // .scrollBar(BarState.Off)
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