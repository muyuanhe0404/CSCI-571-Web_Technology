import { Component, ElementRef, EventEmitter, Input, Output, ViewChild, ViewEncapsulation } from '@angular/core';
import { NgForm } from '@angular/forms';
import { OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AppServiceService } from '../app-service.service'
import { SharedService } from "../shared/shared.service"
import { ThemePalette } from '@angular/material/core';
import { ProgressSpinnerMode } from '@angular/material/progress-spinner';

@Component({
  selector: 'app-detail-bar',
  templateUrl: './detail-bar.component.html',
  styleUrls: ['./detail-bar.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class DetailBarComponent {
  @Input() show = false;
  @Output() showChangeEvent = new EventEmitter<boolean>();
  @ViewChild('carouselExampleControls') public carouselExampleControls: ElementRef | undefined;

  color: ThemePalette = 'accent';
  mode: ProgressSpinnerMode = 'determinate';

  constructor(private appService: AppServiceService,
    private shared: SharedService) { }

  showMore = false;
  data: any
  name: any
  id: any
  detail: any
  venue: any
  v_detail: any
  artist: any
  a_detail: any
  artid: any
  art_detail: any
  arttype = true
  artist_list: Array<any> = []
  a_detail_list: Array<any> = []
  album_list: Array<any> = []
  a_id_list: Array<any> = []
  count = 50;
  count2 = 50;
  count3 = 50;
  lastInext = 50
  lastInext2 = 50
  lastInext3 = 50
  showText = "Show more"
  showText2 = "Show more"
  showText3 = "Show more"
  lat = 0;
  lng = 0;
  center: any
  position: any
  addedItem = false

  handleBackClick() {
    this.showChangeEvent.emit(!this.show)
  }

  ngOnInit() {
    this.artist_list = []
    this.a_detail_list = []
    this.album_list = []

    this.shared.latData.subscribe((data: any) => {
      this.lat = data
    })
    this.shared.lngData.subscribe((data: any) => {
      this.lng = data
    })

    this.shared.currentData.subscribe((data: any) => {
      console.log('detail bar comp get data ===', data);
      if (data) {
        this.artist_list = []
        this.a_detail_list = []
        this.album_list = []
        this.data = data
        this.name = data
        this.id = this.data.id
        this.venue = this.name._embedded.venues ? this.name._embedded.venues[0].name : ''
        this.artist = this.name._embedded.attractions ? this.name._embedded.attractions[0].name : ''
        if (this.name._embedded.attractions) {
          for (var i of this.name._embedded.attractions) {
            this.artist_list.push(i.name)
          }

        }
        console.log("all artist", this.artist_list)
        console.log("now it is", this.name)
        console.log("artist", this.artist)
        const pa = {
          id: this.id,
          venue: this.venue,
          artist: this.artist
        }

        const queryStr = new URLSearchParams(pa).toString();
        this.appService.getDetail(queryStr).subscribe((res: any) => {
          console.log("id", queryStr)
          console.log('api res ===', res);
          if (res && res._embedded) {
            this.detail = res;
            if (this.detail.classifications[0].segment.name == 'Music') {
              this.arttype = true
            } else {
              this.arttype = false
            }
            console.log('detail', this.detail);
            //this.shared.updateMessage(res)
          }
        });

        // for (var art of this.artist_list) {
        //   //console.log("who's the artist",art)
        //   const pa2 = {
        //     artist: art
        //   }
        // const queryStr = new URLSearchParams(pa2).toString();
        this.appService.getArtist(queryStr).subscribe((res: any) => {
          console.log('artist-return', res);
          if (res) {
            this.a_detail = res;
            //this.a_detail_list.push(res)
            this.artid = res.body.artists.items ? res.body.artists.items[0].id : 0
            //this.a_id_list.push(res.body.artists.items ? res.body.artists.items[0].id : 0)
            // console.log("what's the query",queryStr)
            // console.log("what's the id", this.artid)
            // console.log('a-detail', this.a_detail);
            //console.log("a_detail_list", this.a_detail_list)
          }
          const art_i = {
            artid: res.body.artists.items ? res.body.artists.items[0].id : 0
          }
          const queryStr1 = new URLSearchParams(art_i).toString();
          this.appService.getAlbum(queryStr1).subscribe((res: any) => {
            console.log("id pass", queryStr1)
            console.log('artist-album', res);
            if (res) {
              this.art_detail = res;
              //this.album_list.push(res)
              console.log('art-detail', this.art_detail);
              //console.log('album list', this.album_list);
              //this.shared.updateMessage(res)
            }
          });

          // console.log("what's the id_list",this.a_id_list)
          // console.log("what's the album_list",this.album_list)
        });
        //}
        // if(this.artist_list){
        //   for (var aid of this.a_id_list) {
        //   console.log('id === ', aid);
        //   const art_i = {
        //     artid: aid
        //   }
        //   console.log('id2 === ', art_i);
        //   const queryStr1 = new URLSearchParams(art_i).toString();
        //   this.appService.getAlbum(queryStr1).subscribe((res: any) => {
        //     console.log("id pass", queryStr1)
        //     console.log('artist-album', res);
        //     if (res) {
        //       this.art_detail = res;
        //       this.album_list.push(res)
        //       console.log('art-detail', this.art_detail);
        //       console.log('album list', this.album_list);
        //       //this.shared.updateMessage(res)
        //     }
        //   });
        // }
        // }

        this.appService.getVenue(queryStr).subscribe((res: any) => {
          console.log("total pass", queryStr)
          console.log('venue-return', res);
          if (res && res._embedded) {
            this.v_detail = res;
            console.log('v-detail', this.v_detail);
            this.center = {
              lat: parseFloat(this.v_detail?._embedded.venues[0].location.latitude),
              lng: parseFloat(this.v_detail._embedded.venues[0].location.longitude)
            }

            // this.position = {
            //   lat: this.v_detail._embedded.venues[0].location.latitude,
            //   lng: this.v_detail._embedded.venues[0].location.longitude
            // }

            //this.shared.updateMessage(res)
          }

          let data = localStorage.getItem('favor') ? JSON.parse(localStorage.getItem('favor') || '') : [];
          console.log('favor data ===', data);
          const temp = data && data.filter((item: any) => item.id === this.name.id)
          if (temp.length) {
            console.log('same item ===');
            this.addedItem = true
          } else {
            this.addedItem = false
          }
        });

        // this.appService.getArtist(queryStr).subscribe((res: any) => {
        //   console.log("art pass", queryStr)
        //   console.log('artist-return', res);
        //   if (res) {
        //     this.a_detail = res;
        //     this.artid = this.a_detail.body.artists.items ? this.a_detail.body.artists.items[0].id : 0
        //     console.log("what's the id", this.artid)
        //     console.log('a-detail', this.a_detail);
        //     const art_i = {
        //       artid: this.artid
        //     }
        //     const queryStr1 = new URLSearchParams(art_i).toString();
        //     this.appService.getAlbum(queryStr1).subscribe((res: any) => {
        //       console.log("id pass", queryStr1)
        //       console.log('artist-album', res);
        //       if (res) {
        //         this.art_detail = res;
        //         console.log('art-detail', this.art_detail);
        //         //this.shared.updateMessage(res)
        //       }
        //     });
        //   }
        // });

      }

    })

  }
  // mapOptions: google.maps.MapOptions = {
  //   center: { lat:this.v_detail._embedded.venues[0].location.latitude, lng: this.v_detail._embedded.venues[0].location.longitude },
  //   zoom: 14
  // }
  // marker = {
  //   position: { lat:this.v_detail._embedded.venues[0].location.latitude, lng: this.v_detail._embedded.venues[0].location.longitude },
  // }

  // mapOptions: google.maps.MapOptions = {
  //   center: { lat:this.v_detail._embedded.venues[0].location.latitude, lng: this.v_detail._embedded.venues[0].location.longitude },
  //   zoom: 14
  // }
  // marker = {
  //   position: { lat:this.v_detail._embedded.venues[0].location.latitude, lng: this.v_detail._embedded.venues[0].location.longitude },
  // }

  addFavoriteData() {
    // save data
    let data = localStorage.getItem('favor') ? JSON.parse(localStorage.getItem('favor') || '') : [];
    console.log('favor data ===', data);
    const temp = data && data.filter((item: any) => item.id === this.name.id)
    if (temp.length) {
      console.log('same item ===');
      let filteredData = data && data.filter((ele: any) => ele.id !== this.name.id)
      localStorage.setItem('favor', JSON.stringify(filteredData))
      this.addedItem = false
      alert('item removed from favorite list')
    } else {
      data.push(this.name);
      this.addedItem = true
      localStorage.setItem('favor', JSON.stringify(data))
      alert('item added from favorite list')
    }

  }

  toggleShowOrLess(len: number) {
    if (this.count < 51) {
      this.count = len
      this.showText = 'Show less'
    } else {
      this.count = this.lastInext
      this.showText = 'Show more'
    }

  }
  toggleShowOrLess2(len: number) {
    if (this.count2 < 51) {
      this.count2 = len
      this.showText2 = 'Show less'
    } else {
      this.count2 = this.lastInext2
      this.showText2 = 'Show more'
    }

  }
  toggleShowOrLess3(len: number) {
    if (this.count3 < 51) {
      this.count3 = len
      this.showText3 = 'Show less'
    } else {
      this.count3 = this.lastInext3
      this.showText3 = 'Show more'
    }

  }

}
