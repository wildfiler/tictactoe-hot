Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
end
Capybara.default_driver = Capybara.javascript_driver = :cuprite

RSpec.configure do |config|
  config.prepend_before(:each, type: :system) do
    driven_by Capybara.javascript_driver
  end
end
