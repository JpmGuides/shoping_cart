import { Component, OnInit, Input, ElementRef } from '@angular/core';
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
  public selectedDatesFilter: any = 'null'
  public selectedKindFilter: any = 'null'
  public selectedDurationFilter: any = 'null'
  public selectedAgeFilter: any = 'null'
  categoryId: any
  activeFilters: any = {}
  activeMetadataFilters: any = {}
  availableProducts: any

  constructor(private _http: HttpClient, private cookieService: CookieService, private elementRef: ElementRef) {
    this.categoryId = this.elementRef.nativeElement.getAttribute('category');
  }

  ngOnInit() {
    this.getClientDetails()
    this.getOrder()
  }

  selectCategory(category) {
    this.selectedCategory = category
    if (this.selectedCategory.order_metadata_key) {
      this.availableProducts = _.orderBy(this.selectedCategory.products, 'metadata.' + this.selectedCategory.order_metadata_key)
    } else {
      this.availableProducts = this.selectedCategory.products
    }
    window.history.pushState({ foo: this.client.name }, '', '/clients/' + this.client.id + '/categories/' + category.reference);
    window.scrollTo(0,0);
  }

  deselectCategory() {
    this.selectedCategory = null
    this.selectedDatesFilter = ''
    this.availableProducts = null
    window.history.pushState({ foo: this.client.name }, '', '/clients/' + this.client.id);
    window.scrollTo(0,0);
  }

  getClientDetails() {
    this._http.get(window.location.href + '.json', { responseType: 'json' })
    .subscribe((data) => {
      this.client = data
      let images = []

      this.client.online_categories.forEach(category => {
        if (category.image_url) {
          images.push(category.image_url)
        }

        category.products.forEach(product => {
          if (product.image_url) {
            images.push(product.image_url)
          }
        })

        if (this.categoryId && this.categoryId == category.reference) {
          this.selectCategory(category)
        }
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

    return filters
  }

  addDatesFilter() {
    if (this.selectedDatesFilter != 'null') {
      let parsedDate = this.selectedDatesFilter.split(',')

      this.activeFilters.start_date = parsedDate[0]
      this.activeFilters.end_date = parsedDate[1]
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

  addKindFilter() {
    if (this.selectedKindFilter != 'null') {
      this.activeFilters.kind = this.selectedKindFilter
    } else {
      delete this.activeFilters.kind
    }

    this.applyFilters()
  }

  durationFilters() {
    let filters = this.selectedCategory.products.map(product => {
      if (product.metadata) {
        return product.metadata.duration
      }
    })

    filters = _.uniq(_.compact(filters)).sort()

    return filters
  }

  addDurationFilter() {
    if (this.selectedDurationFilter != 'null') {
      this.activeMetadataFilters.duration = this.selectedDurationFilter
    } else {
      delete this.activeMetadataFilters.duration
    }

    this.applyFilters()
  }

  ageFilters() {
    return [5,6,7,8,9,10,11,12,13,14,15,16,17,18];
  }

  addAgeFilter() {
    if (this.selectedAgeFilter != 'null') {
      this.activeMetadataFilters.age = this.selectedAgeFilter
    } else {
      delete this.activeMetadataFilters.age
    }

    this.applyFilters()
  }

  applyFilters() {
    if (this.selectedCategory.order_metadata_key) {
      this.availableProducts = _.orderBy(this.selectedCategory.products, 'metadata.' + this.selectedCategory.order_metadata_key)
    }

    this.availableProducts = _.filter(this.selectedCategory.products, this.activeFilters)

    if (this.activeMetadataFilters.duration) {
      this.availableProducts = _.filter(this.availableProducts, ['metadata.duration', this.activeMetadataFilters.duration])
    }

    if (this.activeMetadataFilters.age) {
      let age_filter = this.activeMetadataFilters.age
      this.availableProducts = _.filter(this.availableProducts, function(item) {
        return item.metadata && item.metadata.max_age && item.metadata.min_age && parseInt(item.metadata.max_age) >= age_filter && parseInt(item.metadata.min_age) <= age_filter
      });
    }
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

  addProduct(product, event) {
    let element = event.target

    if (event.target.tagName == 'SPAN') {
     element = element.parentElement
    }

    element.setAttribute('disabled', 'disabled')
    element.classList.add('added')

    setTimeout(() => {
      element.classList.remove('added')
      setTimeout(() => {
        element.removeAttribute('disabled')
      }, 20)
    }, 1500);

    const httpOptions = {
      headers: new HttpHeaders({
        'X-CSRF-Token': document.querySelector('meta[name=csrf-token]').getAttribute('content')
      })
    }

    this._http.post('/clients/' + this.client.id + '/orders/add_product.json', {
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
    }
  }
}
