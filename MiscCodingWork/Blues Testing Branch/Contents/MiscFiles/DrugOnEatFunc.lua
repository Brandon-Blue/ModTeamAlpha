local DrugList = require "DrugList"
--local Timers = require "Timers"

--Will go into \lua\client\

function ExampleTakeDrug(food, player, item)

    local stats = player:getStats()
    local x = item:getModData().DrugID
    local drug = keyValue[x]
    local base = keyValue[x].base
    local category = keyValue[x].category

    if not (getModData()[category]) then
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
    print(player:getModData()[category])

    print("I didn't feel like typing more")

end

function Potency(x, player)
    local base = 1

    local stats = player:getStats()
    local dmg = player:getBodyDamage()

    local potency = keyValue[x].potency
    local weight = player:getNutrition():getWeight()

    local finalPotency = (base * potency) * (100 / weight)

    return finalPotency
end