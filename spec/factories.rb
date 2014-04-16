FactoryGirl.define do
  factory :user do
    email 'fake@example.com'
    password "thisisactuallynotapasswordyousillycomputer"
  end

  factory :book do
    title 'The Conquest of Bread'
    dateIssued '1892'
    author ['Peter Kropotkin']
  end
end