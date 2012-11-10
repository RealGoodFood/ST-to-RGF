Before do
  Fixtures.reset_cache
  fixtures_folder = File.join(Rails.root  , 'spec', 'fixtures')
  fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
  Fixtures.create_fixtures(fixtures_folder, fixtures)
  
  Capybara.default_host = 'test.lvh.me'
  Capybara.server_port = 9887
  Capybara.app_host = "http://test.lvh.me:9887"
end


Before('@badge') do
  # FactoryGirl.create(:community, :domain => "test3")
  #   puts "COMMUNITIES: #{Community.all.count}"
  steps %Q{
    Given there are following users:
       | person | 
       | kassi_testperson1 |
       | kassi_testperson2 |
    And I am logged in as "kassi_testperson1"
    And I belong to test group "4"
    When I go to the badges page of "kassi_testperson1"
    And I should see "Badges" within ".inbox_tab_selected"
    And I should see "Received feedback" within ".inbox_tab_unselected"
  }
end

Before ('@subdomain2') do
  Capybara.default_host = 'test2.lvh.me'
  Capybara.app_host = "http://test2.lvh.me:9887"
end

After('@subdomain2') do
  Capybara.default_host = 'test.lvh.me'
  Capybara.app_host = "http://test.lvh.me:9887"
end

Before ('@no_subdomain') do
  Capybara.default_host = 'lvh.me'
  Capybara.app_host = "http://lvh.me:9887"
end

After('@no_subdomain') do
  Capybara.default_host = 'test.lvh.me'
  Capybara.app_host = "http://test.lvh.me:9887"
end

Before ('@www_subdomain') do
  Capybara.default_host = 'www.lvh.me'
  Capybara.app_host = "http://www.lvh.me:9887"
end

After('@www_subdomain') do
  Capybara.default_host = 'test.lvh.me'
  Capybara.app_host = "http://test.lvh.me:9887"
end
