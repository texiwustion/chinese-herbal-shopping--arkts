export class ITabItem {
  title: string = '';
  @BuilderParam render: () => void;
  iconUnselected: Resource;
  iconSelected: Resource;
}

export class IHerbalItem {
  name: string = '';
  image: Resource | string = '';
  price: number = -1;
  class: string;
}