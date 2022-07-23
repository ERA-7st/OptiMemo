import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element)

    this.modal.show()
  }

  close() {
    this.modal.hide()
  }

  validate_close(event) {
    if (event.detail.success) {
      this.modal.hide()
    }
  }
}