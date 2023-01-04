DrugInfo = {}

--- This is a constructor module for creating/storing information for new drugs. Used in other LUA files.

function DrugInfo:new(info)

  ---@type string, category
 local category = info.category

 ---@type string, reference for addiction
 local base = info.base

 ---@type string, in-game name
 local name = info.name

 ---@type string, in-game description
 local description = info.description

 ---@type number, potency modifier
 local potency = info.potency

 ---@type number, duration modifier
 local duration = info.duration

 ---@type number, onset modifier
 local onset = info.onset

 ---@type boolean, are there special effects outside of those defined by the base
 local sideEffects = info.sideEffects

 ---@type boolean, does this trigger any effects on the players screen?
 local screenEffects = info.ScreenEffects

end

return DrugInfo