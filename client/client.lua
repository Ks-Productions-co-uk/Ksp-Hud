local QBCore = exports['qb-core']:GetCoreObject()
local fps = 0
local isPlayerLoaded = false
local lastUpdate = 0
local UPDATE_INTERVAL = 10000 -- 10 seconds, No need to touch.

local GetGameTimer = GetGameTimer
local floor = math.floor
local format = string.format
local GetPlayerServerId = GetPlayerServerId
local PlayerId = PlayerId

local function GetTotalPlayerCount()
    TriggerServerEvent('ksp-hud:server:getPlayerCount')
end

local function GetCurrentTime()
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    return format("%02d:%02d", hours, minutes)
end

local function GetCurrentDate()
    local year, month, day = GetUtcTime()
    return format("%02d/%02d/%04d", day, month, year)
end

local function RequestFullHUDUpdate()
    local player = QBCore.Functions.GetPlayerData()
    if player then
        local currentTime = GetGameTimer()
        if currentTime - lastUpdate > UPDATE_INTERVAL then
            lastUpdate = currentTime
            
            SendNUIMessage({
                type = "updateHUD",
                playerId = GetPlayerServerId(PlayerId()),
                cash = player.money['cash'],
                bank = player.money['bank'],
                job = player.job.label,
                grade = player.job.grade.name,
                gang = player.gang.label,
                ganggrade = player.gang.grade.name
            })

            SendNUIMessage({
                type = "updateSingleLineText",
                text = Config.SingleLineText
            })

            GetTotalPlayerCount()
        end
    end
end

local function InitialHUDUpdate()
    while not LocalPlayer.state.isLoggedIn do
        Wait(100)
    end
    while not QBCore.Functions.GetPlayerData().job do
        Wait(100)
    end
    RequestFullHUDUpdate()
end

RegisterNetEvent('ksp-hud:client:updatePlayerCount', function(count)
    if not isPlayerLoaded then return end
    local maxPlayers = GetConvarInt('sv_maxclients', 64)
    
    SendNUIMessage({
        type = "updateInfobar",
        fps = fps,
        time = GetCurrentTime(),
        date = GetCurrentDate(),
        players = format("%d/%d", count, maxPlayers)
    })
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    ShutdownLoadingScreenNui()
    LocalPlayer.state:set('isLoggedIn', true, false)
    isPlayerLoaded = true
    Wait(1000)
    RequestFullHUDUpdate()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    LocalPlayer.state:set('isLoggedIn', false, false)
    isPlayerLoaded = false
end)

RegisterNetEvent('QBCore:Client:OnMoneyChange', function()
    if not isPlayerLoaded then return end
    RequestFullHUDUpdate()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function()
    if not isPlayerLoaded then return end
    RequestFullHUDUpdate()
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function()
    if not isPlayerLoaded then return end
    RequestFullHUDUpdate()
end)

-- Commands and Keymapping
RegisterKeyMapping('openHudMenu', 'Open HUD Menu', 'keyboard', Config.HudKey)

RegisterCommand('openHudMenu', function()
    if not isPlayerLoaded then return end
    SendNUIMessage({
        type = "openConfigMenu",
        colorPresets = Config.ColorPresets
    })
    SetNuiFocus(true, true)
end, false)

RegisterNUICallback('closeConfigMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

CreateThread(function()
    local lastFrameTime = GetGameTimer()
    local currentFrameTime = 0
    local frameCount = 0
    local updateCounter = 0

    while true do
        Citizen.Wait(0)
        if isPlayerLoaded then
            currentFrameTime = GetGameTimer()
            frameCount = frameCount + 1

            if currentFrameTime - lastFrameTime >= Config.FpsUpdateInterval then
                fps = floor((frameCount / (currentFrameTime - lastFrameTime)) * 1000)
                lastFrameTime = currentFrameTime
                frameCount = 0

                GetTotalPlayerCount()

                updateCounter = updateCounter + 1
                if updateCounter >= 20 then
                    InitialHUDUpdate()
                    updateCounter = 0
                end
            end
        end
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Wait(1000)
    if QBCore.Functions.GetPlayerData() then
        isPlayerLoaded = true
        LocalPlayer.state:set('isLoggedIn', true, false)
        RequestFullHUDUpdate()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    LocalPlayer.state:set('isLoggedIn', false, false)
    isPlayerLoaded = false
    SetNuiFocus(false, false)
end)

CreateThread(function()
    while not isPlayerLoaded do
        Wait(1000)
    end
    InitialHUDUpdate()
end)
