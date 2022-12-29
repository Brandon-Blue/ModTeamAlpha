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
    name = "Stimulant",
    category = "Stimulant"
    base = nil,
    description = "",
    potency = nil,
    duration = nil,
    onset = nil,
    effectTier1 = BaseEffect_Stimulant_tier1,
    effectTier2 = BaseEffect_Stimulant_tier2,
    effectTier3 = BaseEffect_Stimulant_tier3,
    screenEffects = nil,
}


DrugInfo["Meth"] = {
 name = 'Meth',
 category = 'Stimulant',
 base = 'Meth',
 description = '',
 potency = 50,
 duration = 10,
 onset = 5,
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
 onset = 5,
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
 onset = 5,
 sideEffects = true,
 screenEffects = false
}

DrugInfo["Heroin"] = {
 name = 'Heroin',
 category = 'Narcotic',
 base = 'Heroin',
 description = getText('UI_Item_Heroin_Description'),
 potency = 70,
 duration = 20,
 onset = 10,
 sideEffects = false,
 screenEffects = false
}

DrugInfo["Steroids"] = {
 name = 'Steroids',
 category = 'Steroids',
 base = 'Steroids',
 description = getText('UI_Item_Steroids_Description'),
 potency = 50,
 duration = 100,
 onset = 0,
 sideEffects = false,
 screenEffects = false
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