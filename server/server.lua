local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('ksp-hud:server:getPlayerCount', function()
    local players = GetPlayers()
    local playerCount = #players
    TriggerClientEvent('ksp-hud:client:updatePlayerCount', source, playerCount)
end)
