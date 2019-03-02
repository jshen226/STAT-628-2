rm(list = ls())
library(jsonlite)
library(dplyr)
library(data.table)

b_train=jsonlite::stream_in(file("business_train.json"),pagesize = 100)
str(b_train)
head(b_train)
restaurant_train=b_train %>% filter(grepl("restaurants",ignore.case=T,categories))

## business subset 
b_sub_train=read.csv("business_subset_train.csv",header = T)

# 1 restaurant 47500/33024+14482=47506
restaurant_train=b_sub_train %>% filter(grepl("restaurants",ignore.case=T,categories))
write.csv(restaurant_train,"restaurant_sub_train.csv")
str(restaurant_train)

# 2 shopping 25547/19337+6212=25549
shopping_train=b_sub_train %>% filter(grepl("shopping",ignore.case=T,categories))
write.csv(shopping_train,"shopping_sub_train.csv")
str(shopping_train)

# 3 food 30183/17582+6433=24015
food_train=b_sub_train %>% filter(grepl("food",ignore.case=T,categories))
write.csv(food_train,"food_sub_train.csv")
str(food_train)

# 4 home services 15877/11677+4201=15878
homeservices_train=b_sub_train %>% filter(grepl("home services",ignore.case=T,categories))
str(homeservices_train)
write.csv(homeservices_train,"homeservices_sub_train.csv")

# 5 beauty & spas 15657/10936+4721=15657
beautyspas_train=b_sub_train %>% filter(grepl("beauty & spas",ignore.case=T,categories))
str(beautyspas_train)
write.csv(beautyspas_train,"beautyspas_sub_train.csv")

# 6 health & medical 13869/10210
healthmedical_train=b_sub_train %>% filter(grepl("health & medical",ignore.case=T,categories))
str(healthmedical_train)
write.csv(healthmedical_train,"healthmedical_sub_train.csv")

# 7 local services 11174/8449
localservices_train=b_sub_train %>% filter(grepl("local services",ignore.case=T,categories))
str(localservices_train)
write.csv(localservices_train,"localservices_sub_train.csv")

# 8 nightlife 10443/8242
nightlife_train=b_sub_train %>% filter(grepl("nightlife",ignore.case=T,categories))
str(nightlife_train)
write.csv(nightlife_train,"nightlife_sub_train.csv")

# 9 bars 12222/7334
bars_train=b_sub_train %>% filter(grepl("bars",ignore.case=T,categories))
str(bars_train)
write.csv(bars_train,"bars_sub_train.csv")

# 10 automotive 10653/7296
automotive_train=b_sub_train %>% filter(grepl("automotive",ignore.case=T,categories))
str(automotive_train)
write.csv(automotive_train,"automotive_sub_train.csv")

# 11 event planning & services 8265/6494
eventplanningservices_train=b_sub_train %>% filter(grepl("event planning & services",ignore.case=T,categories))
str(eventplanningservices_train)
write.csv(eventplanningservices_train,"eventplanningservices_sub_train.csv")

# 12 active life 7585/5757
activelife_train=b_sub_train %>% filter(grepl("active life",ignore.case=T,categories))
str(activelife_train)
write.csv(activelife_train,"activelife_sub_train.csv")

# 13 fashion 6235/4933
fashion_train=b_sub_train %>% filter(grepl("fashion",ignore.case=T,categories))
str(fashion_train)
write.csv(fashion_train,"fashion_sub_train.csv")

# 14 american(traditional) 8987/4456
americantraditional_train=b_sub_train %>% filter(grepl("american",ignore.case=T,categories))
str(americantraditional_train)
#there is only american
write.csv(americantraditional_train,"american_sub_train.csv")

# 15 sandwiches 5852/4412
sandwiches_train=b_sub_train %>% filter(grepl("sandwiches",ignore.case=T,categories))
str(sandwiches_train)
write.csv(sandwiches_train,"sandwiches_sub_train.csv")

# 16 coffee and tea 5871/4272
coffeetea_train=b_sub_train %>% filter(grepl("coffee & tea",ignore.case=T,categories))
str(coffeetea_train)
write.csv(coffeetea_train,"coffeetea_sub_train.csv")

# 17 fast food 5775/4249
fastfood_train=b_sub_train %>% filter(grepl("fast food",ignore.case=T,categories))
str(fastfood_train)
write.csv(fastfood_train,"fastfood_sub_train.csv")

# 18 home & garden 5190/4189
homegarden_train=b_sub_train %>% filter(grepl("home & garden",ignore.case=T,categories))
str(homegarden_train)
write.csv(homegarden_train,"homegarden_sub_train.csv")

# 19 professional services 5032/3950
professionalservices_train=b_sub_train %>% filter(grepl("professional services",ignore.case=T,categories))
str(professionalservices_train)
write.csv(professionalservices_train,"professionalservices_sub_train.csv")

# 20 hair salons 5580/3895
hairsalons_train=b_sub_train %>% filter(grepl("hair salons",ignore.case=T,categories))
str(hairsalons_train)
write.csv(hairsalons_train,"hairsalons_sub_train.csv")
