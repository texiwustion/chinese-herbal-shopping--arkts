@Entry
@Component
struct Login {
  @State message: string = '欢迎登录中药材商城'

  build() {
    Row() {
      Column() {
        Image($r("app.media.icon"))
          .width('80vp')
          .height('80vp')
          .margin({bottom: '30vp'})
        Text(this.message)
          .fontSize('30fp')
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}