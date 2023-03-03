Config = {}


Config.models = {
    Model = {},
    Peds = {

        {
            name = "test",
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
            name = "stables_1",
            coords = vector3(-365.6872253418, 790.73187255859, 116.17196655273),
            heading = 175.245,
            model = "u_m_m_htlrancherbounty_01",
            anim_dict = "amb_misc@world_human_stand_waiting@female_a@idle_a",
            anim = "idle_a",
            targets = {
                {
                    event = "bw-stables:OpenMenu",
                    label = "Open Stables"
                }
            }
        },

    }
}