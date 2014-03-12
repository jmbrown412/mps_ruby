require 'spec_helper'

describe MercuryRubyClient::Transaction do

  it 'should receive a credit sale response from Mercury Payments API' do
    @request            = MercuryRubyClient::Transaction.new
    params              = Hash.new
    params['InvoiceNo'] = '101'
    params['RefNo']     = '101'
    params['Track2']    = '4003000123456781=17055025432198712345'
    params['Purchase']  = '1.00'

    response = @request.process params, "/Credit/Sale"
    expect response.should_not eq nil
  end
end