require 'spec_helper'

describe "Proxies" do
  before(:each) do
    Proxy.table_name = 'examples'
  end

  describe "/proxies page" do
    it "should can add records" do
      logger.debug "Rspec Proxies@#{__LINE__}#should can add records"
      visit proxies_path(table_name: 'examples')
      page.should have_content('Name')
      page.should have_content('Position')
      page.should have_content('Add new record')
      click_on('Add new record')
      current_path.should == new_proxy_path(table_name: 'examples')
      fill_in 'Name', with: 'Alpha'
      fill_in 'Position', with: '1'
      click_button 'Save'
      page.should have_content 'Alpha'
      page.should have_content '1'
      click_on 'Back to list'
      current_path.should == proxies_path(table_name: 'examples')
      page.should have_content 'Alpha'
      page.should have_content '1'
    end

    it "should can delete records", js: true do
      logger.debug "Rspec Proxies@#{__LINE__}#should can delete records"
      Proxy.create name: 'Alpha', position: '1'
      visit proxies_path(table_name: 'examples')
      page.should have_content 'Alpha'
      page.should have_content '1'
      click_on 'Destroy'
      page.driver.browser.accept_js_confirms
      page.should have_content 'Alpha'
      sleep 1
      page.should_not have_content 'Alpha'
      page.should_not have_content '1'
    end

    it "should can mass update records", js: true do
      logger.debug "Rspec Proxies@#{__LINE__}#should can mass update records"
      Proxy.create name: 'Alpha', position: '1'
      Proxy.create name: 'Beta', position: '2'
      Proxy.create name: 'Delta', position: '3'
      visit proxies_path(table_name: 'examples')
      page.should have_content 'Alpha'
      page.should have_content 'Beta'
      page.should have_content 'Delta'
      find(:xpath, %q(//tr/th[contains(text(), 'Name')])).click
      page.should have_css %q(input[value=Alpha])
      page.should have_css %q(input[value=Beta])
      page.should have_css %q(input[value=Delta])
      alpha_input = find %q(input[value=Alpha])
      alpha_input.set 'l'
      page.execute_script %Q{ $('input[value=Alpha]').trigger("focus") }
      page.execute_script %Q{ $('input[value=Alpha]').trigger("keydown") }
      page.should have_selector(:xpath, %q(//ul/li/a[contains(text(), 'Alpha')]))
      page.should_not have_selector(:xpath, %q(//ul/li/a[contains(text(), 'Beta')]))
      page.should have_selector(:xpath, %q(//ul/li/a[contains(text(), 'Delta')]))
      click_on 'Cancel'
      page.should_not have_css %q(input[value=Alpha])
      page.should_not have_css %q(input[value=Beta])
      page.should_not have_css %q(input[value=Delta])
      find(:xpath, %q(//tr/th[contains(text(), 'Name')])).click
      alpha_input = find %q(input[value=Alpha])
      alpha_input.set 'Gamma'
      page.execute_script %Q{ $('input[value=Alpha]').trigger("focus") }
      page.execute_script %Q{ $('input[value=Alpha]').trigger("keydown") }
      click_on 'Save'
      sleep 1
      page.should_not have_content 'Alpha'
      page.should have_content 'Gamma'
    end
  end
end
