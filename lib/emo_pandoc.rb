require "emo_pandoc/version"
require 'emot'

class EmoPandoc
  def self.filter(json)
    case json
    when Array
      json.each do |item|
        filter(item)
      end
    when Hash
      if json["t"] == "Str"
        json["c"].gsub!(/:([a-z0-9\+\-_]+):/) do
          Emot.icon($1.to_sym)
        end
      else
        json.each do |key, val|
          if val.kind_of? Array
            val.each do |item|
              filter(item)
            end
          end
        end
      end
    else
      # ignore
    end
    json
  end
end
