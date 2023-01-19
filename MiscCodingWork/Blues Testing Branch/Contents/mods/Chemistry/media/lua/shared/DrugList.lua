
--[[    Drug Info    ]]--
DrugInfo = {}

DrugInfo["BlueMeth"] = {
    name = 'BlueMeth',
    category = 'Stimulant',
    baseEffect = StimulantEffects,
    alias = 'Meth',
    delivery = 'smoke',
    description = '',
    potency = 1,
    duration = 420,
    toxicity = 15,
}
DrugInfo["RedMeth"] = {
    name = 'RedMeth',
    category = 'Stimulant',
    alias = 'Meth',
    delivery = 'smoke',
    description = '',
    potency = 5,
    duration = 60,
    toxicity = 5,
}
DrugInfo["PurpleMeth"] = {
    name = 'PurpleMeth',
    category = 'Stimulant',
    alias = 'Meth',
    delivery = 'smoke',
    description = '',
    potency = 15,
    duration = 120,
    toxicity = 50,
}
function DrugInfo:getDrugInfo(name)
    return DrugInfo[name]
end

--[[    Main Drug Effect    ]]--
local MainDrugEffects = {}

MainDrugEffects["Stimulant"] = {
    baseEffect = StimulantEffects,
}
function DrugInfo:getMainDrugEffects(name)
    return MainDrugEffects[name]
end