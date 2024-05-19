import router from '@ohos.router';

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
          .margin({bottom: StyleConstants.MARGIN_MORE})
        Text(this.message)
          .fontSize('30fp')
          .fontWeight(FontWeight.Bold)

        /**
          用户名和密码 -- 输入
         */
        TextInput({placeholder: "请输入用户名"})
          .maxLength(StyleConstants.USERNAME_MAX_LENGTH) // 用户名最大长度: 6
          .inputStyle()
          .onChange(data => {
            this.username = data;
            console.info('username: ' + data);
          })
        TextInput({placeholder: "请输入密码"})
          .type(InputType.Password)
          .maxLength(StyleConstants.PASSWORD_MAX_LENGTH) // 密码最大长度: 20
          .inputStyle()
          .onChange(data => {
            this.password = data;
            console.info('password: ' + data);
          })

        /**
         * 帮助文字 -- 忘记密码
         */
        Row() {
          Text('忘记密码')
            .fontSize('18fp')
            .fontColor(Color.Blue)
        }
        .width(StyleConstants.WIDTH_NORMAL)
        .justifyContent(FlexAlign.End)

        /**
         * 登录按钮 -- 点击进行用户验证等事件
         */
        Button('登录', {type: ButtonType.Capsule, stateEffect: true})
          .width(StyleConstants.WIDTH_NORMAL)
          .margin(StyleConstants.MARGIN_NORMAL)
          .onClick(() => {
            console.info('用户点击了登录按钮')
            router.pushUrl({
              url: 'pages/MainPage'
            }).catch((error: Error) => {
              console.info('触发 router 路由事件时发生了错误: ', error)
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

/**
 * 公共的样式函数
 */
@Extend(TextInput) function inputStyle() {
  .placeholderColor(ColorConstants.PLACEHOLDER)
  .padding(StyleConstants.TEXT_INPUT_PADDING)
  .margin(StyleConstants.TEXT_INPUT_MARGIN)
}