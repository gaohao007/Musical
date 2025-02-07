import { preferences } from "@kit.ArkData"
import { PlayStateType } from "../models/playState"

export  class PrefernceClass{
  context:Context
  readonly  playStateKey:string ='music_state'

  constructor( context:Context) {
    this.context = context
  }
  async getStore(){
    return await preferences.getPreferences(this.context,'music')
  }

  async  setPlayState(playState:PlayStateType){
    const  store = await this.getStore()
    await store.put(this.playStateKey,JSON.stringify(playState))
    await store.flush()
  }

}
