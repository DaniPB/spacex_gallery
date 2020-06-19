require 'spec_helper'

require './services/get_last_lounch.rb'

RSpec.describe GetLastLounch do
  describe "#call" do
    let(:response) { subject.() }

    context "Good API response" do
      it "Should return a parsed response with the API information" do
        VCR.use_cassette("get_last_lounch_success_response") do
          expected_response = {
            images: [
              "https://live.staticflickr.com/65535/50009748327_93e52a451f_o.jpg"
            ],
            mission_name: "Starlink-8 & SkySat 16-18",
            launch_date_local: "2020-06-13T05:21:00-04:00"
          }
         
          expect(response).to eq(expected_response)
        end
      end
    end

    context "Bad URL" do
      it "Should return an error message" do
        VCR.use_cassette("get_last_lounch_failure_response") do
          stub_const("GetLastLounch::URL", '/v3/launches/latst')

          expected_response = {
            message: "Hubo un error",
            details: { error: "Not Found" }
          }
         
          expect(response).to eq(expected_response)
        end
      end
    end
  end
end
