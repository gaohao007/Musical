import { momentList } from '../constants/MusicConstants'
import { momentListType } from '../models/music'

@Component
@Preview
export default struct Moment {

  build() {
    Column() {
      Row() {
        Text("互动广场").fontColor("#eaeaec")
      }
      .width("100%")
      .padding(24)

      List() {
        ForEach(momentList, (item: momentListType) => {
          ListItem() {
            Row() {
              Row({ space: 12 }) {
                Image(item.avatar)
                  .width(40)
                  .borderRadius(40)
                Column({ space: 12 }) {
                  // 作者
                  Text(item.author)
                    .fontColor('#e9e9e7')
                  // 内容
                  Text(item.content)
                    .fontColor('#aaa9af')
                    .fontSize(12)

                  Row() {
                    Image(item.song.img)
                      .width(60)
                      .aspectRatio(1)
                    Column({ space: 10 }) {
                      Text(item.song.name)
                        .fontColor('#f4f4f6')
                        .fontSize(12)
                      Text(item.song.author)
                        .fontColor('#a8a8ad')
                        .fontSize(10)
                    }
                    .height(60)
                    .alignItems(HorizontalAlign.Start)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .padding(12)
                    .layoutWeight(1)

                    Image($r("app.media.ic_single_play"))
                      .width(20)
                      .fillColor('#ececec')
                      .margin({ right: 12 })
                  }
                  .width("100%")
                  .backgroundColor('#46474c')
                  .borderRadius(8)
                  .clip(true)

                  Row({ space: 20 }) {
                    Row() {
                      Image($r('app.media.ic_share'))
                        .width(20)
                        .fillColor('#c9c8cd')
                      Text('分享')
                        .fontColor('#9e9da2')
                        .fontSize(12)
                        .margin({ left: 4 })
                    }

                    Row() {
                      Image($r('app.media.ic_comment_o'))
                        .width(20)
                        .fillColor('#c9c8cd')
                      Text(item.comment.toString())
                        .fontColor('#9e9da2')
                        .fontSize(12)
                        .margin({ left: 4 })
                    }

                    Row() {
                      Image($r('app.media.ic_like'))
                        .width(20)
                        .fillColor('#c9c8cd')
                      Text(item.like.toString())
                        .fontColor('#9e9da2')
                        .fontSize(12)
                        .margin({ left: 4 })
                    }
                  }
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

              }
              .padding({
                top: 12,
                bottom: 24
              })
              .borderWidth({
                bottom: 1
              })
              .alignItems(VerticalAlign.Top)
              .borderColor("#292931")
              .width("100%")
            }
            .padding(16)
          }
        })
        ListItem() {
          Row() {
            Text('我是有底线的~')
              .fontColor(Color.Gray)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding(16)
        }
      }
    }
    .width("100%")
    .height("100%")
  }
}