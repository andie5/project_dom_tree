# spec/dom_reader_spec.rb

require 'dom_reader'

describe DomReader do 
  describe '#initialize' do
    it 'creates a loader of type DomReader' do
      expect(DomReader.new("test.html")).is_a? DomReader
    end

    it "accepts a string filepath and does not throw an error" do
      expect {DomReader.new("test.html")}.not_to raise_error
    end

    it "throws an error if no file path provided" do
      expect {DomReader.new}.to raise_error(ArgumentError)
    end
  end

   describe "#remove_doctype" do
    let(:dom) {DomReader.new("test2.html") }

     it "returns a string with no doctype regardless of the file passed in" do
      expect(dom.html_str).to eq("<html>\n</html>")
    end
  end
end
