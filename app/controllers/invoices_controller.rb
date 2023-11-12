class InvoicesController < ApplicationController
  def new; end

  def create
    @invoice = Invoice.new()
    render json: { url: generate_invoice_url }
  end

  private

  def generate_invoice_url
    # create a pdf file from params
    InvoiceTemplate.new(invoice_params)
  end

  def invoice_params
    params.permit(:org_name, :org_email, :org_address, item_params)
  end

  def item_params
    # example params:
    # {
    #   "items": [
    #     {
    #       "name": "Item 1",
    #       "description": "Description of Item 1",
    #       "price": 100,
    #       "quantity": 1
    #     },
    #  }
    params.require(:items).map do |item|
      item.permit(:name, :description, :price, :quantity)
    end
end
