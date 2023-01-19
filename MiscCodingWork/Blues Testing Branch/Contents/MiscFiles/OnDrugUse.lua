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


--[[

]]--

local DrugList = require "DrugList"


--Will go into \lua\client\

function ExampleTakeDrug (item, player)

    local stats = player:getStats()
    local x = item:getModData().DrugID

    print(x)

    local drug = DrugInfo.[x]

    print(drug.name)

    local category = drug.category

    if not (player:getModData()[category]) then
        player:getModData()[category] = 0
    end

    local finalPotency = (player:getModData()[category]) + (Potency(x, player))

    player:getModData()[category] = finalPotency

    stats:setPanic(stats:getPanic() + 100)
    stats:setHunger(0)

    print("Variables of the taken drug!")
    print("-----------------------------")
    print("Drug Name: " .. drug.name)
    print("Drug Category: " .. drug.category)
    print("Drug Potency: " .. drug.potency)
    print("-----------------------------")
    print("Drug Category ModData Value: " .. player:getModData()[category])

    print("I didn't feel like typing more")
end

function Potency(x, player)
    local base = 1

    local stats = player:getStats()
    local dmg = player:getBodyDamage()

    local potency = DrugInfo.[x].potency
    local weight = player:getNutrition():getWeight()

    local finalPotency = (base * potency) * (100 / weight)

    return finalPotency
end