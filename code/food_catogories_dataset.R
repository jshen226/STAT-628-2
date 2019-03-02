rm(list = ls())
library(jsonlite)
library(dplyr)
library(data.table)

## business subset 
b_sub_train=read.csv("business_subset_train.csv",header = T)

# 1 restaurant 47500/33024+14482=47506
restaurant_train=b_sub_train %>% filter(grepl("restaurants",ignore.case=T,categories))
write.csv(restaurant_train,"restaurant_sub_train.csv")
str(restaurant_train)

# 2 food 30183/17582+6433=24015
food_train=b_sub_train %>% filter(grepl("food",ignore.case=T,categories))
write.csv(food_train,"food_sub_train.csv")
str(food_train)

# 3 bars 12222/7334+1684=9018 (should delete dive bars)
bars_train=b_sub_train %>% filter(grepl("bars",ignore.case=T,categories))
str(bars_train)
write.csv(bars_train,"bars_sub_train.csv")

# 4 american 8987/4456+858=5314
americantraditional_train=b_sub_train %>% filter(grepl("American",ignore.case=T,categories))
str(americantraditional_train)
#there is only american both traditional and new
write.csv(americantraditional_train,"american_sub_train.csv")

# 5 sandwiches 5852/4412+1440=5852
sandwiches_train=b_sub_train %>% filter(grepl("sandwiches",ignore.case=T,categories))
str(sandwiches_train)
write.csv(sandwiches_train,"sandwiches_sub_train.csv")

# 6 coffee and tea 5871/4272+1595=5867
coffeetea_train=b_sub_train %>% filter(grepl("coffee & tea",ignore.case=T,categories))
str(coffeetea_train)
write.csv(coffeetea_train,"coffeetea_sub_train.csv")

# 7 fast food 5775/4249+1526=5775
fastfood_train=b_sub_train %>% filter(grepl("fast food",ignore.case=T,categories))
str(fastfood_train)
write.csv(fastfood_train,"fastfood_sub_train.csv")

# 8 pizza 5478/3761+1717=5478
pizza_train=b_sub_train %>% filter(grepl("pizza",ignore.case=T,categories))
str(pizza_train)
write.csv(pizza_train,"pizza_sub_train.csv")

# 9 breakfast & brunch 4322/3399+923=4322
breakfastbrunch_train=b_sub_train %>% filter(grepl("breakfast & brunch",ignore.case=T,categories))
str(breakfastbrunch_train)
write.csv(breakfastbrunch_train,"breakfastbrunch_sub_train.csv")

# 10 burgers 4344/3343+1001=4344
burgers_train=b_sub_train %>% filter(grepl("burgers",ignore.case=T,categories))
str(burgers_train)
write.csv(burgers_train,"burgers_sub_train.csv")

# 11 specialty food 3866/3140+727=3867
specialtyfood_train=b_sub_train %>% filter(grepl("specialty food",ignore.case=T,categories))
str(specialtyfood_train)
write.csv(specialtyfood_train,"specialtyfood_sub_train.csv")

# 12 italian 3743/2691+1052=3743
italian_train=b_sub_train %>% filter(grepl("italian",ignore.case=T,categories))
str(italian_train)
write.csv(italian_train,"italian_sub_train.csv")

# 13 mexican 3675/2426
mexican_train=b_sub_train %>% filter(grepl("mexican",ignore.case=T,categories))
str(mexican_train)
write.csv(mexican_train,"mexican_sub_train.csv")

# 14 chinese 3739/2303+1254=3557
chinese_train=b_sub_train %>% filter(grepl("chinese",ignore.case=T,categories))
str(chinese_train)
write.csv(chinese_train,"chinese_sub_train.csv")

# 15 desserts 2654/2074+580=2654
desserts_train=b_sub_train %>% filter(grepl("desserts",ignore.case=T,categories))
str(desserts_train)
write.csv(desserts_train,"desserts_sub_train.csv")

# 16 cafes 2702/2068+532=2600
cafes_train=b_sub_train %>% filter(grepl("cafes",ignore.case=T,categories))
str(cafes_train)
write.csv(cafes_train,"cafes_sub_train.csv")

