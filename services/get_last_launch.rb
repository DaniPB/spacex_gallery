require './services/requests_manager.rb'

class GetLastLaunch
  include RequestsManager

  URL = "/v3/launches/latest"

  def call
    response = get(URL)

    parsed_response = parse_response(response.body)

    if response.status == 200
      build_response(parsed_response)
    else
      { message: "Hubo un error", details: parsed_response }
    end
  end

  def build_response(response)
    images = response.dig(:links, "flickr_images")

    response.slice(:mission_name, :launch_date_local).merge(images: images)
  end
end
