import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import templateString from './app.component.html';

@Component({
  selector: 'catalog',
  template: templateString
})

export class AppComponent implements OnInit {
  public client: any
  public selectedCategory: any

  constructor(private _http: HttpClient) { }

  ngOnInit() {
    this.getClientDetails()
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
