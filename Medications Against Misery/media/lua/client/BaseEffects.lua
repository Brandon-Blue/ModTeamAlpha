-- Stimulants
function BaseEffect_Stimulant_tier1()
    local player = getPlayer()
    local stats = player:getStats()
    local health = player:getBodyDamage():getOverallBodyHealth()
    -- Adds to the players current endurance using a inverse linear equation f(x) = (-1x + y) with x being the players health
    -- The lower the players health, the more endurance will be restored.
    local enduranceChange = -50 * (health/100) + 1
    stats:setEndurance(stats:getEndurance() + enduranceChange)
    stats:setHunger(stats:getHunger() + 0.15)
    return enduranceChange
end


function BaseEffect_Stimulant_tier2()
    local player = getPlayer()
    local stats = player:getStats()
    local health = player:getBodyDamage():getOverallBodyHealth()
    local enduranceChange = 0.2 + (-50 * (health/100) + 1)
    stats:setEndurance(stats:getEndurance() + enduranceChange)
    stats:setHunger(stats:getHunger() + 0.25)
    return enduranceChange
end

function BaseEffect_Stimulant_tier3()
    local player = getPlayer()
    local stats = player:getStats()
    local health = player:getBodyDamage():getOverallBodyHealth()
    local enduranceChange = 0.3 + (-50 * (health/100) + 1)
    stats:setEndurance(stats:getEndurance() + enduranceChange)
    stats:setHunger(stats:getHunger() + 0.35)
    return enduranceChange
end


-- Steroids
local steroidDamageMod = 0

-- Only buffs damage to zombies
local function steroidDamageBuff(attacker, target, weapon, damage)
    if getPlayer() != attacker then return end
    if target:isZombie() then
       damage = damage * steroidDamageMod
    end



function BaseEffect_Steroid_tier1()
    steroidDamageMod = 1.2
    local player = getPlayer()
    local nutrition = player:getNutrition()
    nutrition:setCalories(nutrition:getCalories() + 750)
    Events.OnWeaponHitCharacter.Add(steroidDamageBuff)
end
