#!/usr/bin/ruby

# file: dynarex-parser.rb

require 'requestor'

code = Requestor.read('http://rorbuilder.info/r/ruby') do |x| 
  x.require 'rexleparser'
end

eval code

class DynarexParser

  def initialize(s)
    @a = parse(s)
  end
  
  def to_a()
    @a
  end
  
  private
  
  def parse(s)

    s.instance_eval{
      def fetch_node(name)
        self[/<#{name}>(.*)<\/#{name}>/m,1]
      end
    }

    root_name = s[/<(\w+)/,1]

    summary = RexleParser.new("<summary>#{s.fetch_node(:summary)}</summary>").to_a

    raw_records = s.fetch_node(:records)
    records = nil

    if raw_records then
      node_name = raw_records[/<(\w+)/,1]
      records = raw_records.strip.split(/(?=<#{node_name}[^>]*>)/).map {|x| RexleParser.new(x).to_a}
    end 

    [root_name, "", {}, [*summary], ['records', "",{}, *records]]
  end

end