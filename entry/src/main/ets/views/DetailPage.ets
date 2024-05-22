@Entry
@Component
struct Detail {

  build() {
    Row() {
      Navigation() {
        Text('药材详情')
      }
      .title('药材详情')
      .titleMode(NavigationTitleMode.Mini)
    }
    .height('100%')
  }
}

export default Detail