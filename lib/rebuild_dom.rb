require_relative 'dom_reader'

class RebuildDom
  attr_accessor :tree, :html_str

  def initialize(tree)
    @tree = tree
    @html_str = ""
  end

  def rebuild(node)
    current(node)
    rebuild_children(node)
  end

  def current(node)
    @html_str << node.text
  end

  def rebuild_children(node)
    unless node.children.nil?
      node.children.each do |child|
        spacing = extra_indentation(node)
        @html_str << "#{child.text}" + "#{spacing}"
        rebuild_children(child)
      end
    end
  end

  def extra_indentation(node)

    spacing = ""
    closing_tags = node.text.scan(/\A(<\/[a-z0-9]+>)/).join

    # Opening tag but not a list item
    if(node.type != "text") && (node.type != "li") && closing_tags.empty?
      spacing = "    "
    # List type closing tag
    elsif(node.type == "li") && !closing_tags.empty?
      spacing = "\n    "
    # Any closing type tag 
    elsif(node.type != "text") && !closing_tags.empty?
        spacing = "\n"
    end
    spacing
  end

  # The original string
  #<html>\n  <head>\n    <title>\n      This is a test page\n    </title>\n  </head>\n  <body>\n    <div class=\"top-div\">\n      I'm an outer div!!!\n      <div class=\"inner-div\">\n        I'm an inner div!!! I might just <em>emphasize</em> some text.\n      </div>\n      I am EVEN MORE TEXT for the SAME div!!!\n    </div>\n    <main id=\"main-area\">\n      <header class=\"super-header\">\n        <h1 class=\"emphasized\">\n          Welcome to the test doc!\n        </h1>\n        <h2>\n          This document contains data\n        </h2>\n      </header>\n      <ul>\n        Here is the data:\n        <li>Four list items</li>\n        <li class=\"bold funky important\">One unordered list</li>\n        <li>One h1</li>\n        <li>One h2</li>\n        <li>One header</li>\n        <li>One main</li>\n        <li>One body</li>\n        <li>One html</li>\n        <li>One title</li>\n        <li>One head</li>\n        <li>One doctype</li>\n        <li>Two divs</li>\n        <li>And infinite fun!</li>\n      </ul>\n    </main>\n  </body>\n</html>"
end