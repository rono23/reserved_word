require "active_support/all"
require "reserved_word/version"
require "reserved_word/word"

module ReservedWord
  @words = ActiveSupport::OrderedOptions.new
  @words.default_words = ReservedWord::Word::SITE_SLUG

  def self.include?(word)
    @words.default_words.include?(word)
  end

  def self.list
    @words.default_words
  end

  def self.clear
    @words.default_words = Array.new
  end

  def self.clear_all
    @words = ActiveSupport::OrderedOptions.new
    self.clear
  end

  def self.word_list
    ReservedWord::Word.constants.map(&:downcase)
  end

  def self.all
    @words.to_hash
  end

  def self.load!(type, key=nil)
    if key == nil
      @words.default_words = load_words(type)
    else
      @words[key] = load_words(type)
    end
  end

  def self.load_words(type)
    ReservedWord::Word.const_get(type.upcase)
  end

  def self.method_missing(sym, *args, &block)
    sym = $1.to_sym if sym.to_s =~ /(.*)=$/
    super if ReservedWord.singleton_methods.include? sym

    if @words[sym] == nil
      if args.first.class == Array
        @words[sym] = args.first
      else
        super
      end
    else
      @words[sym]
    end
  end
end
