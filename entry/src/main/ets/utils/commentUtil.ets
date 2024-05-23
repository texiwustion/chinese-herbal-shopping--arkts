import { ICommentModel } from '../models/ViewModel';

export function filterCommentsByHerbalId(comments: ICommentModel[], herbalId: number): ICommentModel[] {
  return comments.filter(comment => comment.herbalId === herbalId);
}