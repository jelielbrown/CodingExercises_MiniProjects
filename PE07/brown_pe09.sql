-- AUTHOR: Jeliel Brown
-- DATE: 11/24/25

-- Task 1

SELECT name
FROM recipe
WHERE source = 'Mom';

-- Task 2

SELECT MIN(cost) AS cheapest, MAX(cost) AS priciest
FROM ingredient
WHERE type = 'herb';

-- Task 3

SELECT recipe.name
FROM recipe
JOIN nutrition ON recipe.recipe_id = nutrition.recipe_id
WHERE nutrition.name = "Calories" AND nutrition.quantity < 800;

-- Task 4

SELECT ingredient.name, ingredient_list.quantity
FROM recipe
JOIN ingredient_list ON recipe.recipe_id = ingredient_list.recipe_id
JOIN ingredient ON ingredient_list.ingredient_id = ingredient.ingredient_id
WHERE recipe.name LIKE '%Beef Parmesan%';

-- Task 5

SELECT CONCAT(nutrition.name, ': ', nutrition.quantity, ' ', nutrition.unit) AS nutrition_badge
FROM nutrition
JOIN recipe ON nutrition.recipe_id = recipe.recipe_id
WHERE recipe.name = 'Linguine Pescadoro';

-- Task 6

SELECT recipe.name
FROM recipe
LEFT JOIN ingredient_list ON recipe.recipe_id = ingredient_list.recipe_id
LEFT JOIN ingredient ON ingredient_list.ingredient_id = ingredient.ingredient_id
AND ingredient.type IN('beef', 'pork', 'chicken', 'lamb')
WHERE ingredient.ingredient_id IS NULL;

-- Task 7

SELECT recipe.name
FROM recipe
JOIN ingredient_list ON recipe.recipe_id = ingredient_list.recipe_id
JOIN ingredient ON ingredient_list.ingredient_id = ingredient.ingredient_id
JOIN nutrition ON recipe.recipe_id = nutrition.recipe_id
WHERE ingredient.type = 'fish' AND nutrition.name = 'calories' AND nutrition.quantity < 700;

-- Task 8

SELECT recipe.name AS vegetable_items
FROM recipe
JOIN ingredient_list ON recipe.recipe_id = ingredient_list.recipe_id
JOIN ingredient ON ingredient.ingredient_id = ingredient.ingredient_id
WHERE ingredient.type = 'vegetable';