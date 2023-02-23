SetDiscordAppId(config.DiscordAppID)

Citizen.CreateThread(function()
	while true do
		SetDiscordRichPresenceAsset(config.discordImageName) 
		SetDiscordRichPresenceAssetText(config.hoverText)
		SetRichPresence(config.richPresenceText) 
		SetDiscordRichPresenceAction(0, config.button1.text, config.button1.url)
		Wait(5000)
	end
end)
