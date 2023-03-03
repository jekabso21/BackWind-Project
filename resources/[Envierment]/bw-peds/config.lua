Config = {}


Config.models = {
    Model = {},
    Peds = {

        {
            name = "Shopkeeper1",
            coords = vector3(-324.18838500977, 803.55560302734, 117.88165283203),
            heading = 279.78,
            model = "u_m_o_vhtexoticshopkeeper_01",
            anim_dict = "amb_misc@world_human_stand_waiting@female_a@idle_a",
            anim = "idle_a",
            targets = {
                {
                    event = "redemrp_shops:OpenShop",
                    label = "Open Shop"
                }
            }
        },
        {
            name = "Stables",
            coords = vector3(-365.58154296875, 790.85565185547, 116.17276763916),
            heading = 162.4949798584,
            model = "a_m_m_rancher_01",
            anim_dict = "amb_misc@world_human_stand_waiting@female_a@idle_a",
            anim = "idle_a",
            targets = {
                {
                    event = "bw-stable:OpenStable",
                    label = "Open Stable"
                }
            }
        }
    }
}