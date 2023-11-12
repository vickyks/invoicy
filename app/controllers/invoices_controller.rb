class InvoicesController < ApplicationController
  def new
    @form_token = form_authenticity_token
  end

  def create
    render json: { url: generate_invoice_url }
  end

  private

  def generate_invoice_url
    # create a pdf file from params
    InvoiceTemplate.new(invoice_params)
  end

  def invoice_params
    params.permit(
      :org_name,
      :org_address,
      :org_email,
      :recipient_name,
      :recipient_address,
      items: [
        :name,
        :description,
        :unit_price,
        :quantity
      ]
    )
  end
end
