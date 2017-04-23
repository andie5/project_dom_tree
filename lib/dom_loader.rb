
# Load the dom file, then run the read_file method
# filepath = ../test.html"
# DomLoader.new(filepath or filename).read_file

class DomLoader
  attr_accessor :dict_file, :html_str

  def initialize(file_path)
    @dict_file = file_path
    read_file
  end

  def read_file
    @html_str = File.read(@dict_file)
  end
end



