import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['container', 'form', 'popover'];

  addItem() {
    const index = this.containerTarget.children.length + 1;
    const template = this.template(index);
    this.containerTarget.insertAdjacentHTML("beforeend", template);
  }

  template(index) {
    return `<div data-invoice-target="item" class="border border-gray-300 rounded p-4 mb-4">
      <legend class="text-lg font-semibold mb-2">Item ${index}</legend>
        <div class="mb-4">
          <label for="item_name_${index}" class="block text-gray-700 text-sm font-bold mb-2">Item</label>
          <input type="text" id="item_name_${index}" name="items[][name]" placeholder="Enter item name"
                 class="appearance-none border rounded w-full py-2 px-3 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
          <label for="item_description_${index}" class="block text-gray-700 text-sm font-bold mb-2">Description</label>
          <input type="text" id="item_description_${index}" name="items[][description]" placeholder="Enter item name"
                 class="appearance-none border rounded w-full py-2 px-3 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
          <label for="item_unit_price_${index}" class="block text-gray-700 text-sm font-bold mb-2">Unit Price</label>
          <input type="text" id="item_unit_price_${index}" name="items[][unit_price]" placeholder="Enter item name"
                 class="appearance-none border rounded w-full py-2 px-3 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
          <label for="item_quantity_${index}" class="block text-gray-700 text-sm font-bold mb-2">Quantity</label>
          <input type="text" id="item_quantity_${index}" name="items[][quantity]" placeholder="Enter item name"
                 class="appearance-none border rounded w-full py-2 px-3 leading-tight focus:outline-none focus:shadow-outline">
        </div>
    </div>`;
  }

  handleFormSubmit(event) {
    event.preventDefault();

    const formData = new FormData(this.formTarget);

    fetch('/invoices', {
      method: 'POST',
      body: formData,
    })

    .then(response => {
      if (response.ok) {
        return response.blob(); // Get the response as a Blob
      } else {
        throw new Error('Failed to generate invoice');
      }
    })
    .then(blob => {
      const fileUrl = URL.createObjectURL(blob);

      this.popoverTarget.children[0].innerHTML = `<p class="text-teal-500">Success! Your invoice is ready for download.</p><a href="${fileUrl}" download class="block mt-4 text-teal-500 hover:underline">Download Invoice</a>`;

      this.showPopover();

      this.popoverTarget.querySelector("a").addEventListener("click", () => this.hidePopover());
      setTimeout(() => URL.revokeObjectURL(fileUrl), 1000);
    })
    .catch(error => {
      console.error('Error:', error);
      alert('Failed to generate invoice');
    });
  }

  showPopover() {
    this.popoverTarget.style.display = 'block';
  }

  hidePopover() {
    this.popoverTarget.style.display = 'none';
  }
}
