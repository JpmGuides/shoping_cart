import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { HttpClient } from '@angular/common/http';
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

  constructor(private _http: HttpClient) { }

  ngOnInit() {
    this.getClientDetails()
  }

  decrementQuantity(product) {
    product.quantity = (product.quantity || 0) - 1

    if (product.quantity < 0) {
      product.quantity = 0;
    }
  }

  incrementQuantity(product) {
    product.quantity = (product.quantity || 0) + 1
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
