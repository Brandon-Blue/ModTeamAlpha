--local DrugList = require "DrugList"
-- to use, need to do DrugList.*name of table*.variable
--Will go into \lua\client\

function PleaseWork(food, player, percent)
    print('You ate:' .. food:getName() .. ', I just hope it was worth it...')
    print('This is a simple test function, if you see this that means it worked!')
    print ('Merry Christmas!')
end


function PleaseWork2(food, player, percent)

    print('Second Test Drug Function')
    local x = food:getModData().DrugID
    print('DrugID = ' .. x)
    local DrugID = DrugList[x]
    print ('DrugID.name = ' ..DrugID.name)
    local category = DrugID.category
    print('DrugID.category = ' .. category)
    print("-----------------------------")
    print('If the ID, Name, and Category of the drug you consumed were just posted, that means this function worked!')
    print('If not, well... SHIT.')
end

function PleaseWork3(food, player, percent)
    --[[print('Third Test Drug Function')
    local stats = player:getStats()

    local x = food:getModData().DrugID
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

    print("I didn't feel like typing more, I just REALLY hope that these all worked... <3")--]]
    --[[local x = food:getModData().DrugID
    print(x)
    local DrugID = DrugInfo:getDrugInfo(x)
    local category = DrugID.category
    local stats = player:getStats()
    local finalPotency = (player:getModData()[category]) + (Potency(DrugID, player))--]]
    
end

function OnEat_Drug(item, player)
    local x = item:getModData().DrugID
    local drugData = DrugInfo:getDrugInfo(x)
    local categoryData = DrugInfo:getDrugInfo(drugData.category)
    local initalPotency = Potency(drugData, player)
    player:getModData().cumPot = player:getModData().cumPot + initalPotency
    drugData.sideEffect()
    -- Everything from this point on is psuedo code
    if (player:getMoodleLevel("High") == 1) then
        categoryData.effectTier1()
    elseif (player:getMoodleLevel("High") == 2) then
        categoryData.effectTier2()
    elseif (player:getMoodleLevel("High") == 3) then
        categoryData.effectTier3()
    end
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