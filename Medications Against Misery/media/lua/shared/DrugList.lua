DrugList = {}
local DrugInfo = {}


--[[
function DrugInfo:new(info)
 DrugInfo.instance = info
 DrugInfo.keyValue[info.name] = info
end


New Drug Format

    DrugInfo:new({
        name = '',
        category = '',
        base = '',
        description = getText(''),
        potency = ,
        duration = ,
        onset = ,
        sideEffects = ,
            effects = {},
        screenEffects = '',
    })

Defined Drug categories -
    Stimulants
    Narcotic
    Depressants
    Psychedelics
    Steroid
]]--


DrugInfo["Stimulant"] = {
    effectTier1 = BaseEffect_Stimulant_tier1,
    effectTier2 = BaseEffect_Stimulant_tier2,
    effectTier3 = BaseEffect_Stimulant_tier3,
}

DrugInfo["Opioid"] = {
    effectTier1 = BaseEffect_Opioid_tier1,
    effectTier2 = BaseEffect_Opioid_tier2,
    effectTier3 = BaseEffect_Opioid_tier3,
}

DrugInfo["Psychedelic"] = {
    effectTier1 = nil,
    effectTier2 = nil,
    effectTier3 = nil,
}

DrugInfo["SamllEnergyDrink"] = {
    name = "SamllEnergyDrink",
    category = "Stimulant",
    base = "EnergyDrink",
    potency = 1,
    duration = 10,
    sideEffects = nil,
}

DrugInfo["LightEnergyDrink"] = {
    name = "LightEnergyDrink",
    category = "Stimulant",
    base = "EnergyDrink",
    potency = 5,
    duration = 10,
    sideEffects = nil,
}

DrugInfo["StrongEnergyDrink"] = {
    name = "StrongEnergyDrink",
    category = "Stimulant",
    base = "EnergyDrink",
    potency = 10,
    duration = 10,
    sideEffects = nil,
}

DrugInfo["Cocaine"] = {
    name = "Cocaine",
    category = "Stimulant",
    base = "Cocaine",
    potency = 55,
    duration = 20,
    sideEffects = nil,

}

DrugInfo["Epinephrine"] = {
    name = 'Epinephrine',
    category = 'Stimulant',
    base = 'Epinephrine',
    description = '',
    potency = 35,
    duration = 10,
    sideEffects = false,
    screenEffects = false
   }

DrugInfo["Meth"] = {
 name = 'Meth',
 category = 'Stimulant',
 base = 'Meth',
 description = '',
 potency = 50,
 duration = 10,
 sideEffects = false,
 screenEffects = false
}

DrugInfo["RedMeth"] = {
 name = 'RedMeth',
 category = 'Stimulant',
 base = 'Meth',
 description = '',
 potency = 50,
 duration = 10,
 sideEffects = true,
 screenEffects = false
}

DrugInfo["PurpleMeth"] = {
 name = 'PurpleMeth',
 category = 'Stimulant',
 base = 'Meth',
 description = '',
 potency = 50,
 duration = 10,
 sideEffects = true,
 screenEffects = false
}

DrugInfo["Heroin"] = {
 name = 'Heroin',
 category = 'Opioid',
 base = 'Heroin',
 description = getText('UI_Item_Heroin_Description'),
 potency = 70,
 duration = 20,
 sideEffects = false,
 screenEffects = false
}

DrugInfo["Percocet"] = {
    name = "Percocet",
    category = "Opioid",
    base = "Painkiller",
    potency = 30,
    duration = 20,
    sideEffects = nil,
}

DrugInfo["Codeine"] = {
    name = "Codeine",
    category = "Opioid",
    base = "Painkiller",
    potency = 30,
    duration = 20,
    sideEffects = nil,
}

DrugInfo["Morphine"] = {
    name = "Morphine",
    category = "Opioid",
    base = "Painkiller",
    potency = 30,
    duration = 20,
    sideEffects = OnEat_Morphine,
}

DrugInfo["Steroids"] = {
 name = 'Steroids',
 category = 'Steroids',
 base = 'Steroids',
 description = getText('UI_Item_Steroids_Description'),
 potency = 50,
 duration = 100,
 sideEffects = false,
 screenEffects = false
}


DrugInfo["LSD"] = {
    name = "LSD",
    category = "Psychedelic"
    base = "LSD",
    potency = 40,
    duratinon = 30,
    sideEffects = nil,
    screenEffects = nil,
}

DrugInfo["Psilocybin"] = {
    name = "Psilocybin",
    category = "Psychedelic"
    base = "Shrooms",
    potency = 40,
    duratinon = 30,
    sideEffects = nil,
    screenEffects = nil,
}


DrugInfo["Ketamine"] = {
    name = "Ketamine",
    category = "Psychedelic"
    base = "Ketamine",
    potency = 40,
    duratinon = 30,
    sideEffects = nil,
    screenEffects = nil,
}

function DrugInfo:getDrugInfo(name)
    return DrugInfo[name]
end



--[[
player:getModData().DrugAddict.anyFuckingThingYouWant = "Bob Saget"

ConsumedStimulants -

between 0 - 10 = Weak Stimulant Buzz
        11 - 20 = Strong Stimulant Buzz
        21 - x = Stimulant High

        Weak Stimulant Crash
        Strong Stimulant Crash

        Stimulant Overdose

read speed, endurance,


]]--