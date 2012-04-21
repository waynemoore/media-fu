require "spec_helper.rb"
require "utils.rb"
require "parser"

describe "recursive dir parser" do

  it "searches sub directories" do
    Dir.should_receive(:glob).with('foo/**/*').and_return([])
    parse_file_names('foo')
  end

  it "parses filenames as media" do
    path = '/blegga'
    contents = ["#{path}/foo.s01e01.avi", "#{path}/sub/bar.s02e03.avi"]
    Dir.stub(:glob).and_return(contents)

    metadata = parse_file_names(path)
    metadata.should have(2).items

    metadata[0].should == {
      :path => "#{contents[0]}",
    }.merge(parse(File.basename contents[0]))

    metadata[1].should == {
      :path => "#{contents[1]}",
    }.merge(parse(File.basename contents[1]))
  end

  it "skips unparsable filenames" do
    path = '/blegga'
    contents = ["#{path}/blah", "#{path}/sub/bar.s02e03.avi"]
    Dir.stub(:glob).and_return(contents)

    metadata = parse_file_names(path)
    metadata.should have(1).item
    metadata[0].should == {
      :path => "#{contents[1]}",
    }.merge(parse(File.basename contents[1]))
  end

end
