import router from '@ohos.router'
import { IHerbalModel } from '../models/ViewModel'

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
        Scroll() {
          Image(this.info.image)
            .width('100%')
            .height('300vp')
            .objectFit(ImageFit.Contain)
        }

      }
      .title('药材详情')
      .titleMode(NavigationTitleMode.Mini)
    }
    .height('100%')
  }
}

export default Detail