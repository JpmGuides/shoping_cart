import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CookieService } from 'ngx-cookie-service';
import { BsLocaleService } from 'ngx-bootstrap/datepicker';

import templateString from './app.component.html';

@Component({
  selector: 'order',
  template: templateString
})

export class AppComponent implements OnInit {
  public order: any
  public total: number
  public crsfToken: string
  public displayBack: boolean = false

  constructor(private _http: HttpClient, private cookieService: CookieService, private localeService: BsLocaleService) {
    this.localeService.use('fr');
  }

  ngOnInit() {
    this.getOrder()
    if (this.cookieService.get('cart-key')) {
      this.displayBack = true;
    }

    this.crsfToken = document.querySelector('meta[name=csrf-token]').getAttribute('content')
  }

  goBack() {
    window.history.back();
  }

  valueFor(item: any, key: string, type: string) {
    if (!item.order_fields_values) {
      return ''
    }

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

  onSubmit(event) {
    event.preventDefault()

    let allRequiredValid: boolean = true
    let requiredFields: NodeListOf<HTMLInputElement> = document.querySelectorAll('input[required], select[required]') as NodeListOf<HTMLInputElement>

    for (let i = 0; i < requiredFields.length; ++i) {
      if (!!requiredFields[i].value) {
        requiredFields[i].classList.remove('is-invalid')
      } else {
        allRequiredValid = false
        requiredFields[i].classList.add('is-invalid')
      }
    }

    if (allRequiredValid) {
      event.target.submit()
    }
  }
}
