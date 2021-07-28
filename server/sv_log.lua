--Configuration--
local discordwebhook = ''
--End Of Configuration--

ESX = nil
local playertimes = {}

RegisterServerEvent('esx_mball_log:server:playtime')
AddEventHandler('esx_mball_log:server:playtime', function(playtime)
  local _source = source
  playertimes[_source] = playtime
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerConnecting', function()
  specificjointime = os.date("%d/%m/%Y %X") or 0
end)

--Player Connecting
RegisterServerEvent('esx_mball_log:esxjoin')
AddEventHandler('esx_mball_log:esxjoin', function()
  local _source = source
  local name = GetPlayerName(_source)
  local mb = Masipallopaa(_source)
  local xPlayer = ESX.GetPlayerFromId(_source)
  local esx = ESXInfo(_source)
  local specificjointime = specificjointime
    sendToDiscordLogsEmbed(3158326, '`✅` | PLAYER CONNECTING',' Player: `' ..name.. '`\n Hex-ID: `' ..mb.identifier.. '`\n License: `' ..mb.license.. '`\n Discord ID: `' ..mb.discord.. '`\n XBL ID: `' ..mb.xbl.. '`\n Live ID: `' ..mb.live.. '`\n FiveM ID: `' ..mb.fivem.. '`\n Specific Jointime: `' ..specificjointime.. '`\n IP: `' ..GetPlayerEndpoint(_source)..
    '`\n\n**ESX Information**\n Character: `'..esx.charactername..'`\n Money: `'..esx.overallmoney..' (Cash: '..esx.cash..' Bank: '..esx.bankmoney..')`\n Job: `'..esx.characterjob..' ('..esx.jobgrade..')`')
end)

--Player Leaving
AddEventHandler('playerDropped', function(reason)
  local _source = source
  local name = GetPlayerName(_source)
  local playtime = playertimes[_source] or 0
  local mb = Masipallopaa(_source)
  local xPlayer = ESX.GetPlayerFromId(_source)
  local esx = ESXInfo(_source)
    sendToDiscordLogsEmbed(3158326, '`❌` | PLAYER DROPPED',' Reason: `' ..reason.. '`\n Player: `' ..name.. '`\n Playtime: `' ..playtime.. ' minutes`\n Hex-ID: `' ..mb.identifier.. '`\n License: `' ..mb.license.. '`\n Discord ID: `' ..mb.discord.. '`\n XBL ID: `' ..mb.xbl.. '`\n Live ID: `' ..mb.live.. '`\n FiveM ID: `' ..mb.fivem.. '`\n IP: `' ..GetPlayerEndpoint(_source)..
    '`\n\n**ESX Information**\n Character: `'..esx.charactername..'`\n Money: `'..esx.overallmoney..' (Cash: '..esx.cash..' Bank: '..esx.bankmoney..')`\n Job: `'..esx.characterjob..' ('..esx.jobgrade..')`')
end)

RegisterCommand("pinfo", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
      if args[1] and tonumber(args[1]) and xPlayer.getGroup(source) ~= 'user' and xPlayer.getGroup(source) == 'mod' or xPlayer.getGroup(source) == 'admin' or xPlayer.getGroup(source) == 'superadmin' then
        local _source = args[1]
        TriggerEvent('esx_mball_log:playerinfo', _source)
      TriggerClientEvent("chat:addMessage", source, { args = { "MBall-Logs", "Player Info sent to Discord!" } })
end
end, false)

RegisterServerEvent('esx_mball_log:playerinfo')
AddEventHandler('esx_mball_log:playerinfo', function(_source)
  local name = GetPlayerName(_source)
  local mb = Masipallopaa(_source)
  local xPlayer = ESX.GetPlayerFromId(_source)
  local esx = ESXInfo(_source)
  sendToDiscordLogsEmbed(3158326, '`📝` | PLAYER INFO REQUESTED',' Player: `' ..name.. '`\n Hex-ID: `' ..mb.identifier.. '`\n License: `' ..mb.license.. '`\n Discord ID: `' ..mb.discord.. '`\n XBL ID: `' ..mb.xbl.. '`\n Live ID: `' ..mb.live.. '`\n FiveM ID: `' ..mb.fivem.. '`\n IP: `' ..GetPlayerEndpoint(_source)..
  '`\n\n**ESX Information**\n Character: `'..esx.charactername..'`\n Money: `'..esx.overallmoney..' (Cash: '..esx.cash..' Bank: '..esx.bankmoney..')`\n Job: `'..esx.characterjob..' ('..esx.jobgrade..')`')
end)

