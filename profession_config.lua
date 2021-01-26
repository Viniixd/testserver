--> Global profession definitions
-->		Everything in this file
-->		must be static and cannot be reloaded
-->		to avoid unexpected behaviours

dofile('data/lib/profession/profession_lib.lua')

if not PROFESSION_DEF then

	------------------------------------------
	-- rank ids and reserved must follow up --
	--    with a sequential consistency		--
	------------------------------------------
	PROFESSION_RANKA = 5
	PROFESSION_RANKB = 4
	PROFESSION_RANKC = 3
	PROFESSION_RANKD = 2
	PROFESSION_RANKE = 1
	PROFESSION_RANK_FIRST = PROFESSION_RANKE
	PROFESSION_RANK_LAST = PROFESSION_RANKA

	PROFESSION_MISSION_ITEMS = {[1] = {[11198] = 300, [5878] = 150, [5902] = 100}, [2] = {[5877] = 150, [5948] = 100, [12423] = 200}, [3] = {[3976] = 10000}}

	PROFESSION_STORAGE_TASK = {['Elf'] = {COUNT = 400, STORAGE = 0x115A + 1}, ['Elf Scout'] = {COUNT = 300, STORAGE = 0x115A + 2}, ['Elf Arcanist'] = {COUNT = 200, STORAGE = 0x115A + 3}}
	PROFESSION_STORAGE_MISSIONS = 0x1159
	PROFESSION_STORAGE_AMOUNT = 0x10CC
	PROFESSION_STORAGE_ITEM = 0x10CD
	PROFESSION_STORAGE_BUILDING = 0x10CE --> used in a range of it + queuesize
	PROFESSION_STORAGE_CANCEL_BUILDING = 0x10CE + 0x12C

	AMOUNT_OFFSET = 0x64
	BUILDING_OFFSET = 0xC8

