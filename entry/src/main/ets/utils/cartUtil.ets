import { IOrderModel } from '../models/ViewModel';
function getCartItems(items: IOrderModel[]): IOrderModel[] {
  return items.filter(item => item.status === 'added');
}

function getPurchasedItems(items: IOrderModel[]): IOrderModel[] {
  return items.filter(item => item.status === 'purchased');
}

export { getCartItems, getPurchasedItems }