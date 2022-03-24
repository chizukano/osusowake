// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["latitudeInput", "longitudeInput"]

  connect() {
    console.log("connected")
  }

  getPosition(event) {
    event.preventDefault()
    navigator.geolocation.getCurrentPosition(
      (data) => {
        this.latitudeInputTarget.value = data.coords.latitude
        this.longitudeInputTarget.value = data.coords.longitude
        this.element.submit()
      },
      (data) => { console.log(data) }
    )
  }
}
