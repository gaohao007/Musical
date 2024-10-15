import { songs } from '../constants'
import { songItemType } from '../models/music'

@Entry
@Component
struct Play {
  @State panelHeight: string = '0%'

  @Builder
  deleteButton(index: number) {
    Button("删除")
      .backgroundColor($r("app.color.primary_light"))
      .fontColor("#fff")
      .width(80)
      .height('100%')
      .type(ButtonType.Normal)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      //播放
      Stack() {
        // 变色背景
        Image(songs[0].img)
          .width('100%')
          .height('100%')
          .blur(1000)

        Column() {
          Stack({ alignContent: Alignment.Top }) {
            Row() {
              Row() {
                Image(songs[0].img)
                  .width('70%')
                  .borderRadius(400)
              }
              .backgroundImage($r('app.media.ic_cd'))
              .backgroundImageSize(ImageSize.Cover)
              .justifyContent(FlexAlign.Center)
              .width('100%')
              .borderRadius(400)
              .clip(true)
              .aspectRatio(1)
            }
            .margin({
              top: 50
            })
            .width('90%')
            .aspectRatio(1)
            .justifyContent(FlexAlign.Center)
            .padding(24)

            // 唱针
            Image($r('app.media.ic_stylus'))
              .width(200)
              .aspectRatio(1)
              .rotate({
                angle: -55,
                centerX: 100,
                centerY: 30
              })
              .animation({
                duration: 500
              })
          }

          // 歌曲信息
          Stack() {
            Column({ space: 8 }) {
              Text(songs[0].name)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.primary_dark'))
              Text(songs[0].author)
                .fontSize(18)
                .fontColor($r('app.color.primary_dark'))
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.Center)
            .zIndex(1)

            Column({ space: 8 }) {
              Text(songs[0].name)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.primary_light'))
              Text(songs[0].author)
                .fontSize(18)
                .fontColor($r('app.color.primary_light'))
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.Center)
            .zIndex(2)

            Column({ space: 8 }) {
              Text(songs[0].name)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
              Text(songs[0].author)
                .fontSize(18)
                .fontColor(Color.White)
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.Center)
            .zIndex(3)
          }
          .layoutWeight(1)

          //操作
          Row() {
            Badge({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC' } }) {
              Image($r("app.media.ic_like"))
                .fillColor(Color.White)
                .width(24)
            }

            Badge({ value: '10W', style: { badgeSize: 12, badgeColor: '#45cccccc' } }) {
              Image($r("app.media.ic_comment_o"))
                .fillColor(Color.White)
                .width(18)
            }

            Badge({ value: 'hot', style: { badgeSize: 12, badgeColor: '#a8ff3131' } }) {
              Image($r("app.media.ic_bells_o"))
                .fillColor(Color.White)
                .width(24)
            }

            Badge({ value: 'vip', style: { badgeSize: 12, badgeColor: '#b7efd371' } }) {
              Image($r("app.media.ic_download_o"))
                .fillColor(Color.White)
                .width(24)
            }
          }
          .width("100%")
          .justifyContent(FlexAlign.SpaceAround)

          //播放
          Column() {
            Row() {
              Text('00:00')
                .fontSize(12)
                .fontColor(Color.White)

              Slider({
                value: 0,
                min: 0,
                max: 0
              })
                .layoutWeight(1)
                .blockColor(Color.White)
                .selectedColor(Color.White)
                .trackColor('#ccc5c5c5')
                .trackThickness(2)
              Text('00:00')
                .fontSize(12)
                .fontColor(Color.White)
            }
            .width('100%')
            .padding(24)

            Row() {
              Image($r('app.media.ic_auto'))
                .fillColor(Color.White)
                .width(30)

              Image($r("app.media.ic_prev"))
                .fillColor(Color.White)
                .width(30)

              // 播放按钮
              Image($r('app.media.ic_play'))
                .fillColor(Color.White)
                .width(50)
              // 下一首
              Image($r('app.media.ic_next'))
                .fillColor(Color.White)
                .width(30)
              // 播放列表
              Image($r('app.media.ic_song_list'))
                .fillColor(Color.White)
                .width(30)
                .onClick(() => {
                  this.panelHeight = '100%'
                })
            }
            .width('100%')
            .padding({ bottom: 24 })
            .justifyContent(FlexAlign.SpaceAround)
          }
        }
      }

      //列表
      Column() {
        Column() {

        }
        .onClick(() => {
          this.panelHeight = '0%'
        })
        .width("100%")
        .layoutWeight(1)

        Column() {
          //播放列表
          Row() {
            Row() {
              Image($r("app.media.ic_play"))
                .width(20)
                .fillColor("#ff5186")
            }
            .width(50)
            .aspectRatio(1)
            .justifyContent(FlexAlign.Center)

            Text(`播放列表 (${songs.length})`)
              .fontColor(Color.White)
              .fontSize(14)
              .layoutWeight(1)
            Image($r('app.media.ic_close'))
              .fillColor('#ffa49a9a')
              .width(24)
              .aspectRatio(1)
              .margin({ right: 16 })
              .onClick(() => {
                this.panelHeight = '0%'
              })
          }
          .width('100%')
          .padding(8)
          .border({
            width: { bottom: 1 },
            color: '#12ec5c87'
          })

          List() {
            ForEach(songs, (item: songItemType, index: number) => {
              ListItem() {
                Row() {
                  Row() {
                    Text((index + 1).toString())
                      .fontColor('#ffa49a9a')
                  }.width(50)
                  .aspectRatio(1)
                  .justifyContent(FlexAlign.Center)

                  Column() {
                    Text(item.name)
                      .fontSize(14)
                      .fontColor(index === 0 ? $r('app.color.primary_light') : '#ffa49a9a')
                    Text(item.author)
                      .fontSize(12)
                      .fontColor(index === 0 ? $r('app.color.primary_light') : Color.Gray)
                  }.alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Image($r('app.media.ic_more'))
                    .width(24)
                    .height(24)
                    .margin({ right: 16 })
                    .fillColor(Color.Gray)
                }
                .alignItems(VerticalAlign.Center)
              }
              .swipeAction({
                end: this.deleteButton(index)
              })
              .border({
                width: { bottom: 1 },
                color: "#12ec5c87"
              })
            })
          }
        }
        .height(400)
        .borderRadius({
          topLeft: 4,
          topRight: 4
        })
        .backgroundColor('#ff353333')
        .width("100%")
      }
      .height(this.panelHeight)
    }
    .width("100%")
    .height('100%')
    .backgroundColor(Color.Transparent)
  }
}