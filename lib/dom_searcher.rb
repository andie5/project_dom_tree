require_relative 'dom_reader'

class DomSearcher
  attr_accessor :tree, :nodes_found

  def initialize(tree)
    @tree = tree
    @nodes_found = []
  end

  def search_by(some_node, search_item)
    case search_item
      when :name
       some_node.type
      when :text
       some_node.text
      when :id
       some_node.id
      when :class
       some_node.classes
    end
  end

  def check_current(some_node, type, text)
    if(some_node.type.scan(text))
      @nodes_found << some_node
    end
  end

  def search_children(some_node, type, text)
    
    search_type = search_by(some_node, type)
    check_current(some_node, search_type, text)
    search_children_nodes(some_node, search_type, text)
  end

  def search_children_nodes(some_node, type, text)
    # from the node given loop through its children until there are no more children
    unless some_node.children.nil?
      some_node.children.each do |child|
        if(child.type.scan(text) )
          @nodes_found << some_node
        end
        search_children_nodes(child, type, text)
      end
    end
  end

  def search_ancestors(some_node, type, text)
    @nodes_found = []

    search_type = search_by(some_node, type)
    check_current(some_node, search_type, text)
    search_ancestors_nodes(some_node, search_type, text)
  end

  def search_ancestors_nodes(some_node, type, text)
     # from the node given loop through its parent until there are no more parents

     unless some_node.parent.nil?
      some_node.parent.each do |ancestor|
        if(ancestor.type.scan(text))
          @nodes_found << some_node
        end
        search_ancestors_nodes(ancestor, type, text)
      end
    end
  end
end