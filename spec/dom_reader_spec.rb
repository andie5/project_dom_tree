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

    it "returns an empty string once the string is processed" do
      expect(dom.html_str).to eq("")
    end
  end

  describe '#opening_tags' do
    let(:dom) {DomReader.new("test2.html") }
    it 'outputs a string that contains an opening tag' do
      expect(dom.opening_tags("<li>One main</li>")).to eq("<li>")
    end

    it 'outputs an empty string when there is no immediate string' do
      expect(dom.opening_tags("</head>\n  <body>\n    <div class=\"top-div\">")).to eq("")
    end
  end

  describe '#closing_tags' do
    let(:dom) {DomReader.new("test2.html") }
    it 'outputs a string that contains a closing tag' do
      expect(dom.closing_tags("</head>\n  <body>\n    <div class=\"top-div\">")).to eq("</head>")
    end

    it 'outputs an empty string when there is no immediate string' do
      expect(dom.closing_tags("<li>One main</li>")).to eq("")
    end
  end

  describe '#em_tags' do
    let(:dom) {DomReader.new("test2.html") }
    it 'outputs a string with an em tag' do
      expect(dom.em_tags("I'm an inner div!!! I might just <em>emphasize</em> some text.")).to eq("<em>emphasize</em> some text.")
    end

    it 'outputs an empty string when there is no em tag' do
      expect(dom.em_tags("<li>One main</li>")).to eq("")
    end
  end

  describe '#id_tag' do
    let(:dom) {DomReader.new("test2.html") }
    it 'outputs an id string' do
      expect(dom.id_tag("<main id=\"main-area\">")).to eq("main-area")
    end

    it 'outputs an empty string when there are no classes' do
      expect(dom.id_tag("<li>One main</li>")).to eq("")
    end
  end

  describe '#class_tags' do
    let(:dom) {DomReader.new("test2.html") }
    it 'outputs an array with the ids' do
      expect(dom.class_tags("<li class=\"bold funky important\">")).to eq(["bold", "funky", "important"])
    end

    it 'outputs an empty string when there are no classes' do
      expect(dom.class_tags("<li>One main</li>")).to eq([])
    end
  end

  describe '#get_type_opening' do
    let(:dom) {DomReader.new("test2.html") }
    it 'outputs the opening type tag' do
      expect(dom.get_type_opening("<li class=\"bold funky important\">")).to eq("li")
    end
  end

  describe '#get_type_closing' do
    let(:dom) {DomReader.new("test2.html") }
    it 'outputs the opening type tag' do
      expect(dom.get_type_closing("</head>\n  <body>\n    <div class=\"top-div\">")).to eq("head")
    end
  end

  describe "creates a tree a nodes from a html string" do
    let(:dom) {DomReader.new("test2.html") }

    it "returns the head node as 'html'" do
      expect(dom.document.type).to eq("html")
    end
  end
  
end
