import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SharedService {
  private messageState = new BehaviorSubject(null)
  private dataState = new BehaviorSubject(null)
  private latState = new BehaviorSubject(null)
  private lngState = new BehaviorSubject(null)

  currentMessageState = this.messageState.asObservable()
  currentData = this.dataState.asObservable()
  latData = this.latState.asObservable()
  lngData = this.lngState.asObservable()
  
  constructor() { }

  updateMessage(data: any) {
    this.messageState.next(data)
  }

  updateData(data: any) {
    this.dataState.next(data)
  }

  updateLat(data: any) {
    this.latState.next(data)
  }
  updateLng(data: any) {
    this.lngState.next(data)
  }

}
