# FoodDeserts

To switch between the food deserts the map shows,

1. Go to line 63 in the ViewController.swift file
2. Change the forResource parameter in the Bundle.main.url method. (guard let url = Bundle.main.url(forResource: "Food_Access_USDA", withExtension: "geojson"))
  If you want to see the Florida Food Deserts, replace the parameter with "FloridaFoodDeserts"
  If you want to see the Baltimore Food Deserts, replace the parameter with "Food_Access_USDA"
  
Note: The map is also zoomed out. If on a virutal machine, make sure to zoom in on the map to the desired region to get a better view of the regions.
