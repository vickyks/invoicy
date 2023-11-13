require 'rails_helper'

RSpec.describe InvoiceTemplate do
  let(:invoice_data) do
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

  let(:temp_dir) { Dir.mktmpdir }
  let(:template_path) { Rails.root.join('spec', 'fixtures', 'invoice_template.html.erb') }

  subject { described_class.new(invoice_data, template_path) }

  after do
    FileUtils.remove_entry(temp_dir)
    File.delete(subject.path) if File.exist?(subject.path)
  end

  describe '#pdf' do
    let(:invoice_template) { InvoiceTemplate.new(invoice_data) }

    it 'generates a PDF file' do
      # Set the path to the temporary directory
      allow(invoice_template).to receive(:path).and_return(File.join(temp_dir, invoice_template.filename))

      # Call the pdf method to generate the PDF
      invoice_template.pdf

      # Now you can write expectations based on the generated PDF file in the temporary directory
      generated_pdf_path = invoice_template.path
      expect(File.exist?(generated_pdf_path)).to be_truthy
    end
  end

  describe '#filename' do
    it 'returns a filename with the correct format' do
      timestamp = Time.now.to_i
      expect(subject.filename).to match(/invoice_#{timestamp}\.pdf/)
    end
  end
end
