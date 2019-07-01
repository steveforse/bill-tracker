require "rails_helper"

RSpec.describe SchedulesController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/payees/1/schedules/new").to route_to("schedules#new", payee_id: '1')
    end

    it "routes to #edit" do
      expect(:get => "/schedules/1/edit").to route_to("schedules#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/payees/1/schedules").to route_to("schedules#create", payee_id: '1')
    end

    it "routes to #update via PUT" do
      expect(:put => "/schedules/1").to route_to("schedules#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/schedules/1").to route_to("schedules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/schedules/1").to route_to("schedules#destroy", :id => "1")
    end
  end
end