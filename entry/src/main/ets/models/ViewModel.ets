export class ITabItem {
  title: string = '';
  @BuilderParam render: () => void;
  iconUnselected: Resource;
  iconSelected: Resource;
}