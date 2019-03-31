rm(list=ls())
library(dplyr)
library(data.table)

b_sub_train=read.csv("business_subset_train.csv",header = T)
restaurants=b_sub_train %>% filter(grepl("restaurants",ignore.case=T,categories))
str(restaurants)
res_id=restaurants$business_id
write.csv(res_id,"res_id.csv")

# 1 american(traditional)
americantraditional_train=b_sub_train %>% filter(grepl("American \\(traditional\\)",ignore.case=T,categories))
str(americantraditional_train)
write.csv(americantraditional_train,"americantraditional_sub_train.csv")

# 2 american(new)
americannew_train=b_sub_train %>% filter(grepl("American \\(new\\)",ignore.case=T,categories))
str(americannew_train)
write.csv(americannew_train,"americannew_sub_train.csv")

# 3 italian 
italian_train=b_sub_train %>% filter(grepl("italian",ignore.case=T,categories))
str(italian_train)
write.csv(italian_train,"italian_sub_train.csv")

# 4 mexican 3666/3675 ######################################
mexican_train=restaurants %>% filter(grepl("mexican",ignore.case=T,categories))
str(mexican_train)
write.csv(mexican_train,"mexican_sub_train.csv")

# 5 chinese 3557/3551###############################
chinese_train=restaurants %>% filter(grepl("chinese",ignore.case = T,categories))
str(chinese_train)
write.csv(chinese_train,"chinese_sub_train.csv")

# 6 japanese
japanese_train=restaurants %>% filter(grepl("japanese",ignore.case=T,categories))
str(japanese_train)
write.csv(japanese_train,"japanese_sub_train.csv")

# 7 canadian(new) 
canadian_train=restaurants %>% filter(grepl("canadian \\(new\\)",ignore.case=T,categories))
str(canadian_train)
write.csv(canadian_train,"canadian_sub_train.csv")

# 8 thai
thai_train=restaurants %>% filter(grepl("thai",ignore.case=T,categories))
str(thai_train)
write.csv(thai_train,"thai_sub_train.csv")

# 9 indian
indian_train=restaurants %>% filter(grepl("indian",ignore.case=T,categories))
str(indian_train)
write.csv(indian_train,"indian_sub_train.csv")

# 10 vietnamese
vietnamese_train=restaurants %>% filter(grepl("vietnamese",ignore.case=T,categories))
str(vietnamese_train)
write.csv(vietnamese_train,"vietnamese_sub_train.csv")

# 11 greek 
greek_train=restaurants %>% filter(grepl("greek",ignore.case=T,categories))
str(greek_train)
write.csv(greek_train,"greek_sub_train.csv")

# 12 french
french_train=restaurants %>% filter(grepl("french",ignore.case=T,categories))
str(french_train)
write.csv(french_train,"french_sub_train.csv")

# 13 korean
korean_train=restaurants %>% filter(grepl("korean",ignore.case=T,categories))
str(korean_train)
write.csv(korean_train,"korean_sub_train.csv")

# 14 caribbean
caribbean_train=restaurants %>% filter(grepl("caribbean",ignore.case=T,categories))
str(caribbean_train)
write.csv(caribbean_train,"caribbean_sub_train.csv")

# 15 latin american
latinamerican_train=restaurants %>% filter(grepl("latin american",ignore.case=T,categories))
str(latinamerican_train)
write.csv(latinamerican_train,"latinamerican_sub_train.csv")

# 16 pakistani
pakistani_train=restaurants %>% filter(grepl("pakistani",ignore.case=T,categories))
str(pakistani_train)
write.csv(pakistani_train,"pakistani_sub_train.csv")

# 17 hawaiian
hawaiian_train=restaurants %>% filter(grepl("hawaiian",ignore.case=T,categories))
str(hawaiian_train)
write.csv(hawaiian_train,"hawaiian_sub_train.csv")

# 18 portuguese
portuguese_train=restaurants %>% filter(grepl("portuguese",ignore.case=T,categories))
str(portuguese_train)
write.csv(portuguese_train,"portuguese_sub_train.csv")

# 19 lebanese
lebanese_train=restaurants %>% filter(grepl("lebanese",ignore.case=T,categories))
str(lebanese_train)
write.csv(lebanese_train,"lebanese_sub_train.csv")

# 20 filipino
filipino_train=restaurants %>% filter(grepl("filipino",ignore.case=T,categories))
str(filipino_train)
write.csv(filipino_train,"filipino_sub_train.csv")

