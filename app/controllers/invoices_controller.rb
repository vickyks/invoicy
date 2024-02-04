# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :generate_pdf, only: %i(create)

  def new
    @form_token = form_authenticity_token
  end

  def create
    send_file(
      invoice.path,
      type: 'application/pdf', # Set the appropriate content type
      filename: invoice.filename, # Set the desired file name
      disposition: 'attachment' # Make the browser download the file
    )
  end

  private

  def generate_pdf
    invoice.pdf
  end

  def invoice
    InvoiceTemplate.new(invoice_params)
  end

  def invoice_params
    params.permit(
      :org_name,
      :org_address,
      :org_email,
      :recipient_name,
      :recipient_address,
      items: %i[
        name
        description
        unit_price
        quantity
      ]
    )
  end
end
