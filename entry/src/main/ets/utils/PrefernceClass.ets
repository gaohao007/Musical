import { preferences } from "@kit.ArkData"
import { defaultState, PlayStateType } from "../models/playState"
import { Context } from "@kit.AbilityKit";
export  class PrefernceClass{
  context:Context
  readonly  playStateKey:string ='music_state'

  constructor( context:Context) {
    this.context = context
  }
  async getStore(){
    return await preferences.getPreferences(this.context,'music')
  }
//存数据
  async  setPlayState(playState:PlayStateType){
    const  store = await this.getStore()
    await store.put(this.playStateKey,JSON.stringify(playState))
    await store.flush()
  }
//   取数据
  async getPlayState():Promise<PlayStateType>{
    const  store = await this.getStore()
    //如果没有取到用默认值替代
    const str = await store.get(this.playStateKey,JSON.stringify(defaultState))
    return JSON.parse(str as string) as PlayStateType
  }

}