# 17 wine & spirits 1795/1795
winespirits_train=b_sub_train %>% filter(grepl("wine & spirits",ignore.case=T,categories))
str(winespirits_train)
write.csv(winespirits_train,"winespirits_sub_train.csv")

# 18 chicken wings 2133/1672+461=2133
chickenwings_train=b_sub_train %>% filter(grepl("chicken wings",ignore.case=T,categories))
str(chickenwings_train)
write.csv(chichenwings_train,"chickenwings_sub_train.csv")

# 19 salad 2006/1624+382=2006
salad_train=b_sub_train %>% filter(grepl("salad",ignore.case=T,categories))
str(salad_train)
write.csv(salad_train,"salad_sub_train.csv")

# 20 seafood 2157/1550+482=2032
seafood_train=b_sub_train %>% filter(grepl("seafood",ignore.case=T,categories))
str(seafood_train)
write.csv(seafood_train,"seafood_sub_train.csv")

# 21 japanese 2196/1543+652=2195
japanese_train=b_sub_train %>% filter(grepl("japanese",ignore.case=T,categories))
str(japanese_train)
write.csv(japanese_train,"japanese_sub_train.csv")

# 22 ice cream & frozen yogurt 2226/1542+684=2226
icecreamfrozenyogurt_train=b_sub_train %>% filter(grepl("ice cream & frozen yogurt",ignore.case=T,categories))
str(icecreamfrozenyogurt_train)
write.csv(icecreamfrozenyogurt_train,"icecreamfrozenyogurt_sub_train.csv")

# 23 beer 2138/1411+384=1795
beer_train=b_sub_train %>% filter(grepl("beer",ignore.case=T,categories))
str(beer_train)
write.csv(beer_train,"beer_sub_train.csv")

# 24 sushi bars 1808/1294+514=1808
sushibars_train=b_sub_train %>% filter(grepl("sushi bars",ignore.case=T,categories))
str(sushibars_train)
write.csv(sushibars_train,"sushibars_sub_train.csv")

# 25 canadian 1525/1223
canadian_train=b_sub_train %>% filter(grepl("canadian",ignore.case=T,categories))
str(canadian_train)
write.csv(canadian_train,"canadian_sub_train.csv")

# 26 asian fusion 1576/1212
asianfusion_train=b_sub_train %>% filter(grepl("asian fusion",ignore.case=T,categories))
str(asianfusion_train)
write.csv(asianfusion_train,"asianfusion_sub_train.csv")

# 27 delis 1569/1189+380=1569
delis_train=b_sub_train %>% filter(grepl("delis",ignore.case=T,categories))
str(delis_train)
write.csv(delis_train,"delis_sub_train.csv")

# 28 mediterranean 1456/1118
mediterranean_train=b_sub_train %>% filter(grepl("mediterranean",ignore.case=T,categories))
str(mediterranean_train)
write.csv(mediterranean_train,"mediterranean_sub_train.csv")

# 29 juice bars & smoothies 1386/1052
juicebarssmoothies_train=b_sub_train %>% filter(grepl("juice bars & smoothies",ignore.case=T,categories))
str(juicebarssmoothies_train)
write.csv(juicebarssmoothies_train,"juicebarssmoothies_sub_train.csv")

# 30 barbeque 1434/1017+417=1434
barbeque_train=b_sub_train %>% filter(grepl("barbeque",ignore.case=T,categories))
str(barbeque_train)
write.csv(barbeque_train,"barbeque_sub_train.csv")

# 31 steakhouses 1299/988
steakhouses_train=b_sub_train %>% filter(grepl("steakhouses",ignore.case=T,categories))
str(steakhouses_train)
write.csv(steakhouses_train,"steakhouses_sub_train.csv")

# 32 diners 1142/884
diners_train=b_sub_train %>% filter(grepl("diners",ignore.case=T,categories))
str(diners_train)
write.csv(diners_train,"diners_sub_train.csv")

