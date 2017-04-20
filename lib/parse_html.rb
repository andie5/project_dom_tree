
# Parse the simple HTML in test_small.html into a data structure 
# Read through your data structure and output the same HTML again at the end (though it doesn't need to be formatted exactly the same way)


# html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
require 'pry'

Node = Struct.new(:current, :children, :parent)

class ParseHTML

  attr_accessor :root, :html_string, :parsed_str

  def initialize(html_string)
    parser_script(html_string)
    outputter(@root)
  end

  def parser_script(html_string)
    @html_string = html_string
    html_def = Node.new
    html_def.current = first_tag(html_string)
    html_def.children = []
    html_def.parent = nil

    @root = html_def
    build_tree(@root)  
  end

  def first_tag(html_string)
    html_string.scan(/^(<[a-z]+>)/).join
  end

  def opening_tags(html_string)
    html_string.scan(/^(<[a-z]+>)/).join
  end

  def closing_tags(html_string)
    html_string.scan(/^(<\/[a-z]+>)/).join
  end

  def build_tree(head)
    while @html_string.length > 0
      create_child_nodes(head)
      head.children.each do |child|

        # puts "The string found is '#{head.current}"
        # puts "The remaining string is'#{@html_string}"
        build_tree(child)
      end
    end
  end

  def create_child_nodes(current_node)
    @html_string = @html_string.sub(/^#{current_node.current}/, "").strip

    if @html_string.length > 0
      open_tag = opening_tags(@html_string)
      close_tag = closing_tags(@html_string)
      current = ""

      if(!open_tag.empty?)
        current = open_tag
      elsif(!close_tag.empty?)
        current = close_tag
      else
        i = @html_string.index(/</)
        current = @html_string[0..i-1]
      end

      new_node = Node.new(current, [], current_node)
      current_node.children << new_node
    end
  end

  def outputter(data_structure)
    current_node = data_structure
    puts "#{current_node.current}"
   
    current_node.children.each do |child|
      unless child.children.nil?
        outputter(child)
      end
    end
  end
    
end