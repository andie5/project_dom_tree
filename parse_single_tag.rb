Node = Struct.new(:name, :id, :classes, :type)

class ParseSingleTag

# Warmup 1
# Write a method which parses this string into a simple Hash or Struct object containing its key attributes. Use Regex.
# "<p class='foo bar' id='baz' name='fozzie'>"
  def parse_tag(tag)
    tag_def = Node.new
    tag_def.name = tag.scan(/name='(.+)'/).join
    tag_def.id = tag.scan(/id='(.+)'\s/).join
    tag_def.classes = tag.scan(/class='(.+?)'/).join.split(" ")
    tag_def.type = tag.scan(/<([a-z]+\s)/).join.strip  
    tag_def   
  end
end
