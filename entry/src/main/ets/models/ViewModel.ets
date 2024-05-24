export class ITabItem {
  title: string = '';
  @BuilderParam render: () => void;
  iconUnselected: Resource;
  iconSelected: Resource;
}

export class IHerbalModel {
  id: number;
  name?: string = '无名药材';
  image?: Resource | string = '';
  price?: number = -1;
  class?: string = '未分类';
  count?: number = -1;
  description?: string = '无描述';
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