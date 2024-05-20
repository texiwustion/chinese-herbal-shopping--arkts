@Component
struct Mine {

  build() {
    Row() {
      Text('我的')
    }
    .height('100%')
  }
}

@Builder
export default function MineRender() {
  Mine()
}