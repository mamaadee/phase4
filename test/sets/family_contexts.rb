module Contexts
    module FamilyContexts
        def create_families
            @almaadeed = FactoryBot.create(:family, user: @almaadeed_u)
            @alhaj = FactoryBot.create(:family, user: @alhaj_u, family_name: "Alhaj", parent_first_name: "Ali")
            @phelps = FactoryBot.create(:family, user: @phelps_u, family_name: "Phelps", parent_first_name: "Goerge")
        end

        def delete_families
            @almaadeed.delete
            @alhaj.delete
            @phelps.delete
        end
        
        def create_inactive_families
            @alsheeb = FactoryBot.create(:family, user: @alsheeb_u, family_name: "Alsheeb", parent_first_name: "Mohammed", active: false)
        end

        def delete_inactive_families
            @alsheeb.delete
        end
    end
end