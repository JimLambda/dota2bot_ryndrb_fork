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
-- X.nForceLineupTeam = TEAM_RADIANT
X.nForceLineupTeam = nil

-- 让 bots 自己开防御符文（Glyph）。
-- 原版逻辑是「队里只要有一个真人就完全不开」，怕抢了真人的符文。
-- 设成 true 后，即使有真人在场，队里第一个 bot 也会在自己被推时开符文。
-- 设成 false 就恢复原版行为。
X.bGlyphWithHuman = true

-- 开符文的激进度：
--   'normal'  原版：只有敌方英雄正在打塔 / 近战兵营 / 遗迹时才开
--   'creep'   小兵 / 召唤物 / 攻城车在打建筑也算（纯小兵推塔也会开）
--   'panic'   在 creep 基础上再放宽：塔 <55%、兵营和遗迹 <75%，且远程兵营也算
X.sGlyphAggression = 'panic'

-- 手动阵容：按位置填英雄代码名
-- 1 = 优势路大哥   2 = 中单   3 = 劣势路   4 = 游走辅助   5 = 硬辅
-- 不需要指定的位置保持 nil，那个位置就会走原来的自动选人
X.tForceLineup = {
	-- tank heroes
	-- [1] = 'npc_dota_hero_bristleback', -- 'npc_dota_hero_antimage',
	-- [2] = 'npc_dota_hero_shredder', -- 'npc_dota_hero_zuus',
	-- [3] = 'npc_dota_hero_abaddon', -- 'npc_dota_hero_axe',
	-- [4] = 'npc_dota_hero_skeleton_king', -- 'npc_dota_hero_lion',
	-- [5] = 'npc_dota_hero_centaur', -- 'npc_dota_hero_crystal_maiden',

	[1] = 'npc_dota_hero_medusa', -- 'npc_dota_hero_antimage',
	[2] = 'npc_dota_hero_luna', -- 'npc_dota_hero_zuus',
	[3] = 'npc_dota_hero_sniper', -- 'npc_dota_hero_axe',
	[4] = 'npc_dota_hero_drow_ranger', -- 'npc_dota_hero_lion',
	[5] = 'npc_dota_hero_templar_assassin', -- 'npc_dota_hero_crystal_maiden',
}

-- tanky heroes
-- X.tTankyHeroes = {
-- 	'npc_dota_hero_bristleback',
-- 	'npc_dota_hero_shredder',
-- 	'npc_dota_hero_centaur',
-- 	'npc_dota_hero_abaddon',
--     'npc_dota_hero_skeleton_king'
-- }

-- 自动兜底：手动指定的英雄如果在那个位置没有构建（例如骷髅王没有 pos_4），
-- 自动在 1~5 号位里随机挑一个它有构建的位置，用那套加点和天赋。
-- 出装仍然用下面 tItemBuilds 里你写的这套，不受影响。
-- 想自己指定借用哪个位置，就给该英雄填 base_pos（优先级高于自动兜底）。
X.bAutoBasePos = true

-- 专属出装：按英雄代码名索引
--   base_pos  : 可选。手动指定借用哪个位置的加点和天赋，填了就不走自动兜底
--   buy_list  : 出装顺序，从前往后买（必须写 item_xxx 内部名）
--   sell_list : 两两成对 {要卖掉的, 一旦有了它就卖}，可以不写
-- 只有上面 tForceLineup 里登记过的英雄才会生效
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

	-- ===== 远程阵容（当前使用）：每项 8 件，纯大件 =====

    ['npc_dota_hero_medusa'] = {
		buy_list = {
            "item_power_treads",
            "item_manta",
            "item_skadi",
            "item_butterfly",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_ultimate_scepter_2",
            "item_moon_shard",
		}
	},

    ['npc_dota_hero_luna'] = {
		buy_list = {
            "item_power_treads",
            "item_manta",
            "item_butterfly",
            "item_satanic",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_ultimate_scepter_2",
            "item_moon_shard",
		}
	},

    ['npc_dota_hero_sniper'] = {
		buy_list = {
            "item_power_treads",
            "item_hurricane_pike",
            "item_mjollnir",
            "item_greater_crit",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_ultimate_scepter_2",
            "item_moon_shard",
		}
	},

    ['npc_dota_hero_drow_ranger'] = {
		buy_list = {
            "item_power_treads",
            "item_hurricane_pike",
            "item_greater_crit",
            "item_butterfly",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_ultimate_scepter_2",
            "item_moon_shard",
		}
	},

    ['npc_dota_hero_templar_assassin'] = {
		buy_list = {
            "item_phase_boots",
            "item_desolator",
            "item_black_king_bar",
            "item_greater_crit",
            "item_aghanims_shard",
            "item_ultimate_scepter",
            "item_ultimate_scepter_2",
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

-- 某个英雄是否被手动指定过（在 tForceLineup 里登记过）
function X.IsForcedHero( sHeroName, nTeam )

	if not X.bForceLineup then return false end

	if X.nForceLineupTeam ~= nil
	and X.nForceLineupTeam ~= nTeam
	then
		return false
	end

	for pos = 1, 5
	do
		if X.tForceLineup[pos] == sHeroName
		then
			return true
		end
	end

	return false
end

-- 专属出装：只有被手动指定的英雄才会生效
function X.GetItemBuild( sHeroName, nTeam )

	if not X.IsForcedHero( sHeroName, nTeam ) then return nil end

	return X.tItemBuilds[sHeroName]
end

-- 要借用哪个位置的加点和天赋：填了 base_pos 就用它，没填返回 nil（交给自动兜底）
function X.GetBasePos( sHeroName, nTeam )

	if not X.IsForcedHero( sHeroName, nTeam ) then return nil end

	local tBuild = X.tItemBuilds[sHeroName]
	if tBuild ~= nil then return tBuild.base_pos end

	return nil
end

return X
