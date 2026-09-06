-- ============================================================================
-- 个人配置：手动阵容 + 专属出装
--
-- 这个文件是你唯一需要改的地方。它同时被
--   · hero_selection.lua 读取（决定选什么英雄）
--   · FunLib/jmz_func.lua 读取（决定出什么装备）
--
-- 规则：
--   1. 在 tForceLineup 里指定位置的英雄，才会被强制选中
--   2. 只有被强制选中的英雄，才会套用 tItemBuilds 里的出装
--   3. 没指定（nil）的位置照常随机选人，随机到的英雄照常用 BotLib 里的默认出装
--   4. 加点和天赋完全不受影响，走的还是 BotLib/hero_xxx.lua 里的原始配置
-- ============================================================================

local X = {}

-- 总开关：false 时整个文件不生效，一切照旧
X.bForceLineup = true

-- 只作用于某一队。TEAM_RADIANT / TEAM_DIRE；填 nil 则两队都生效
X.nForceLineupTeam = TEAM_RADIANT

-- 手动阵容：按位置填英雄代码名
-- 1 = 优势路大哥   2 = 中单   3 = 劣势路   4 = 游走辅助   5 = 硬辅
-- 不需要指定的位置保持 nil，那个位置就会走原来的自动选人
X.tForceLineup = {
	[1] = 'npc_dota_hero_bristleback', -- 'npc_dota_hero_antimage',
	[2] = 'npc_dota_hero_shredder', -- 'npc_dota_hero_zuus',
	[3] = 'npc_dota_hero_abaddon', -- 'npc_dota_hero_axe',
	[4] = 'npc_dota_hero_skeleton_king', -- 'npc_dota_hero_lion',
	[5] = 'npc_dota_hero_centaur', -- 'npc_dota_hero_crystal_maiden',
}

-- tanky heroes
-- X.tTankyHeroes = {
-- 	'npc_dota_hero_bristleback',
-- 	'npc_dota_hero_shredder',
-- 	'npc_dota_hero_centaur',
-- 	'npc_dota_hero_abaddon',
--     'npc_dota_hero_skeleton_king'
-- }

-- 专属出装：按英雄代码名索引
--   base_pos  : 可选，见下方说明
--   buy_list  : 出装顺序，从前往后买（必须写 item_xxx 内部名）
--   sell_list : 两两成对 {要卖掉的, 一旦有了它就卖}，可以不写
-- 只有上面 tForceLineup 里登记过的英雄才会生效
--
-- 关于 base_pos：有的英雄在某个位置根本没有构建（例如骷髅王只有 pos_1 / pos_3，
-- 没有 pos_4）。硬把它放到没有构建的位置，该英雄的脚本会直接报错，结果是一件
-- 装备都不买。这时填 base_pos 让它借用别的位置的加点和天赋，出装仍用你这套。
X.tItemBuilds = {
    ['npc_dota_hero_bristleback'] = {
		buy_list = {
            "item_boots_of_bearing",
            "item_crimson_guard",
            "item_shivas_guard",
            "item_assault",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_sphere",
            "item_ultimate_scepter_2",
            "item_lotus_orb",
            "item_moon_shard",
		}
	},

    ['npc_dota_hero_shredder'] = {
		buy_list = {
            "item_guardian_greaves",
            "item_bloodstone",
            "item_pipe",
            "item_wind_waker",
            "item_shivas_guard",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_ultimate_scepter_2",
            "item_lotus_orb",
            "item_moon_shard",
		}
	},

    ['npc_dota_hero_abaddon'] = {
		buy_list = {
            "item_boots",
            "item_vladmir",
            "item_pipe",
            "item_skadi",
            "item_radiance",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_travel_boots_2",
            "item_ultimate_scepter_2",
            "item_assault",
            "item_moon_shard",
		}
	},

    ['npc_dota_hero_skeleton_king'] = {
		buy_list = {
            "item_boots",
            "item_crimson_guard",
            "item_desolator",
            "item_radiance",
            "item_assault",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_travel_boots_2",
            "item_ultimate_scepter_2",
            "item_bloodthorn",
            "item_moon_shard",
		}
	},

    ['npc_dota_hero_centaur'] = {
		buy_list = {
            "item_boots",
            "item_crimson_guard",
            "item_pipe",
            "item_shivas_guard",
            "item_lotus_orb",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_travel_boots_2",
            "item_ultimate_scepter_2",
            "item_radiance",
            "item_moon_shard",
		}
	},

	-- 例子（去掉注释即可用）：
	-- ['npc_dota_hero_antimage'] = {
	-- 	buy_list = {
	-- 		"item_tango",
	-- 		"item_double_branches",
	-- 		"item_quelling_blade",
	-- 		"item_circlet",
	-- 		"item_slippers",
	--
	-- 		"item_magic_wand",
	-- 		"item_wraith_band",
	-- 		"item_power_treads",
	-- 		"item_bfury",
	-- 		"item_manta",
	-- 		"item_butterfly",
	-- 		"item_aghanims_shard",
	-- 		"item_abyssal_blade",
	-- 		"item_skadi",
	-- 		"item_moon_shard",
	-- 		"item_monkey_king_bar",
	-- 		"item_ultimate_scepter_2",
	-- 	},
	-- 	sell_list = {
	-- 		"item_wraith_band", "item_abyssal_blade",
	-- 		"item_magic_wand", "item_skadi",
	-- 		"item_power_treads", "item_monkey_king_bar",
	-- 	},
	-- },
}

-- 判断某个英雄是否被手动指定，是则返回它的专属出装，否则返回 nil
function X.GetItemBuild( sHeroName, nTeam )

	if not X.bForceLineup then return nil end

	if X.nForceLineupTeam ~= nil
	and X.nForceLineupTeam ~= nTeam
	then
		return nil
	end

	for pos = 1, 5
	do
		if X.tForceLineup[pos] == sHeroName
		then
			return X.tItemBuilds[sHeroName]
		end
	end

	return nil
end

-- 判断某个英雄是否要借用其它位置的加点和天赋（base_pos），不需要则返回 nil
function X.GetBasePos( sHeroName, nTeam )

	if not X.bForceLineup then return nil end

	if X.nForceLineupTeam ~= nil
	and X.nForceLineupTeam ~= nTeam
	then
		return nil
	end

	for pos = 1, 5
	do
		if X.tForceLineup[pos] == sHeroName
		then
			local tBuild = X.tItemBuilds[sHeroName]
			if tBuild ~= nil then return tBuild.base_pos end
		end
	end

	return nil
end

return X
