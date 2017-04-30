# project_dom_tree
Like leaves on the wind

Andrea A

[A data structures, algorithms, file I/O, ruby and regular expression (regex) project from the Viking Code School](http://www.vikingcodeschool.com)

#Warmup 1

```tag = parse_tag("<p class='foo bar' id='baz'>")
tag.type 
#=> "p"
tag.classes 
#=> ["foo", "bar"]
tag.id 
#=> "baz"
tag.name 
#=> "fozzie"
```

Using pry:

# DomReader
```load 'load_reader.rb'
filepath = "../test.html"
dr = DomReader.new(filepath)
```

# NodeRenderer
```load 'node_renderer.rb'
filepath = "../test.html"
dr = DomReader.new(filepath)
nr = NodeRenderer.new(dr.document)
nr.render
```

# DomSearcher
```load 'dom_searcher.rb'
filepath = "../test.html"
dr = DomReader.new(filepath)
ds = DomSearcher.new(dr.document)
ds.search_children(dr.document, :name, "html")
ds.search_ancestors(dr.document, :name, "html")
```

# RebuildDom
```load 'rebuild_dom.rb'
filepath = "../test.html"
dr = DomReader.new(filepath)
rd = RebuildDom.new(dr.document)
rd.rebuild(dr.document)
rd.html_str ```



