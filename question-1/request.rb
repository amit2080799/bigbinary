# To get data from api
class Request
  def fetch_api_response(url)
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri
      http.request request
    end
  end
end
