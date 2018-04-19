module Contexts
  module CreditCardContexts
    def create_valid_cards
        @visa = CreditCard.new(4324424564313, Date.current.year, 12)
        @master = CreditCard.new(5453256782464678, Date.current.year, 12)
        @disc = CreditCard.new(6546267534365435, Date.current.year, 12)
        @dccb = CreditCard.new(31234567890124, Date.current.year, 12)
        @amex = CreditCard.new(353535796442353, Date.current.year, 12)
    end
    
    def create_invalid_card_dates
      @old1 = CreditCard.new(4123456789012345, Date.current.year - 1, 12)
      @old2 = CreditCard.new(4123456789012345, Date.current.year, 01)
    end
  end
end