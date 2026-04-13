local craftRecipes = {
  {
    name = 'chair',
    ingredients = {
      { name = 'wood', count = 4 },
      { name = 'paint', count = 1 },
      { name = 'nail', count = 4 },
    },
  },
  {
    name = 'table',
    ingredients = {
      { name = 'wood', count = 8 },
      { name = 'paint', count = 1 },
      { name = 'nail', count = 4 },
    },
  },
  {
    name = 'halloween costume',
    ingredients = {
      { name = 'pumpkin', count = 1 },
      { name = 'cloth', count = 8 },
    },
  },
  {
    name = 'stone axe',
    ingredients = {
      { name = 'wood', count = 2 },
      { name = 'stone', count = 2 },
    },
  },
}

local craftsByIngredient = {}

function setupCraftsByIngredient()
  craftsByIngredient = {}
  for _, recipe in ipairs(craftRecipes) do
    for _, ingredient in ipairs(recipe.ingredients) do
      local ingredientName = ingredient.name
      if not craftsByIngredient[ingredientName] then
        craftsByIngredient[ingredientName] = {}
      end
      table.insert(craftsByIngredient[ingredientName], recipe)
    end
  end

end

function getRecipes()
  return craftRecipes
end

function getRecipesByIngredientName(name)
  return craftsByIngredient[name] or {}
end

function getAvailableRecipes(ingredients)
  local avaibleQuantityIngredients = {}
  local possibleRecipes = {}
  local availableRecipes = {}

  for _, ingredient in ipairs(ingredients) do
    avaibleQuantityIngredients[ingredient.name] = ingredient.count
  end
  for _, ingredient in ipairs(ingredients) do
    local recipes = getRecipesByIngredientName(ingredient.name)
    for _, recipe in ipairs(recipes) do
      possibleRecipes[recipe.name] = recipe
    end
  end
  for _, recipe in pairs(possibleRecipes) do
    local canCraft = true
    for _, ingredient in ipairs(recipe.ingredients) do
      if not avaibleQuantityIngredients[ingredient.name] or avaibleQuantityIngredients[ingredient.name] < ingredient.count then
        canCraft = false
        break
      end
    end
    if canCraft then
      table.insert(availableRecipes, recipe)
    end
  end
  return availableRecipes
end

function main()
  setupCraftsByIngredient()

  local woodRecipes = getRecipesByIngredientName("wood")
  local pumpkinRecipes = getRecipesByIngredientName("pumpkin")
  local clothRecipes = getRecipesByIngredientName("cloth")
  local stoneRecipes = getRecipesByIngredientName("stone")
  local nailRecipes = getRecipesByIngredientName("nail")
  local paintRecipes = getRecipesByIngredientName("paint")
  local availableRecipes = getAvailableRecipes({
    { name = 'wood', count = 5 },
    { name = 'nail', count = 4 },
    { name = 'paint', count = 30 },
  })
  print("\nWood recipes:")
  printRecipes(woodRecipes)
  print("\nAvailable recipes:")
  --[[
  printRecipes(availableRecipes)
  print("\nStone recipes:")
  printRecipes(stoneRecipes)
  print("\nPumpkin recipes:")
  printRecipes(pumpkinRecipes)
  print("\nCloth recipes:")
  printRecipes(clothRecipes)
  print("\nNail recipes:")
  printRecipes(nailRecipes)
  print("\nPaint recipes:")
  printRecipes(paintRecipes)
  ]]
end

function printRecipes(recipes)
  for _, recipe in ipairs(recipes) do
    print(recipe.name)
  end
end

main()
