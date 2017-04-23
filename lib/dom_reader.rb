
require_relative 'dom_loader'

Node = Struct.new(:type, :id, :classes, :text, :children, :parent)

class DomReader

  attr_accessor :document, :html_str

  def initialize(file_path)
    dom_loader = DomLoader.new(file_path)
    @html_str = dom_loader.html_str

    # Remove the doctype node before parsing the rest if the file
    @html_str = @html_str.sub(/^<!doctype html>/, "").strip
    parser_script(dom_loader.html_str)
  end

  def parser_script(html_string)
    @document = Node.new
    raw_output = opening_tags(html_string)
    @document.type = get_type_opening(raw_output)
    @document.classes = []
    @document.id = nil
    @document.text = raw_output
    @document.children = []
    @document.parent = nil
    build_tree(@document)  
  end

  def remove_doctype
     @html_str = @html_str.sub(/^<!doctype html>/, "").strip
  end

  def opening_tags(output)
    output.scan(/\A(<[^\/].*?>)/).join
  end

  def id_tag(output)
    output.scan(/id="(.+?)"/).join
  end

  def class_tags(output)
    output.scan(/class="(.+?)"/).join.split(" ")
  end

  def closing_tags(output)
    output.scan(/\A(<\/[a-z0-9]+>)/).join
  end

  def em_tags(output)
    output.scan(/<em>[a-z0-9]+<\/em>.*/).join
  end


  def build_tree(current_node)
    while @html_str.length > 0
      create_child_node(current_node)
      current_node.children.each do |child|
        build_tree(child)
      end
    end
  end

  def create_child_node(current_node)
    # loop through each child in the array
    # create new node with no children and the parent is the current node
    
    @html_str = @html_str.sub(/^#{current_node.text}/, "").strip
    current = ""
    type = ""

    if @html_str.length > 0
      open_tag = opening_tags(@html_str)
      id = process_attr_id(open_tag)
      classes = process_attr_class(open_tag)
      close_tag = closing_tags(@html_str)
      em_tag = em_tags(@html_str)

      if(!open_tag.empty?)
        current = open_tag
        type = get_type_opening(open_tag)
      elsif(!close_tag.empty?)
        current = close_tag
        type = get_type_closing(close_tag)
      # elsif(!em_tag.empty?)
      #   i = @html_str.index(/</)
      #   em_size = em_tag.length
      #   current = @html_str[0..i+em_size]
      else
        i = @html_str.index(/</, 0)
        current = @html_str[0..i-1]
      end

      # Get the type of node
      type = "text" if type.empty?


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

  def get_type_opening(text)
    # Check for the tag with a class/id i.e a space after the namex
    type = text.scan(/\A<([a-z0-9]+\s)/).join.strip

    # Check for a tag with an immediate closing brace
    if type.empty?
      type = text.scan(/<([a-z0-9]+)>/).join.strip
    end
    type
  end

  def get_type_closing(text)
    # Check for the tag with a class/id i.e a space after the namex
    text.scan(/\A<\/([a-z]+)>/).join.strip
  end
end