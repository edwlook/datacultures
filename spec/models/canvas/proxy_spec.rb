require 'rails_helper'
require 'faraday'
require 'byebug'

RSpec.describe Canvas::Proxy, :type => :model do

   before(:all) do
     @connection = Faraday.new('http://localhost:3100/api/v1/')
   end

   describe "As a site admin" do
     @connection = Faraday.new('http://localhost:3100/api/v1/')
     @connection.headers.merge!({"Authorization" => "Bearer " + Rails.application.secrets[:master_api_key]})

     it "calls to the discussion API work" do
       api_call = @connection.get('courses/1/discussion_topics')
       expect(api_call.status).to eq(200)
     end

   end


end