# 21 taiwanese 183/182 ########################333
taiwanese_train=restaurants %>% filter(grepl("taiwanese",ignore.case=T,categories))
str(taiwanese_train)
write.csv(taiwanese_train,"taiwanese_sub_train.csv")

# 22 modern european
moderneuropean_train=restaurants %>% filter(grepl("modern european",ignore.case=T,categories))
str(moderneuropean_train)
write.csv(moderneuropean_train,"moderneuropean_sub_train.csv")

# 23 irish include irish and irish pub
irish_train=restaurants %>% filter(grepl("irish",ignore.case=T,categories))
str(irish_train)
write.csv(irish_train,"irish_sub_train.csv")

# 24 spanish
spanish_train=restaurants %>% filter(grepl("spanish",ignore.case=T,categories))
str(spanish_train)
write.csv(spanish_train,"spanish_sub_train.csv")

# 25 persian/iranian
persianiranian_train=restaurants %>% filter(grepl("persian/iranian",ignore.case=T,categories))
str(persianiranian_train)
write.csv(persianiranian_train,"persianiranian_sub_train.csv")

# 26 african
african_train=restaurants %>% filter(grepl("african",ignore.case=T,categories))
str(african_train)
write.csv(african_train,"african_sub_train.csv")

# 27 british
british_train=restaurants %>% filter(grepl("british",ignore.case=T,categories))
str(british_train)
write.csv(british_train,"british_sub_train.csv")

# 28 turkish
turkish_train=restaurants %>% filter(grepl("turkish",ignore.case=T,categories))
str(turkish_train)
write.csv(turkish_train,"turkish_sub_train.csv")

# 29 afghan
afghan_train=restaurants %>% filter(grepl("afghan",ignore.case=T,categories))
str(afghan_train)
write.csv(afghan_train,"afghan_sub_train.csv")

# 30 cantonese
cantonese_train=restaurants %>% filter(grepl("cantonese",ignore.case=T,categories))
str(cantonese_train)
write.csv(cantonese_train,"cantonese_sub_train.csv")

# 31 peruvian
peruvian_train=restaurants %>% filter(grepl("peruvian",ignore.case=T,categories))
str(peruvian_train)
write.csv(peruvian_train,"peruvian_sub_train.csv")

# 32 german
german_train=restaurants %>% filter(grepl("german",ignore.case=T,categories))
str(german_train)
write.csv(german_train,"german_sub_train.csv")

# 33 szechuan 81/79
szechuan_train=restaurants %>% filter(grepl("szechuan",ignore.case=T,categories))
str(szechuan_train)
write.csv(szechuan_train,"szechuan_sub_train.csv")

# 34 brazilian
brazilian_train=restaurants %>% filter(grepl("brazilian",ignore.case=T,categories))
str(brazilian_train)
write.csv(brazilian_train,"brazilian_sub_train.csv")

# 35 ethiopian
ethiopian_train=restaurants %>% filter(grepl("ethiopian",ignore.case=T,categories))
str(ethiopian_train)
write.csv(ethiopian_train,"ethiopian_sub_train.csv")

# 36 malaysian
malaysian_train=restaurants %>% filter(grepl("malaysian",ignore.case=T,categories))
str(malaysian_train)
write.csv(malaysian_train,"malaysian_sub_train.csv")

# 37 moroccan
moroccan_train=restaurants %>% filter(grepl("moroccan",ignore.case=T,categories))
str(moroccan_train)
write.csv(moroccan_train,"moroccan_sub_train.csv")

# 38 salvadoran
salvadoran_train=restaurants %>% filter(grepl("salvadoran",ignore.case=T,categories))
str(salvadoran_train)
write.csv(salvadoran_train,"salvadoran_sub_train.csv")

# 39 cuban
cuban_train=restaurants %>% filter(grepl("cuban",ignore.case=T,categories))
str(cuban_train)
write.csv(cuban_train,"cuban_sub_train.csv")

# 40 arabian
arabian_train=restaurants %>% filter(grepl("arabian",ignore.case=T,categories))
str(arabian_train)
write.csv(arabian_train,"arabian_sub_train.csv")

# 41 russian
russian_train=restaurants %>% filter(grepl("russian",ignore.case=T,categories))
str(russian_train)
write.csv(russian_train,"russian_sub_train.csv")

# 42 new mexican cuisine
newmexicancuisine_train=restaurants %>% filter(grepl("new mexican cuisine",ignore.case=T,categories))
str(newmexicancuisine_train)
write.csv(newmexicancuisine_train,"newmexicancuisine_sub_train.csv")

