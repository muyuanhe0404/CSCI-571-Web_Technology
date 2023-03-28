import { Component, EventEmitter, Input, Output, ViewChild } from '@angular/core';
import { SharedService } from "../shared/shared.service"

@Component({
  selector: 'app-table',
  templateUrl: './table.component.html',
  styleUrls: ['./table.component.css']
})
export class TableComponent {
  @Input() show = false;
  @Output() showChangeEvent = new EventEmitter<boolean>();

  title = "table"

  constructor(private shared: SharedService) {
    console.log('show from search ===', this.show);
  }

  handleRowClick(row: any) {
    console.log('handleRowClick ===', this.show, row);
    this.showChangeEvent.emit(!this.show)
    this.shared.updateData(row);
  }

  displayedColumns: string[] = ['Date/Time'];
  data: any
  name: string = ""
  headers = ["Date/Time", "Icon", "Event", "Genre", "Venue"]
  
  ngOnInit() {
    this.shared.currentMessageState.subscribe((data: any) => {
      
      // this.name = this.data[0].name
      console.log("this data is", data)
      if (data && data.length) {
        this.data = data.sort((a: any, b: any) => Date.parse(a.dates.start.dateTime) - Date.parse(b.dates.start.dateTime))
      }
    })
  }
}



