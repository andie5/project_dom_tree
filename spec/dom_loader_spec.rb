# spec/dom_loader_spec.rb

require 'dom_loader'

describe DomLoader do 
  describe '#initialize' do
    it 'creates a loader of type DomLoader' do
      expect(DomLoader.new("test.html")).is_a? DomLoader
    end

    it "accepts a string filepath and does not throw an error" do
      expect {DomLoader.new("test.html")}.not_to raise_error
    end

    it "throws an error if no file path provided" do
      expect {DomLoader.new}.to raise_error(ArgumentError)
    end
  end

   describe "#read_file" do
    let(:dom) {DomLoader.new("rspec_test.html") }

     it "returns an error if the file path isn't found" do
      expect {DomLoader.new("unknown.html")}.to raise_error(StandardError)
    end

    it "returns a string version of a file" do
      expect(dom.html_str).to eq("<html>\n</html>\n")
    end
  end
end
