@Component
struct Home {

  build() {
    Row() {
      Text('首页')
    }
    .height('100%')
  }
}

@Builder
export default function HomeRender() {
  Home()
}