import { generateKeyPair, encryptMessage, decryptMessage } from '../utils/hashPassword';
import relationalStore from '@ohos.data.relationalStore';
import CommonConstants from '../constants/CommonConstants';
import Rdb from './Rdb';
import { IUserModel } from '../models/ViewModel';

export default class UserTable {
  // 使用常量文件“CommonConstants”中配置的参数，实例化userTable对象
  private userTable = new Rdb(CommonConstants.USER_TABLE.tableName, CommonConstants.USER_TABLE.sqlCreate, CommonConstants.USER_TABLE.columns);
  private keyPair;

  constructor(callback: Function = () => {}) {
    this.userTable.getRdbStore(callback);
    this.initKeys();
  }

  async initKeys() {
    // 初始化密钥对
    this.keyPair = await generateKeyPair();
  }

  async register(user: IUserModel, callback: Function) {
    console.info('正在注册用户: ', JSON.stringify(user))
    // 插入用户数据
    this.insertData(user, callback);
  }

  async login(username: string, password: string, callback: Function) {
    this.query(username, async (users: IUserModel[]) => {
      if (users.length > 0) {
        let user: IUserModel = users[0]
        if (user.password === password) {
          // 登录成功
          callback(null);
        } else {
          // 密码错误
          callback(new Error('Invalid password'));
        }
      } else {
        // 用户名不存在
        callback(new Error('Username not found'));
      }
    });
  }

  // 插入数据的方法，接收单个用户数据对象，和回调函数
  insertData(user: IUserModel, callback: Function) {
    // 首先查询是否已经存在具有同名的用户
    this.query(user.username, (result) => {
      if (result.length > 0) {
        // 如果存在同名的用户，调用回调函数，并传入错误信息
        callback(new Error('Username already exists'));
      } else {
        // 通过工具函数，将用户数据，转化为存储键值对
        const valueBucket = this.generateBucket(user);
        // 如果没有同名的用户，执行userTable的插入数据方法，透传回调函数
        this.userTable.insertData(valueBucket, callback);
        callback(null);
      }
    });
  }

  // 查询用户数据的方法
  query(username, callback: Function) {
    // 初始化操作数据库的谓词对象
    let predicates = new relationalStore.RdbPredicates(CommonConstants.USER_TABLE.tableName);
    // 使用谓词执行userTable的查询方法，此时谓词匹配指定username
    predicates.equalTo('username', username);
    this.userTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      // 创建局部变量，存储结果的行数
      let count: number = resultSet.rowCount;
      // 如果查询的结果为0，执行回调函数，传入空数组
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG}` + 'Query no results!');
        callback([]);
      } else {
        // 如果有结果，将结果集指向第一行
        resultSet.goToFirstRow();
        // 创建局部变量，存储最后将返回的结果数组
        const result: IUserModel[] = [];
        // 使用循环为结果添加内容
        for (let i = 0; i < count; i++) {
          let tmp: IUserModel = {
            username: '',
            password: ''
          };
          tmp.username = resultSet.getString(resultSet.getColumnIndex('username'));
          tmp.password = resultSet.getString(resultSet.getColumnIndex('password'));
          result[i] = tmp;
          // 转至下一行
          resultSet.goToNextRow();
        }
        // 执行回调函数，把所有的查询结果传入
        callback(result);
      }
    });
  }

  // 工具函数，将用户数据的数据结构，转化为存储键值对
  generateBucket(user: IUserModel) {
    let obj: relationalStore.ValuesBucket = {};
    obj.username = user.username;
    obj.password = user.password;
    return obj;
  }
}