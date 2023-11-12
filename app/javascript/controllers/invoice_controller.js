import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="invoice"
export default class extends Controller {
  // static targets = ['form']
  static targets = ['form', 'container'];

  connect() {
    this.formTarget.addEventListener('submit', this.handleFormSubmit.bind(this));
  }

  handleFormSubmit(event) {
    event.preventDefault();

    // Access form data
    const formData = new FormData(this.formTarget);

    fetch('/api/invoices', {
      method: 'POST',
      body: formData,
    }).then(response => {
      const pdfUrl = response.url;

      // Use Turbo Streams to update the page
      this.stimulate('Invoices#create', pdfUrl);
    });
  }

  addItem() {
    const newItemNumber = this.containerTarget.children.length + 1;

    // Clone the first item form and update its attributes
    const newItemForm = this.containerTarget.firstElementChild.cloneNode(true);
    newItemForm.innerHTML = newItemForm.innerHTML.replace(/_1/g, `_${newItemNumber}`);

    // Append the new item form to the container
    this.containerTarget.appendChild(newItemForm);
  }
}
