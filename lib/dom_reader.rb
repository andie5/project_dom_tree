
require_relative 'dom_loader'

Node = Struct.new(:type, :id, :classes, :text,  :children, :parent)

class DomReader

  attr_accessor :document, :html_str

  def initialize(file_path)
    dom_loader = DomLoader.new(file_path)
    @html_str = dom_loader.html_str

    # Remove the doctype node before parsing the rest if the file
    @html_str = @html_str.sub(/^<!doctype html>/, "").strip

    # @html_str = parser_script(dom_loader.html_str)
  end

  def parser_script(html_string)
    @document = Node.new
    @document.type = first_tag(html_string)
    @document.classes = []
    @document.id = nil
    @document.text = nil
    @document.children = []
    @document.parent = nil
    build_tree(@root)  
  end

  def remove_doctype
     @html_str = @html_str.sub(/^<!doctype html>/, "").strip
  end

  def first_tag(html_string)
    @html_str.scan(/^(<[a-z]+>)/).join
  end

  def opening_tags(html_string)
    @html_str.scan(/^(<[a-z]+>)/).join
  end

  def id_tag(text)
    text.scan(/id="(.+?)"\s/).join
  end

  def class_tags(text)
    text.scan(/class="(.+?)"\s/).join.split(" ")
  end

  def closing_tags(html_string)
    @html_str.scan(/^(<\/[a-z]+>)/).join
  end

  def build_tree(current_node)
    while @html_str.length > 0
      create_child_nodes(current_node)
      current_node.children.each do |child|
        build_tree(child)
      end
    end
  end

  def create_child_node(current_node)
    # loop through each child in the array
    # create new node with no children and the parent is the current node
    @html_str = @html_str.sub(/^#{current_node.text}/, "").strip

    if @html_str.length > 0
      open_tag = opening_tags(@html_str)
      id = process_attr_id(open_tag)
      classes = process_attr_class(open_tag)
      close_tag = closing_tags(@html_str)

      current = ""

      if(!open_tag.empty?)
        current = open_tag
      elsif(!close_tag.empty?)
        current = close_tag
      else
        i = @html_str.index(/</)
        current = @html_str[0..i-1]
      end

      # Get the type of node
      type = get_type(current)
      if get_type(current).empty?
        type = "text"
      end

      new_node = Node.new(type, id, classes, current, [], current_node)
      current_node.children << new_node
    end
  end

  def process_attr_id(text)
    text = text.strip
    id_tag(text)
  end

  def process_attr_class(text)
    text = text.strip
    class_tags(text)
  end

  def get_type(text)
    # Check for the tag with a class/id i.e a space after the namex
    type = text.scan(/<([a-z]+\s)/).join.strip

    # Check for a tag with an immediate closing brace
    if type.empty?
      type = text.scan(/<([a-z]+)>/).join.strip
    end
    type
  end
end