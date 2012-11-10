Given /^I use subdomain "([^"]*)"$/ do |subdomain|
  #visit("http://#{subdomain}.lvh.me:9887") 
  Capybara.default_host = "#{subdomain}.lvh.me"
  Capybara.app_host = "http://#{subdomain}.lvh.me:9887" if Capybara.current_driver == :culerity
end

When 'the system processes jobs' do
  Delayed::Worker.new(:quiet => true).work_off
end

When /^I print "(.+)"$/ do |text|
  puts text
end

Then /^(?:|I )should not see selector "([^"]*)"?$/ do |selector|
  lambda {
    with_scope(selector) do
      # nothing to do here, just try to search the selector and should fail on that
    end
  }.should raise_error(Capybara::ElementNotFound)
end

When /^I move the focus to "([^"]*)"?$/ do |selected_element_id|
  #find("##{selected_element_id}").trigger('focus')
  page.evaluate_script("$('##{selected_element_id}').focus();")
end

When /^(?:|I )attach a valid image file to "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  @latest_uploaded_image = 'Australian_painted_lady.jpg'
  attach_image(@latest_uploaded_image, field, selector)
end

When /^(?:|I )attach an image with invalid extension to "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  attach_image('i_am_not_image.txt', field, selector)
end

Then /^I should see the image I just uploaded$/ do
  page.should have_xpath("//img[contains(@src,'#{@latest_uploaded_image}')]")
end

Then /^I should not see the image I just uploaded$/ do
  page.should_not have_xpath("//img[contains(@src,'#{@latest_uploaded_image}')]")
end

def attach_image(filename, field, selector)
  path = File.join(Rails.root, 'spec', 'fixtures', filename)
  with_scope(selector) do
    attach_file(field, path)
  end
end