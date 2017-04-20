require 'dom_reader'
require 'dom_renderer'

class DomSearcher
  attr_accessor :tree; :nodes_found

  
# Consider saving your Regular Expression to a variable or constant that's appropriately named instead of just using the naked expression in your code.

  def initialize
    # stores the tree
  end

  def search_by(type, word)

    # loop through the tree
    # store each node found in the array that

# if its a class search by class, elseif text seach the text, else if id, seacrh by id or class 

    # current.type == word
  end

  def search_children(some_node, :id, "key-section")
    # from the node given loop through its children until there are no more children
  end


  def search_ancestors
     # from the node given loop through its parent until there are no more parentss
  end


  def output
    sidebars.each { |node| renderer.render(node) }
  end



end