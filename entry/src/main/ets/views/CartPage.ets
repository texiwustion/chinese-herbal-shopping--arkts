@Component
struct Cart {

  build() {
    Row() {
      Text('购物车')
    }
    .height('100%')
  }
}

@Builder
export default function CartRender() {
  Cart()
}