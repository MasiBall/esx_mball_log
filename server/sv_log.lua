--Configuration--
local discordwebhook = ''
--End Of Configuration--

ESX = nil
local playertimes = {}

RegisterServerEvent('mball_log:server:playtime')
AddEventHandler('mball_log:server:playtime', function(playtime)
  local _source = source
  playertimes[_source] = playtime
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerConnecting', function()
  specificjointime = os.date("%d/%m/%Y %X") or 0
end)

--Player Connecting
RegisterServerEvent('mball_log:esxjoin')
AddEventHandler('mball_log:esxjoin', function()
  local _source = source
  local name = GetPlayerName(_source)
  local license = nil
  local identifier = nil
	local discord = nil
  local xbl = nil
  local live = nil
  local fivem = nil
  local xPlayer = ESX.GetPlayerFromId(_source)
  local charactername = xPlayer.getName()
  local cash = xPlayer.getMoney()
  local bankmoney = xPlayer.getAccount('bank').money
  local overallmoney = cash + bankmoney
  local characterjob = xPlayer.job.label
  local jobgrade = xPlayer.job.grade_label
  local specificjointime = specificjointime
	for k,v in ipairs(GetPlayerIdentifiers(_source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
		  license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			identifier = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      xbl = v
    elseif string.sub(v, 1, string.len("live:")) == "live:" then
      live = v
    elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
      fivem = v
	  end
  end
  if license == nil then
    license = "No License found"
  end
  if identifier == nil then
    identifier = "No Hex-ID found"
  end
  if discord == nil then
    discord = "No Discord found"
  end
  if xbl == nil then
    xbl = "No xbl ID found"
  end
  if live == nil then
    live = "No Live ID found"
  end
  if fivem == nil then
    fivem = "No FiveM ID found"
  end
    sendToDiscordLogsEmbed(3158326, '`✅` | PLAYER CONNECTING',' Player: `' .. name .. '`\n Hex-ID: `' ..identifier.. '`\n License: `' ..license.. '`\n Discord ID: `' ..discord.. '`\n XBL ID: `' ..xbl.. '`\n Live ID: `' ..live.. '`\n FiveM ID: `' ..fivem.. '`\n Specific Jointime: `' ..specificjointime.. '`\n IP: `' ..GetPlayerEndpoint(_source)..
    '`\n\n**ESX Information**\n Character: `'..charactername..'`\n Money: `'..overallmoney..' (Cash: '..cash..' Bank: '..bankmoney..')`\n Job: `'..characterjob..' ('..jobgrade..')`')
end)

--Player Leaving
AddEventHandler('playerDropped', function(reason)
  local _source = source
  local name = GetPlayerName(_source)
  local playtime = playertimes[_source] or 0
  local license = nil
  local identifier = nil
	local discord = nil
  local xbl = nil
  local live = nil
  local fivem = nil
  local xPlayer = ESX.GetPlayerFromId(_source)
  local charactername = xPlayer.getName()
  local cash = xPlayer.getMoney()
  local bankmoney = xPlayer.getAccount('bank').money
  local overallmoney = cash + bankmoney
  local characterjob = xPlayer.job.label
  local jobgrade = xPlayer.job.grade_label
  for k,v in ipairs(GetPlayerIdentifiers(_source))do
    if string.sub(v, 1, string.len("license:")) == "license:" then
      license = v
    elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
      identifier = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      xbl = v
    elseif string.sub(v, 1, string.len("live:")) == "live:" then
      live = v
    elseif string.sub(v, 1, string.len("fivem:")) == "fivem:" then
      fivem = v
    end
  end
  if license == nil then
    license = "No License found"
  end
  if identifier == nil then
    identifier = "No Hex-ID found"
  end
  if discord == nil then
    discord = "No Discord found"
  end
  if xbl == nil then
    xbl = "No xbl ID found"
  end
  if live == nil then
    live = "No Live ID found"
  end
  if fivem == nil then
    fivem = "No FiveM ID found"
  end
    sendToDiscordLogsEmbed(3158326, '`❌` | PLAYER DROPPED',' Reason: `' ..reason.. '`\n Player: `' ..name.. '`\n Playtime: `' ..playtime.. ' minutes`\n Hex-ID: `' ..identifier.. '`\n License: `' ..license.. '`\n Discord ID: `' ..discord.. '`\n XBL ID: `' ..xbl.. '`\n Live ID: `' ..live.. '`\n FiveM ID: `' ..fivem.. '`\n IP: `' ..GetPlayerEndpoint(_source)..
    '`\n\n**ESX Information**\n Character: `'..charactername..'`\n Money: `'..overallmoney..' (Cash: '..cash..' Bank: '..bankmoney..')`\n Job: `'..characterjob..' ('..jobgrade..')`')
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