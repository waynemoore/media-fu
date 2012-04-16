require "spec_helper.rb"
require "parser"

describe "parser" do

  it "returns nil when no match is found" do
    parse("").should be_nil
    parse("blah").should be_nil
  end

  describe "parses filenames as tv shows" do

    names = ["foo_Bar_s01e02.avi",
             "foo_Bar_s1e02.avi",
             "foo_Bar_s1e2.avi",
             "foo Bar s01e02.avi",
             "foo.Bar.s01e02.avi",
             "foo_Bar_s01e02-BLEGGA-LOL.avi",
             "foo_Bar_s1e02.BLEGGA.Moo.avi",
             "foo_Bar_s1e2_DVD.avi",
             "foo_Bar_S01E02.AVI",
             "foo_Bar_S1E02.Avi",
             "foo_Bar_S1E2.AvI",

             "foo_Bar_01x02.avi",
             "foo_Bar_1x02.avi",
             "foo_Bar_1x2.avi",
             "foo.Bar.1x2.avi",
             "foo_Bar_01x02-FooBar-baz.avi",
             "foo_Bar_1x02.FooBar-baz.avi",
             "foo_Bar_1x2.FooBar-baz.avi",
             "foo.Bar.1x2_FooBar_baz.avi",
             "foo_Bar_01X02.avi",
             "foo_Bar_1X02.avi",
             "foo_Bar_1X2.avi",
             "foo.Bar.1X2.avi",
             ]

    names.each do |name|
      it "for name: #{name} " do
        meta_data = parse(name)
        meta_data.should == {
          :type => :tv_show,
          :title => "foo Bar",
          :season => 1,
          :episode => 2,
          :format => :avi
        }
      end
    end
  end

  describe "parses filenames as movies" do

    names = [
             "home_Video_(2012).avi",
             "home-Video-(2012).avi",
             "home.Video.(2012).avi",
             "home Video (2012).avi",
            ]

    names.each do |name|
      it "for name: #{name}" do
        meta_data = parse(name)
        meta_data.should == {
          :type => :movie,
          :title => "home Video (2012)",
          :format => :avi
        }
      end
    end
  end

end
