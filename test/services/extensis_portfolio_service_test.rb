require 'test_helper'

class ExtensisPortfolioService < ActiveSupport::TestCase
  test 'it returns the available operations' do
    extensis_portfolio_service = ExtensisPortfolioService.new

    assert_not_nil extensis_portfolio_service.get_soap_operations, 'Should return soap operations'
  end
end
