import { PlayerNav } from '../components'
import { tabsData } from '../constants'
import { TabClass } from '../models'
import Find from './Find'
import Mine from './Mine'
import Moment from './Moment'
import Recommend from './Recommend'
import SongList from './SongList'
import { promptAction, router } from '@kit.ArkUI'
import { emitter } from '@kit.BasicServicesKit'
import { EveConstans } from '../constants/EveConstans'
import { defaultState, PlayStateType, PlayStateTypeModel } from '../models/playState'
import { PrefernceClass } from '../utils/PrefernceClass'
import AVPlayerClass from '../utils/AVPLayerClass'

@Entry
@Component
struct Index {
  @State
  currentName: string = 'recommend'
  @State
  opacityNum: number = 1

  @State
  playState:PlayStateType =new PlayStateTypeModel(defaultState)

  // 订阅发布的消息
  async aboutToAppear() {
    //1.从首选项中读取数据
    const preferences: PrefernceClass = new PrefernceClass(AVPlayerClass.context!)
    this.playState = await preferences.getPlayState()

    emitter.on({ eventId:EveConstans.EVENT_ID},(receive:emitter.EventData)=>{
      const json:string = receive.data?.playStateStr
      this.playState = JSON.parse(json)
    } )
  }

  @Builder
  getTabBar(item: TabClass) {
    Column() {
      Row() {
        Image(item.icon).fillColor((item.name == this.currentName) ? Color.White : $r('app.color.primary_dark'))
          .width(item.name == this.currentName ? 18 : 22)
          .aspectRatio(1)
      }
      .width(22)
      .aspectRatio(1)
      .borderRadius(22)
      .backgroundColor(item.name == this.currentName ? $r('app.color.primary_light') : Color.Transparent)
      .justifyContent(FlexAlign.Center)

      Text(item.title)
        .fontSize(12)
        .fontWeight(400)
        .margin({ top: 5 })
        .fontColor(item.name === this.currentName ? $r('app.color.primary_light') : $r('app.color.primary_dark'))
    }.width('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Tabs({ barPosition: BarPosition.End }) {
        ForEach(tabsData, (item: TabClass) => {
          TabContent() {
            if (item.name === 'recommend') {
              Recommend()
            }
            else if (item.name === "find") {
              Find()
            }
            else if (item.name === "moment") {
              Moment()
            }else if (item.name === "mine"){
              Mine()
            }
            else {
              SongList()
            }

          }.tabBar(this.getTabBar(item))
          .backgroundColor("#121215")
        })
      }
      .onChange(index => {
        this.currentName = tabsData[index].name
      })
      .barHeight(60)
    if (this.playState.playList.length>0 &&  this.currentName!=='mine'){
      PlayerNav({playState:this.playState})
        .translate({
          y: -60
        }).onClick(() => {
        promptAction.showToast({ message: "音乐播放" })
        router.pushUrl({url:"pages/Play"})
      })
    }


    }
    .width('100%')
    .height('100%')
    .backgroundColor("#3c3f41")
    .opacity(this.opacityNum)


  }

  pageTransition() {
    PageTransitionEnter({ duration: 200 })
      .onEnter(() => {
        this.opacityNum = 1
      })
    PageTransitionExit({ duration: 200 })
      .onExit(() => {
        this.opacityNum = 0
      })
  }
}