# Introducing the dynarex-parser gem

    require 'rexleparser'

    class DynarexParser

      def initialize(s)

        s.instance_eval{
          def fetch_node(name)
            self.slice(((self =~ /<#{name}>/) + name.length + 2) .. (self =~ /<\/#{name}>/) - 1)
          end
        }

        root_name = s[/<(\w+)/,1]

        summary = RexleParser.new("<summary>#{s.fetch_node(:summary)}</summary>").to_a

        raw_records = s.fetch_node(:records)
        node_name = raw_records[/<(\w+)/,1]
        records = raw_records.strip.split(/(?=<#{node_name}[^>]+>)/).map {|url| RexleParser.new(url).to_a}

        @a = [root_name, "", {}, [*summary], ['records', "",{}, *records]]
      end
      
      def to_a()
        @a
      end
    end

    s = "<urls><summary><name>eee</name><age>44</age></summary><records><url><name>fun</name></url><url><name>right</name></url><url><name>rrr</name></url></records></urls>"
    a = DynarexParser.new(s).to_a

    #=> ["urls", "", {}, ["summary", "", {}, ["name", "eee", {}], ["age", "44", {}]], ["records", "", {}, ["url", "", {}, ["name", "fun", {}]], ["url", "", {}, ["name", "right", {}]], ["url", "", {}, ["name", "rrr", {}]]]]
    
Parse a Dynarex document with the Dynarex Parser

The Dynarex Parser reads a Dynarex document as an XML string and returns a tree representation within an array for use by Rexle. The Dynarex document is simple to parse since it contains only a summary node and a records node at the top level. The records node stores a flat list of records in native XML format, which can be parsed using String#split combined with RexleParser.

This method is much quicker than simply using RexleParser on its own since Dynarex records can be processed uniformly within a predetermined loop.

