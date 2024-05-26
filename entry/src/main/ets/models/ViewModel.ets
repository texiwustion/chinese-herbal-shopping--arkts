export class ITabItem {
  title: string = '';
  @BuilderParam render: () => void;
  iconUnselected: Resource;
  iconSelected: Resource;
}

export interface IHerbalModel {
  id: number;
  name?: string;
  image?: Resource | string;
  price?: number;
  class?: string;
  count?: number;
  description?: string;
}

export class ICommentModel {
  id: number;
  herbalId: number;
  username: string;
  comment: string;
}

export class IOrderModel {
  id: number;
  herbal: IHerbalModel;
  quantity: number;
  username: string;
  status: 'added' | 'purchased';
}

export class IUserModel {
  username: string;
  password: string;
}