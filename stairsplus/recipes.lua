--[[
More Blocks: Stairs+

Copyright © 2011-2019 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Copy recipe for furnace (the regular recipe must exist at this point!)
local function copy_cooking_recipe(category, alternate, modname, subname, recipeitem)
	local original_output = minetest.get_craft_result({method = "cooking", items = { ItemStack(recipeitem .. " 1")}})
	if original_output.item:is_empty() == true then
		--print("cooking " .. recipeitem .. " does not give anything!")
		return
	end

	local original_destname = original_output.item:get_name()

	-- print("cooking " .. recipeitem .. " produces " .. original_destname)

	local original_destsubname = string.match(original_destname, ":(.+)")
	if original_destsubname == nil then
		print("Warning: could not match subname of " .. original_output.item.get_name())
		return
	end

	local new_recipe = {type = "cooking"}
	new_recipe.recipe = modname .. ":" .. category .. "_" .. subname .. alternate
	new_recipe.output = modname .. ":" .. category .. "_" .. original_destsubname .. alternate

	-- print("created cooking recipe " .. new_recipe.recipe .. " -> " .. new_recipe.output)

	minetest.register_craft(new_recipe)
end

stairsplus.register_recipes = function(category, alternate, modname, subname, recipeitem)
	copy_cooking_recipe(category, alternate, modname, subname, recipeitem)
	if category == "micro" and alternate == "" then
		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 7",
			recipe = {modname .. ":stair_" .. subname .. "_inner"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 6",
			recipe = {modname .. ":stair_" .. subname},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 5",
			recipe = {modname .. ":stair_" .. subname .. "_outer"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 4",
			recipe = {modname .. ":slab_" .. subname},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 4",
			recipe = {modname .. ":stair_" .. subname .. "_alt"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 3",
			recipe = {modname .. ":stair_" .. subname .. "_right_half"},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":micro_" .. subname .. " 2",
			recipe = {modname .. ":panel_" .. subname},
		})

		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
		})

		minetest.register_alias(modname .. ":micro_" .. subname .. "_bottom", modname .. ":micro_" .. subname)
	elseif category == "panel" and alternate == "" then
		minetest.register_craft({
			output = modname .. ":panel_" .. subname .. " 12",
			recipe = {
				{recipeitem, ""},
				{recipeitem, recipeitem},
			},
		})

		minetest.register_craft({
			output = modname .. ":panel_" .. subname .. " 12",
			recipe = {
				{"", recipeitem},
				{recipeitem, recipeitem},
			},
		})

		minetest.register_craft({
			type = "shapeless",
			output = modname .. ":panel_" .. subname,
			recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
		})

		minetest.register_craft({
			type = "shapeless",
			output = recipeitem,
			recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
		})

		minetest.register_alias(modname.. ":panel_" ..subname.. "_bottom", modname.. ":panel_" ..subname)
	elseif category == "slab" then
		if alternate == "" then
			minetest.register_craft({
				output = modname .. ":slab_" .. subname .. " 6",
				recipe = {{recipeitem, recipeitem, recipeitem}},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})

			-- uncomment this rule when conflict is no longer likely to happen
			--	https://github.com/minetest/minetest/issues/2881
			-- minetest.register_craft({
			--	type = "shapeless",
			--	output = modname .. ":slab_" .. subname,
			--	recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
			-- })

			-- then remove these two
			minetest.register_craft({
				output = modname .. ":slab_" .. subname,
				recipe = {{modname .. ":panel_" .. subname, modname .. ":panel_" .. subname}},
			})

			minetest.register_craft({
				output = modname .. ":slab_" .. subname,
				recipe = {
					{modname .. ":panel_" .. subname},
					{modname .. ":panel_" .. subname},
				},
			})
			------------------------------

			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname, modname .. ":slab_" .. subname},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. " 3",
				recipe = {modname .. ":stair_" .. subname, modname .. ":stair_" .. subname},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe = {modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe = {modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_half", modname .. ":slope_" .. subname .. "_inner_half"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_cut_half", modname .. ":slope_" .. subname .. "_inner_cut_half"},
			})
		elseif alternate == "_quarter" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_three_quarter", modname .. ":slab_" .. subname .. "_quarter"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_quarter",
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_quarter",
				recipe = {modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1"},
			})
		elseif alternate == "_three_quarter" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_three_quarter",
				recipe = {modname .. ":slab_" .. subname, modname .. ":slab_" .. subname .. "_quarter"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_three_quarter",
				recipe = {modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter", modname .. ":slab_" .. subname .. "_quarter"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_three_quarter",
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})
		elseif alternate == "_2" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_14", modname .. ":slab_" .. subname .. "_2"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_2",
				recipe = {modname .. ":slab_" .. subname .. "_1", modname .. ":slab_" .. subname .. "_1"},
			})
		elseif alternate == "_14" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_14",
				recipe = {modname .. ":slab_" .. subname .. "_three_quarter", modname .. ":slab_" .. subname .. "_2"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_14",
				recipe = {modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2", modname .. ":slab_" .. subname .. "_2"},
			})
		elseif alternate == "_15" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe = {modname .. ":slab_" .. subname .. "_15", modname .. ":slab_" .. subname .. "_1"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slab_" .. subname .. "_15",
				recipe = {modname .. ":slab_" .. subname .. "_14", modname .. ":slab_" .. subname .. "_1"},
			})
		end
	elseif category == "slope" then
		if alternate == "" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname, modname .. ":slope_" .. subname},
			})
		elseif alternate == "_half" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half_raised"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half",
					modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half"},
			})
		elseif alternate == "_outer" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer", modname .. ":slope_" .. subname .. "_inner"},
			})
		elseif alternate == "_outer_half" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_half", modname .. ":slope_" .. subname .. "_inner_half_raised"},
			})
		elseif alternate == "_inner_half" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_half_raised", modname .. ":slope_" .. subname .. "_inner_half"},
			})
		elseif alternate == "_outer_cut" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_cut", modname .. ":slope_" .. subname .. "_inner_cut"},
			})
		elseif alternate == "_outer_cut_half" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_outer_cut_half", modname .. ":slope_" .. subname .. "_inner_cut_half_raised"},
			})
		elseif alternate == "_cut" then
			minetest.register_craft({
				type = "shapeless",
				output = recipeitem,
				recipe =  {modname .. ":slope_" .. subname .. "_cut", modname .. ":slope_" .. subname .. "_cut"},
			})
		elseif alternate == "_half_raised" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_half_raised",
				recipe =  {modname .. ":slope_" .. subname .. "_half", modname .. ":slope_" .. subname .. "_half",
					modname .. ":slope_" .. subname .. "_half"},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_half_raised",
				recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_half"},
			})
		elseif alternate == "_inner_half_raised" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_inner_half_raised",
				recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_inner_half"},
			})
		elseif alternate == "_outer_half_raised" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_outer_half_raised",
				recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_outer_half"},
			})
		elseif alternate == "_inner_cut_half_raised" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":slope_" .. subname .. "_inner_cut_half_raised",
				recipe =  {modname .. ":slab_" .. subname, modname .. ":slope_" .. subname .. "_inner_cut_half"},
			})
		end
	elseif category == "stair" then
		if alternate == "" then
			minetest.register_craft({
				output = modname .. ":stair_" .. subname .. " 8",
				recipe = {
					{recipeitem, "", ""},
					{recipeitem, recipeitem, ""},
					{recipeitem, recipeitem, recipeitem},
				},
			})

			minetest.register_craft({
				output = modname .. ":stair_" .. subname .. " 8",
				recipe = {
					{"", "", recipeitem},
					{"", recipeitem, recipeitem},
					{recipeitem, recipeitem, recipeitem},
				},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname,
				recipe = {modname .. ":panel_" .. subname, modname .. ":slab_" .. subname},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname,
				recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname,
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname,
				recipe = {modname .. ":panel_" .. subname, modname .. ":panel_" .. subname, modname .. ":panel_" .. subname},
			})
		elseif alternate == "_inner" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_inner",
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})
		elseif alternate == "_outer" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_outer",
				recipe = {modname .. ":micro_" .. subname, modname .. ":slab_" .. subname},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_outer",
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})
		elseif alternate == "_half" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_half",
				recipe = {modname .. ":micro_" .. subname, modname .. ":micro_" .. subname, modname .. ":micro_" .. subname},
			})

			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_half",
				recipe = {modname .. ":panel_" .. subname, modname .. ":micro_" .. subname},
			})
		elseif alternate == "_right_half" then
			minetest.register_craft({
				type = "shapeless",
				output = modname .. ":stair_" .. subname .. "_right_half",
				recipe = {modname .. ":stair_" .. subname .. "_half"},
			})
		elseif alternate == "_alt" then
			minetest.register_craft({ -- See mirrored variation of the recipe below.
				output = modname .. ":stair_" .. subname .. "_alt",
				recipe = {
					{modname .. ":panel_" .. subname, ""},
					{""                            , modname .. ":panel_" .. subname},
				},
			})

			minetest.register_craft({ -- Mirrored variation of the recipe above.
				output = modname .. ":stair_" .. subname .. "_alt",
				recipe = {
					{""                            , modname .. ":panel_" .. subname},
					{modname .. ":panel_" .. subname, ""},
				},
			})
		end
	end
end
