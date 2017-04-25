require 'dom_reader.rb'

class NodeRenderer

  attr_accessor :tree, :total_nodes, :node_count

  def initialize(tree)
    @tree = tree
  end

  def nodes_count(tree_strc=@tree)
    @total_nodes = 0
    # Based on the node passed in
    tree_strc.children.each do |node|
      @total_nodes +=1
    end
    puts "The total number of nodes are #{@total_nodes}"
  end

  def type_count(tree_strc=@tree)
    # Based on the node passed in
    @node_count = Hash.new

    tree_strc.children.each do |node|
      type = node.type

      # If the hash key is already present append to it or add it as a new key
      if(@node_count.key?(type))
        @node_count[type] += 1
      else
        # Add a new key to the hash 
        @node_count[type] = 1
      end
    end
    puts "The total number of nodes of each type are #{@type_count}"
  end

  def data_attributes(node)
    puts "The nodes data_attributes are as follows:"

    node.classes == [] ? puts "There are no classes" : puts "The classes are as follows #{node.classes}"
    node.id = ""? puts "No id attributes" : puts "The id is follows #{node.id}"
  end


  def print_statistics
    # print total nodes
    # print hash of node counts

    # output the actual attributes stored in the node
  end

  # def outputter(data_structure)
  #   current_node = data_structure
  #   puts "#{current_node.current}"
   
  #   current_node.children.each do |child|
  #     unless child.children.nil?
  #       outputter(child)
  #     end
  #   end
  # end

end