
class DictionaryLoader
  attr_accessor :dict_file, :html_string

  def load(file_path)
    @html_string = read_file(file_path)
  end

  def read_file(file_path)
    File.read("test.html")

    # File.readlines(file_path).each do |line|
    #   arr << line.strip
    # end
    # arr
  end
end



