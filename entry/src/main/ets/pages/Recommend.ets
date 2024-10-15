import { dailyRecommend, recommendList, swiperList } from '../constants'
import { recommendDailyType, recommendListType } from '../models/music'

@Preview
@Component
export default struct Recommend {
  @Builder
  SearchInput() {
    Row() {
      Row({ space: 4 }) {
        Image($r('app.media.ic_search'))
          .width(20)
          .aspectRatio(1)
          .fillColor('#7a828e')
        TextInput({ placeholder: "只因你太美🔥" })
          .placeholderColor("#7a828e")
          .fontColor('#7a828e')
          .layoutWeight(1)
        Image($r('app.media.ic_code'))
          .width(20)
          .aspectRatio(1)
          .fillColor('#7a828e')
      }
      .width("100%")
      .padding(12)
      .borderRadius(60)
      .backgroundColor('#FF2D2A2A')
    }
    .width('100%')
    .padding(12)

  }

  @Builder
  SwiperComponent() {
    Row() {
      Swiper() {
        ForEach(swiperList, (item: string) => {
          Row() {
            Image(item).width("100%")
          }
          .borderRadius(8)
          .clip(true)
        })
      }.margin(8)
      .autoPlay(true)
    }.width("100%")
    .padding(12)
  }

  @Builder
  TitleBar(title: string) {
    Row() {
      Text(title)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
      Text('更多')
        .fontColor(Color.Gray)
    }
    .width('100%')
    .padding(8)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    Scroll() {
      Column() {
        this.SearchInput()
        this.SwiperComponent()

        //每日推荐
        Column() {
          this.TitleBar("每日推荐")
          Row() {
            Scroll() {
              Row({ space: 10 }) {
                ForEach(dailyRecommend, (item: recommendDailyType) => {
                  Column() {
                    Text(item.type)
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .fontColor(Color.White)
                      .fontWeight(FontWeight.Bold)
                      .fontSize(12)
                      .padding(8)
                      .backgroundColor(item.top)
                    Image(item.img)
                      .width('100%')
                      .aspectRatio(1)
                    Text(item.title)
                      .width('100%')
                      .fontSize(12)
                      .padding(12)
                      .fontColor('#FFE9DFDF')
                      .backgroundColor(item.bottom)
                  }
                  .width('40%')
                  .borderRadius(8)
                  .clip(true)
                })
              }
            }
            .width("100%")
            .scrollable(ScrollDirection.Horizontal)
          }.padding({
            left: 8,
            right: 8
          })
        }

        //推荐歌单
        Column() {
          this.TitleBar("推荐歌单")

          Row() {
            Scroll() {
              Row({ space: 8 }) {
                ForEach(recommendList, (item: recommendListType) => {
                  Column() {
                    Row() {
                      Image(item.img)
                        .width('100%')
                        .borderRadius(8)
                      Text(item.count)
                        .fontSize(12)
                        .fontColor(Color.White)
                        .fontWeight(FontWeight.Bold)
                        .position({
                          x: 6,
                          y: 6
                        })
                    }

                    Text(item.title)
                      .fontSize(12)
                      .fontColor('#FFE9DFDF')
                      .maxLines(2)
                      .textAlign(TextAlign.Start)
                      .textOverflow({
                        overflow: TextOverflow.Ellipsis
                      })
                      .margin({
                        top: 8
                      })
                  }
                  .width('30%')
                })
              }
            }
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
          }
          .padding({
            left: 8,
            right: 8
          })

        }
      }
      .height('100%')
      .width('100%')
    }
  }
}
