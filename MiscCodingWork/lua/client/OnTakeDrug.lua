local DrugList = require "DrugList"

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
            .CumOD

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
]]--


function OnTakeDrug(item, player)
    local modData = player:getModData()
    local coreData = modData.StreetPharma

    -- Pulls DrugID off of item, and uses that to reference DrugList.lua
    local x = item:getModData().DrugID
    local drugData = DrugInfo:getDrugInfo(x)

    -- Checks player traits, and modifies potency value accordingly
    local drugPotency = PotencyMod(drugData.potency, player)
    local drugCat = drugData.category
    coreData[drugCat] = coreData[drugCat] or 0
    coreData[drugCat] = coreData[drugCat] + drugPotency

    -- Adds the duration of the drug to the players modData
    local durationData = modData.StreetPharmaDurations
    local drugDuration = drugData.duration
    durationData[drugCat] = durationData[drugCat] or 0
    durationData[drugCat] = durationData[drugCat] + drugDuration

    -- Checks the drug alias and delivery, and adds that to the record
    local recordData = modData.StreetPharmaRecords
    local drugAlias = drugData.alias
    local drugDelivery = drugData.delivery
    recordData[drugAlias] = recordData[drugAlias] or 0
    recordData[drugAlias] = recordData[drugAlias] + 1
    recordData[drugDelivery] = recordData[drugDelivery] or 0
    recordData[drugDelivery] = recordData[drugDelivery] + 1

    -- Checks if the item has unique side effects, if it does, it calls that function
    if drugData.sideEffect then
        drugData.sideEffect()
    end

    DrugsInPlayerSystem(player, drugData)
    ODCheck(player, drugData)
end

local function PotencyMod(potency, player)
    local base = 1
    --local potency = DrugID.potency

    if player:HasTrait("Emaciated") then
        base = 1.5
    end
    if player:HasTrait("Very Underweight") then
        base = 1.25
    end
    if player:HasTrait("Underweight") then
        base = 1.1
    end
    if player:HasTrait("Overweight") then
        base = 0.9
    end
    if player:HasTrait("Obese") then
        base = 0.75
    end
    if player:HasTrait("IronGut") then
        base = base * 0.9
    end
    if player:HasTrait("WeakStomach") then
        base = base * 1.1
    end

    local finalPotency = (base * potency)

    return finalPotency
end

-- Checks potency value of the drugs consumed, and triggers corresponding effects
local function DrugsInPlayerSystem(player, drugData)
    local modData = player:getModData()
    local coreData = modData.StreetPharma
    local drugCat = drugData.category
    local drugAmount = coreData[drugCat]
    local drugEffects = DrugInfo:getMainDrugEffects(drugCat)

    if drugAmount == 0 or drugAmount == nil then
        print("StreetPharma: I honestly don't know what happened to cause this... ")
        return
    else
        if drugAmount <= 6 then
            -- begin t1 drug effects
            do
                --Need to put in the thing that adds drug events.
                print("Initializing T1 " .. drugCat .. " effects")
            end
            return
        end
        if drugAmount <= 12 then
            -- begin t2 drug effects
            do
                print("Initializing T2 " .. drugCat .. " effects")
            end
            return
        end
        if drugAmount <= 18 then
            -- begin t3 drug effects
            do
                print("Initializing T3 " .. drugCat .. " effects")
            end
            return
        end
        if drugAmount > 18 then
            -- begin t4 drug effects
            do
                print("Initializing T4 " .. drugCat .. " effects")
            end
            return
        end
    end
end

local function ODCheck(player, drugData)

end