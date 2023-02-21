Config = {}

--create config table where I can write peds location, model, animation, targets event, targets name
Config.models = {
    Peds = {
        {
            name = "test",
            coords = vector3(-277.82373046875, 804.83990478516, 119.38006591797),
            heading = 266.35,
            model = "s_m_m_ambientsdpolice_01",
            animation = {
                lib = "WORLD_HUMAN_HAMMERING",
                anim = "WORLD_HUMAN_HAMMERING"
            },
            ped = nil,
            targets = {
                {
                    event = "test:target",
                    name = "test"
                }
            }
        }
    }
}