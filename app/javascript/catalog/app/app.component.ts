import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { CookieService } from 'ngx-cookie-service';

import * as _ from 'lodash';
import templateString from './app.component.html';

@Component({
  selector: 'catalog',
  template: templateString
})

export class AppComponent implements OnInit {
  public client: any
  public selectedCategory: any
  public order: any
  activeFilters: any = {}

  constructor(private _http: HttpClient, private cookieService: CookieService) { }

  ngOnInit() {
    this.getClientDetails()
    this.getOrder()
  }

  selectCategory(category) {
    this.selectedCategory = category;
  }

  deselectCategory() {
    this.selectedCategory = null;
  }

  getClientDetails() {
    this._http.get(window.location.href + '.json', { responseType: 'json' })
    .subscribe((data) => {
      this.client = data
      let images = []

      this.client.categories.forEach(category => {
        if (category.image_url) {
          images.push(category.image_url)
        }

        category.products.forEach(product => {
          if (product.image_url) {
            images.push(product.image_url)
          }
        })
      })

      this.pload(images)
    })
  }

  datesFilters() {
    let filters = this.selectedCategory.products.map(product => {
      if (product.start_date && product.end_date) {
        return [product.start_date, product.end_date]
      } else {
        return null
      }
    })
    filters = _.uniqWith(_.compact(filters), _.isEqual)

    console.log(filters)

    return filters
  }

  addDatesFilter(dates) {
    if (dates != 'null') {
      let parsedDate = dates.split(',')

      this.activeFilters.start_date = new Date(parsedDate[0])
      this.activeFilters.end_date = new Date(parsedDate[1])
    } else {
      delete this.activeFilters.start_date
      delete this.activeFilters.end_date
    }

    this.applyFilters()
  }

  kindFilters() {
    let filters = this.selectedCategory.products.map(product => {
      return product.kind
    })

    filters = _.uniq(_.compact(filters))

    return filters
  }

  addKindFilter(kind) {
    if (kind != 'null') {
      this.activeFilters.kind = kind
    } else {
      delete this.activeFilters.kind
    }

    this.applyFilters()
  }

  applyFilters() {
    console.log(this.activeFilters)
  }

  getOrder() {
    let key = this.cookieService.get('cart-key')

    if (key) {
      this._http.get('/orders/' + key + '.json', { responseType: 'json' })
      .subscribe((data) => {
        this.order = data
      });
    }
  }

  goToOrder() {
    window.location.href = '//' + window.location.host + '/orders/' + this.cookieService.get('cart-key')
  }

  addProduct(product) {
    const httpOptions = {
      headers: new HttpHeaders({
        'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').getAttribute('content')
      })
    }

    this._http.post(window.location.href + '/orders/add_product.json', {
      order: {
        key: this.cookieService.get('cart-key'),
        products: [product]
      }
    }, httpOptions).subscribe((response: any) => {
      this.cookieService.set('cart-key', response.key, null, '/')
      this.order = response
    });
  }

  pload(...args: any[]):void {
    let imgs = []
    for (var i = 0; i < args.length; i++) {
      imgs[i] = new Image();
      imgs[i].src = args[i];
      console.log('loaded: ' + args[i]);
    }
  }
}
