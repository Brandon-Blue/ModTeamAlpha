local DrugList = require "DrugList"
-- local DrugEffects = require "DrugEffects"

--[[
Player ModData
   1.) StreetPharma = {}
       - Holds potency effects by category
            .Stimulant
            .Depressant
            .Narcotic
            .Psychedelic
            .Steroid
       - Holds cumulative potency and ODs
            .CumPot
            .DrugToxicity

   2.) StreetPharmaDurations = {}
       - Holds duration of drugs effecting the player
       - Durations are measured in in-game minutes
            .Stimulant
            .Depressant
            .Narcotic
            .Psychedelic
            .Steroid

   3.) StreetPharmaRecords = {}
       - Holds info on drugs taken by the player
       - Data for the following given in the DrugList.lua through 'alias = x'
            .Meth
            .Heroin
            .Cocaine
            ~ Etc ~

   4.) StreetPharmaDrugTiers = {}
       - Holds the current tier of high the player is experiencing, valued 1 - 4 by drug category
       -

   5.) StreetPharmaDrugCrash = {}
       - Records the tier of drug crashes on the player
]]--

function OnTakeDrug(item, player)
    local modData = player:getModData()
    local coreData = modData.StreetPharma

    -- Pulls DrugID off of item, and uses that to reference DrugList.lua
    local x = item:getModData().DrugID
    local drugData = DrugInfo:getDrugInfo(x)
    local drugCat = drugData.category

    if drugCat ~= "None" or nil then
        -- Checks player traits, and modifies potency value accordingly

        local drugPotency = PotencyMod(player, drugData.potency)
        coreData[drugCat] = coreData[drugCat] or 0
        coreData[drugCat] = coreData[drugCat] + drugPotency

        -- Adds Drug potency and toxicity to the player cumulative counts
        coreData.CumPot = coreData.CumPot or 0
        coreData.CumPot = coreData.CumPot + drugPotency

       -- local newToxicity = DrugToxicityMod(player, coreData, drugData, drugPotency)
        coreData.DrugToxicity = coreData.DrugToxicity or 0
        coreData.DrugToxicity = coreData.DrugToxicity + drugData.toxicity

        -- Adds the duration of the drug to the players modData
        local durationData = modData.StreetPharmaDurations
        local drugDuration = drugData.duration
        durationData[drugCat] = durationData[drugCat] or 0
        durationData[drugCat] = durationData[drugCat] + drugDuration

        print(drugCat .. 'duration: ' .. durationData[drugCat])
        print(drugCat .. 'potency: ' .. coreData[drugCat])
        print('Cumulative Potency: ' .. coreData.CumPot)
        print('Toxicity: ' .. coreData.DrugToxicity)


        -- CheckDrugTier(drugCat, drugData)
        -- ODCheck(player, drugData)
    end

    -- Checks the drug alias and delivery, and adds that to the record
    local recordData = modData.StreetPharmaRecords
    local drugAlias = drugData.alias
    local drugDelivery = drugData.delivery
    recordData[drugAlias] = recordData[drugAlias] or 0
    recordData[drugAlias] = recordData[drugAlias] + 1
    recordData[drugDelivery] = recordData[drugDelivery] or 0
    recordData[drugDelivery] = recordData[drugDelivery] + 1

    print('Delivery: ' .. drugData.delivery .. ' = ' .. recordData[drugDelivery])
    print('Alias: ' .. drugData.alias .. ' = ' .. recordData[drugAlias])

    -- Checks if the item has unique side effects, if it does, it calls that function
    if drugData.sideEffect then
        drugData.sideEffect()
    end
end

------------------------------------------------------------------------

local function PotencyMod(player, potency)
    local base = 1

    if player:HasTrait("Emaciated") then
        base = 1.5
    elseif player:HasTrait("Very Underweight") then
        base = 1.25
    elseif player:HasTrait("Underweight") then
        base = 1.1
    elseif player:HasTrait("Overweight") then
        base = 0.9
    elseif player:HasTrait("Obese") then
        base = 0.75
    end

    if player:HasTrait("IronGut") then
        base = base * 0.9
    elseif player:HasTrait("WeakStomach") then
        base = base * 1.1
    end

    local finalPotency = (base * potency)

    return finalPotency
end

------------------------------------------------------------------------

-- Checks potency value of the drugs consumed, and triggers corresponding effects
local function CheckDrugTier(drugCat, drugData)
    local modData = getPlayer():getModData()
    local coreData = modData.StreetPharma

    local drugAmount = coreData[drugCat]
    -- local drugEffects = DrugInfo:getMainDrugEffects(drugCat)
    local drugTier = 0

    if drugAmount == 0 or drugAmount == nil then
        print("StreetPharma: No " .. drugCat .. " detected, you are clean!")
        return
    else
        if drugAmount <= 6 then
                drugTier = 1
                print("StreetPharma: Initializing T1 " .. drugCat .. " effects")
                -- begin t1 drug effects
            return
        elseif drugAmount <= 12 then
                drugTier = 2
                print("StreetPharma: Initializing T2 " .. drugCat .. " effects")
                -- begin t2 drug effects
            return
        elseif drugAmount <= 18 then
                drugTier = 3
                print("StreetPharma: Initializing T3 " .. drugCat .. " effects")
                -- begin t3 drug effects
            return
        elseif drugAmount > 18 then
                drugTier = 4
                print("StreetPharma: Initializing T4 " .. drugCat .. " effects")
                -- set t4 drug effects
            return
        end

        modData.StreetPharmaDrugTiers[drugCat] = drugTier

        if drugData.baseEffects then
            drugData.baseEffect()
            return
        else
            local altBaseEffects = DrugInfo:getMainDrugEffects(drugCat).baseEffect
            altBaseEffects.baseEffect()
        end
    end
end

---------------------------------------------------------------------------------

local function BaseStimulantEffects()
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
        modData.StreetPharma.Stimulants = 0
        Event.EveryOneMinute.Remove(BaseStimulantEffects)

    end
end


--[[
local function ODCheck()
    local player = getPlayer()
    local modData = player:getModData()
    local coreData = modData.StreetPharma

end

local function DrugToxicityMod(player, coreData, drugData, drugPotency)
    local toxicityData = coreData.DrugToxicity or 0


end
]]--

