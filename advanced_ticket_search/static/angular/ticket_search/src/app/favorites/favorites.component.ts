import { Component } from '@angular/core';
import { SharedService } from "../shared/shared.service"

@Component({
  selector: 'app-favorites',
  templateUrl: './favorites.component.html',
  styleUrls: ['./favorites.component.css']
})
export class FavoritesComponent {
  constructor(private shared: SharedService) {
    
  }
  ngOnInit() {
    this.data = localStorage.getItem('favor') ? JSON.parse(localStorage.getItem('favor') || '') : []
  }

  displayedColumns: string[] = ['Date/Time'];
  data: any
  name: string = ""
  headers = ["#", "Date", "Event", "Catagory", "Venue","Favorite"]

  deleteItem(item: any) {
    console.log('item data ===', item);
    this.data = localStorage.getItem('favor') ? JSON.parse(localStorage.getItem('favor') || '') : []
    this.data = this.data.filter((ele: any) => ele.id !== item.id)
    localStorage.setItem('favor', JSON.stringify(this.data))
  }
}