AddEventHandler('chatMessage', function(source, name, msg)
  local mb = Masipallopaa(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local esx = ESXInfo(source)
  sendToDiscordLogsEmbed(3158326, '`💬` | CHAT',' Player: `' ..name.. '`\n Message: `' ..msg.. '`\n Hex-ID: `' ..mb.identifier.. '`\n License: `' ..mb.license.. '`\n Discord ID: `' ..mb.discord.. '`\n XBL ID: `' ..mb.xbl.. '`\n Live ID: `' ..mb.live.. '`\n FiveM ID: `' ..mb.fivem.. '`\n IP: `' ..GetPlayerEndpoint(source)..
  '`\n\n**ESX Information**\n Character: `'..esx.charactername..'`\n Money: `'..esx.overallmoney..' (Cash: '..esx.cash..' Bank: '..esx.bankmoney..')`\n Job: `'..esx.characterjob..' ('..esx.jobgrade..')`')
end)

RegisterServerEvent('esx_mball_log:CustomLog')
AddEventHandler('esx_mball_log:CustomLog',function(source, message1, message2)
  local _source = source
  local name = GetPlayerName(_source)
  local mb = Masipallopaa(_source)
  local xPlayer = ESX.GetPlayerFromId(_source)
  local esx = ESXInfo(_source)
  sendToDiscordLogsEmbed(3158326, '`😗` | Custom Log',' Player: `' ..name.. '`\n' ..message1.. ' `' ..message2.. '`\n Hex-ID: `' ..mb.identifier.. '`\n License: `' ..mb.license.. '`\n Discord ID: `' ..mb.discord.. '`\n XBL ID: `' ..mb.xbl.. '`\n Live ID: `' ..mb.live.. '`\n FiveM ID: `' ..mb.fivem.. '`\n IP: `' ..GetPlayerEndpoint(_source)..
  '`\n\n**ESX Information**\n Character: `'..esx.charactername..'`\n Money: `'..esx.overallmoney..' (Cash: '..esx.cash..' Bank: '..esx.bankmoney..')`\n Job: `'..esx.characterjob..' ('..esx.jobgrade..')`')
end)

function sendToDiscordLogsEmbed(color, name, message, footer)
  local footer = 'Made My MasiBall   '..os.date("%d/%m/%Y     %X")
  local embed = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = footer,
            },
        }
    }

  PerformHttpRequest(discordwebhook, function(err, text, headers) end, 'POST', json.encode({username = 'Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function Masipallopaa(_source)
  local idtablemb = {
    license = "No License found",
    identifier = "No Hex-ID found",
    discord = "No Discord found",
    xbl = "No xbl ID found",
    live = "No Live ID found",
    fivem = "No FiveM ID found"
  }

    for k,v in ipairs(GetPlayerIdentifiers(_source))do
    if string.sub(v, 1, string.len("license:")) == "license:" then
      idtablemb.license = v
    elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
      idtablemb.identifier = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      idtablemb.discord = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      idtablemb.xbl = v
    elseif string.sub(v, 1, string.len("live:")) == "live:" then
      idtablemb.live = v
    elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
      idtablemb.fivem = v
    end
  end
  return idtablemb
end

function ESXInfo(_source)
  local esxdata = {
    charactername = "No character name found",
    cash = "No cash balance found",
    bankmoney = "No bank balance found",
    overallmoney = "Couldn't count overall money",
    characterjob = "No job found",
    jobgrade = "No job grade found"
  }
  local xPlayer = ESX.GetPlayerFromId(_source)
  esxdata.charactername = xPlayer.getName()
  esxdata.cash = xPlayer.getMoney()
  esxdata.bankmoney = xPlayer.getAccount('bank').money
  esxdata.overallmoney = esxdata.cash + esxdata.bankmoney
  esxdata.characterjob = xPlayer.job.label
  esxdata.jobgrade = xPlayer.job.grade_label
  return esxdata
end