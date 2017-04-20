# Node = structu for the tree

class DomReader
  Node = Struct.new(:type, :classes, :id, :text,  :children, :parent)

  attr_accessor :document 

  def initialize
  end

  def find_tags
   tag_def = Node.new
    tag_def.id = tag.scan(/id='(.+)'\s/).join
    tag_def.classes = tag.scan(/class='(.+?)'/).join.split(" ")
    tag_def.type = tag.scan(/(<[a-z]+>)/).join.strip  
    tag_def  
  end 

  def initialize
    # call the build_tree method with the string version of the document
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

  def build_tree(@html_str)
    # build the root node and store it
    # recurse function on the rest of the tree
  end

  def create_child_node(current_node)
    # loop through each child in the array
    # create new node with no children and the parent is the current node
  end

end