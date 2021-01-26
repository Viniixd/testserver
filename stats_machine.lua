local RARE = 1
local EPIC = 2
local LEGENDARY = 3

local OP_CATA = 0
local OP_SUCCESS = 1
local OP_BROKE = 2

local ARMOR = 20
local TRANSFORM = 21
local CHARGES = 23

local tier_prefixes = {
	['rare'] = RARE,
	['epic'] = EPIC,
	['legendary'] = LEGENDARY
}

local cfg = {
	lever_aid = 2020;
	-- catas without a tier
	catas = {[22396] = 50, [22397] = 20, [28777] = 20, [28789] = 20};
	pos = {
		lever = {x=32340, y=32252, z=7};
		catas = {x=32339, y=32251, z=7};
		item =  {x=32340, y=32251, z=7};
		modfi = {x=32341, y=32251, z=7};
	};
	forge = {
		[RARE] = {
			showattr = true;
			shuffle_chance = 60;
			success = 50;
			broke = 20;
			catas = {[22396] = 70, [22397] = 50, [28777] = 50, [28789] = 50, [28784] = 20, [28679] = 20};
			prefix = 'rare';
			extra = {0,0};
			stats_chance = {100000, 5000}
		};
		[EPIC] = {
			shuffle_chance = 30;
			success = 20;
			broke = 30;
			catas = {[22396] = 100, [22397] = 70, [28777] = 70, [28789] = 70, [28784] = 50, [28679] = 50, [28785] = 20, [28699] = 20, [2131] = 2, [2131] = 2};
			prefix = 'epic';
			extra = {7,20};
			stats_chance = {333, 25000}
		};
		[LEGENDARY] = {
			shuffle_chance = 10;
			success = 10;
			broke = 50;
			catas = {[22396] = 100, [22397] = 100, [28777] = 100, [28789] = 100, [28784] = 70, [28679] = 70, [28785] = 50, [28699] = 50, [28788] = 20, [28781] = 10, [28689] = 20, [28793] = 10, [27207] = 1};
			prefix = 'legendary';
			extra = {20, 35};
			stats_chance = {1000000, 1000000}
		};
	};
	modfiers = {
		[2135] = {broke = 10; success = 20};
		[2136] = {broke = 15; success = 30};
	}
}

local random = math.random
local insert = table.insert
local concat = table.concat

local prefixes  = {
	'fortified',
	'sharpened',
	'accurate',
	'powerful',
	'balanced',
	'flawless',
	'charged',
	'unique',
	'amplified'
}

local stats = {
	[WEAPON_SHIELD] = {
		{ITEM_ATTRIBUTE_DEFENSE, {name = 'def', prefix = prefixes[1], percent = {7, 25}}};
	};

	[WEAPON_DISTANCE] = {
		{ITEM_ATTRIBUTE_ATTACK, {name = 'atk', prefix = prefixes[2], percent = {7, 25}}};
		{ITEM_ATTRIBUTE_HITCHANCE, {name = 'accuracy', prefix = prefixes[3], percent = {10, 25}}};
		{ITEM_ATTRIBUTE_SHOOTRANGE, {name = 'range', prefix = prefixes[4], percent = {17, 34}}};
	};

	[WEAPON_SWORD] = {
		{ITEM_ATTRIBUTE_ATTACK, {name = 'atk', prefix = prefixes[2], percent = {7, 25}}};
		{ITEM_ATTRIBUTE_DEFENSE, {name = 'def', prefix = prefixes[1], percent = {7, 25}}};
	};

	[WEAPON_AXE] = {
		{ITEM_ATTRIBUTE_ATTACK, {name = 'atk', prefix = prefixes[2], percent = {7, 25}}};
		{ITEM_ATTRIBUTE_DEFENSE, {name = 'def', prefix = prefixes[1], percent = {7, 25}}};
	};

	[WEAPON_CLUB] = {
		{ITEM_ATTRIBUTE_ATTACK, {name = 'atk', prefix = prefixes[2], percent = {7, 25}}};
		{ITEM_ATTRIBUTE_DEFENSE,  {name = 'def', prefix = prefixes[1], percent = {7, 25}}};
	};

	[WEAPON_WAND] = {
		{ITEM_ATTRIBUTE_SPELLAMP, {name = 'amplify',prefix = prefixes[9], percent = {200, 250}}};
	};

	[ARMOR] = {
		{ITEM_ATTRIBUTE_ARMOR, {name = 'arm', prefix = prefixes[6], percent = {7, 20}}};
	};

	[CHARGES] = {
		{ITEM_ATTRIBUTE_CHARGES, {name = 'charges', prefix = prefixes[7], percent = {30, 45}}}
	};

	[TRANSFORM] = {
		{ITEM_ATTRIBUTE_DURATION, {name = 'time', prefix = prefixes[8], percent = {35, 50}}}
	}
}

local function get_current_tier(name)
	for i = 1, #prefixes do
		for k, v in pairs(tier_prefixes) do
			if name:find(prefixes[i]) and name:find('['..k..']') then
				return v
			end
		end
	end
	return -1
