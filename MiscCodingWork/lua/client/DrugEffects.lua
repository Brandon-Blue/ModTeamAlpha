
-- Stimulants
function Stimulant_Tier1()
    local player = getPlayer()
    local stats = player:getStats()
    local dmg = player:getBodyDamage()





end

------------------------------------------------------------------------------------------------------------
function every10mins()
    -- check players mod data, reduce effective duration by 1.
    local duration = getPlayer():getModData().DrugDuration

    if duration = 0 then
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
    if Cumulative Potency >= x then
    Events.EveryMinute.Add(DrugEffectPerMinute)
    Events.EveryTenMinute.Add(every10mins)
    end
end

------------------------------------------------------------------------------------------------------------

--[[    Thanks to MusicManiac on the PZ Discord for helping with this section below!    ]]--


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