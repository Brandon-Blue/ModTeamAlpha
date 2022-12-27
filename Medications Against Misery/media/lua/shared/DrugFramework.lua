--[[DrugInfo = {}

--- This is a constructor module for creating/storing information for new drugs. Used in other LUA files.

function DurgInfo:newBase(info)
    local o = {}

    o.name = info.name




function DrugInfo:newDrug(info)
 local o = {}

  ---@type string, category
 o.category = info.category

 ---@type string, reference for addiction
 o.base = info.base

 ---@type string, in-game name
 o.name = info.name

 ---@type string, in-game description
 o.description = info.description

 ---@type number, potency modifier
 o.potency = info.potency

 ---@type number, duration modifier
 o.duration = info.duration

 ---@type number, onset modifier
 o.onset = info.onset

 ---@type boolean, are there special effects outside of those defined by the base
 o.sideEffects = info.sideEffects

 ---@type boolean, does this trigger any effects on the players screen?
 o.screenEffects = info.ScreenEffects
 return o
 
end

return DrugInfo--]]