require 'dom_searcher'
require 'dom_reader'


describe DomSearcher do 
  
  describe '#initialize' do
    let(:dom) {DomReader.new("test2.html") }
    
    it 'creates a loader of type DomSearcher' do
      expect(DomSearcher.new(dom.document)).is_a? DomSearcher
    end

    it "accepts a tree variable and does not throw an error" do
      expect {DomSearcher.new(dom.document)}.not_to raise_error
    end

    it "throws an error if no tree variable is provided" do
      expect {DomSearcher.new}.to raise_error(ArgumentError)
    end
  end


  describe '#search_by' do
    let(:ds) {DomReader.new("test2.html") }
    let(:dom) {DomSearcher.new(ds.document) }
    it 'returns the correct search type' do
      expect(dom.search_by(ds.document, :name)).to eq("html")
    end

    it 'returns no classes if there is no class' do
      expect(dom.search_by(ds.document, :classes)).to be(nil)
    end

    it 'returns the correct search text' do
      expect(dom.search_by(ds.document, :text)).to eq("<html>")
    end

    it 'returns no id if there is no id attribute' do
      expect(dom.search_by(ds.document, :id)).to be(nil)
    end
  end

   describe '#check_current' do
    let(:ds) {DomReader.new("test2.html") }
    let(:dom) {DomSearcher.new(ds.document) }


    it 'finds a an element and stores the node' do
      expect(dom.check_current(ds.document, :name, "html")).is_a? Node
    end
  end
end