import { Component } from '@angular/core';
import { NgForm } from '@angular/forms';
import { OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AppServiceService } from '../app-service.service'
import { SharedService } from "../shared/shared.service"
@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent {
  constructor(private appService: AppServiceService,
    private shared: SharedService) { }

  message: any
  data: any;
  show = false;
  autoDetect = false;
  hav_d = false;

  ngOnInit(): void {
    // this.hav_d = true
  }

  showChange(value: boolean) {
    console.log('search component showChange ===', value);
    this.show = value;
  }

  onSubmit(form: NgForm) {
    console.log(form.value);
    this.Keyword = form.value.Keyword;
    this.Catagory = form.value.Catagory;
    this.Distance = form.value.Distance;
    this.Location = form.value.Location;
    console.log("keyword", this.Keyword);
    console.log("Catagory", this.Catagory);
    console.log("Distance", this.Distance);
    console.log("Location", this.Location);
    if (this.autoDetect) {
      if (this.Keyword) {
        this.appService.getIp().subscribe((res: any) => {
          console.log('ip', res);
          if (res) {
            this.ip = res;
            const temp = res.split(",")
            console.log('seprate ip ===', temp);
            console.log('set ip', this.ip);
            this.lat = temp[0]
            this.shared.updateLat(temp[0])
            this.lng = temp[1]
            this.shared.updateLng(temp[1])
            console.log("lat", this.lat);
            console.log("lng", this.lng);
          }
          const params = {
            keyword: this.Keyword,
            catagory: this.Catagory,
            distance: this.Distance,
            location: this.Location,
            lat: this.lat,
            lng: this.lng
          }

          const queryStr = new URLSearchParams(params).toString();
          this.appService.getData(queryStr).subscribe((res: any) => {
            console.log("param", params)
            this.hav_d = true
            console.log('api res ===', res._embedded);
            if (res && res._embedded && res._embedded.events) {
              this.data = res._embedded.events;
              console.log('set daa ===', res._embedded);
              this.shared.updateMessage(res._embedded.events)
            } else {
              this.data = null
            }
          });
        });
        // this.appService.getIp().subscribe((res: any) => {
        //   console.log('ip', res);
        //   if (res) {
        //     this.ip = res;
        //     const temp = res.split(",")
        //     console.log('seprate ip ===', temp);
        //     console.log('set ip', this.ip);
        //   }
        // });
      }
    } else {
      if (this.Keyword && this.Location) {
        this.appService.getLoc(this.Location, this.key).subscribe((res: any) => {
          this.lat = res.results[0].geometry.location.lat
          this.shared.updateLat(res.results[0].geometry.location.lat)
          this.lng = res.results[0].geometry.location.lng
          this.shared.updateLng(res.results[0].geometry.location.lng)
          console.log("lat", this.lat);
          console.log("lng", this.lng);
          const params = {
            keyword: this.Keyword,
            catagory: this.Catagory,
            distance: this.Distance,
            location: this.Location,
            lat: this.lat,
            lng: this.lng
          }

          const queryStr = new URLSearchParams(params).toString();
          this.appService.getData(queryStr).subscribe((res: any) => {
            console.log("param", params)
            this.hav_d = true
            console.log('api res ===', res._embedded);
            if (res && res._embedded && res._embedded.events) {
              this.data = res._embedded.events;
              console.log('set daa ===', res._embedded);
              this.shared.updateMessage(res._embedded.events)
            } else {
              this.data = null
            }
          });
        });
        // this.appService.getIp().subscribe((res: any) => {
        //   console.log('ip', res);
        //   if (res) {
        //     this.ip = res;
        //     const temp = res.split(",")
        //     console.log('seprate ip ===', temp);
        //     console.log('set ip', this.ip);
        //   }
        // });
      }
    }

  }

  Keyword: string = "";
  Catagory: string = "";
  Distance: string = "10";
  Location: string = "";
  key: string = 'AIzaSyAF6ko5HSQ3milsvb2D1RnU_L-GDmsRhU0'
  lat: string = ""
  lng: string = ""
  ip: any
  // private fetch_data(){
  //   this.http.get('/api/products').subscribe((res)=>{
  //     console.log("success",res);
  //   })
  // }

  resetForm(form: NgForm) {
    // form.reset();
    this.Keyword = "";
    this.Catagory = "";
    this.Distance = "10";
    this.Location = "";
    this.lat = ""
    this.lng = ""
  }

  handleAutoDetect(event: any) {
    console.log('handleAutoDetect ===', event.target.checked);
    if (event.target.checked) {
      this.autoDetect = true
      this.Location = ''
    } else {
      this.autoDetect = false
    }

  }
}
