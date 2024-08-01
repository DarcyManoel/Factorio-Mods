script.on_event(defines.events.on_pre_player_crafted_item, function(event)
    local player = game.players[event.player_index]
    InstantCrafting_InitGlobal()
    InstantCrafting_CancelCraft(player)
    InstantCrafting_RemoveIngredients(player)
    InstantCrafting_AddProducts(player)
end)

script.on_event(defines.events.on_player_cancelled_crafting, function(event)
    local player = game.players[event.player_index]
    InstantCrafting_RememberProducts(event.recipe, event.cancel_count)
    InstantCrafting_RememberIngredients(event.items)
end)

function InstantCrafting_InitGlobal()
    global.InstantCrafting = global.InstantCrafting or {}
    global.InstantCrafting.products = {}
    global.InstantCrafting.ingredients = {}
end

function InstantCrafting_CancelCraft(player)
    local craftToCancel = {index = #player.crafting_queue}
    if #player.crafting_queue > 0 then
        craftToCancel.count = player.crafting_queue[craftToCancel.index].count
        player.cancel_crafting(craftToCancel)
    end
end

function InstantCrafting_RememberProducts(recipe, count)
    for _, product in pairs(recipe.products) do
        local productToInsert = {name = product.name}
        productToInsert.count = (product.amount or 1) * count
        table.insert(global.InstantCrafting.products, productToInsert)
    end
end

function InstantCrafting_AddProducts(player)
    for _, product in pairs(global.InstantCrafting.products) do
        player.insert(product)
    end
end

function InstantCrafting_RememberIngredients(items)
    global.InstantCrafting.ingredients = {}
    for item, count in pairs(items.get_contents()) do
        local stack = {name = item, count = count}
        table.insert(global.InstantCrafting.ingredients, stack)
    end
end

function InstantCrafting_RemoveIngredients(player)
    for _, ingredient in pairs(global.InstantCrafting.ingredients) do
        player.remove_item(ingredient)
    end
end
