import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import templateString from './app.component.html';

@Component({
  selector: 'catalog',
  template: templateString
})

export class AppComponent implements OnInit {
  public client: any

  constructor(private _http: HttpClient) { }

  ngOnInit() {
    this.getClientDetails()
    console.log(this.client)
  }

  getClientDetails() {
    this._http.get(window.location.href + '.json', { responseType: 'json' })
    .subscribe((data) => {
      this.client = data
    });
  }
}
