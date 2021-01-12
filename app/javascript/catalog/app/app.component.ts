import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { CookieService } from 'ngx-cookie-service';

import templateString from './app.component.html';

@Component({
  selector: 'catalog',
  template: templateString
})

export class AppComponent implements OnInit {
  public client: any
  public selectedCategory: any
  public order: any

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
    console.log('hello')
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
