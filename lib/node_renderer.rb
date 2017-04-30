require_relative 'dom_reader'

class NodeRenderer
  attr_accessor :tree, :total_nodes, :node_count

  def initialize(tree)
    @tree = tree
  end

  def render(node=@tree)
    nodes_count(node)
    type_count(node)
    print_statistics(node)
  end

  def nodes_count(node)
    @total_nodes = 0
    unless node.children.nil?
      node.children.each do |child|
        nodes_count(child)
        @total_nodes +=1
      end
    end
  end

  def type_count(node)
    # Based on the node passed in
    @node_count = Hash.new

    unless node.children.nil?
      node.children.each do |child|
        type_count(child)
        type = child.type

        # If the hash key is already present append to it or add it as a new key
        if(@node_count.key?(type))
          @node_count[type] += 1
        else
          # Add a new key to the hash 
          @node_count[type] = 1
        end
      end
    end
  end

  def output_types
    puts "The frequency of each type of node:"
     @node_count.each {|key, value| puts "#{key} : #{value}"}
  end

  def data_attributes(node)
    if node.classes == []
      puts "There are no classes in this node"
    else
      puts "The classes are as follows #{node.classes}"
    end

    if node.id = ""
      puts "No id attributes"
    else
      puts "The id is as follows #{node.id}"
    end
  end

  def print_statistics(node)
    puts "The total number of nodes are #{@total_nodes}"
    output_types
    data_attributes(node)
  end
end