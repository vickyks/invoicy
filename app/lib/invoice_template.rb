class InvoiceTemplate
  include 

  def initialize(invoice_data)
    @invoice_data = invoice_data
  end

  def generate_pdf
    PrawnHtml.append_html(pdf, invoice_template)
    pdf.render_file(path)
  end

  def path
    Rails.root.join('tmp', 'invoices', "invoice_#{Time.now.to_i}.pdf")
  end

  private

  def pdf
    @pdf ||= Prawn::Document.new(page_size: 'A4')
  end

  def total
    subtotals.sum
  end

  def subtotals
    @invoice_data.map do |item|
      item[:unit_price].to_f * item[:quantity].to_f
    end
  end

  def invoice_template
    Rails.root.join('app', 'views', 'pdfs', 'invoice.html')
  end
end
