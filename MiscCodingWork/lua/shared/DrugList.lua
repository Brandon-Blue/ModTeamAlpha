DrugList = {}

--[[    Drug Info    ]]--
local DrugInfo = {}

DrugInfo["BlueMeth"] = {
    name = 'BlueMeth',
    category = 'Stimulant',
    alias = 'Meth',
    delivery = 'smoke',
    description = '',
    potency = 1,
    duration = 10,
    onset = 5,
}
DrugInfo["RedMeth"] = {
    name = 'RedMeth',
    category = 'Stimulant',
    alias = 'Meth',
    delivery = 'smoke',
    description = '',
    potency = 5,
    duration = 10,
    onset = 5,
}
DrugInfo["PurpleMeth"] = {
    name = 'PurpleMeth',
    category = 'Stimulant',
    alias = 'Meth',
    delivery = 'smoke',
    description = '',
    potency = 15,
    duration = 10,
    onset = 5,
}
function DrugInfo:getDrugInfo(name)
    return DrugInfo[name]
end

--[[    Main Drug Effect    ]]--
local MainDrugEffects = {}

MainDrugEffects["Stimulant"] = {
    Tier1 = Stimulant_Tier1(),
    Tier2 = Stimulant_Tier2(),
    Tier3 = Stimulant_Tier3(),
    Tier4 = Stimulant_Tier4(),
}
function DrugInfo:getMainDrugEffects(name)
    return MainDrugEffects[name]
end