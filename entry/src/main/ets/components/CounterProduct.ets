@Component
export struct CounterProduct {
  @State @Watch('onChange') quantityCount: number = 1;
  @State disabled: boolean = true;
  private count: number = 1;
  private counterMin: number = 1;
  private onNumberChange: (n: number) => void = () => {};

  aboutToAppear() {
    this.quantityCount = this.count;
    if (this.quantityCount === this.counterMin) {
      this.disabled = true;
    }
  }

  onChange() {
    this.disabled = (this.quantityCount === this.counterMin);
  }

  build() {
    Row() {
      Image(this.disabled ? $r('app.media.ic_decrease_disable') : $r('app.media.ic_decrease'))
        .width('24vp')
        .height('24vp')
        .onClick(() => {
          if (this.disabled) {
            return;
          }
          this.quantityCount = Math.max(this.quantityCount - 1, this.counterMin);
          this.onNumberChange(this.quantityCount);
        })
      Text(`${this.quantityCount}`)
        .fontSize('12fp')
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
        .width('32vp')
        .height('24vp')
      Image($r('app.media.ic_increase'))
        .width('24vp')
        .height('24vp')
        .onClick(() => {
          this.quantityCount = Math.min(this.quantityCount + 1, Number.MAX_VALUE);
          this.onNumberChange(this.quantityCount);
        })
    }
    .width('78vp')
    .height('24vp')
  }
}