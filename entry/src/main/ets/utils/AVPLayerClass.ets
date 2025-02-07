import { media } from "@kit.MediaKit";
import { songItemType } from "../models";
import { Log } from "@abner/log"
import { emitter } from "@kit.BasicServicesKit";
import { PlayStateType } from "../models/playState";
import { EveConstans } from "../constants/EveConstans";

//播放器工具类
export  default  class  AVPlayerClass{
//   播放器属性
 static  player: media.AVPlayer |null = null
  // 当前播放总时长
  static  durationTime:number=0
//   当前播放时间进度
  static  currentTime:number=0
//   播放状态:
  static  isPlay:boolean =false
//   播放模式:
  static playMode:"auto" | 'repeat' | 'random' = 'auto'
//   播放列表
  static  playList:songItemType[]=[]

//   播放序号:
  static playIndex:number =-1;
//
  static song:songItemType


//   播放器功能

//   初始化播放器
  static  async init(){
    // 创建播放器
    AVPlayerClass.player = await  media.createAVPlayer()



  //   设置一个状态监听:
    AVPlayerClass.player.on('stateChange',(state:media.AVPlayerState)=>{
      switch (state){
        case 'initialized':
          AVPlayerClass.player?.prepare()
          break
        case 'prepared':
          AVPlayerClass.player?.play();
          AVPlayerClass.isPlay =true;
          break
      }
    })

  //   监听总时长
    AVPlayerClass.player.on("durationUpdate",(duration:number)=>{
      AVPlayerClass.durationTime = duration
    })
  //  监听播放时长
    AVPlayerClass.player.on('timeUpdate',(time:number)=>{
      AVPlayerClass.currentTime =time
      const obj :PlayStateType={
        name:AVPlayerClass.song?.name,
        author:AVPlayerClass.song?.author,
        img:AVPlayerClass.song?.img,
        url:AVPlayerClass.song?.url,
        time:AVPlayerClass.currentTime,
      duration:AVPlayerClass.durationTime,
        playList:AVPlayerClass.playList,
        playIndex:AVPlayerClass.playIndex,
        isPlay:AVPlayerClass.isPlay,
        playMode:AVPlayerClass.playMode
      }
      AVPlayerClass.updateState(obj)

    })

  }

//   播放歌曲
  static singleType(song:songItemType){
    AVPlayerClass.song = song;
    // 判断歌曲是否重复
    const  isReapt=AVPlayerClass.playList.some(item=>item.id===song.id)
    if(isReapt){
      if (AVPlayerClass.player?.url === song.url) {
        AVPlayerClass.changePlay() //重新播放
      }else {
        //切歌
       AVPlayerClass.playIndex = AVPlayerClass.playList.findIndex(value=>value.id ===song.id)
      AVPlayerClass.changePlay()
      }
    }else {
      AVPlayerClass.playList.unshift(song)
      AVPlayerClass.playIndex =0;
      AVPlayerClass.changePlay()
    }
    Log.info(JSON.stringify(AVPlayerClass.playList))


  }

  static async  changePlay(){
    //重置播放器,处于闲置状态
    await AVPlayerClass.player?.reset()
    AVPlayerClass.durationTime = 0;
    AVPlayerClass.currentTime =0;

    AVPlayerClass.player!.url = AVPlayerClass.playList[AVPlayerClass.playIndex].url
  }

//   数据同步
  static updateState(playState:PlayStateType){
    emitter.emit({
      eventId:EveConstans.EVENT_ID
    },{
      data:{
        playStateStr:JSON.stringify(playState)
      }
    })
  }
  static pause(){
    AVPlayerClass.player?.pause()
    AVPlayerClass.isPlay =false
    const obj :PlayStateType={
      name:AVPlayerClass.song?.name,
      author:AVPlayerClass.song?.author,
      img:AVPlayerClass.song?.img,
      url:AVPlayerClass.song?.url,
      time:AVPlayerClass.currentTime,
      duration:AVPlayerClass.durationTime,
      playList:AVPlayerClass.playList,
      playIndex:AVPlayerClass.playIndex,
      isPlay:AVPlayerClass.isPlay,
      playMode:AVPlayerClass.playMode
    }
    AVPlayerClass.updateState(obj)
  }
}