
-- All x_Tier functions are triggered every minute

--[[
Stat max values:
    Hunger = 0-1
        - Defaults to 0.0
        - Base     = Increases @ 0.03 / min irl
        - Exercise = Increases @ 0.07 / min irl

    Thirst = 0-1
        - Defaults to 0.0
        - Reduced @ 0.0288 / min irl

    Endurance = 0-1
        - Defaults to 1.0
        - Running    = Decreases @ 0.1872 / min irl
        - Sprinting  = Decreases @ 1.638 / min irl
        - 'Immobile' = Increases @ 0.1116 / min irl

    Fatigue = 0-1
        - Increases @ 0.1242

    Stress = 0-1
        - Defaults to 0.0
        - Decreases @ 0.108 / min irl

    Boredom = 0-100
        - Defaults to 0.0
        - Increases @ 3.6 / min irl
        - Decreases @ 138.6 / min irl

    Unhappiness = 0-100
        - Defaults to 0.0
        - Increases @ 1.8 / min irl

    Temperature = 30.0 C - 41.0 C
]]--

-- Stimulants

-- Instead of making 4 different functions for this, dont be dumb lol
-- make one function that scales with the current tier of effect the player is in.
-- Just use the same nested tables that would have triggered this, and instead adjust
-- a base multiplying value by that


local function StimulantEffects()
    local player = getPlayer()
    local modData = player:getModData()
    local durationData = modData.StreetPharmaDurations.Stimulants or 0
    local tierData = modData.StreetPharmaDrugTiers.Stimulants or 0

    if durationData ~= 0 and tierData ~= 0 then
        local stats = player:getStats()
        local tierMultiplier = 1
        if tierData > 1 then
            tierMultiplier = (tierData - (tierData/4))
        end

        -- Tier multipliers:
        -- t1: 1
        -- t2: 1.5
        -- t3: 2.25
        -- t4: 3
        -- Endurance

        local enduranceChange = 0.004 * tierMultiplier
        -- ~0.24 / hour @ T1
        if stats:getEnduranceRecharging() == true then
            enduranceChange = enduranceChange * 1.5
            -- ~0.36 / hour @ T1
        elseif player:isSitOnGround() == true then
            enduranceChange = enduranceChange * 1.5
            -- ~0.36 / hour @ T1
        end
        stats:setEndurance(stats:getEndurance() + enduranceChange)
        stats:setHunger(stats:getHunger() - (0.005 * tierMultiplier))
        stats:setThirst(stats:getThirst() - (0.005 * tierMultiplier))
        stats:setBoredom(stats:getBoredom() - (0.08 * tierMultiplier))
        stats:setFatigue(stats:getFatigue() - (0.003 * tierMultiplier))

        durationData = durationData - 1
        modData.StreetPharmaDurations.Stimulants = durationData

        local crashDuration = modData.StreetPharmaDrugCrash.Stimulants or 0
        modData.StreetPharmaDrugCrash.Stimulants = crashDuration + 1 + (math.floor(tierData/3))

        if durationData == 0 then
            -- Event.EveryOneMinute.Add(StimulantWithdrawl) or a function like StimCrashCheck()
            -- this would give the player the withdrawl only when they hit 0
        end
    else
        modData.StreetPharmaDurations.Stimulants = 0
        modData.StreetPharmaDrugTiers.Stimulants = 0
        Event.EveryOneMinute.Remove(StimulantEffects)

    end
end
--[[
local function BaseNarcoticsEffects()
    local player = getPlayer()
    local modData = player:getModData()
    local durationData = modData.StreetPharmaDurations.Narcotics or 0
    local tierData = modData.StreetPharmaDrugTiers.Narcotics or 0

    if durationData ~= 0 and tierData ~= 0 then
        local stats = player:getStats()
        local tierMultiplier = 1
        if tierData > 1 then
            tierMultiplier = (tierData - (tierData/4))
        end

        -- Tier multipliers:
        -- t1: 1
        -- t2: 1.5
        -- t3: 2.25
        -- t4: 3
        -- Endurance

        local enduranceChange = 0.004 * tierMultiplier
        -- ~-0.24 / hour @ T1
        if stats:getEnduranceRecharging() == true then
            enduranceChange = enduranceChange * 1.5
            -- ~-0.36 / hour @ T1
        elseif player:isSitOnGround() == true then
            enduranceChange = enduranceChange * 1.5
            -- ~-0.36 / hour @ T1
        end

        stats:setEndurance(stats:getEndurance() - enduranceChange)
        stats:setHunger(stats:getHunger() - (0.005 * tierMultiplier))
        stats:setThirst(stats:getThirst() - (0.005 * tierMultiplier))
        stats:setBoredom(stats:getBoredom() - (0.08 * tierMultiplier))
        stats:setFatigue(stats:getFatigue() - (0.003 * tierMultiplier))

        durationData = durationData - 1
    else
        Event.OnEveryMinute.Remove(BaseStimulantEffects)
    end
end

------------------------------------------------------------------------------------------------------------
function every10mins()
    -- check players mod data, reduce effective duration by 1.
    local duration = getPlayer():getModData().DrugDuration

    if duration == 0 then
    Events.EveryMinute.Remove(DrugEffectPerMinute)
    Events.EveryTenMinute.Remove(every10mins)
    end
    else
    getPlayer():getModData().DrugDuration = (duration - 1)
    end
end

function DrugEffectPerMinute()
    -- give player stat bonus or trigger effect. Considering multiplying these values based on world speed (?)
    -- example vvv
    local stats = getPlayer():getStats()
    local NewEndurance = (stats:getEndurance() + 2)
    stats:setEndurance(NewEndurance)
end

function TakeDrug()
    if CumulativePotency >= x then
    Events.EveryMinute.Add(DrugEffectPerMinute)
    Events.EveryTenMinute.Add(every10mins)
    end
end
]]--
------------------------------------------------------------------------------------------------------------

--[[    Thanks to MusicManiac on the PZ Discord for helping with this section below!    ]]--

--[[
-- These two functions need different versions for each
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
function DrugsInPlayerSystem()
    local player = getPlayer();
    player:getModData().YourModName = player:getModData().YourModName or {};
    local modData = getPlayer():getModData().YourModName;
    modData.DrugXYZPotencyLeft = modData.DrugXYZPotencyLeft or 0;
    modData.DrugXYZAfterEffectsDurationLeft = modData.DrugXYZAfterEffectsDurationLeft or 0
    if modData.DrugXYZPotencyLeft >= x or modData.DrugXYZAfterEffectsDurationLeft >= 0 then
        Events.EveryMinute.Add(DrugXYZEffectPerMinute)
    end
end

Events.OnCreatePlayer.Add(DrugsInPlayerSystem);
]]--