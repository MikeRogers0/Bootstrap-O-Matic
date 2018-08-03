class Colormind::API
  def self.random_colours
    response = api.post '/api/', '{"model":"default"}'

    if response.status == 200
      begin
        JSON.parse(response.body)['result'].collect do |colours|
          "##{colours.collect {|c| c.to_s(16).ljust(2, '0') }.join('')}"
        end
      rescue
        [
          "##{SecureRandom.hex(3)}",
          "##{SecureRandom.hex(3)}",
          "##{SecureRandom.hex(3)}",
          "##{SecureRandom.hex(3)}",
          "##{SecureRandom.hex(3)}"
        ]
      end
    else
      [
        "##{SecureRandom.hex(3)}",
        "##{SecureRandom.hex(3)}",
        "##{SecureRandom.hex(3)}",
        "##{SecureRandom.hex(3)}",
        "##{SecureRandom.hex(3)}"
      ]
    end
  end

  def self.api
    Faraday.new(url: 'http://colormind.io/') do |req|
      req.adapter  Faraday.default_adapter
    end
  end
end
