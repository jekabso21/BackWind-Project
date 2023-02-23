local SeatTarget = 0
local Anim

local Animations = {
  Seat = {
    "GENERIC_SEAT_CHAIR_SCENARIO",
    "GENERIC_SEAT_CHAIR_TABLE_SCENARIO",
    "PROP_HUMAN_SEAT_NO_BACK_WIP_COLLECTION"
  },
  Bench = "GENERIC_SEAT_BENCH_SCENARIO"
}

local SeatModels = {
  `p_chairironnbx01x`,
  `p_chairnbx02x`,
  `p_chairwicker03x`,
  `p_theaterchair01b01x`,
  `p_theaterchair02a01x`,
  `p_theaterchair02b01x`,
  `p_theaterchair02c01x`,
  `p_ambchair01x`,
  `p_ambchair02x`,
  `p_chairhob01x`,
  `p_chairhob02x`,
  `p_chairrusticsav01x`,
  `p_armchair01x`,
  `p_chestchair01x`,
  `p_diningchairs01x`,
  `p_toiletchair01x`,
  `p_windsorchair03x`,
  `p_chairrocking03x`,
  `p_woodendeskchair01x`,
  `p_barberchair01x`,
  `p_barberchair02x`,
  `p_barberchair03x`,
  `p_birthingchair01x`,
  `p_bistrochair01x`,
  `p_chair02x`,
  `p_chair02x_dmg`,
  `p_chair04x`,
  `p_chair05x`,
  `p_chair05x_sea`,
  `p_chair06x`,
  `p_chair06x_dmg`,
  `p_chair07x`,
  `p_chair09x`,
  `p_chair_10x`,
  `p_chair11x`,
  `p_chair12bx`,
  `p_chair12x`,
  `p_chair13x`,
  `p_chair14x`,
  `p_chair15x`,
  `p_chair16x`,
  `p_chair17x`,
  `p_chair18x`,
  `p_chair19x`,
  `p_chair20x`,
  `p_chair21x`,
  `p_chair21x_fussar`,
  `p_chair22x`,
  `p_chair23x`,
  `p_chair24x`,
  `p_chair25x`,
  `p_chair26x`,
  `p_chair27x`,
  `p_chair30x`,
  `p_chair31x`,
  `p_chair34x`,
  `p_chair37x`,
  `p_chair38x`,
  `p_chair_barrel04b`,
  `p_chairbroken01x`,
  `p_chairComfy01x`,
  `p_chaircomfy02`,
  `p_chaircomfy03x`,
  `p_chaircomfy04x`,
  `p_chaircomfy05x`,
  `p_chaircomfy06x`,
  `p_chaircomfy07x`,
  `p_chaircomfy08x`,
  `p_chaircomfy09x`,
  `p_chaircomfy10x`,
  `p_chaircomfy11x`,
  `p_chaircomfy12x`,
  `p_chaircomfy14x`,
  `p_chaircomfy16x`,
  `p_chaircomfy17x`,
  `p_chaircomfy18x`,
  `p_chaircomfy22x`,
  `p_chaircomfy23x`,
  `p_chairconvoround01x`,
  `p_chair_crate02x`,
  `p_chair_crate15x`,
  `p_chair_cs05x`,
  `p_chairdeck01x`,
  `p_chairdeckfolded01x`,
  `p_chairdesk01x`,
  `p_chairdesk02x`,
  `p_chairdining01x`,
  `p_chairdining02x`,
  `p_chairdining03x`,
  `p_chairdoctor01x`,
  `p_chairdoctor02x`,
  `p_chaireagle01x`,
  `p_chairfolding02x`,
  `p_chairmed01x`,
  `p_chairmed02x`,
  `p_chairoffice02x`,
  `p_chairpokerfancy01x`,
  `p_chairporch01x`,
  `p_chairrocking02x`,
  `p_chairrocking04x`,
  `p_chairrocking05x`,
  `p_chairrocking06x`,
  `p_chairrustic01x`,
  `p_chairrustic02x`,
  `p_chairrustic03x`,
  `p_chairrustic04x`,
  `p_chairrustic05x`,
  `p_chairsalon01x`,
  `p_chairtall01x`,
  `p_chairvictorian01x`,
  `p_chairwhite01x`,
  `p_chairwicker01b_static`,
  `p_chairwicker01x`,
  `p_chairwicker02x`,
  `p_medwheelchair01x`,
  `p_oldarmchair01x`,
  `p_pianochair01x`,
  `p_rockingchair01x`,
  `p_rockingchair02x`,
  `p_rockingchair03x`,
  `p_sit_chairwicker01a`,
  `p_sit_chairwicker01b`,
  `p_sit_chairwicker01c`,
  `p_sit_chairwicker01d`,
  `p_sit_chairwicker01e`,
  `p_windsorchair01x`,
  `p_windsorchair02x`,
  `p_woodenchair01x`,
  `p_group_chair05x`,
  `p_chaircomfycombo01x`,
  `mp005_s_posse_foldingchair_01x`,
  `mp005_s_posse_col_chair01x`,
  `mp005_s_posse_trad_chair01x`,
  `s_chair04x`,
  `p_chair21_leg01x`,
  `p_cs_electricchair01x`,
  `s_bfchair04x`,
  `s_electricchair01x`,
  `p_gen_chairpokerfancy01x`,
  `p_gen_chair06x`,
  `p_gen_chair07x`,
  `p_gen_chair08x`,
  `p_chair_privatedining01x`,
  `p_privatelounge_chair01x`,
  `mp007_p_mp_chairdesk01x`,
  `mp007_p_nat_chairfolding02x`
}

