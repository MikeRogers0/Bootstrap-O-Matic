class Colormind::API
  def self.random_colours
    response = api.post '/api/', '{"model":"default"}'

    if response.status == 200
      result = JSON.parse(response.body)['result'].collect do |colours|
        "##{colours.collect {|c| c.to_s(16)}.join('')}"
      end
    else
      []
    end
  end

  def self.api
    Faraday.new(url: 'http://colormind.io/') do |req|
      req.adapter  Faraday.default_adapter
    end
  end
end
