Given (/^I am on Bifrost-Boeger searchpage/) do
  visit root_path
  print page.html
end

When(/^Search for "(.*)" in "(.*)"/) do |query, term|
  fill_in 'q', :with => query
  select term , :from => 'search_field'
  click_on 'searchButton'
  print page.html
end

Then(/^I should see "(.*)" in "(.*)"/) do |query, field|
  page.should have_content "#{field}: #{query}"
end