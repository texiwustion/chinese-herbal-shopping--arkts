export class ITabItem {
  title: string = '';
  @BuilderParam render: () => void
}