import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms'
import { AppComponent } from './app.component';
import { ContainerComponent } from './container/container.component';
import { NavComponent } from './nav/nav.component';
import { SearchComponent } from './search/search.component';
import { FavoritesComponent } from './favorites/favorites.component'
import { RouterModule, Routes } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpClientModule } from "@angular/common/http";
import { AppServiceService } from "./app-service.service";
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MyTableComponent } from './my-table/my-table.component';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { RealTableComponent } from './real-table/real-table.component';
import { TableComponent } from './table/table.component';
import { DetailBarComponent } from './detail-bar/detail-bar.component'
import { MatTabsModule } from '@angular/material/tabs';
import { GoogleMapsModule } from '@angular/google-maps'
import { IvyCarouselModule } from 'angular-responsive-carousel';
import {MatIconModule} from '@angular/material/icon';
import {MatProgressSpinnerModule} from '@angular/material/progress-spinner';
import { CommonModule } from '@angular/common';
const appRoute: Routes = [
  { 
    path: 'search',
    component: SearchComponent
  },
  { 
    path: 'favorites',
    component: FavoritesComponent 
  }
]
@NgModule({
  declarations: [
    AppComponent,
    ContainerComponent,
    NavComponent,
    SearchComponent,
    FavoritesComponent,
    MyTableComponent,
    RealTableComponent,
    TableComponent,
    DetailBarComponent
  ],
  imports: [
    BrowserModule,
    RouterModule.forRoot(appRoute),
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    MatTableModule,
    MatTabsModule,
    MatPaginatorModule,
    MatSortModule,
    GoogleMapsModule,
    IvyCarouselModule,
    MatIconModule,
    MatProgressSpinnerModule,
    CommonModule 
  ],
  providers: [AppServiceService],
  bootstrap: [AppComponent]
})
export class AppModule { }
