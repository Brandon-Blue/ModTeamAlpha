
--[[    Thanks to MusicManiac on the PZ Discord for helping with this section below!    ]]--

-- These two functions need different versions for each category of drug. So -

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



---
function InitializePlayerDrugData()
    local playerMD = getPlayer():getModData()

    -- Misc data related to mod
    playerMD.StreetPharma = playerMD.StreetPharma or {};

    -- Effect durations currently effecting the player.
    playerMD.StreetPharmaDurations = playerMD.StreetPharmaDurations or {};

    -- Records of drug use.
    playerMD.StreetPharmaRecords = playerMD.StreetPharmaRecords or {};

    if playerMD.StreetPharma and playerMD.StreetPharmaDurations and playerMD.StreetPharmaRecords then
        print("StreetPharma initialized successfully for: " .. getPlayer():getFullName() .. "!")
    else
        print("StreetPharma failed to initialize for: " .. getPlayer():getFullName() .. "!")
    end
end

Events.OnCreatePlayer.Add(InitializePlayerDrugData);