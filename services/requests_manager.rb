module RequestsManager

  SPACEX_URL = "https://api.spacexdata.com/v3/"

  def get(source)
    connection = Faraday.new(url: SPACEX_URL) do |f|
      f.adapter :net_http
    end

    connection.get(source)
  end

  def parse_response(json)
    parsed = JSON.parse(json)
    parsed.transform_keys!(&:to_sym)
  end
end
