import { ColorConstants } from '../constants/ColorConstants';
import { ICommentModel } from '../models/ViewModel'
@Component
struct CommentList {
  private commentData: ICommentModel[];

  aboutToAppear() {
    console.info('评价列表数据: ', JSON.stringify(this.commentData))
  }

  build() {
    List() {
      ForEach(this.commentData, (item: ICommentModel) => {
        ListItem() {
          Column() {
            Text(`${item.username}`)
              .fontSize('18fp')
              .fontColor(ColorConstants.GREEN_DEEP)
            Text(`${item.comment}`)
              .fontSize('15fp')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .padding('10vp')
      }, (item: ICommentModel) => item.id.toString())
    }
    .width('100%')
  }
}

export default CommentList