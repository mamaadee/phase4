module Contexts
    module RegistrationContexts
        def create_registrations
            @maryam_r = FactoryBot.create(:registration, camp: @camp2, student: @maryam)
            @amna_r = FactoryBot.create(:registration, camp: @camp1, student: @amna)
            @dan_r  = FactoryBot.create(:registration, camp: @camp1, student: @dan)
        end

        def delete_registrations
            @maryam_r.delete
            @amna_r.delete
            @dan_r.delete
        end
    end
end