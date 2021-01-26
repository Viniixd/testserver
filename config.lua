if TFS_DEBUG then
	loginProtocolPort = 9000
	gameProtocolPort = 9001
	statusProtocolPort = 9005

	motd = "DEBUG SERVER"
	serverName = "Arcadia DEBUG"

	mapName = "map2"

	enableLiveCasting = false
	liveCastPort = 9002
	mysqlDatabase = "debug"
else
	loginProtocolPort = 7171
	gameProtocolPort = 7172
	statusProtocolPort = 7171
	motd = "Bem-vindos ao Servidor Global Pizza."
	serverName = "Global Pizza"
	mapName = "map1"
	enableLiveCasting = true
	liveCastPort = 7173
	mysqlDatabase = "tfs"
end

worldType = "pvp"
hotkeyAimbotEnabled = true
protectionLevel = 1
killsToRedSkull = 4
killsToBlackSkull = 6
pzLocked = 60 * 1000
removeChargesFromRunes = true
timeToDecreaseFrags = 8 * 60 * 60 * 1000
whiteSkullTime = 5 * 60 * 1000
stairJumpExhaustion = 2 * 1000
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75

ip = "191.252.221.240"
bindOnlyGlobalAddress = true
maxPlayers = 1000
onePlayerOnlinePerAccount = false
allowClones = false
statusTimeout = 5 * 1000
replaceKickOnLogin = true
maxPacketsPerSecond = 10-50

clientVersionMin = 1094
clientVersionMax = 1097
clientVersionStr = "Only clients with protocol 10.94 to 10.97 allowed!"

freeDepotLimit = 2000
premiumDepotLimit = 10000
depotBoxes = 17

deathLosePercent = -1

housePriceEachSQM = 5000
houseRentPeriod = "weekly"

timeBetweenActions = 200
timeBetweenExActions = 600

mapAuthor = "Jocker"

marketOfferDuration = 30 * 24 * 60 * 60
premiumToCreateMarketOffer = true
checkExpiredMarketOffersEachMinutes = 60
maxMarketOffersAtATimePerPlayer = 100

mysqlHost = "127.0.0.1"
mysqlUser = "tfs"
mysqlPass = "doQ]Egw:b5vrM4NyAz-KvVu8*"
mysqlPort = 3306
mysqlSock = ""
passwordType = "sha1"

allowChangeOutfit = true
freePremium = false
kickIdlePlayerAfterMinutes = 15
maxMessageBuffer = 8
emoteSpells = true
classicEquipmentSlots = false
allowWalkthrough = true
coinPacketSize = 25
coinImagesURL = "https://globalpizza-br.com/images/store/"

experienceStages = true
rateExp = 5
rateSkill = 35
rateLoot = 3

rateMagic = 20
rateSpawn = 2

deSpawnRange = 2
deSpawnRadius = 50

staminaSystem = true

warnUnsafeScripts = true
convertUnsafeScripts = true

defaultPriority = "high"
startupDatabaseOptimization = true

ownerName = "Jocker"
ownerEmail = "globalpizza.server@gmail.com"
url = "https://globalpizza-br.com/"
location = "Brazil"
