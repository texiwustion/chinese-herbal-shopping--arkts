import relationalStore from '@ohos.data.relationalStore'
import { CommonTable } from '../models/CommonTable';

export default class CommonConstants {

  // Rdb 数据库配置
  static readonly STORE_CONFIG: relationalStore.StoreConfig = {
    name:'database.db',
    securityLevel:relationalStore.SecurityLevel.S1
  }

  static readonly USER_TABLE: CommonTable = {
    tableName:'userTable',
    sqlCreate:'CREATE TABLE IF NOT EXISTS userTable(username TEXT PRIMARY KEY, password TEXT)',
    columns:['username', 'password']
  }
  
  static readonly HERBAL_TABLE: CommonTable = {
    tableName: 'herbalTable',
    sqlCreate: 'CREATE TABLE IF NOT EXISTS herbalTable(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, image TEXT, price INTEGER, class TEXT, count INTEGER, description TEXT)',
    columns: ['id', 'name', 'image', 'price', 'class', 'count', 'description']
  }

  static readonly HERBAL_TABLE_TAG = '[Debug.herbalTable]'

  static readonly RDB_TAG = '[Debug.Rdb]';
  static readonly TABLE_TAG = '[Debug.userTable]';
  static readonly INDEX_TAG = '[Debug.Index]';

}