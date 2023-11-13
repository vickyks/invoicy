# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  describe 'GET /invoices' do
    it 'returns http success' do
      get '/invoices/'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /invoices' do
    let(:invoice_pdf) { File.read(Rails.root.join('spec/fixtures/invoice.pdf')) }

    before do
      allow(InvoiceTemplate).to_receive(:generate_pdf).and_return(invoice_pdf)
    end

    context 'with invoice params' do
      let(:params) do
        {
          "org_name": 'Your Organization',
          "org_address": '123 Main St, Cityville',
          "org_email": 'info@yourorganization.com',
          "recipient_name": 'John Doe',
          "recipient_address": '456 Oak St, Townsville',
          "items": [
            {
              "name": 'Item 1',
              "description": 'Description of Item 1',
              "unit_price": 10.00,
              "quantity": 2
            },
            {
              "name": 'Item 2',
              "description": 'Description of Item 2',
              "unit_price": 8.50,
              "quantity": 5
            }
          ]
        }
      end

      it 'returns http success' do
        post '/invoices/'
        expect(response).to have_http_status(:success)
      end

      it 'returns a pdf' do
        post '/invoices/', params

        expect(response.body).to eq(invoice_pdf)
      end
    end
  end
end
