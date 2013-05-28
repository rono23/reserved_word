module ReservedWord
  module Word
  end
end

Dir[File.dirname(__FILE__) + "/word/*.rb"].each { |file| require file }
