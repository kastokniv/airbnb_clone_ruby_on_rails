# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Favourites", type: :request do
  let(:headers) do
    { "ACCEPT" => "application/json" }
  end
  let(:user) { create(:user) }
  let(:property) { create(:property) }

  before { sign_in user }

  describe "POST create" do
    let(:params) do
      {
        user_id: user.id,
        property_id: property.id
      }
    end

    it "creates a new favourite" do
      expect do
        post api_favourites_path, params: params, headers: headers
      end.to change(Favourite, :count).by(1)
      expect(response.status).to eq 201
    end
  end

  describe "DELETE destroy" do
    it "deletes a favourite" do
      favourite = create(:favourite)
      expect do
        delete api_favourite_path(favourite), headers: headers
      end.to change(Favourite, :count).by(-1)
      expect(response.status).to eq 204
    end
  end
end
