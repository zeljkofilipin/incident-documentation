require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
driver.navigate.to 'https://phabricator.wikimedia.org/T188381'

elements = driver.find_elements(class: 'remarkup-link')

puts elements

driver.quit
