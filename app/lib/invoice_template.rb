# frozen_string_literal: true

class InvoiceTemplate
  def initialize(invoice_data)
    @invoice_data = invoice_data
  end

  def pdf
    prawndoc = Prawn::Document.new(page_size: 'A4')
    PrawnHtml.append_html(prawndoc, html_template)
    prawndoc.render_file(path)
  end

  def path
    Rails.root.join('tmp', 'invoices', filename)
  end

  def filename
    "invoice_#{Time.now.to_i}.pdf"
  end

  private

  def total
    subtotals.sum
  end

  def subtotals
    @invoice_data.map do |item|
      item[:unit_price].to_f * item[:quantity].to_f
    end
  end

  def template_path
    Rails.root.join('app', 'views', 'pdfs', 'invoice.html.erb')
  end

  def html_template
    html = File.read(template_path)
    erb_binding = binding
    ERB.new(html).result(erb_binding)
  end
end
