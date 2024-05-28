import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

import { ColorConstants } from '../constants/ColorConstants'
import { StyleConstants } from '../constants/StyleConstants'
import UserTable from '../database/UserTable';

AppStorage.SetOrCreate('username', '');
// 全局订单列表
AppStorage.SetOrCreate('orders', []);
AppStorage.SetOrCreate('test', 1);

@Entry
@Component
struct Login {
  private userTable = new UserTable(() => {
    console.log('RdbStore initialized.');
  });
  private authTitle: Array<string> = ['注册', '登录']

  @State authIndex: number = 1
  @State message: string = '欢迎登录中药材商城'
  @State username: string = ""
  @State password: string = ""
  @State confirmPassword: string = ""

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
        if (this.authIndex === 0) {
          TextInput({placeholder: "请再次输入密码"})
            .type(InputType.Password)
            .maxLength(StyleConstants.PASSWORD_MAX_LENGTH) // 密码最大长度: 20
            .inputStyle()
            .onChange(data => {
              this.confirmPassword = data;
              console.info('confirmPassword: ' + data);
            })

        }

        /**
         * 帮助文字 -- 忘记密码
         */
        Flex({justifyContent: FlexAlign.SpaceBetween}) {
          Text(this.authTitle[1 - this.authIndex])
            .fontSize('18fp')
            .fontColor(Color.Blue)
            .onClick(() => {
              this.authIndex = 1 - this.authIndex;
              this.confirmPassword = ''
            })

          Text('忘记密码')
            .fontSize('18fp')
            .fontColor(Color.Blue)
        }
        .width(StyleConstants.WIDTH_NORMAL)

        /**
         * 登录按钮 -- 点击进行用户验证等事件
         */
        if (this.authIndex === 1) {
          Button('登录', {type: ButtonType.Capsule, stateEffect: true})
            .width(StyleConstants.WIDTH_NORMAL)
            .margin(StyleConstants.MARGIN_NORMAL)
            .onClick(async () => {
              console.info('用户点击了登录按钮')
              if (this.username == '' || this.password == '') {
                console.info('用户名或者密码为空')
                promptAction.showToast({
                  message: '用户名或密码不能为空',
                  duration: 3000,
                  bottom: '60vp'
                })
                return
              }
              console.info('登录--准备验证信息')
              // 登录
              await this.userTable.login(this.username, this.password, (err) => {
                if (err) {
                  console.error('Login Error:', err);
                  promptAction.showToast({
                    message: '用户不存在或密码错误',
                    duration: 3000,
                    bottom: '60vp'
                  })
                } else {
                  // 全局变量
                  AppStorage.Link('username').set(this.username)
                  router.replaceUrl({
                    url: 'pages/MainPage',
                  }).catch((error: Error) => {
                    console.info('触发 router 路由事件时发生了错误: ', error)
                  })
                }
              });

            })
        } else {
          Button('注册', {type: ButtonType.Capsule, stateEffect: true})
            .width(StyleConstants.WIDTH_NORMAL)
            .margin(StyleConstants.MARGIN_NORMAL)
            .onClick(async () => {
              console.info('用户点击了注册按钮')
              if (this.username == '' || this.password == '') {
                console.info('用户名或者密码为空')
                promptAction.showToast({
                  message: '用户名或密码不能为空',
                  duration: 3000,
                  bottom: '60vp'
                })
                return
              }
              if (this.password !== this.confirmPassword) {
                console.info('两次密码输入不一致')
                promptAction.showToast({
                  message: '两次密码输入不一致',
                  duration: 3000,
                  bottom: '60vp'
                })
                return
              }
              // 注册
              await this.userTable.register({username: this.username, password: this.password}, (err) => {
                if (err) {
                  console.error('Registration Error:', err);
                } else {
                  console.log('Registration Successful');
                  promptAction.showToast({
                    message: '注册成功',
                    duration: 3000,
                    bottom: '60vp'
                  })
                  this.authIndex = 1;
                }
              });

            })
        }

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

export default Login