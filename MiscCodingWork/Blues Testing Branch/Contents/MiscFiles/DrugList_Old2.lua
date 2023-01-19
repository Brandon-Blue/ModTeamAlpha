local DrugFramework = require "DrugFramework"


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

local Meth = DrugInfo:new({
 name = 'Meth',
 category = 'Stimulant',
 base = 'Meth',
 description = getText('UI_Item_Meth_Description'),
 potency = 50,
 duration = 10,
 onset = 5,
 sideEffects = false,
 screenEffects = false
})

local RedMeth = DrugInfo:new({
 name = 'RedMeth',
 category = 'Stimulant',
 base = 'Meth',
 description = getText('UI_Item_RedMeth_Description'),
 potency = 50,
 duration = 10,
 onset = 5,
 sideEffects = true,
 screenEffects = false
})

local Heroin = DrugInfo:new({
 name = 'Heroin',
 category = 'Narcotic',
 base = 'Heroin',
 description = getText('UI_Item_Heroin_Description'),
 potency = 70,
 duration = 20,
 onset = 10,
 sideEffects = false,
 screenEffects = false
})

local Steroids = DrugInfo:new({
 name = 'Steroids',
 category = 'Steroids',
 base = 'Steroids',
 description = getText('UI_Item_Steroids_Description'),
 potency = 50,
 duration = 100,
 onset = 0,
 sideEffects = false,
 screenEffects = false
})


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