end

local function look_arr(arr, id)
	for _, t in pairs(arr) do
		if t == id then
			return true
		end
	end
	return false
end

local function stat_get_duration(item)
	local tid = ItemType(item.itemid):getTransformEquipId()
	if tid > 0 then
		item:transform(tid)
		local vx = item:getAttribute(ITEM_ATTRIBUTE_DURATION)
		item:transform(item.itemid)
		item:removeAttribute(ITEM_ATTRIBUTE_DURATION)
		return vx
	end
	return 0
end

local function attr_to_val(item, attr)
	local it = ItemType(item.itemid)
	local v = {
		[ITEM_ATTRIBUTE_ATTACK] = it:getAttack(),
		[ITEM_ATTRIBUTE_DEFENSE] = it:getDefense(),
		[ITEM_ATTRIBUTE_EXTRADEFENSE] = it:getExtraDefense(),
		[ITEM_ATTRIBUTE_ARMOR] = it:getArmor(),
		[ITEM_ATTRIBUTE_HITCHANCE] = it:getHitChance(),
		[ITEM_ATTRIBUTE_SHOOTRANGE] = it:getShootRange(),
		[ITEM_ATTRIBUTE_CHARGES] = it:getCharges(),
		[ITEM_ATTRIBUTE_DURATION] = stat_get_duration(item),
	}
	return v[attr]
end

local function is_item_in_place(pos, id, amount)
	local tile = Tile(pos)
	if not tile:getItemById(id) then
		return false, id, amount
	end
	local c = tile:getItemCountById(id)
	if c < amount then
		return false, id, amount-c
	end
	return true
end

local function clear_item_attrs(item)
	local it = ItemType(item.itemid)
	item:setAttribute(ITEM_ATTRIBUTE_NAME, it:getName())
	item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, it:getDescription())
end

