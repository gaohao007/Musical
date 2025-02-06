import { media } from "@kit.MediaKit";
import { songItemType } from "../models";

//播放器工具类
export  default  class  AVPlayerClass{
//   播放器属性
 static  player: media.AVPlayer |null = null
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
          AVPlayerClass.player?.play()
          break
      }
    })

  }

//   播放歌曲
  static singleType(song:songItemType){
      AVPlayerClass.player!.url = song.url
  }

}