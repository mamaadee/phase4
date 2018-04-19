require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
    #methods
    def test_valid_cards
        create_valid_cards
        assert @visa.valid?
        assert @master.valid?
        assert @disc.valid?
    end
    
    def test_card_identification
        create_valid_cards
        assert_equal("VISA", @visa.type.name)
        assert_equal("MC", @master.type.name)
        assert_equal("DISC", @disc.type.name)
    end
    
    def test_invalid_card_dates
        create_invalid_card_dates
        deny @old1.valid?
        deny @old2.valid?
    end

end