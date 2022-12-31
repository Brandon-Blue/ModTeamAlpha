-- Stimulants
function BaseEffect_Stimulant_tier1(player)
    local stats = player:getStats()
    local bodyInfo = player:getBodyDamage()
    -- Adds to the players current endurance using a inverse linear equation f(x) = (-1x + y) with x being the players health
    -- The lower the players health, the more endurance will be restored.
    local enduranceChange = -90 * (bodyInfo:getOverallBodyHealth()/10000) + 1
    stats:setEndurance(stats:getEndurance() + enduranceChange)
    stats:setHunger(stats:getHunger() - 0.05)
end


function BaseEffect_Stimulant_tier2(player)
    local stats = player:getStats()
    local health = player:getBodyDamage():getOverallBodyHealth()
    local enduranceChange = 0.15 + (-90 * (health/100) + 1)
    stats:setEndurance(stats:getEndurance() + enduranceChange)
    stats:setHunger(stats:getHunger() - 0.15)
end

function BaseEffect_Stimulant_tier3(player)
    local stats = player:getStats()
    local health = player:getBodyDamage():getOverallBodyHealth()
    local enduranceChange = 0.3 + (-90 * (health/100) + 1)
    stats:setEndurance(stats:getEndurance() + enduranceChange)
    stats:setHunger(stats:getHunger() - 0.25)
end

function BaseEffect_Opioid_tier1(player)
    local stats = player:getStats()
    local bodyInfo = player:getBodyDamage()
    stats:setEndurance(stats:getEndurance() - 0.1)
    bodyInfo:setPainReduction(bodyInfo:getPainReduction() + 0.05)
end

function BaseEffect_Opioid_tier2(player)
    local stats = player:getStats()
    local bodyInfo = player:getBodyDamage()
    stats:setEndurance(stats:getEndurance() - 0.2)
    bodyInfo:setPainReduction(bodyInfo:getPainReduction() + 0.1)
end

function BaseEffect_Opioid_tier3(player)
    local stats = player:getStats()
    local bodyInfo = player:getBodyDamage()
    stats:setEndurance(stats:getEndurance() - 0.3)
    bodyInfo:setPainReduction(bodyInfo:getPainReduction() + 0.15)
end

function OnEat_SmallEnergyDrink(item, player, stats)   
    stats:setEndurance(stats:getEndurance() + 0.1)
end

function OnEat_LightEnergyDrink(item, player, stats)
    stats:setEndurance(stats:getEndurance() + 0.2)
end

function OnEat_StrongEnergyDrink(item, player, stats)
    stats:setEndurance(stats:getEndurance() + 0.3)
end

function OnEat_Cocaine(item, player, stats)
    stats:setEndurance(stats:getEndurance() + 0.5)
end

function OnEat_Percocet(item, player, stats)
    local bodyInfo = player:getBodyDamage()
    stats:setPainReduction(stats:getPainReduction() + 0.75)
    stats:setEndurance(stats:getEndurance() - 0.25)
end

function OnEat_Codeine(item, player, stats)
    local bodyInfo = player:getBodyDamage()
    stats:setPainReduction(stats:getPainReduction() + 0.1)
    bodyInfo:setColdReduction(bodyInfo:getColdReduction() + 0.65)
end

function OnEat_Morphine(item, player, stats)
    local bodyInfo = player:getBodyDamage()
    local bodyParts = bodyInfo:getBodyParts()
    for i = 0, bodyParts:size() - 1 do
        local p = bodyInfo:getBodyParts():get(i)
        local factureTime = p:getFractureTime() 
        print(p)
        if  factureTime > 0 then
            p:setFractureTime(factureTime - 30)
        end
    end
end