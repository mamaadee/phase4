module Contexts
    module StudentContexts
        def create_students
            @maryam = FactoryBot.create(:student, family: @almaadeed, rating: 100)
            @amna = FactoryBot.create(:student, family: @alhaj, first_name: "Amna", last_name: "Alhaj", date_of_birth: 11.years.ago.to_date, rating: 1929)
            @dan = FactoryBot.create(:student, family: @phelps, first_name: "Daniel", last_name: "Phelps", date_of_birth: 18.years.ago.to_date, rating: 678) 
        end
        
        def delete_students
            @maryam.delete
            @amna.delete
            @dan.delete
        end
        
        def create_inactive_students
            @fatma = FactoryBot.create(:student, family: @alsheeb, first_name: "Fatma", last_name: "AlSheeb", date_of_birth: 5.years.ago.to_date, active: false, rating: nil)
        end

        def delete_inactive_students
            @fatma.delete
        end
    end
end