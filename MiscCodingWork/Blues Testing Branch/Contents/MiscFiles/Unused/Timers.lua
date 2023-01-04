Timers = {
    ActiveTimers = {},
}

--- Module for the sake of creating timers. Goes in \lua\shared.
---

Timers.add = function(delay, repeats, callback, args)
    local hours = getGameTime():getWorldAgeHours()
    local t = {
        delay = delay,
        callback = callback,
        args = args,
        repeats = repeats,
        trigger = hours + (delay/60),
    }
    t.id = ZombRand(100000) .."-".. t.trigger
    Timers.ActiveTimers[t.id] = t
    return t
end
--[[
The above function takes 4 arguments.
delay = the number of minutes to wait before triggering the timer
repeats = the number of times to repeat the timer, after the first triggering
callback = the function to call when the timer is triggered. Accepts 2 arguments, the timer itself and whatever value
            is in the args variable.
args = passed to the callback function. Can be anything, but need to be careful not to pass variables that may have
        expired. Example - IsoPlayer, as the specific player may have left before the timer is triggered.
]]--


Timers.remove = function(timer)
    if type(timer) == "table" then
        -- not a proper timer table
        if not timer.id then return end
        timer = timer.id
    end
    Timers.ActiveTimers[timer] = nil
end
-- The timer argument can be one of 2 things: the actual timer table returned by Timers.add(), or the timer id.

Timers.check = function()
    local current = getGameTime():getWorldAgeHours()
    for id, timer in pairs(Timers.ActiveTimers) do
        if timer.trigger <= current then
            if not timer.repeats or timer.repeats == 0 then
                Timers.ActiveTimers[id] = nil
            elseif type(timer.repeats) == "number" then
                timer.repeats = timer.repeats - 1
            end
            timer.trigger = current + (timer.delay/60)
            timer.callback(timer, timer.args)
        end
    end
end

Events.EveryOneMinute.Add(Timers.check)