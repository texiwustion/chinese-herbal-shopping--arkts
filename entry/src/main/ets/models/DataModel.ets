import { IHerbalModel, ICommentModel, IOrderModel } from './ViewModel'
export const classifyTitle: string[] = [
  "全部",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
  "分类",
]

export const herbalInfo: Array<IHerbalModel> = [
  {
    id: 1,
    name: '阿魏',
    price: 100,
    class: '树脂类'
  },
  {
    id: 2,
    name: '阿魏',
    price: 100,
    class: '树脂类'
  },
  {
    id: 3,
    name: '阿魏',
    price: 100,
    class: '树脂类'
  },
  {
    id: 4,
    name: '阿魏',
    price: 100,
    class: '树脂类'
  },
]

export const fakeComments: ICommentModel[] = [
  { id: 1, herbalId: 1, username: 'Alice', comment: 'Great herbal, really helped with my headaches.' },
  { id: 2, herbalId: 2, username: 'Bob', comment: 'Not very effective, wouldn\'t recommend.' },
  { id: 3, herbalId: 3, username: 'Charlie', comment: 'Amazing results, worth every penny.' },
  { id: 4, herbalId: 4, username: 'David', comment: 'Average herbal, nothing special.' },
  { id: 5, herbalId: 1, username: 'Eve', comment: 'Works like a charm, my go-to herbal now.' },
  { id: 6, herbalId: 2, username: 'Frank', comment: 'Didn\'t work for me, disappointed.' },
  { id: 7, herbalId: 3, username: 'Grace', comment: 'Highly recommend, exceeded my expectations.' },
  { id: 8, herbalId: 4, username: 'Hannah', comment: 'Decent herbal, but a bit pricey.' },
  { id: 9, herbalId: 1, username: 'Ian', comment: 'Helped me sleep better, very satisfied.' },
  { id: 10, herbalId: 2, username: 'Julia', comment: 'No effect on me, waste of money.' },
];

export const fakeOrderItems: IOrderModel[] = [
  { id: 1, herbal: herbalInfo[1 - 1], quantity: 2, username: 'Alice', status: 'added' },
  { id: 2, herbal: herbalInfo[3 - 1], quantity: 1, username: 'Bob', status: 'added' },
  { id: 3, herbal: herbalInfo[4 - 1], quantity: 3, username: 'Charlie', status: 'added' },
  { id: 4, herbal: herbalInfo[2 - 1], quantity: 1, username: 'David', status: 'purchased' },
  { id: 5, herbal: herbalInfo[2 - 1], quantity: 2, username: 'Eve', status: 'purchased' },
];