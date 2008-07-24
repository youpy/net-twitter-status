require 'rubygems'
require 'hpricot'
require 'open-uri'

module Net
  module Twitter
    class Status
      VERSION = '0.0.1'

      class Features
        include Enumerable

        def initialize(elements)
          @elements = elements
        end

        def each
          @elements.each do |element|
            yield Feature.new(element)
          end
        end

        def size
          @elements.size
        end

        def names
          map do |feature|
            feature.name
          end
        end

        def [](name)
          find do |feature|
            feature.name == name
          end
        end
      end
      
      class Feature
        def initialize(element)
          @element = element
        end

        def name
          @element.inner_text
        end

        def status
          case @element['style'].gsub(/^background-color:/, '')
            when 'orange'
            :problem
            when 'yellowgreen'
            :ok
            when 'darkred'
            :offline
          end
        end

        def message
          @element['title']
        end
      end

      def features
        doc = Hpricot(open('http://status.twitter.com/').read)
        elements = doc.search('//div[@id="description"]//span').map do |element|
          element
        end

        Features.new(elements)
      end
    end
  end
end
