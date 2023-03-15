import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import {ContainerComponent} from './container/container.component';
import { NavComponent } from './nav/nav.component';
import { SearchComponent } from './search/search.component';
import { FavoritesComponent } from './favorites/favorites.component'
import {RouterModule, Routes} from '@angular/router';

const appRoute: Routes = [
  {path:'search',component: SearchComponent},
  {path:'favorites',component: FavoritesComponent}

]
@NgModule({
  declarations: [
    AppComponent,
    ContainerComponent,
    NavComponent,
    SearchComponent,
    FavoritesComponent
  ],
  imports: [
    BrowserModule,
    RouterModule.forRoot(appRoute)
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
