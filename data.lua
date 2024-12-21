
local item_sounds = require("__base__.prototypes.item_sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require ("__base__.prototypes.entity.sounds")

local graphics = "__snouz-big-substation__/graphics"
local ENTITYPATH = graphics .. "/entity/"


data:extend(
{
  {
    type = "item",
    name = "big-substation",
    icon = graphics .. "/icons/big-substation.png",
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-dd[big-substation]",
    inventory_move_sound = item_sounds.electric_large_inventory_move,
    pick_sound = item_sounds.electric_large_inventory_pickup,
    drop_sound = item_sounds.electric_large_inventory_move,
    place_result = "big-substation",
    stack_size = 10,
    random_tint_color = item_tints.iron_rust,
    weight = 100 * kg
  },

  {
    type = "recipe",
    name = "big-substation",
    energy_required = 90,
    enabled = false,
    ingredients =
    {
      {type = "item", name = "substation", amount = 20},
      {type = "item", name = "concrete", amount = 300},
      {type = "item", name = "steel-plate", amount = 15}
    },
    results = {{type="item", name="big-substation", amount=1}}
  },

  {
    type = "technology",
    name = "electric-energy-distribution-2-big",
    icon = graphics .. "/technology/electric-energy-distribution-2-big.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "big-substation"
      }
    },
    prerequisites = {"electric-energy-distribution-2", "concrete", "utility-science-pack"},
    unit =
    {
      count = 700,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1}
      },
      time = 60
    },
  },

  {
    type = "electric-pole",
    name = "big-substation",
    icon = graphics .. "/icons/big-substation.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "big-substation"},
    fast_replaceable_group = "big-substation",
    max_health = 800,
    corpse = "big-substation-remnants",
    dying_explosion = "substation-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 90
      }
    },
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    damaged_trigger_effect = hit_effects.entity({{-0.5, -2.5}, {0.5, 0.5}}),
    drawing_box_vertical_extension = 2,
    maximum_wire_distance = 25,
    supply_area_distance = 32.5,
    pictures =
    {
      layers =
      {
        {
          filename = ENTITYPATH .. "big-substation.png",
          priority = "high",
          width = 384,
          height = 384,
          direction_count = 1,
          scale = 0.5,
        },
        {
          filename = ENTITYPATH .. "big-substation_shadow.png",
          priority = "high",
          width = 384,
          height = 384,
          direction_count = 1,
          scale = 0.5,
          draw_as_shadow = true,
        }
      }
    },
    impact_category = "metal",
    open_sound = sounds.electric_network_open,
    close_sound = sounds.electric_network_close,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/substation.ogg",
        volume = 0.4
      },
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.32,
      fade_in_ticks = 30,
      fade_out_ticks = 40,
      use_doppler_shift = false
    },
    connection_points = {
      {
        shadow = {
          copper = util.by_pixel(29, -24),
          green = util.by_pixel(42, -26),
          red = util.by_pixel(16, -5)
        },
        wire = {
          copper = util.by_pixel(-3, -54),
          green = util.by_pixel(11, -57),
          red = util.by_pixel(-15, -37)
        }
      },
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
      width = 12,
      height = 12,
      priority = "extra-high-no-scale"
    },
  },


  {
    type = "corpse",
    name = "big-substation-remnants",
    icon = graphics .. "/icons/big-substation.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "energy-pipe-distribution-remnants",
    order = "a-d-a",
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    tile_width = 5,
    tile_height = 5,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = {
      filename = ENTITYPATH .. "big-substation_remnant.png",
      line_length = 1,
      width = 384,
      height = 384,
      frame_count = 1,
      direction_count = 1,
      shift = {0,0},
      scale = 0.5
    }
  },
})

if mods["space-age"] then
  table.insert(data.raw["technology"]["electric-energy-distribution-2-big"].prerequisites, "electromagnetic-science-pack")
  table.insert(data.raw["technology"]["electric-energy-distribution-2-big"].unit.ingredients, {"electromagnetic-science-pack", 1})
  table.insert(data.raw["recipe"]["big-substation"].ingredients, {type = "item", name = "supercapacitor", amount = 10})
end
  