require 'rebuild_dom'
require 'dom_reader'


describe RebuildDom do 
  
  describe '#initialize' do
    let(:dom) {DomReader.new("test2.html") }
    
    it 'creates a loader of type DomSearcher' do
      expect(RebuildDom.new(dom.document)).is_a? RebuildDom
    end

    it "accepts a tree variable and does not throw an error" do
      expect {RebuildDom.new(dom.document)}.not_to raise_error
    end

    it "throws an error if no tree variable is provided" do
      expect {RebuildDom.new}.to raise_error(ArgumentError)
    end
  end

  describe "html_str" do
    let(:dom) {DomLoader.new("test2.html") }
    let(:rd) {RebuildDom.new(dom) }
    let(:rd2) {rd.rebuild(dom) }


    it "the html string starts off as blank" do
      expect(rd.html_str).to eq("")
    end

  end
end