local pressAmount = 0
local keys = { 30, 31 }

local function breakStrafe(key, time)
    CreateThread(function()
        local finishTime = GetGameTimer() + time
        while finishTime > GetGameTimer() do
            SetControlNormal(0, key, 1.0)
            Wait(0)
        end
    end)
end

CreateThread(function()
    while true do
        Wait(1000)
        if pressAmount > 4 then
            local key = IsControlJustPressed(0, 30) and 30 or 31
            breakStrafe(key, 250)
        end
        pressAmount = 0
    end
end)

CreateThread(function()
    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        if IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(playerPed) then
            time = 0
            for i=1, #keys do
                if IsControlJustPressed(0, keys[i]) then
                    pressAmount = pressAmount + 1
                end
            end
        end
        Wait(time)
    end
end)