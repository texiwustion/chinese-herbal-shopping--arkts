import { ColorConstants } from '../constants/ColorConstants'
import { StyleConstants } from '../constants/StyleConstants'

@Entry
@Component
struct Login {
  @State message: string = '欢迎登录中药材商城'
  @State username: string = ""
  @State password: string = ""

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

        /**
          用户名和密码 -- 输入
         */
        TextInput({placeholder: "请输入用户名"})
          .placeholderColor(ColorConstants.PLACEHOLDER)
          .maxLength(StyleConstants.USERNAME_MAX_LENGTH) // 用户名最大长度: 6
          .padding(StyleConstants.TEXT_INPUT_PADDING)
          .margin(StyleConstants.TEXT_INPUT_MARGIN)
          .onChange(data => {
            this.username = data;
            console.info('username: ' + data);
          })
        TextInput({placeholder: "请输入密码"})
          .type(InputType.Password)
          .placeholderColor(ColorConstants.PLACEHOLDER)
          .maxLength(StyleConstants.USERNAME_MAX_LENGTH) // 用户名最大长度: 6
          .padding(StyleConstants.TEXT_INPUT_PADDING)
          .margin(StyleConstants.TEXT_INPUT_MARGIN)
          .onChange(data => {
            this.password = data;
            console.info('password: ' + data);
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}