# 43 mongolian
mongolian_train=restaurants %>% filter(grepl("mongolian",ignore.case=T,categories))
str(mongolian_train)
write.csv(mongolian_train,"mongolian_sub_train.csv")

# 44 belgian
belgian_train=restaurants %>% filter(grepl("belgian",ignore.case=T,categories))
str(belgian_train)
write.csv(belgian_train,"belgian_sub_train.csv")

# 45 colombian
colombian_train=restaurants %>% filter(grepl("colombian",ignore.case=T,categories))
str(colombian_train)
write.csv(colombian_train,"colombian_sub_train.csv")

# 46 argentine
argentine_train=restaurants %>% filter(grepl("argentine",ignore.case=T,categories))
str(argentine_train)
write.csv(argentine_train,"argentine_sub_train.csv")

# 47 cambodian
cambodian_train=restaurants %>% filter(grepl("cambodian",ignore.case=T,categories))
str(cambodian_train)
write.csv(cambodian_train,"cambodian_sub_train.csv")

# 48 sri lankan
srilankan_train=restaurants %>% filter(grepl("sri lankan",ignore.case=T,categories))
str(srilankan_train)
write.csv(srilankan_train,"srilankan_sub_train.csv")

# 49 singaporean
singaporean_train=restaurants %>% filter(grepl("singaporean",ignore.case=T,categories))
str(singaporean_train)
write.csv(singaporean_train,"singaporean_sub_train.csv")

# 50 basque
basque_train=restaurants %>% filter(grepl("basque",ignore.case=T,categories))
str(basque_train)
write.csv(basque_train,"basque_sub_train.csv")

# 51 hungarian
hungarian_train=restaurants %>% filter(grepl("hungarian",ignore.case=T,categories))
str(hungarian_train)
write.csv(hungarian_train,"hungarian_sub_train.csv")

# 52 venezuelan
venezuelan_train=restaurants %>% filter(grepl("venezuelan",ignore.case=T,categories))
str(venezuelan_train)
write.csv(venezuelan_train,"venezuelan_sub_train.csv")

# 53 laotian
laotian_train=restaurants %>% filter(grepl("laotian",ignore.case=T,categories))
str(laotian_train)
write.csv(laotian_train,"laotian_sub_train.csv")

# 54 indonesian
indonesian_train=restaurants %>% filter(grepl("indonesian",ignore.case=T,categories))
str(indonesian_train)
write.csv(indonesian_train,"indonesian_sub_train.csv")

# 55 ukrainian
ukrainian_train=restaurants %>% filter(grepl("ukrainian",ignore.case=T,categories))
str(ukrainian_train)
write.csv(ukrainian_train,"ukrainian_sub_train.csv")

# 56 egyptian
egyptian_train=restaurants %>% filter(grepl("egyptian",ignore.case=T,categories))
str(egyptian_train)
write.csv(egyptian_train,"egyptian_sub_train.csv")

# 57 south african
southafrican_train=restaurants %>% filter(grepl("south african",ignore.case=T,categories))
str(southafrican_train)
write.csv(southafrican_train,"southafrican_sub_train.csv")

# 58 bangladeshi
bangladeshi_train=restaurants %>% filter(grepl("bangladeshi",ignore.case=T,categories))
str(bangladeshi_train)
write.csv(bangladeshi_train,"bangladeshi_sub_train.csv")

# 59 dominican
dominican_train=restaurants %>% filter(grepl("dominican",ignore.case=T,categories))
str(dominican_train)
write.csv(dominican_train,"dominican_sub_train.csv")

# 60 haitian
haitian_train=restaurants %>% filter(grepl("haitian",ignore.case=T,categories))
str(haitian_train)
write.csv(haitian_train,"haitian_sub_train.csv")

# 61 burmese
burmese_train=restaurants %>% filter(grepl("burmese",ignore.case=T,categories))
str(burmese_train)
write.csv(burmese_train,"burmese_sub_train.csv")

# 62 syrian
syrian_train=restaurants %>% filter(grepl("syrian",ignore.case=T,categories))
str(syrian_train)
write.csv(syrian_train,"syrian_sub_train.csv")

# 63 shanghainese
shanghainese_train=restaurants %>% filter(grepl("shanghainese",ignore.case=T,categories))
str(shanghainese_train)
write.csv(shanghainese_train,"shanghainese_sub_train.csv")

# 64 scandinavian
scandinavian_train=restaurants %>% filter(grepl("scandinavian",ignore.case=T,categories))
str(scandinavian_train)
write.csv(scandinavian_train,"scandinavian_sub_train.csv")

