import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"
import debounce from "debounce"

// Connects to data-controller="searchable-dropdown"
export default class extends Controller {
  static values = {
    url: String,
    attribute: String
  }
  static targets = ["search"]
  
  connect() {
    this.selected = new Set()
    this.setupEventListener()
    this.debouncedChange = debounce(this.debouncedChange.bind(this), 300)
  }

  change(e) {
    get(`${this.urlValue}?${this.attributeValue}=${e?.target?.value || ''}`, {
      responseKind: "turbo-stream"
    })
  }

  debouncedChange(e) {
    this.change(e)
  }

  select(e) {
    const ingredient = e.target.value

    if (e.target.checked) {
      this.selected.add(ingredient)
    } else {
      this.selected.delete(ingredient)
    }

    // Reset the dropdown
    this.searchTarget.value = ''
    this.change()
  }

  setupEventListener() {
    document.addEventListener("turbo:before-stream-render", (event) => {
      const turboStreamElement = event.target
      const {action, target} = turboStreamElement
      const template = turboStreamElement.firstElementChild
      if (action === 'update') {
        template.content.querySelectorAll('input[type="checkbox"]').forEach((checkbox) => {
          if (this.selected.has(checkbox.value)) {
            checkbox.checked = true
          }
        })
      }
    })
  }
}