local do_op = {
	[OP_CATA] = function(tier, wt, item, catas)
		local tile = Tile(cfg.pos.catas)
		local removed = {}
		for k, v in pairs(tile:getItems()) do
			if catas[v.itemid] then
				if not removed[v.itemid] then
					removed[v.itemid] = 0 
				end
				if removed[v.itemid] <= catas[v.itemid] then
					v:remove(1)
					removed[v.itemid] = removed[v.itemid] + 1
				end
			end
		end
		Position(cfg.pos.catas):sendMagicEffect(CONST_ME_BLOCKHIT)
	end;

	[OP_SUCCESS] = function(tier, wt, item, catas)
		local stat = stats[wt]
		local t = cfg.forge[tier]
		local stats_used = {}
		for j = 1, #t.stats_chance do
			if random(1, 100000) <= t.stats_chance[j] then
				::retry::
				local selected = random(1, #stat)
				if look_arr(stats_used, stat[selected]) then
					if #stat > 1 then
						goto retry
					end
				else
					insert(stats_used, stat[selected])
				end
			end
		end
		if #stats_used == 0 then
			return
		end
		local stat_desc = {}
		clear_item_attrs(item)
		for i = 1,#stats_used do
			local v = random(stats_used[i][2].percent[1], stats_used[i][2].percent[2]) + random(t.extra[1], t.extra[2])
			if wt == WEAPON_WAND then
				item:setAttribute(stats_used[i][1], v)
			else
				local basestat = attr_to_val(item, stats_used[i][1])
				item:setAttribute(stats_used[i][1], basestat + math.abs(basestat * v / 100))
			end
				insert(stat_desc, '[' .. stats_used[i][2].name .. ': +' .. v .. '%]')
		end
		local it = ItemType(item.itemid)
		if t.showattr then
			for stat = 1, #stats_used do
				item:setAttribute(ITEM_ATTRIBUTE_NAME, "[" .. stats_used[stat][2].prefix .. "] " .. item:getAttribute(ITEM_ATTRIBUTE_NAME))
			end
			item:setAttribute(ITEM_ATTRIBUTE_NAME, item:getAttribute(ITEM_ATTRIBUTE_NAME) .. " " .. it:getName())
		else
			item:setAttribute(ITEM_ATTRIBUTE_NAME, t.prefix .. " " .. it:getName())
		end
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, concat(stat_desc, "\n"))
		local tile = Tile(cfg.pos.catas)
		local removed = {}
		for k, v in pairs(tile:getItems()) do
			if catas[v.itemid] then
				if not removed[v.itemid] then
					removed[v.itemid] = 0 
				end
				if removed[v.itemid] <= catas[v.itemid] then
					v:remove(1)
					removed[v.itemid] = removed[v.itemid] + 1
				end
			end
		end
		Position(cfg.pos.item):sendMagicEffect(random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
		Position(cfg.pos.catas):sendMagicEffect(CONST_ME_BLOCKHIT)
	end;

	[OP_BROKE] = function(tier, wt, item, catas)
		local tile = Tile(cfg.pos.catas)
		local removed = {}
		for k, v in pairs(tile:getItems()) do
			if catas[v.itemid] then
				if not removed[v.itemid] then
					removed[v.itemid] = 0 
				end
				if removed[v.itemid] <= catas[v.itemid] then
					v:remove(1)
					removed[v.itemid] = removed[v.itemid] + 1
				end
			end
		end
		item:remove(1)
		Position(cfg.pos.catas):sendMagicEffect(CONST_ME_BLOCKHIT)
		Position(cfg.pos.item):sendMagicEffect(CONST_ME_BLOCKHIT)
	end
}

local function apply_modifiers(tier)
	local t = cfg.forge[tier]
	local tile = Tile(cfg.pos.modfi)
	local items_used = {}
	local success, broke = t.success, t.broke
	for k, v in pairs(tile:getItems()) do
		local mod = cfg.modfiers[v.itemid]
		if mod and not items_used[v.itemid] then
			items_used[v.itemid] = v
			success = success + mod.success
			broke = broke + mod.broke
		end
	end
	return success, broke, items_used
end

local function shuffle_op(tier)
	local n = random(1, 10000)
	local op = OP_CATA
	local success, broke, items = apply_modifiers(tier)
	-- choose which chance is the lowest first
	if success < broke then
		if n < success * 100 then
			op = OP_SUCCESS
		elseif n < broke * 100 then
			op = OP_BROKE
		end
	else
		if n < broke * 100 then
			op = OP_BROKE
		elseif n < success * 100 then
			op = OP_SUCCESS
		end
	end
	return op, items
end

local function shuffle_tier()
	local n = random(1, 10000)
	for i = RARE, LEGENDARY do
		if cfg.forge[i].shuffle_chance * 100 <= n then
			return i;
		end
	end
	return RARE
end

local function get_index(it)
	if it:getArmor() > 0 then
		return ARMOR
	elseif it:getCharges() > 0 then
		return CHARGES
	elseif it:getTransformEquipId() > 0 then
		return TRANSFORM
	end
	return nil
end

local catas_pos = cfg.pos.catas
local item_pos = cfg.pos.item
local forge_table = cfg.forge

local function get_catas(str)
	local tier = get_current_tier(str)
	if tier == -1 then
		return cfg.catas
	elseif tier == RARE then
		return forge_table[RARE].catas
	elseif tier == EPIC then
		return forge_table[EPIC].catas
	elseif tier == LEGENDARY then
		return forge_table[LEGENDARY].catas
	end
	return nil
end

local op_to_msg = {
	[OP_BROKE] = "your item broke";
	[OP_CATA] = "your catalysts broke";
	[OP_SUCCESS] = "your item changed";
}

function onUse(player, item)
	local up = Tile(item_pos):getTopDownItem()
	if not up then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "There is no item for upgrade in position.")
		return false
	end
	local it = ItemType(up.itemid)
	if it:isStackable() then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "This item cannot have an upgrade.")
		return false
	end
	local wt = it:getWeaponType()
	if wt == WEAPON_NONE then
		wt = get_index(it)
		if not wt then
			player:sendTextMessage(MESSAGE_EVENT_ORANGE, "This item cannot have an upgrade.")
			return false
		end
	end
	local tier = shuffle_tier()
	local str = item:getAttribute(ITEM_ATTRIBUTE_NAME) .. ' ' .. item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
	local catas_t = get_catas(str)
	local missing_catas = {len = 0}
	for k, v in pairs(catas_t) do
		local ok, id, amount = is_item_in_place(catas_pos, k, v)
		if not ok then
			missing_catas[id] = amount
			missing_catas.len = missing_catas.len + 1
		end
	end
	if missing_catas.len > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "There is not enough catalysts.")
		for k, v in pairs(missing_catas) do
			if k ~= 'len' then
				player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Missing "..v.." "..ItemType(k):getName())
			end
		end
		return false
	end
	local op, modfiers = shuffle_op(tier)
	local mod_used = {['success'] = 0, ['broke'] = 0, names = {}}
	local size = 0
	for k,v in pairs(modfiers) do
		local it = cfg.modfiers[k]
		mod_used.success = mod_used.success + it.success
		local name = v:getName()
		insert(mod_used.names, name)
		mod_used.broke = mod_used.broke + it.broke
		v:remove(1)
		size = size + 1
		Position(cfg.pos.modfi):sendMagicEffect(CONST_ME_POFF)
	end
	if size > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "you have chance modifiers used: " .. concat(mod_used.names, ", "))
		if mod_used.success ~= 0 or mod_used.broke ~= 0 then
			player:sendTextMessage(MESSAGE_EVENT_ORANGE, "your success chance was increased by: "..mod_used.success.."%")
			player:sendTextMessage(MESSAGE_EVENT_ORANGE, "your broke chance was increased by: "..mod_used.broke.."%")
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, "no modifiers items used")
	end
	player:sendTextMessage(MESSAGE_EVENT_ORANGE, op_to_msg[op])
	do_op[op](tier, wt, up, catas_t)
	-- item:transform() switch lever side
	return true
end
