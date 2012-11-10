require 'spec_helper'

describe Api::PeopleController do
  render_views
  
  describe "index" do
    it "returns correct user based on email" do
      @p1 = FactoryGirl.create(:person, :given_name => "Danny", :family_name => "van Testburg", :phone_number => "123456789", :email => "danny@example.com")
      get :index, :email => @p1.email, :format => :json
      resp = JSON.parse(response.body)
      response.status.should == 200
      resp["people"][0]["given_name"].should == "Danny"
      resp["people"][0]["id"].should == @p1.id
    end
  end
    
    
  describe "show" do
  
    before(:each) do
      @p1 = FactoryGirl.create(:person, :given_name => "Danny", :family_name => "van Testburg", :phone_number => "123456789")
      @c1 = FactoryGirl.create(:community)
      @c2 = FactoryGirl.create(:community)
      @l1 = FactoryGirl.create(:location, :person => @p1, :location_type => "person")
      @p1.communities << @c1
      @p1.communities << @c2
      @p1.ensure_authentication_token!
      @p2 = FactoryGirl.create(:person)
      @p2.ensure_authentication_token!
    end
  
    it "returns basic json of a person" do
      get :show, :id => @p1.id, :format => :json
      resp = JSON.parse(response.body)
      response.status.should == 200
      #puts resp.to_yaml
      resp["given_name"].should == "Danny"
      resp["family_name"].should == "van Testburg"
      resp["id"].should == @p1.id
    end
    
    it "includes email if the person asks his own details" do
      request.env['Sharetribe-API-Token'] = @p1.authentication_token
      get :show, :id => @p1.id, :format => :json
      response.status.should == 200
      resp = JSON.parse(response.body)
      #puts resp.to_yaml
      resp["id"].should == @p1.id
      resp["email"].should == @p1.email
      resp["picture_url"].should =~ /^http/
      resp["thumbnail_url"].should =~ /^http/
    end
    
    it "includes phone and location if asker is logged in" do
      request.env['Sharetribe-API-Token'] = @p2.authentication_token
      get :show, :id => @p1.id, :format => :json
      response.status.should == 200
      resp = JSON.parse(response.body)
      #puts resp.to_yaml
      resp["id"].should == @p1.id
      resp["email"].should be_nil
      resp["phone_number"].should == "123456789"
      resp["location"].should_not be_nil
      
    end
    
    it "should not include phone and location if asker is not logged in" do
      get :show, :id => @p1.id, :format => :json
      response.status.should == 200
      resp = JSON.parse(response.body)
      #puts resp.to_yaml
      resp["id"].should == @p1.id
      resp["email"].should be_nil
      resp["phone_number"].should be_nil
      resp["location"].should be_nil
    end
    
    
  end

end