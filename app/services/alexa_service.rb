require 'rest_client'
require 'json'

class AlexaService
  def self.cal_rank(url)
    headers = {
      'content-type': "application/json",
      'x-api-key': "8T7SlYd7Tp16a9VPBovC26LXGhosXjeM97CLbUUv",
      'accept': "json",
    }
    alexa_url = 'https://awis.api.alexa.com/api?Action=UrlInfo&ResponseGroup=Rank&Url=' + url
    response = RestClient.get(alexa_url, headers)
    
    extract_value(response)
  end

  private

  def self.extract_value(response)
    doc = Nokogiri::XML(response)
    doc.xpath("//TrafficData//Rank")[0].text
  end
end