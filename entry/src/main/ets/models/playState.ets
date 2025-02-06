//同步的歌曲数据
import { songItemType } from '.'

export interface  PlayStateType{
  img:string
  name:string
  author:string
  url:string
  time:number
  duration:number
  playList:songItemType[]
  playIndex:number
  isPlay:boolean
  playMode:'auto'|'repeat'|'random'
}

export class PlayStateTypeModel implements PlayStateType{
  img:string=''
  name:string=''
  author:string=''
  url:string=''
  time:number=0
  duration:number=0
  playList:songItemType[]=[]
  playIndex:number=0
  isPlay:boolean=false
  playMode:'auto'|'repeat'|'random' ='auto'

  constructor(model:PlayStateType) {
    this.img =model.img
    this.name =model.name
    this.author = model.author
    this.url =model.url
    this.time =model.time
    this.duration = model.duration
    this.playList = model.playList
    this.isPlay = model.isPlay
    this.playIndex = model.playIndex
    this.playMode = model.playMode

  }
}

export const  defaultState={
  img:'',
  name:'',
  author:'',
  url:'',
  time:0,
  duration:0,
  playList:[],
  playIndex:0,
  isPlay:false,
  playMode:'auto'
} as PlayStateType
