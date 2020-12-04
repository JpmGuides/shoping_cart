import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import templateString from './app.component.html';

@Component({
  selector: 'order',
  template: templateString
})

export class AppComponent implements OnInit {
  public order: any
  public total: number

  constructor(private _http: HttpClient) { }

  ngOnInit() {
    this.getOrder()
    console.log(this.order)
  }

  getOrder() {
    this._http.get(window.location.href + '.json', { responseType: 'json' })
    .subscribe((data) => {
      this.order = data
      this.total = this.order.order_items.reduce((a, b) => +a + +b.price, 0);
    });
  }
}