# 33 cocktail bars 989/853
cocktailbars_train=b_sub_train %>% filter(grepl("cocktail bars",ignore.case=T,categories))
str(cocktailbars_train)
write.csv(cocktailbars_train,"cocktailbars_sub_train.csv")

# 34 thai 1199/798+380=1178
thai_train=b_sub_train %>% filter(grepl("thai",ignore.case=T,categories))
str(thai_train)
write.csv(thai_train,"thai_sub_train.csv")

# 35 wine bars 904/793
winebars_train=b_sub_train %>% filter(grepl("wine bars",ignore.case=T,categories))
str(winebars_train)
write.csv(winebars_train,"winebars_sub_train.csv")

# 36 indian 1176/792+384=1176
indian_train=b_sub_train %>% filter(grepl("indian",ignore.case=T,categories))
str(indian_train)
write.csv(indian_train,"indian_sub_train.csv")

# 37 ethnic food 882/755
ethnicfood_train=b_sub_train %>% filter(grepl("ethnic food",ignore.case=T,categories))
str(ethnicfood_train)
write.csv(ethnicfood_train,"ethnicfood_sub_train.csv")

# 38 bakeries 2963/752
bakeries_train=b_sub_train %>% filter(grepl("bakeries",ignore.case=T,categories))
str(bakeries_train)
write.csv(bakeries_train,"bakeries_sub_train.csv")

# 39 vegetarian 868/716
vegetarian_train=b_sub_train %>% filter(grepl("vegetarian",ignore.case=T,categories))
str(vegetarian_train)
write.csv(vegetarian_train,"vegetarian_sub_train.csv")

# 40 vietnamese 1033/665
vietnamese_train=b_sub_train %>% filter(grepl("vietnamese",ignore.case=T,categories))
str(vietnamese_train)
write.csv(vietnamese_train,"vietnamese_sub_train.csv")

# 41 french 836/605
french_train=b_sub_train %>% filter(grepl("french",ignore.case=T,categories))
str(french_train)
write.csv(french_train,"french_sub_train.csv")

# 42 greek 859/598
greek_train=b_sub_train %>% filter(grepl("greek",ignore.case=T,categories))
str(greek_train)
write.csv(greek_train,"greek_sub_train.csv")

# 43 comfort food 702/572
comfortfood_train=b_sub_train %>% filter(grepl("comfort food",ignore.case=T,categories))
str(comfortfood_train)
write.csv(comfortfood_train,"comfortfood_sub_train.csv")

# 44 soup 689/551
soup_train=b_sub_train %>% filter(grepl("soup",ignore.case=T,categories))
str(soup_train)
write.csv(soup_train,"soup_sub_train.csv")

# 45 buffets 725/546
buffets_train=b_sub_train %>% filter(grepl("buffets",ignore.case=T,categories))
str(buffets_train)
write.csv(buffets_train,"buffets_sub_train.csv")

# 46 vegan 659/530
vegan_train=b_sub_train %>% filter(grepl("vegan",ignore.case=T,categories))
str(vegan_train)
write.csv(vegan_train,"vegan_sub_train.csv")

# 47 korean 752/521
korean_train=b_sub_train %>% filter(grepl("korean",ignore.case=T,categories))
str(korean_train)
write.csv(korean_train,"korean_sub_train.csv")

# 48 hot dogs 599/456
hotdogs_train=b_sub_train %>% filter(grepl("hot dogs",ignore.case=T,categories))
str(hotdogs_train)
write.csv(hotdogs_train,"hotdogs_sub_train.csv")

# 49 donuts 624/450
donuts_train=b_sub_train %>% filter(grepl("donuts",ignore.case=T,categories))
str(donuts_train)
write.csv(donuts_train,"donuts_sub_train.csv")

# 50 bagels 490/378
bagels_train=b_sub_train %>% filter(grepl("bagels",ignore.case=T,categories))
str(bagels_train)
write.csv(bagels_train,"bagels_sub_train.csv")

# 51 gastropubs 448/371
gastropubs_train=b_sub_train %>% filter(grepl("gastropubs",ignore.case=T,categories))
str(gastropubs_train)
write.csv(gastropubs_train,"gastropubs_sub_train.csv")




