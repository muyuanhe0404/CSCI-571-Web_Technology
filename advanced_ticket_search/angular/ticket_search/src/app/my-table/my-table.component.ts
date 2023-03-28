import {AfterViewInit, Component, OnInit, ViewChild} from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import {MatTableDataSource} from '@angular/material/table';
import {SharedService}from "../shared/shared.service"
@Component({
  selector: 'app-my-table',
  templateUrl: './my-table.component.html',
  styleUrls: ['./my-table.component.css']
})
export class MyTableComponent implements OnInit {
  displayedColumns: string[] = ['date', 'icon', 'event', 'genre','venue'];
  dataSource = new MatTableDataSource<any>([]);

  @ViewChild(MatPaginator, { static: true })
  paginator!: MatPaginator;

  constructor(private shared: SharedService) {

  }

  ngOnInit() {
    this.dataSource.paginator = this.paginator;
    this.shared.currentMessageState.subscribe((data: any) => {
      this.dataSource = data
    })
  }

}


export interface PeriodicElement {
  //id: string;
  // dates: object;
  
}
