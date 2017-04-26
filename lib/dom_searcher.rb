require_relative 'dom_reader'

class DomSearcher
  attr_accessor :tree, :nodes_found,
  
# Consider saving your Regular Expression to a variable or constant that's appropriately named instead of just using the naked expression in your code.

  def initialize(tree)
    @tree = tree
  end

  def search_by(search_item)
    case search_item
      when :name
       search_item.type
      when :text
       search_item.text
      when :id
       search_item.id
      when :class
       search_item.classes
    end
  end

  def check_current(some_node, type, text)
    if(some_node.search_type.scan(text) )
      @nodes_found << some_node
    end
  end

  def search_children(some_node, type, text)
    @nodes_found = []

    search_type = search_by(type)
    check_current(some_node, search_type, text)
    search_children_nodes(some_node, search_type, text)
  end

  def search_children_nodes(some_node, type, text)
    # from the node given loop through its children until there are no more children
    unless some_node.children.nil?
      some_node.children.each do |child|
        if(child.search_type.scan(text) )
          @nodes_found << some_node
        end
        search_children_nodes(child, search_type, text)
      end
    end
  end

  def search_ancestors(some_node, type, text)
    @nodes_found = []

    search_type = search_by(type)
    check_current(some_node, search_type, text)
    search_ancestors_nodes(some_node, search_type, text)
  end

  def search_ancestors_nodes(some_node, search_type, text)
     # from the node given loop through its parent until there are no more parentss

     unless some_node.parent.nil?
      some_node.parent.each do |ancestor|
        if(ancestor.search_type.scan(text).join != "")
          @nodes_found << some_node
        end
        search_ancestors_nodes(ancestor, search_type, text)
      end
    end
  end

  # def output
  #   sidebars.each { |node| renderer.render(node) }
  # end
end