# 65 australian
australian_train=restaurants %>% filter(grepl("australian",ignore.case=T,categories))
str(australian_train)
write.csv(australian_train,"australian_sub_train.csv")

# 66 honduran
honduran_train=restaurants %>% filter(grepl("honduran",ignore.case=T,categories))
str(honduran_train)
write.csv(honduran_train,"honduran_sub_train.csv")

# 67 austrian
austrian_train=restaurants %>% filter(grepl("austrian",ignore.case=T,categories))
str(austrian_train)
write.csv(austrian_train,"austrian_sub_train.csv")

# 68 armenian
armenian_train=restaurants %>% filter(grepl("armenian",ignore.case=T,categories))
str(armenian_train)
write.csv(armenian_train,"armenian_sub_train.csv")

# 69 iberian
iberian_train=restaurants %>% filter(grepl("iberian",ignore.case=T,categories))
str(iberian_train)
write.csv(iberian_train,"iberian_sub_train.csv")

# 70 czech
czech_train=restaurants %>% filter(grepl("czech",ignore.case=T,categories))
str(czech_train)
write.csv(czech_train,"czech_sub_train.csv")

# 71 tuscan
tuscan_train=restaurants %>% filter(grepl("tuscan",ignore.case=T,categories))
str(tuscan_train)
write.csv(tuscan_train,"tuscan_sub_train.csv")

# 72 scottish
scottish_train=restaurants %>% filter(grepl("scottish",ignore.case=T,categories))
str(scottish_train)
write.csv(scottish_train,"scottish_sub_train.csv")

# 73 trinidadian
trinidadian_train=restaurants %>% filter(grepl("trinidadian",ignore.case=T,categories))
str(trinidadian_train)
write.csv(trinidadian_train,"trinidadian_sub_train.csv")

# 74 sicilian
sicilian_train=restaurants %>% filter(grepl("sicilian",ignore.case=T,categories))
str(sicilian_train)
write.csv(sicilian_train,"sicilian_sub_train.csv")

# 75 slovalian
slovalian_train=restaurants %>% filter(grepl("slovalian",ignore.case=T,categories))
str(slovalian_train)
write.csv(slovalian_train,"slovalian_sub_train.csv")

# 76 uzbek
uzbek_train=restaurants %>% filter(grepl("uzbek",ignore.case=T,categories))
str(uzbek_train)
write.csv(uzbek_train,"uzbek_sub_train.csv")

# 77 mauritius
mauritius_train=restaurants %>% filter(grepl("mauritius",ignore.case=T,categories))
str(mauritius_train)
write.csv(mauritius_train,"mauritius_sub_train.csv")

# 78 guamanian
guamanian_train=restaurants %>% filter(grepl("guamanian",ignore.case=T,categories))
str(guamanian_train)
write.csv(guamanian_train,"guamanian_sub_train.csv")

# 79 nicaraguan
nicaraguan_train=restaurants %>% filter(grepl("nicaraguan",ignore.case=T,categories))
str(nicaraguan_train)
write.csv(nicaraguan_train,"nicaraguan_sub_train.csv")

# 80 calabrian
calabrian_train=restaurants %>% filter(grepl("calabrian",ignore.case=T,categories))
str(calabrian_train)
write.csv(calabrian_train,"calabrian_sub_train.csv")

# 81 bulgarian
bulgarian_train=restaurants %>% filter(grepl("bulgarian",ignore.case=T,categories))
str(bulgarian_train)
write.csv(bulgarian_train,"bulgarian_sub_train.csv")

# 82 hainan
hainan_train=restaurants %>% filter(grepl("hainan",ignore.case=T,categories))
str(hainan_train)
write.csv(hainan_train,"hainan_sub_train.csv")

# 83 czech/slovakian
czechslovakian_train=restaurants %>% filter(grepl("czech/slovakian",ignore.case=T,categories))
str(czechslovakian_train)
write.csv(czechslovakian_train,"czechslovakian_sub_train.csv")

# 84 senegalese
senegalese_train=restaurants %>% filter(grepl("senegalese",ignore.case=T,categories))
str(senegalese_train)
write.csv(senegalese_train,"senegalese_sub_train.csv")

# 85 eastern european
easterneuropean_train=restaurants %>% filter(grepl("eastern european",ignore.case=T,categories))
str(easterneuropean_train)
write.csv(easterneuropean_train,"easterneuropean_sub_train.csv")

