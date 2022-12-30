item meth
{
    OnEat = foo("Meth")
}

------------------

local DrugInfo = require "DrugList"

function foo(x)

   local consumption = determineConsumption(x.potency)
    local category = x.category

    player:getModData().DrugAddict. = "Bob Saget"

    local base = x.base




end
