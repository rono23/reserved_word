require File.join(File.dirname(__FILE__), '../lib/reserved_word')

describe "ReservedWord" do
  before do
    ReservedWord.clear_all
    ReservedWord.load!(:site_slug)
  end

  it "should have default words" do
    ReservedWord.default_words.should be_kind_of(Array)
  end

  describe ".include?" do
    it "should include a word in default words" do
      ReservedWord.include?('about').should be_true
    end

    it "should not include a word in default words" do
      ReservedWord.include?('foo').should be_false
    end
  end

  describe ".list" do
    it "should return default words" do
      ReservedWord.list.should eq ReservedWord.default_words
    end
  end

  describe ".clear" do
    it "should clear default words" do
      ReservedWord.clear
      ReservedWord.list.should be_empty
    end
  end

  describe ".clear_all" do
    it "should clear all words" do
      ReservedWord.foo = %w(bar)
      ReservedWord.clear_all
      ReservedWord.list.should be_empty
      lambda { ReservedWord.foo }.should raise_error
    end
  end

  describe ".word_list" do
    it "should return the list of ReservedWord::Word" do
      ReservedWord.word_list.should be_kind_of(Array)
      ReservedWord.word_list.include?(:site_slug).should be_true
    end
  end

  describe ".all" do
    it "should return all words as hash" do
      hash = { default_words: ReservedWord.list }
      ReservedWord.all.should eq hash
    end

    it "should return all words with original words as hash" do
      words = %w(foo bar)
      hash = { default_words: ReservedWord.list, test: words }
      ReservedWord.test = words
      ReservedWord.all.should eq hash
    end
  end

  describe ".load!" do
    before { ReservedWord.clear }

    it "should be loaded one of ReservedWord::Word" do
      ReservedWord.load!(:site_slug)
      ReservedWord.include?('about').should be_true
    end

    it "should be loaded one of ReservedWord::Word as test" do
      ReservedWord.load!(:site_slug, :test)
      ReservedWord.test.include?('about').should be_true
    end
  end

  describe ".load_words" do
    it "should return words from ReservedWord::Word" do
      ReservedWord.load_words(:site_slug).should be_kind_of(Array)
      ReservedWord.load_words(:site_slug).include?('about')
    end
  end

  describe ".method_missing" do
    context 'when new word is set up' do
      before { ReservedWord.new_word = %w(foo bar) }

      it 'should be accessed' do
        ReservedWord.new_word.should be_kind_of(Array)
        ReservedWord.new_word.include?("foo").should be_true
        ReservedWord.new_word.include?("bar").should be_true
      end
    end

    context 'when class method is overriden' do
      it 'should raise error' do
        lambda { ReservedWord.all = %w(foo bar) }.should raise_error
        lambda { ReservedWord.list = %w(foo bar) }.should raise_error
      end
    end
  end
end
