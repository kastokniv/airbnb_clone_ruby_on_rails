require "rails_helper"

RSpec.describe "Homes", type: :request do
    let(:property) { create(:property) }
    let(:user) { create(:user) }
    
    before { sign_in user }

    describe "GET new" do
        it "succeeds" do
            get new_property_reservation_path(property), params: {
                checkin_date: "01/10/2023",
                checkout_date: "01/12/2023"
            }
        end
    end
end