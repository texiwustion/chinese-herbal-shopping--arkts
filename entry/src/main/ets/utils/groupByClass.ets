import { IHerbalModel } from '../models/ViewModel';

export default function groupByClass(result: IHerbalModel[]): { [key: string]: IHerbalModel[] } {
  if (result.length === 0) return {}
  return result.reduce((acc, item) => {
    const className = item.class || '未分类'; // 或者给没有class的条目设置一个默认值
    if (!acc[className]) {
      acc[className] = [];
    }
    acc[className].push(item);
    return acc;
  }, {} as { [key: string]: IHerbalModel[] });
}