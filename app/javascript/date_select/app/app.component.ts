import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { CookieService } from 'ngx-cookie-service';

import templateString from './app.component.html';

@Component({
  selector: 'date-select',
  template: templateString
})

export class AppComponent implements OnInit {
  public client: any
  public selectedCategoryReference: any
  public selectedCategory: any
  public startDate: any
  public products = []
  public selectedProductReference: any
  public selectedProduct: any
  public totalQuantity = 0

  constructor(private _http: HttpClient, private cookieService: CookieService) { }

  ngOnInit() {
    this.getClientDetails()
  }

  decrementQuantity(product) {
    if (product.quantity > 0) {
      product.quantity = (product.quantity || 0) - 1
      this.totalQuantity--
    }
  }

  incrementQuantity(product) {
    product.quantity = (product.quantity || 0) + 1
    this.totalQuantity++
  }

  findCategoryObject() {
    if (this.selectedCategoryReference != 'undefined') {
      this.selectedCategory = this.client.categories.find((c) => { return c.reference == this.selectedCategoryReference})
      this.products = this.selectedCategory.products
    } else {
      this.selectedCategory = undefined
      this.products = []
    }
  }

  continueToOrder() {
    const httpOptions = {
      headers: new HttpHeaders({
        'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').getAttribute('content')
      })
    }

    this._http.post(window.location.href + '/orders.json', {
      order: {
        key: this.cookieService.get('cart-key'),
        start_date: this.startDate,
        products: this.selectedCategory.products
      }
    }, httpOptions).subscribe((response: any) => {
      this.cookieService.set('cart-key', response.key, null, '/')
      window.location.href = '//' + window.location.host + '/orders/' + response.key
    });
  }

  getClientDetails() {
    this._http.get(window.location.href + '.json', { responseType: 'json' })
    .subscribe((data) => {
      this.client = data
      console.log(data)
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

  pload(...args: any[]):void {
    let imgs = []
    for (var i = 0; i < args.length; i++) {
      imgs[i] = new Image();
      imgs[i].src = args[i];
      console.log('loaded: ' + args[i]);
    }
  }
}
