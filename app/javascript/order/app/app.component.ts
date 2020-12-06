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
  public crsfToken: strin

  constructor(private _http: HttpClient) { }

  ngOnInit() {
    this.getOrder()
    this.crsfToken = document.querySelector('meta[name=csrf-token]').getAttribute('content')
  }

  valueFor(item: any, key: string, type: string) {
    const field = item.order_fields_values.filter(function(i) { return i.key == key})

    if (field.length > 0) {
      let value = field[0].value
      if (type == 'date') {
        value = Date.parse(value)
      }
      return value
    } else {
      return ''
    }
  }

  getOrder() {
    this._http.get(window.location.href + '.json', { responseType: 'json' })
    .subscribe((data) => {
      this.order = data
      this.total = this.order.order_items.reduce((a, b) => +a + +b.price, 0);
    });
  }
}
