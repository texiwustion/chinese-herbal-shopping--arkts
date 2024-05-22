import CartRender from './CartPage'

@Entry
@Component
struct CartEntry {

  build() {
    Row() {
      Navigation() {
        CartRender()
      }
      .title('购物车')
      .titleMode(NavigationTitleMode.Mini)
    }
    .height('100%')
  }
}

export default CartEntry