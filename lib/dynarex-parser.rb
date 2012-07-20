#!/usr/bin/ruby

# file: dynarex-parser.rb

require 'rexleparser'

class DynarexParser

  def initialize(s)
        
    schema = s[/schema>([^<]+)/,1]
    puts 'schema : ' + schema.inspect
    record_name, raw_fields = schema.match(/(\w+)\(([^\(]+)\)$/).captures
    
    error_found = raw_fields.split(',').include? record_name
    raise "record name must not match a field name" if error_found
    
    @a = parse(s.split(/(?=<!--)/).map {|x| x.sub(/<!--.*-->/m,'')}.join)
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
      records = raw_records.split(/(?=<#{node_name}[^>]*>)/).map \
          {|x| RexleParser.new(x.strip).to_a}
    end 

    [root_name, "", {}, [*summary], ['records', "",{}, *records]]
  end

end