local BenchModels = {
  `p_benchironnbx01x`,
  `p_benchironnbx02x`,
  `p_benchnbx01x`,
  `p_benchnbx02x`,
  `p_benchnbx03x`,
  `p_new_stonebench02x`,
  `p_windsorbench01x`,
  `p_workbenchdesk01x`,
  `p_bench03x`,
  `p_bench06x`,
  `p_bench06x_dmg`,
  `p_bench08bx`,
  `p_bench09x`,
  `p_bench11x`,
  `p_bench15_mjr`,
  `p_bench15x`,
  `p_bench16x`,
  `p_bench17x`,
  `p_bench18x`,
  `p_bench20x`,
  `p_benchbear01x`,
  `p_benchbroken02x`,
  `p_benchch01x`,
  `p_benchch01x_dmg`,
  `p_bench_log01x`,
  `p_bench_log02x`,
  `p_bench_log03x`,
  `p_bench_log04x`,
  `p_bench_log05x`,
  `p_bench_log06x`,
  `p_bench_log07x`,
  `p_bench_logsnow07x`,
  `p_benchlong05x`,
  `p_benchpiano02x`,
  `p_hallbench01x`,
  `p_seatbench01x`,
  `p_woodbench02x`,
  `p_benchannsaloon01x`,
  `p_workbench02x`,
  `p_benchwork01x`,
  `p_workbench01x`,
  `s_bench01x`,
  `p_new_rich_bench2x`,
  `p_gen_benchpiano01x_tc01`,
}

AddEventHandler('mouse-selection:CanInteract', function(entity, callback)
  SeatTarget = 0
  local _model = GetEntityModel(entity)
  for _,validModel in pairs (SeatModels) do
    if _model == validModel then
      SeatTarget = entity
      Anim = "Seat"
      callback(true)
      return
    end
  end
  for _,validModel in pairs (BenchModels) do
    if _model == validModel then
      SeatTarget = entity
      Anim = "Bench"
      callback(true)
      return
    end
  end
end)

AddEventHandler("mouse-selection:ClickEntity", function()
  if (SeatTarget == 0) then return end

  CMenu.AddItem({
    title=Lang['seat'],
    id="seat",
    callback="mouse-selection:Seat",
    children = {
      {
        title="Animation 1",
        argument=1
      },
      {
        title="Animation 2",
        argument=2,
        children = {
          {
            title="Animation 1",
            argument=1
          },
          {
            title="Animation 2",
            argument=2
          },
          {
            title="Animation 3",
            argument=3,
            children = {
              {
                title="Animation 1",
                argument=1
              },
              {
                title="Animation 2",
                argument=2
              },
              {
                title="Animation 3",
                argument=3
              },
            }
          },
        }
      },
      {
        title="Animation 3",
        argument=3
      },
    }
  })
end)

AddEventHandler('mouse-selection:Seat', function(entityHover, id, argument)
  if (SeatTarget == 0) then return end

  local player = PlayerPedId()
  local chairpos = GetOffsetFromEntityInWorldCoords(SeatTarget,0.0,-0.05,0.5)
  if Anim == "Bench" then
    chairpos = GetOffsetFromEntityInWorldCoords(SeatTarget,0.0,-.1,0.5)
    Anim = Animations[Anim]
  elseif Anim == "Seat" then
    TriggerServerEvent("print",Animations)
    TriggerServerEvent("print",Anim)
    TriggerServerEvent("print",argument)
    Anim = Animations[Anim][tonumber(argument)]
  end
  TriggerServerEvent("print",Anim)
  local chairheading = GetEntityHeading(SeatTarget)
  TaskStartScenarioAtPosition(player, GetHashKey(Anim), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, 0, true, false)
  while not IsPedUsingAnyScenario(player) do
    Wait(1000)
  end
  Citizen.CreateThread(function()
    while IsPedUsingAnyScenario(player) do
      Wait(2)
      DisplayPrompt('seat_prompt')
      if IsPromptCompleted('seat_prompt','INPUT_FRONTEND_CANCEL') then
        ClearPedTasks(player)
        return
      end
    end
  end)
end)
Citizen.CreateThread(function()
  CreatePromptButton('seat_prompt',Lang['leave'], 'INPUT_FRONTEND_CANCEL', 1000)
end)