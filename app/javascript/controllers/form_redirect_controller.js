import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  next(event) {
    if (event.detail.success) {
      const fetchResponse = event.detail.fetchResponse

      history.pushState(
        {turbo_frame_history: true},
        "",
        fetchResponse.response.url
      )
    }
  }
}
