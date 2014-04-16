require 'spec_helper'

describe CatalogController do
  render_views

  before(:all) do
    FactoryGirl.create(:book)
    @user = FactoryGirl.create(:user)
  end

  describe 'index' do
    before (:each) do
      # override the view helpers to stop the controller hitting Devise and causing errors
      controller.stub(:render_bookmarks_control).and_return(false)
      controller.stub(:current_user).and_return(@user)
    end

    it 'should retrieve a list of books with the correct fields defined' do
      get :index, {search_field: 'all_fields', q: 'conquest'} # do a blank search
      response.should be_successful
      response.should render_template(:index)
      response.should contain('Søgeresultater')
      response.should contain('The Conquest of Bread')
      response.should contain('Peter Kropotkin')
      response.should contain('1892')
    end

    it 'should retrieve a no-results page' do
      get :index, {search_field: 'all_fields', q: 'kfkfkfkjldkfjkgjsklfl'} # do a gobbledygook search
      response.should be_successful
      response.should contain('Ingen bøger fundet')
      response.should_not contain('The Conquest of Bread')
    end
  end

  after(:all) do
    Book.destroy_all
    User.destroy_all
  end
end