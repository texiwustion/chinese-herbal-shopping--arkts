import relationalStore from '@ohos.data.relationalStore';
import CommonConstants from '../constants/CommonConstants';
import Rdb from './Rdb';
import { IHerbalModel } from '../models/ViewModel';

export default class HerbalTable {
  private herbalTable = new Rdb(CommonConstants.HERBAL_TABLE.tableName, CommonConstants.HERBAL_TABLE.sqlCreate, CommonConstants.HERBAL_TABLE.columns);
  // private static instance: HerbalTable = null

  constructor(callback: Function = () => {}) {
    this.herbalTable.getRdbStore(callback);
  }

  getRdbStore(callback: Function = () => {
  }) {
    // 透传回调函数
    this.herbalTable.getRdbStore(callback);
  }

  // static getInstance() {
  //   if (!HerbalTable.instance) {
  //     HerbalTable.instance = new HerbalTable(() => {
  //       console.info('[herbalTable] 创建药材表成功')
  //     })
  //   }
  //   return HerbalTable.instance
  // }

  async addHerb(herb: IHerbalModel, callback: Function) {
    console.info('Adding herb: ', JSON.stringify(herb));
    this.insertData(herb, callback);
  }

  // async updateHerb(herb: IHerbalModel, callback: Function) {
  //   console.info('Updating herb: ', JSON.stringify(herb));
  //   this.updateData(herb, callback);
  // }

  async deleteHerb(id: number, callback: Function) {
    console.info('Deleting herb with ID: ', id);
    this.deleteData(id, callback);
  }

  async queryHerbById(id: number, callback: Function) {
    this.queryById(id, (herbs: IHerbalModel[]) => {
      callback(herbs);
    });
  }

  async loadData(callback: Function) {
    console.info('[herbalTable] 开始加载数据')
    const herbs: IHerbalModel[] = HerbalTable.generateRandomHerbs(24);
    herbs.forEach(async (herb) => {
      await this.addHerb(herb, (err) => {
        if (err) {
          console.error('Failed to add herb:', err);
        }
      });
    });
    callback();
  }

  private static  generateRandomHerbs(count: number): IHerbalModel[] {
    const herbData = [
      {name: '黄芪', class: '根茎类'},
      {name: '人参', class: '根茎类'},
      {name: '甘草', class: '根茎类'},
      {name: '当归', class: '根茎类'},
      {name: '党参', class: '根茎类'},
      {name: '大黄', class: '根茎类'},
      {name: '白术', class: '根茎类'},
      {name: '白芍', class: '根茎类'},
      {name: '茯苓', class: '菌藻类'},
      {name: '川芎', class: '根茎类'},
      {name: '枸杞', class: '果实种子类'},
      {name: '白果', class: '果实种子类'}
    ];

    return Array.from({ length: count }, (_, index) => {
      const herb = herbData[index % herbData.length];
      return {
        id: index + 1,
        name: herb.name,
        image: `common/images/yc_${HerbalTable.getPinyin(herb.name)}.jpg`,
        price: Math.floor(Math.random() * 100),
        class: herb.class,
        count: Math.floor(Math.random() * 100),
        description: '这是一种非常常见的中药材'
      };
    });
  }

  private static getPinyin(chinese: string): string {
    // 这里让我们假设有一个简单的汉字转拼音的函数
    const pinyinMap: { [key: string]: string } = {
      '黄芪': 'huangqi',
      '人参': 'renshen',
      '甘草': 'gancao',
      '当归': 'danggui',
      '党参': 'dangshen',
      '大黄': 'dahuang',
      '白术': 'baishu',
      '白芍': 'baishao',
      '茯苓': 'fuling',
      '川芎': 'chuanxiong',
      '枸杞': 'gouqi',
      '白果': 'baiguo'
    };
    return pinyinMap[chinese] || 'wumingyaocai'; // 未知汉字返回默认拼音
  }

  insertData(herb: IHerbalModel, callback: Function) {
    const valueBucket = this.generateBucket(herb);
    this.herbalTable.insertData(valueBucket, callback);
    callback(null);
    // this.queryById(herb.id, (result) => {
    //   if (result.length > 0) {
    //     callback(new Error('Herb with the same ID already exists'));
    //   } else {
    //
    //   }
    // });
  }

  // updateData(herb: IHerbalModel, callback: Function) {
  //   this.query(herb.id, (result) => {
  //     if (result.length === 0) {
  //       callback(new Error('Herb not found'));
  //     } else {
  //       const valueBucket = this.generateBucket(herb);
  //       this.herbalTable.updateData(valueBucket, { key: 'id', value: herb.id }, callback);
  //       callback(null);
  //     }
  //   });
  // }

  deleteData(id: number, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.HERBAL_TABLE.tableName);
    predicates.equalTo('id', id);
    this.herbalTable.deleteData(predicates, callback);
  }

  queryAll(callback: (result: IHerbalModel[]) => void) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.HERBAL_TABLE.tableName);
    this.herbalTable.query(predicates, this.queryFn(callback));
  }

  queryById(id: number, callback: (result: IHerbalModel[]) => void) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.HERBAL_TABLE.tableName);
    predicates.equalTo('id', id);
    this.herbalTable.query(predicates, this.queryFn(callback));
  }

  queryByPartialName(partialName: string, callback: (result: IHerbalModel[]) => void) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.HERBAL_TABLE.tableName);
    predicates.contains('name', partialName);
    this.herbalTable.query(predicates, this.queryFn(callback));
  }

  private queryFn = (callback: (result: IHerbalModel[]) => void) => (resultSet: relationalStore.ResultSet) => {
    let count: number = resultSet.rowCount;
    if (count === 0 || typeof count === 'string') {
      console.info(`${CommonConstants.HERBAL_TABLE_TAG}` + 'Query no results!');
      callback([]);
    } else {
      resultSet.goToFirstRow();
      const result: IHerbalModel[] = [];
      for (let i = 0; i < count; i++) {
        let tmp: IHerbalModel = {
          id: 0,
          name: '',
          image: '',
          price: 0,
          class: '',
          count: 0,
          description: ''
        }
        tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
        tmp.name = resultSet.getString(resultSet.getColumnIndex('name'));
        tmp.image = resultSet.getString(resultSet.getColumnIndex('image'))
        tmp.price = resultSet.getDouble(resultSet.getColumnIndex('price'));
        tmp.class = resultSet.getString(resultSet.getColumnIndex('class'));
        tmp.count = resultSet.getDouble(resultSet.getColumnIndex('count'));
        tmp.description = resultSet.getString(resultSet.getColumnIndex('description'));
        result[i] = tmp;
        resultSet.goToNextRow();
      }
      callback(result);
    }
  }

  generateBucket(herb: IHerbalModel) {
    let obj: relationalStore.ValuesBucket = {};
    obj.id = herb.id;
    obj.name = herb.name;
    obj.image = herb.image as string;
    obj.price = herb.price;
    obj.class = herb.class;
    obj.count = herb.count;
    obj.description = herb.description;
    return obj;
  }
}

// export default HerbalTable.getInstance()