--> Explorer chests
LEGENDARY_CHEST = {ID = 27240, KEY_ID = 26465, REWARDS = {{2189, 50}, {2190, 30}, {2191, 10}, {2192, 34}, {2193, 100}}, SPAWN_LIMIT = 100, SPAWNED = 0, LEVEL = 3} 
RARE_CHEST = {ID = 27238, KEY_ID = 26464, REWARDS = {{2189, 50}, {2190, 30}, {2191, 10}, {2192, 34}, {2193, 100}}, SPAWN_LIMIT = 200, SPAWNED = 0, LEVEL = 2}
COMMON_CHEST = {ID = 27239, KEY_ID = 26462, REWARDS = {}, SPAWN_LIMIT = 500, SPAWNED = 0, LEVEL = 1}
GLOBAL_CHESTS = {}

	MODAL_BUILDING = {WINDOW = 0x23D9, TITLE = 'Building List', MESSAGE = 'Here is a list with your queue, you can cancel progress or request ready ones', BUTTONS = {OK = {0xCD, 'Get'}, CANCEL = {0xCE, 'Cancel'}, BACK = {0xCF, 'Back'}}}
	MODAL_AMOUNT = {WINDOW = 0x23DA, TITLE = 'Amount', MESSAGE = 'Choose amount you want to build', BUTTONS = {OK = {0x64, 'Next'}, CANCEL = {0x65, 'Back'}}}
	MODAL_CONFIRM = {WINDOW = 0x23DB, TITLE = 'Warning', BUTTONS = {OK = {0x66, 'Build!'}, CANCEL = {0x67, 'Back'}}}
	MODAL_CANCEL_CONFIRM = {WINDOW = 0x23D8, TITLE = 'Warning', MESSAGE = 'You\'re about to cancel your build progress, this is irreversible, although you will have back half of your items and free a queue slot, do you wanna proceed?', BUTTONS = {OK = {0xD0, 'Yes'}, CANCEL = {0xD1, 'No'}}}
	
	PROFESSIONS = 
	{
		PROFESSION_ALCHEMIST = 
		{
			ID = Profession(1),
			MAIN_ITEM = 27180,
			MODAL_CONFIG = {WINDOW = 0x23DC, TITLE = 'Alchemist Workshop', BUTTONS = {OK = {0x68, "Next"}, CANCEL = {0x69, "Leave"}, INFO = {0x6B, "Info"}, BUILDING = {0xC8, 'Bulding'}} }, 
			CRAFT_ITEM_LIST = 
			{
				[PROFESSION_RANKE] =
				{
					[1] = { ID = 27153, COUNT = 1, LEVEL = 1, TIME = 2 * 60, TRIES = 8, DESC = '1x Small Shield Potion. \n\nCost: \n200x Blood Samples; \n100x Vials of Water; \n5x Dwarven Shields.', REQS = { [27190] = 200, [27236] = 100, [2525] = 5} }, 
					[2] = { ID = 27162, COUNT = 1, LEVEL = 3, TIME = 2 * 60, TRIES = 8, DESC = '1x Small ML Potion. \n\nCost: \n200x Blood Samples; \n100x Vials of Water; \n1x Mastermind Potion.', REQS = { [27190] = 200, [27236] = 100, [7440] = 1} },
					[3] = { ID = 27165, COUNT = 1, LEVEL = 8, TIME = 2 * 60, TRIES = 8, DESC = '1x Small Melee Potion. \n\nCost: \n200x Blood Samples; \n100x Vials of Water; \n3x Two Handed Swords.', REQS = { [27190] = 200, [27236] = 100, [2377] = 3} },
					[4] = { ID = 27183, COUNT = 1, LEVEL = 12, TIME = 2 * 60, TRIES = 8, DESC = '1x Small Distance Potion. \n\nCost: \n200x Blood Samples; \n100x Vials of Water; \n3x Bows.', REQS = { [27190] = 200, [27236] = 100, [2456] = 3} },
					[5] = { ID = 27169, COUNT = 1, LEVEL = 15, TIME = 15 * 60, TRIES = 48, DESC = '1x Small Elixir. \n\nCost: \n800x Blood Samples; \n300x Vials of Water; \n1x Small Shield Potion; \n1x Small ML Potion; \n1x Small Melee Potion; \n1x Small Distance Potion.', REQS = { [27190] = 800, [27236] = 300, [27153] = 1, [27162] = 1, [27165] = 1, [27183] = 1} }
				},
				[PROFESSION_RANKD] = 
				{
					[1] = { ID = 27152, COUNT = 1, LEVEL = 20, TIME = 6 * 60, TRIES = 24, DESC = '1x Medium Shield Potion. \n\nCost: \n600x Blood Samples; \n200x Vials of Water; \n300x Poison Samples; \n1x Small Shield Potion.', REQS = { [27190] = 600, [27236] = 200, [27158] = 300, [27153] = 1} }, 
					[2] = { ID = 27161, COUNT = 1, LEVEL = 22, TIME = 6 * 60, TRIES = 24, DESC = '1x Medium ML Potion. \n\nCost: \n600x Blood Samples; \n200x Vials of Water; \n300x Poison Samples; \n1x Small ML Potion.', REQS = { [27190] = 600, [27236] = 200, [27158] = 300, [27162] = 1} },
					[3] = { ID = 27174, COUNT = 1, LEVEL = 25, TIME = 6 * 60, TRIES = 24, DESC = '1x Medium Melee Potion. \n\nCost: \n600x Blood Samples; \n200x Vials of Water; \n300x Poison Samples; \n1x Small Melee Potion.', REQS = { [27190] = 600, [27236] = 200, [27158] = 300, [27165] = 1} },
					[4] = { ID = 27182, COUNT = 1, LEVEL = 30, TIME = 6 * 60, TRIES = 24, DESC = '1x Medium Distance Potion. \n\nCost: \n600x Blood Samples; \n200x Vials of Water; \n300x Poison Samples; \n1x Small Distance Potion.', REQS = { [27190] = 600, [27236] = 200, [27158] = 300, [27183] = 1} },
					[5] = { ID = 27193, COUNT = 1, LEVEL = 36, TIME = 15 * 60, TRIES = 64, DESC = '1x Medium Elixir. \n\nCost: \n1800x Blood Samples; \n700x Vials of Water; \n900x Poison Samples; \n1x Small Elixir.', REQS = { [27190] = 1800, [27236] = 700, [27158] = 900, [27169] = 1} }
				},
				[PROFESSION_RANKC] = 
				{
					[1] = { ID = 27167, COUNT = 1, LEVEL = 40, TIME = 10 * 60, TRIES = 32, DESC = '1x Low Mana Regen Potion. \n\nCost: \n1800x Blood Samples; \n500x Vials of Water; \n400x Poison Samples; \n50x Darkness Samples; \n20x Magical Dusts.', REQS = { [27190] = 1800, [27236] = 500, [27158] = 400, [27184] = 50, [27194] = 20} }, 
					[2] = { ID = 27171, COUNT = 1, LEVEL = 42, TIME = 10 * 60, TRIES = 32, DESC = '1x Low Life Regen Potion. \n\nCost: \n1800x Blood Samples; \n500x Vials of Water; \n400x Poison Samples; \n50x Darkness Samples; \n20x Magical Dusts.', REQS = { [27190] = 1800, [27236] = 500, [27158] = 400, [27184] = 50, [27194] = 20} }, 
					[3] = { ID = 27176, COUNT = 1, LEVEL = 50, TIME = 18 * 60, TRIES = 48, DESC = '1x Small Potion of Rejuvenation. \n\nCost: \n3000x Blood Samples; \n700x Vials of Water; \n800x Poison Samples; \n70x Darkness Samples; \n40x Magical Dusts; \n100x Strong Mana Potions; \n100x Strong Health Potions.', REQS = { [27190] = 3000, [27236] = 700, [27158] = 800, [27184] = 70, [27194] = 40, [7589] = 100, [7588] = 100} }
				},
				[PROFESSION_RANKB] = 
				{
					[1] = { ID = 27151, COUNT = 1, LEVEL = 60, TIME = 20 * 60, TRIES = 72, DESC = '1x Large Shield Potion. \n\nCost: \n3000x Blood Samples; \n700x Vials of Water; \n800x Poison Samples; \n150x Darkness Samples; \n1x Medium Shield Potion.', REQS = { [27190] = 3000, [27236] = 700, [27158] = 800, [27184] = 150, [27152] = 1} }, 
					[2] = { ID = 27161, COUNT = 1, LEVEL = 62, TIME = 20 * 60, TRIES = 72, DESC = '1x Large ML Potion. \n\nCost: \n3000x Blood Samples; \n700x Vials of Water; \n800x Poison Samples; \n150x Darkness Samples; \n1x Medium ML Potion.', REQS = { [27190] = 3000, [27236] = 700, [27158] = 800, [27184] = 150, [27161] = 1} },
					[3] = { ID = 27174, COUNT = 1, LEVEL = 65, TIME = 20 * 60, TRIES = 72, DESC = '1x Large Melee Potion. \n\nCost: \n3000x Blood Samples; \n700x Vials of Water; \n800x Poison Samples; \n150x Darkness Samples; \n1x Medium Melee Potion.', REQS = { [27190] = 3000, [27236] = 700, [27158] = 800, [27184] = 150, [27174] = 1} },
					[4] = { ID = 27181, COUNT = 1, LEVEL = 70, TIME = 20 * 60, TRIES = 72, DESC = '1x Large Distance Potion. \n\nCost: \n3000x Blood Samples; \n700x Vials of Water; \n800x Poison Samples; \n150x Darkness Samples; \n1x Medium Distance Potion.', REQS = { [27190] = 3000, [27236] = 700, [27158] = 800, [27184] = 150, [27182] = 1} },
					[5] = { ID = 27192, COUNT = 1, LEVEL = 75, TIME = 30 * 60, TRIES = 96, DESC = '1x Large Elixir. \n\nCost: \n7200x Blood Samples; \n1500x Vials of Water; \n3000x Poison Samples; \n500x Darkness Samples; \n1x Medium Elixir.', REQS = { [27190] = 7200, [27236] = 1500, [27158] = 30000, [27184] = 500, [27193] = 1} }
				},
				[PROFESSION_RANKA] = 
				{
					[1] = { ID = 27168, COUNT = 1, LEVEL = 80, TIME = 30 * 60, TRIES = 120, DESC = '1x Full Mana Restore Potion. \n\nCost: \n12000x Blood Samples; \n2500x Vials of Water; \n5000x Poison Samples; \n1000x Darkness Samples; \n200x Magical Dusts; \n500x Ultimate Mana Potions.', REQS = { [27190] = 12000, [27236] = 2500, [27158] = 5000, [27184] = 1000, [27194] = 200, [26029] = 500} },
					[2] = { ID = 27172, COUNT = 1, LEVEL = 85, TIME = 30 * 60, TRIES = 120, DESC = '1x Full Life Restore Potion. \n\nCost: \n12000x Blood Samples; \n2500x Vials of Water; \n5000x Poison Samples; \n1000x Darkness Samples; \n200x Magical Dusts; \n500x Supreme Health Potions.', REQS = { [27190] = 12000, [27236] = 2500, [27158] = 5000, [27184] = 1000, [27194] = 200, [26031] = 500} },
					[3] = { ID = 27177, COUNT = 1, LEVEL = 90, TIME = 40 * 60, TRIES = 144, DESC = '1x Full Potion of Rejuvenation. \n\nCost: \n18000x Blood Samples; \n4000x Vials of Water; \n9000x Poison Samples; \n1500x Darkness Samples; \n300x Magical Dusts; \n800x Ultimate Spirit Potions.', REQS = { [27190] = 18000, [27236] = 4000, [27158] = 9000, [27184] = 1500, [27194] = 300, [26030] = 800} }
				},
			},
			PROFESSION_GATHER_ITEMS = 
				{
					[1364] = {PLAYER_GET = {ID = 27236, COUNT = 5}, RANK_REQUIRED = 1, TRANSFORM_TO = 1364},
					[1365] = {PLAYER_GET = {ID = 27236, COUNT = 5}, RANK_REQUIRED = 1, TRANSFORM_TO = 1365},
					[1366] = {PLAYER_GET = {ID = 27236, COUNT = 5}, RANK_REQUIRED = 1, TRANSFORM_TO = 1366},
					[1367] = {PLAYER_GET = {ID = 27236, COUNT = 5}, RANK_REQUIRED = 1, TRANSFORM_TO = 1367},
					[5995] = {PLAYER_GET = {ID = 27190, COUNT = 2}, RANK_REQUIRED = 1, TRANSFORM_TO = 2917},
					[13969] = {PLAYER_GET = {ID = 27190, COUNT = 2}, RANK_REQUIRED = 2, TRANSFORM_TO = 13817},
					[22508] = {PLAYER_GET = {ID = 27190, COUNT = 2}, RANK_REQUIRED = 3, TRANSFORM_TO = 22506},
					[25432] = {PLAYER_GET = {ID = 27190, COUNT = 2}, RANK_REQUIRED = 2, TRANSFORM_TO = 25434},
					[6332] = {PLAYER_GET = {ID = 27190, COUNT = 2}, RANK_REQUIRED = 1, TRANSFORM_TO = 6334},
					[8951] = {PLAYER_GET = {ID = 27158, COUNT = 2}, RANK_REQUIRED = 2, TRANSFORM_TO = 8953},
					[5977] = {PLAYER_GET = {ID = 27158, COUNT = 2}, RANK_REQUIRED = 3, TRANSFORM_TO = 2858},
					[6532] = {PLAYER_GET = {ID = 27158, COUNT = 2}, RANK_REQUIRED = 4, TRANSFORM_TO = 0},
					[27196] = {PLAYER_GET = {ID = 27184, COUNT = 2}, RANK_REQUIRED = 3, TRANSFORM_TO = 0}
				}
		},

		PROFESSION_BLACKSMITH =
		{
			ID = Profession(2),
			MAIN_ITEM = 27173,
			MODAL_CONFIG = {WINDOW = 0x23DD, TITLE = 'Blacksmith Workshop', BUTTONS = {OK = {0x6C, "Next"}, CANCEL = {0x6D, "Leave"}, INFO = {0x6E, "Info"}, BUILDING = {0xC9, 'Bulding'}} },
			CRAFT_ITEM_LIST = 
			{
				[PROFESSION_RANKE] =
				{
					[1] = { ID = 27150, COUNT = 1, LEVEL = 1, TIME = 1 * 60, TRIES = 3, DESC = '1x Silver Dust. \n\nCost: \n1x Silver Ores.', REQS = { [27149] = 1} }, 
					[2] = { ID = 27186, COUNT = 1, LEVEL = 1, TIME = 2 * 60, TRIES = 3, DESC = '1x Copper Dust. \n\nCost: \n1x Copper Ores.', REQS = { [27185] = 1} },
					[3] = { ID = 27175, COUNT = 1, LEVEL = 2, TIME = 3 * 60, TRIES = 3, DESC = '1x Gold Dust. \n\nCost: \n1x Gold Ores.', REQS = { [27174] = 1} },
					[4] = { ID = 27188, COUNT = 1, LEVEL = 2, TIME = 4 * 60, TRIES = 3, DESC = '1x Cobalt Dust. \n\nCost: \n1x Cobalt Ores.', REQS = { [27187] = 1} },
					[5] = { ID = 27194, COUNT = 1, LEVEL = 3, TIME = 5 * 60, TRIES = 3, DESC = '1x Magical Dust. \n\nCost: \n1x Magical Stone.', REQS = { [26460] = 1} },
					[6] = { ID = 28789, COUNT = 1, LEVEL = 10, TIME = 7 * 60, TRIES = 16, DESC = '1x Magical Stone. \n\nCost: \n10x Silver Dusts; \n10x Copper Dusts; \n10x Gold Dusts; \n10x Cobalt Dusts.', REQS = { [27150] = 10, [27186] = 10, [27175] = 10, [27188] = 10} }
				},
				[PROFESSION_RANKD] = 
				{
					[1] = { ID = 28679, COUNT = 1, LEVEL = 20, TIME = 10 * 60, TRIES = 32, DESC = '1x Magical Essence. \n\nCost: \n20x Silver Dusts; \n20x Copper Dusts; \n20x Gold Dusts; \n20x Cobalt Dusts; \n10x Magical Dusts.', REQS = { [27150] = 20, [27186] = 20, [27175] = 20, [27188] = 20, [27194] = 10} }
				},
				[PROFESSION_RANKC] = 
				{
					[1] = { ID = 28699, COUNT = 1, LEVEL = 40, TIME = 20 * 60, TRIES = 56, DESC = '1x Magical Flawless Essence. \n\nCost: \n50x Silver Dusts; \n50x Copper Dusts; \n50x Gold Dusts; \n50x Cobalt Dusts; \n40x Magical Dusts; \n20x Rainbow Dusts.', REQS = { [27150] = 50, [27186] = 50, [27175] = 50, [27188] = 50, [27194] = 40, [27157] = 20} }
				},
				[PROFESSION_RANKB] = 
				{
					[1] = { ID = 28689, COUNT = 1, LEVEL = 60, TIME = 30 * 60, TRIES = 40, DESC = '1x Magical Perfect Essence. \n\nCost: \n100x Silver Dusts; \n100x Copper Dusts; \n100x Gold Dusts; \n100x Cobalt Dusts; \n90x Magical Dusts; \n50x Rainbow Dusts.; \n1x Magical Shield Gem.', REQS = { [27150] = 100, [27186] = 100, [27175] = 100, [27188] = 100, [27194] = 90, [27157] = 50, [27113] = 1} }
				},
				[PROFESSION_RANKA] = 
				{
					[1] = { ID = 28793, COUNT = 1, LEVEL = 80, TIME = 50 * 60, TRIES = 120, DESC = '1x Magical Heroic Essence. \n\nCost: \n200x Silver Dusts; \n200x Copper Dusts; \n200x Gold Dusts; \n200x Cobalt Dusts; \n180x Magical Dusts; \n120x Rainbow Dusts.; \n2x Magical Shield Gem.; \n2x Magical Melee Gem.; \n2x Magical Distance Gem.', REQS = { [27150] = 200, [27186] = 200, [27175] = 200, [27188] = 200, [27194] = 180, [27157] = 120, [27113] = 2, [27117] = 2, [27116] = 2} }
				},
			},

			PROFESSION_GATHER_ITEMS = 
				{
					[27135] = {PLAYER_GET = {ID = 27174, COUNT = 1}, RANK_REQUIRED = 1, TRANSFORM_TO = 27141},
					[27136] = {PLAYER_GET = {ID = 27187, COUNT = 1}, RANK_REQUIRED = 1, TRANSFORM_TO = 27142},
					[27137] = {PLAYER_GET = {ID = 27149, COUNT = 1}, RANK_REQUIRED = 1, TRANSFORM_TO = 27140},
					[27138] = {PLAYER_GET = {ID = 27185, COUNT = 1}, RANK_REQUIRED = 1, TRANSFORM_TO = 27143}
				}
		},

		PROFESSION_ENCHANTER =
		{
			ID = Profession(3),
			MAIN_ITEM = 27159,
			MODAL_CONFIG = {WINDOW = 0x23DE, TITLE = "Enchanter Workshop", BUTTONS = {OK = {0x6F, "Next"}, CANCEL = {0x70, "Leave"}, INFO = {0x71, "Info"}, BUILDING = {0xCA, 'Bulding'}} },
			CRAFT_ITEM_LIST = 
			{
				[PROFESSION_RANKE] =
				{					
					[1] = { ID = 27229, COUNT = 1, LEVEL = 1, TIME = 2 * 60, TRIES = 8, DESC = '1x Amethyst Perfect Crystals. \n\nCost: \n1x Amethyst Raw Crystal.', REQS = { [27191] = 1} }, 
					[2] = { ID = 27230, COUNT = 1, LEVEL = 3, TIME = 2 * 60, TRIES = 8, DESC = '1x Topaz Perfect Crystals. \n\nCost: \n1x Topaz Raw Crystal.', REQS = { [27147] = 1} },
					[3] = { ID = 28777, COUNT = 1, LEVEL = 15, TIME = 5 * 60, TRIES = 24, DESC = '1x Fire Gem. \n\nCost:\n40x Amethyst Perfect Crystals;\n40x Topaz Perfect Crystals.', REQS = { [27229] = 20, [27230] = 20} }

				},
				[PROFESSION_RANKD] = 
				{
					[1] = { ID = 27231, COUNT = 1, LEVEL = 20, TIME = 3 * 60, TRIES = 16, DESC = '1x Emerald Perfect Crystals. \n\nCost: \n1x Emerald Raw Crystal.', REQS = { [27178] = 1} },
					[2] = { ID = 27232, COUNT = 1, LEVEL = 20, TIME = 3 * 60, TRIES = 16, DESC = '1x Ruby Perfect Crystals. \n\nCost: \n1x Ruby Raw Crystal.', REQS = { [27156] = 1} },
					[3] = { ID = 28784, COUNT = 1, LEVEL = 35, TIME = 10 * 60, TRIES = 40, DESC = '1x Frost Gem. \n\nCost: \n40x Amethyst Perfect Crystals; \n40x Topaz Perfect Crystals; \n20x Emerald Perfect Crystals.; 20x Ruby Perfect Crystals; 10x Magical Dusts.', REQS = { [27229] = 40, [27230] = 40, [27231] = 20, [27232] = 20, [27194] = 10} }

				},
				[PROFESSION_RANKC] = 
				{
					[1] = { ID = 27233, COUNT = 1, LEVEL = 40, TIME = 5 * 60, TRIES = 24, DESC = '1x Sapphire Perfect Crystals. \n\nCost: \n1x Sapphire Raw Crystal.', REQS = { [27155] = 1} },
					[2] = { ID = 27157, COUNT = 1, LEVEL = 45, TIME = 5 * 60, TRIES = 24, DESC = '1x Raibow Dusts. \n\nCost:\n 3x Rainbow Raw Crystal.', REQS = { [27170] = 3} },
					[3] = { ID = 28785, COUNT = 1, LEVEL = 50, TIME = 20 * 60, TRIES = 40, DESC = '1x Thunder Gem. \n\nCost: \n60x Amethyst Perfect Crystals; 60x Topaz Perfect Crystals; 40x Emerald Perfect Crystals.; 40x Ruby Perfect Crystals.; 20x Sapphire Perfect Crystals.; 10x Rainbow Dusts; 10x Magical Dusts; 2x Red Dragon Scale Helmets.', REQS = { [27229] = 60, [27230] = 60, [27231] = 40, [27232] = 40, [27233] = 20, [27157] = 10, [27194] = 10, [26961] = 2} }
				},
				[PROFESSION_RANKB] = 
				{
					[1] = { ID = 28788, COUNT = 1, LEVEL = 60, TIME = 20 * 60, TRIES = 80, DESC = '1x Darkness Gem. \n\nCost: \n80x Amethyst Perfect Crystals; 80x Topaz Perfect Crystals; 60x Emerald Perfect Crystals.; 60x Ruby Perfect Crystals.; 40x Sapphire Perfect Crystals.; 20x Rainbow Dusts; 30x Magical Dusts; 2x Red Dragon Scale Helmets.', REQS = { [27229] = 80, [27230] = 80, [27231] = 60, [27232] = 60, [27233] = 40, [27157] = 20, [27194] = 30, [26961] = 2} }
				},
				[PROFESSION_RANKA] = 
				{
					[1] = { ID = 28781, COUNT = 1, LEVEL = 80, TIME = 30 * 60, TRIES = 120, DESC = '1x Soul Gem. \n\nCost: \n100x Amethyst Perfect Crystals; \n100x Topaz Perfect Crystals; \n80x Emerald Perfect Crystals.; \n80x Ruby Perfect Crystals.; \n60x Sapphire Perfect Crystals.; \n40x Rainbow Dusts; \n50x Magical Dusts; \n1x Upgrade Stone+11 Nv01;\n 4x Spellbooks of Mind Control.', REQS = { [27229] = 100, [27230] = 100, [27231] = 80, [27232] = 80, [27233] = 60, [27157] = 40, [27194] = 50, [27216] = 1, [8902] = 4} }
				},
			},
			PROFESSION_GATHER_ITEMS =
				{
					[27139] = {PLAYER_GET = {ID = 27170, COUNT = 1}, RANK_REQUIRED = 3, TRANSFORM_TO = 27144},
					[27203] = {PLAYER_GET = {ID = 27147, COUNT = 1}, RANK_REQUIRED = 1, TRANSFORM_TO = 27204},
					[27205] = {PLAYER_GET = {ID = 27191, COUNT = 1}, RANK_REQUIRED = 1, TRANSFORM_TO = 27206},
					[27209] = {PLAYER_GET = {ID = 27155, COUNT = 1}, RANK_REQUIRED = 3, TRANSFORM_TO = 27212},
					[27210] = {PLAYER_GET = {ID = 27156, COUNT = 1}, RANK_REQUIRED = 2, TRANSFORM_TO = 27213},
					[27211] = {PLAYER_GET = {ID = 27178, COUNT = 1}, RANK_REQUIRED = 2, TRANSFORM_TO = 27214}
				}
		},

		PROFESSION_EXPLORER = 
		{
			ID = Profession(4),
			MAIN_ITEM = 27166,
			MODAL_CONFIG = {WINDOW = 0x23DF, TITLE = "Explorer Workshop", BUTTONS = {OK = {0x72, "Next"}, CANCEL = {0x73, "Leave"}, INFO = {0x74, "Info"}, BUILDING = {0xCB, 'Bulding'}} },
			CRAFT_ITEM_LIST = 
			{
				[PROFESSION_RANKE] =
				{	
					[1] = { ID = 26462, COUNT = 1, LEVEL = 1, TIME = 1 * 60, TRIES = 50, DESC = '1x Common Key. \n\nCost: \n500x Key Parts.', REQS = { [27237] = 500} }
				},
				[PROFESSION_RANKD] = 
				{
					[1] = { ID = 26464, COUNT = 1, LEVEL = 20, TIME = 3 * 60, TRIES = 100, DESC = '1x Rare Key. \n\nCost: \n1200x Key Parts.', REQS = { [27237] = 1200} },
					[2] = { ID = 28501, COUNT = 1, LEVEL = 30, TIME = 30 * 60, TRIES = 300, DESC = '1x Common Dungeon Key. \n\nCost: \n3000x Key Parts.', REQS = { [27237] = 3000} }
				},
				[PROFESSION_RANKC] = 
				{
					[1] = { ID = 26465, COUNT = 1, LEVEL = 40, TIME = 10 * 60, TRIES = 200, DESC = '1x Legendary Key. \n\nCost: \n2000x Key Parts.', REQS = { [27237] = 2000} }
				},
				[PROFESSION_RANKB] = 
				{
					[1] = { ID = 2121, COUNT = 1, LEVEL = 60, TIME = 30 * 60, TRIES = 300, DESC = '1x Common Dungeon Key. \n\nCost: \n3000x Key Parts.', REQS = { [27237] = 3000} }
				},
				[PROFESSION_RANKA] = {},
			},
			PROFESSION_GATHER_ITEMS = {},
			TASKS =
			   {
			   	  STORAGE = 0x187A4A, --> main storage for quest
			      ['deer'] = {amount = 100, items = {[5894] = 40, [5905] = 70}, reward = {[27237] = 1000}, time = 24 * 60 * 60, kill_storage = 0x187AEA, time_storage = 0x187B8A},
			      ['ghoul'] = {amount = 200, items = {[5896] = 40, [5877] = 100}, reward = {[27237] = 700}, time = 24 * 60 * 60, kill_storage = 0x187AEA + 1, time_storage = 0x187B8A + 1},
			      ['fire devil'] = {amount = 100, items = {[5897] = 40, [5906] = 80}, reward = {[27237] = 800}, time = 24 * 60 * 60, kill_storage = 0x187AEA + 2, time_storage = 0x187B8A + 2},
			      ['necromancer'] = {amount = 400, items = {[5878] = 120, [5948] = 120}, reward = {[27237] = 900}, time = 24 * 60 * 60, kill_storage = 0x187AEA + 3, time_storage = 0x187B8A + 3},
			      ['juggernaut'] = {amount = 100, items = {[5902] = 100, [5893] = 100}, reward = {[27237] = 600}, time = 24 * 60 * 60, kill_storage = 0x187AEA + 4, time_storage = 0x187B8A + 4}
			   }
		}
	}
	PROFESSION_DEF = true
end