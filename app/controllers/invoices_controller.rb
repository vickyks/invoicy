# frozen_string_literal: true

class InvoicesController < ApplicationController
  def new
    @form_token = form_authenticity_token
  end

  def create
    # XXX: shoudl I just  do a respond to and change my request instead...?
    send_data invoice.pdf, filename: invoice.filename, type: 'application/pdf', disposition: 'inline'
  end

  private

  def invoice
    InvoiceTemplate.new(invoice_data)
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
