import { songs } from '../constants'
import { songItemType } from '../models/music'
import { defaultState, PlayStateType, PlayStateTypeModel } from '../models/playState'
import { emitter } from '@kit.BasicServicesKit'
import { EveConstans } from '../constants/EveConstans'
import AVPlayerClass from '../utils/AVPLayerClass'
import { preferences } from '@kit.ArkData'
import { PrefernceClass } from '../utils/PrefernceClass'

@Entry
@Component
struct Play {
  @State panelHeight: string = '0%'

@Watch('angleChange')
  @State
  playState:PlayStateType =new PlayStateTypeModel(defaultState)
  @State angle:number=0;
  @State x:number=0
  @State y:number=0

  // 订阅发布的消息
  async aboutToAppear() {
    // 首选项读取数据
    const preferences:PrefernceClass = new PrefernceClass(AVPlayerClass.context!)
    this.playState = await preferences.getPlayState()



    emitter.on({ eventId:EveConstans.EVENT_ID},(receive:emitter.EventData)=>{
      const json:string = receive.data?.playStateStr
      this.playState = JSON.parse(json)
    } )
  }
  angleChange(){
    if (this.playState.isPlay) {
      this.angle = 4*720*(this.playState.time/this.playState.duration)
      this.x=2-Math.ceil(4*Math.random())
      this.y=2-Math.ceil(4*Math.random())
    }else{

      this.x=0;
      this.y=0;
    }
  }


  //格式化时间
  number2time(milliseconds: number) {
    //计算总秒
    const totalSeconds = Math.floor(milliseconds / 1000)

    //计算分钟和秒
    const minutes = Math.floor(totalSeconds / 60)
    const seconds = totalSeconds % 60

    //格式化分钟和秒为两位
    const formaterMinutes = String(minutes).padStart(2, '0')
    const formaterSeconds = String(seconds).padStart(2, '0')

    return `${formaterMinutes}:${formaterSeconds}`
  }






  @Builder
  deleteButton(index: number) {
    Button("删除")
      .backgroundColor($r("app.color.primary_light"))
      .fontColor("#fff")
      .width(80)
      .height('100%')
      .type(ButtonType.Normal)
      .onClick(()=>{
        AVPlayerClass.removeSomeSong(index)
      })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      //播放
      Stack() {
        // 变色背景
        Image(this.playState.img)
          .width('100%')
          .height('100%')
          .blur(1000)

        Column() {
          Stack({ alignContent: Alignment.Top }) {
            Row() {
              Row() {
                Image(this.playState.img)
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
            .rotate({angle:this.angle})

            // 唱针
            Image($r('app.media.ic_stylus'))
              .width(200)
              .aspectRatio(1)
              .rotate({
                angle:this.playState.isPlay?-42:-55,
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
              Text(this.playState.name)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.primary_dark'))
              Text(this.playState.author)
                .fontSize(18)
                .fontColor($r('app.color.primary_dark'))
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.Center)
            .zIndex(1)
            .translate({x:this.x,y:this.y})

            Column({ space: 8 }) {
              Text(this.playState.name)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor($r('app.color.primary_light'))
              Text(this.playState.author)
                .fontSize(18)
                .fontColor($r('app.color.primary_light'))
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.Center)
            .zIndex(2)
            .translate({x:this.x,y:this.y})


            Column({ space: 8 }) {
              Text(this.playState.name)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
              Text(this.playState.author)
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
              Text(this.number2time(this.playState.time))
                .fontSize(12)
                .fontColor(Color.White)

              Slider({
                value: this.playState.time,
                min: 0,
                max: this.playState.duration
              })
                .layoutWeight(1)
                .blockColor(Color.White)
                .selectedColor(Color.White)
                .trackColor('#ccc5c5c5')
                .trackThickness(2)
                .onChange((value: number) => {
                  AVPlayerClass.player?.seek(value)
                })
              Text(this.number2time(this.playState.duration))
                .fontSize(12)
                .fontColor(Color.White)
            }
            .width('100%')
            .padding(24)

            Row() {
              if (this.playState.playMode ==='auto'){
                Image($r('app.media.ic_auto'))
                  .fillColor(Color.White)
                  .width(30)
                  .onClick(()=>{
                    AVPlayerClass.changeMode('repeat')
                  })
              }else if(this.playState.playMode ==='repeat'){
                Image($r('app.media.ic_repeat'))
                  .fillColor(Color.White)
                  .width(30)
                  .onClick(()=>{
                    AVPlayerClass.changeMode('random')
                  })
              }else if (this.playState.playMode ==='random'){
                Image($r('app.media.ic_random'))
                  .fillColor(Color.White)
                  .width(30)
                  .onClick(()=>{
                    AVPlayerClass.changeMode('auto')
                  })
              }

              Image($r("app.media.ic_prev"))
                .fillColor(Color.White)
                .width(30)
                .onClick(()=>{
                  AVPlayerClass.preSong()
                })

              // 播放按钮
              Image(this.playState.isPlay? $r('app.media.ic_paused'):$r('app.media.ic_play'))
                .fillColor(Color.White)
                .width(50)
                .onClick(()=>{
                  if (this.playState.isPlay) {
                    AVPlayerClass.pause()
                  }else{
                    AVPlayerClass.singleType(AVPlayerClass.playList[AVPlayerClass.playIndex])
                  }
                })
              // 下一首
              Image($r('app.media.ic_next'))
                .fillColor(Color.White)
                .width(30)
                .onClick(()=>{
                  AVPlayerClass.nextSong()
                })
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


            Text(`播放列表 (${AVPlayerClass.playList.length})`)
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
            ForEach(this.playState.playList, (item: songItemType, index: number) => {
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
                      .fontColor(index === this.playState.playIndex ? $r('app.color.primary_light') : '#ffa49a9a')
                    Text(item.author)
                      .fontSize(12)
                      .fontColor(index === this.playState.playIndex ? $r('app.color.primary_light') : Color.Gray)
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