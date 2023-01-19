
--[[    Thanks to MusicManiac on the PZ Discord for helping with this section below!    ]]--

-- These two functions need different versions for each category of drug. So -

--[[
function DrugXYZAfterEffects()
    local player = getPlayer();
    player:getModData().YourModName = player:getModData().YourModName or {};
    local modData = getPlayer():getModData().YourModName;
    modData.DrugXYZAfterEffectsDurationLeft = modData.DrugXYZAfterEffectsDurationLeft or 0;
    if modData.DrugXYZAfterEffectsDurationLeft ~= 0 then
        -- do some stuff
        modData.DrugXYZAfterEffectsDurationLeft = modData.DrugXYZAfterEffectsDurationLeft - 1
    else
        Events.EveryMinute.Remove(DrugXYZAfterEffects)
    end
end

function DrugXYZEffectPerMinute()
    local player = getPlayer();
    player:getModData().YourModName = player:getModData().YourModName or {};
    local modData = getPlayer():getModData().YourModName;
    modData.DrugXYZPotencyLeft = modData.DrugXYZPotencyLeft or 0;
    if modData.DrugXYZPotencyLeft ~= 0 then
        local stats = getPlayer():getStats()
        local NewEndurance = (stats:getEndurance() + 2)
        stats:setEndurance(NewEndurance)
        modData.DrugXYZPotencyLeft = modData.DrugXYZPotencyLeft - 1
    else
        Events.EveryMinute.Remove(DrugXYZEffectPerMinute)
        modData.DrugXYZAfterEffectsDurationLeft = 10; -- 10 min
        Events.EveryMinute.Add(DrugXYZAfterEffects)
    end
end
------------------------------------
function DrugsInPlayerSystem1()
    local player = getPlayer();
    player:getModData().StreetPharma = player:getModData().StreetPharma or {};
    local modData = getPlayer():getModData().StreetPharma;
    modData.StimDuration = modData.StimDuration or 0;

    modData.HeadacheDuration = modData.HeadacheDuration or 0;
    if modData.StimPotency >= x or modData.DrugXYZAfterEffectsDurationLeft >= 0 then
        Events.EveryMinute.Add(DrugXYZEffectPerMinute)
    end
end

Events.OnCreatePlayer.Add(DrugsInPlayerSystem1);


]]--
---
function InitializePlayerDrugData()
    local playerMD = getPlayer():getModData()

    -- Misc data related to mod
    playerMD.StreetPharma = playerMD.StreetPharma or {};
    local SPCore = playerMD.StreetPharma
    SPCore.Stimulant = SPCore.Stimulant or 0;
    SPCore.Depressant = SPCore.Depressant or 0;
    SPCore.Narcotic = SPCore.Narcotic or 0;
    SPCore.Psychedelic = SPCore.Psychedelic or 0;
    SPCore.Steroid = SPCore.Steroid or 0;
    SPCore.CumPot = SPCore.CumPot or 0;
    SPCore.DrugToxicity = SPCore.DrugToxicity or 0;


    -- Effect durations currently effecting the player.
    playerMD.StreetPharmaDurations = playerMD.StreetPharmaDurations or {};
    local SPDuration = playerMD.StreetPharmaDurations
    SPDuration.Stimulant = SPDuration.Stimulant or 0;
    SPDuration.Depressant = SPDuration.Depressant or 0;
    SPDuration.Narcotic = SPDuration.Narcotic or 0;
    SPDuration.Psychedelic = SPDuration.Psychedelic or 0;
    SPDuration.Steroid = SPDuration.Steroid or 0;


    -- Records of drug use.
    playerMD.StreetPharmaRecords = playerMD.StreetPharmaRecords or {};
    local SPRecords = playerMD.StreetPharmaRecords
    SPRecords.Meth = SPRecords.Meth

    --Records the current tier of drug effects on the player
    playerMD.StreetPharmaDrugTiers = playerMD.StreetPharmaDrugTiers or {};

    --Records the tier of drug crashes on the player
    playerMD.StreetPharmaDrugCrash = playerMD.StreetPharmaDrugCrash or {};

    if playerMD.StreetPharma and playerMD.StreetPharmaDurations and playerMD.StreetPharmaRecords and playerMD.StreetPharmaDrugTiers then
        print("StreetPharma initialized successfully for: " .. getPlayer():getFullName() .. "!")
    else
        print("StreetPharma failed to initialize for: " .. getPlayer():getFullName() .. "!")
    end
end

Events.OnCreatePlayer.Add(InitializePlayerDrugData);