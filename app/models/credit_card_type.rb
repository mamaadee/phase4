class CreditCardType
  #getter
  attr_reader :name, :pattern

  #initializer
  def initialize(name, pattern)
    @name, @pattern = name, pattern
  end

  def match(number)
    number.to_s.match(pattern)
  end
end