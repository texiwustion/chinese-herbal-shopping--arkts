@Component
export default struct RenderComponent {
  @BuilderParam content: () => void

  build() {
    this.content()
  }
}