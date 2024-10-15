import { songs } from '../constants'

@Preview
@Component
struct PlayerNav {
  build() {
    Row() {
      Row({ space: 10 }) {
        Image(songs[0].img).width(40).aspectRatio(1)
        Column() {
          Text(songs[0].name).fontColor("#fff")
          Text(songs[0].author).fontSize(12).fontColor("#ccc")
        }.alignItems(HorizontalAlign.Start)
      }.height('100%')
      .alignItems(VerticalAlign.Center)

      Row({ space: 16 }) {
        Image($r("app.media.ic_prev"))
          .width(20).aspectRatio(1)
          .fillColor("#4cafc6")
        Image($r('app.media.ic_play'))
          .fillColor('#4cafc6')
          .width(20)

        Image($r('app.media.ic_next'))
          .width(20)
          .aspectRatio(1)
          .fillColor('#4cafc6')
      }.height('100%')
    }
    .width('100%')
    .height(60)
    .backgroundColor("#ff1c1c21")
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 20, right: 20 })
  }
}

export {PlayerNav}
