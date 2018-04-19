module Contexts
    module UserContexts
        def create_users
            @maryam_u = FactoryBot.create(:user)
            @amna_u = FactoryBot.create(:user, username: "amnaazz", phone: "987-777-2135")
            @dan_u = FactoryBot.create(:user, username: "danph")
        end
        
        def delete_users
            @maryam_u.delete
            @amna_u.delete
            @dan_u.delete
        end
        
        def create_family_users
            @almaadeed_u = FactoryBot.create(:user, username: "almaadeed")
            @alhaj_u = FactoryBot.create(:user, username: "alhaj")
            @phelps_u = FactoryBot.create(:user, username: "phelps")
            @alsheeb_u = FactoryBot.create(:user, username: "alsheeb")
        end

        def delete_family_users
            @almaadeed_u.delete
            @alhaj_u.delete
            @phelps_u.delete
            @alsheeb_u.delete
        end
    
    end    
end