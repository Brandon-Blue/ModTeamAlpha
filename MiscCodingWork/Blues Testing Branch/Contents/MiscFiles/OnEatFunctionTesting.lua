local DrugList = require "DrugList"

-- to use, need to do DrugList.*name of table*.variable
--Will go into \lua\client\

function PleaseWork(item)
    print('You ate:' .. item:getName() .. ', I just hope it was worth it...')
    print('This is a simple test function, if you see this that means it worked!')
    print ('Merry Christmas!')
end


function PleaseWork2(player, item)

    print('Second Test Drug Function')
    local x = item:getModData().DrugID
    print('DrugID = ' .. x)

    local DrugID = DrugList[x]
    print ('DrugID.name = ' ..DrugID.name)
    local category = DrugID.category
    print('DrugID.category = ' .. category)
    print("-----------------------------")
    print('If the ID, Name, and Category of the drug you consumed were just posted, that means this function worked!')
    print('If not, well... SHIT.')
end

function PleaseWork3(player, item)
    print('Third Test Drug Function')
    local stats = player:getStats()

    local x = item:getModData().DrugID
    print('DrugID = ' .. x)

    local DrugID = DrugList[x]
    print ('DrugID.name = ' ..DrugID.name)
    local category = DrugID.category
    print('DrugID.category = ' .. category)

    if not (player:getModData()[category]) then
        player:getModData()[category] = 0
    end

    print('Mod Data initialization of ' .. category .. ' = ' .. player:getModData()[category])

    local finalPotency = (player:getModData()[category]) + (Potency(DrugID, player))

    player:getModData()[category] = finalPotency
    stats:setPanic(stats:getPanic() + 100)
    stats:setHunger(0)
    print("Variables of the taken drug!")
    print("-----------------------------")
    print("Drug Name: " .. DrugID.name)
    print("Drug Category: " .. DrugID.category)
    print("Drug Potency: " .. DrugID.potency)
    print("-----------------------------")
    print("Drug Category ModData Value: " .. player:getModData()[category])

    print("I didn't feel like typing more, I just REALLY hope that these all worked... <3")
end

function Potency(DrugID, player)
    local base = 1
    local stats = player:getStats()
    local dmg = player:getBodyDamage()
    local potency = DrugID.potency
    local weight = player:getNutrition():getWeight()

    local finalPotency = (base * potency) * (100 / weight)

    return finalPotency
end