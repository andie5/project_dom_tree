require 'dom_reader.rb'

class NodeRenderer

  attr_accessor :tree, :total_nodes, :node_count

  def initialize(tree)
    @tree = tree

    
  end

  def calculate(node)
    @total_nodes = 0
    # Based on the node passed in
    @tree.each do |node|
      @total_nodes +=1

    type_count

    end

  end


  def type_count
     # store the type of node in a hash
      # check if the node is already in the hash, if not append to it
  end

  def print_statistics
    # print total nodes
    # print hash of node counts

    # output the actual attributes stored in the node
  end

end