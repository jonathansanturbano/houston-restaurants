import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form", "list", "input"];

  update(e) {
    console.log(e.target.value);
    const url = `${this.formTarget.action}?category=${e.target.value}`;
    fetch(url, { headers: { Accept: "text/plain" } })
      .then((response) => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data;
      });
  }
}
