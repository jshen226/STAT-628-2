rm(list = ls())
library(jsonlite)
library(dplyr)
library(data.table)
library(stringr)

business_train=jsonlite::stream_in(file("business_train.json"),pagesize = 100)
american_traditional_train=read.csv("americantraditional_sub_train.csv",header = T)
american_traditional_id=american_traditional_train$business_id
american_traditional_train_all=business_train[which(business_train$business_id %in% american_traditional_id),]
str(american_traditional_train_all)

write.csv(american_traditional_train_all,"american_tradional_train.csv")

american_traditional_star=read.csv("american_traditional_star_and_count.csv",header=T)$star
head(american_traditional_star)
str(american_traditional_star)

american_traditional_attributes=american_traditional_train_all$attributes
head(american_traditional_attributes)
str(american_traditional_attributes)

# Good for Kids
goodforkids=american_traditional_attributes$GoodForKids
boxplot(american_traditional_star~goodforkids,xlab="If good for kids",ylab="Star",main="Good For Kids")

# Noise level
noiselevel=american_traditional_attributes$NoiseLevel
boxplot(american_traditional_star~noiselevel)

# restaurant Delivery
restaurantdelivery=american_traditional_attributes$RestaurantsDelivery
boxplot(american_traditional_star~restaurantdelivery)

# 
goodformeal=american_traditional_attributes$GoodForMeal
boxplot(american_traditional_star~goodformeal)
goodformeal

# 
alcohol=american_traditional_attributes$Alcohol
boxplot(american_traditional_star~alcohol)

################################################ it's better to have caters
caters=american_traditional_attributes$Caters
boxplot(american_traditional_star~caters)
mean(american_traditional_star[which(caters=="True")])-mean(american_traditional_star[which(caters=="False")])

#
wifi=american_traditional_attributes$WiFi
str(wifi)
wifi[c(which(wifi=="u'free'"),which(wifi=="'free'"))]="free"
wifi[c(which(wifi=="u'no'"),which(wifi=="'no'"))]="no"
wifi[c(which(wifi=="u'paid'"),which(wifi=="'paid'"))]="paid"
boxplot(american_traditional_star~wifi)

# ############################################## it's better not have take out 
restaurantstakeout=american_traditional_attributes$RestaurantsTakeOut
boxplot(american_traditional_star~restaurantstakeout)
mean(american_traditional_star[which(restaurantstakeout=="True")])-mean(american_traditional_star[which(restaurantstakeout=="False")])


# ############################################## it's better don't accept credit cards
businessacceptcreditcards=american_traditional_attributes$BusinessAcceptsCreditCards
boxplot(american_traditional_star~businessacceptcreditcards)
mean(american_traditional_star[which(businessacceptcreditcards=="True")])-mean(american_traditional_star[which(businessacceptcreditcards=="False")])


# 
ambience=american_traditional_attributes$Ambience
boxplot(american_traditional_star~ambience)

###########################################################################################################################
businessparking_all=american_traditional_attributes$BusinessParking
businessparking=businessparking_all[-which(is.na(businessparking_all))]
str(businessparking)
head(businessparking)
star_parking=american_traditional_star[-which(is.na(businessparking_all))]

garage=gsub(pattern = ".+'garage': (\\w+),.+",replacement = "\\1",x = businessparking)
head(garage)
boxplot(star_parking~garage)
mean(star_parking[which(garage=="True")])-mean(star_parking[which(garage=="False")])



street=gsub(pattern = ".+'street': (\\w+), .+",replacement = "\\1",x = businessparking)
head(street)
boxplot(star_parking~street)

validated=gsub(pattern = ".+'validated': (\\w+), .+",replacement = "\\1",x = businessparking)
head(validated)
validated[1803]=gsub(pattern = ".+'validated': (\\w+).",replacement = "\\1",x = businessparking[1803])
boxplot(star_parking~validated)

lot=gsub(pattern = ".+'lot': (\\w+), .+",replacement = "\\1",x = businessparking)
lot[1:10]
boxplot(star_parking~lot)

valet=gsub(pattern = ".+'valet': (\\w+).",replacement = "\\1",x = businessparking)
valet[1:10]
valet[1803]=gsub(pattern = ".'valet': (\\w+), .+",replacement = "\\1",x = businessparking[1803])
businessparking[1803]
boxplot(star_parking~valet)

#
boxplot(american_traditional_star~american_traditional_attributes$RestaurantsTableService)

# 
boxplot(american_traditional_star~american_traditional_attributes$RestaurantsGoodForGroups)

#
boxplot(american_traditional_star~american_traditional_attributes$OutdoorSeating)

# 
boxplot(american_traditional_star~american_traditional_attributes$HasTV)

#
boxplot(american_traditional_star~american_traditional_attributes$BikeParking)

# 
boxplot(american_traditional_star~american_traditional_attributes$RestaurantsReservations)

#
boxplot(american_traditional_star~american_traditional_attributes$RestaurantsPriceRange2)
pricerange=american_traditional_attributes$RestaurantsPriceRange2
mean(american_traditional_star[which(pricerange=="1")])-mean(american_traditional_star[which(pricerange=="2")])


################################################# it's better to be dressy, and then casual, the least is formal####################
restaurantsattire=american_traditional_attributes$RestaurantsAttire
restaurantsattire[c(which(restaurantsattire=="'casual'"),which(restaurantsattire=="u'casual'"))]="casual"
restaurantsattire[c(which(restaurantsattire=="'dressy'"),which(restaurantsattire=="u'dressy'"))]="dressy"
restaurantsattire[c(which(restaurantsattire=="'formal'"),which(restaurantsattire=="u'formal'"))]="formal"
boxplot(american_traditional_star~restaurantsattire)

#
boxplot(american_traditional_star~american_traditional_attributes$BusinessAcceptsBitcoin)

################################################ Better not by appointment only
boxplot(american_traditional_star~american_traditional_attributes$ByAppointmentOnly)
mean(american_traditional_star[which(american_traditional_attributes$ByAppointmentOnly=="True")])-mean(american_traditional_star[which(american_traditional_attributes$ByAppointmentOnly=="False")])


# 
boxplot(american_traditional_star~american_traditional_attributes$AcceptsInsurance)

########################################################################################################################## 
boxplot(american_traditional_star~american_traditional_attributes$Music)
american_traditional_attributes$Music[1:10]

music_all=american_traditional_attributes$Music
music=music_all[-c(which(is.na(music_all)),which(music_all=="{}"))]
str(music)
head(music)  
star_music=american_traditional_star[-c(which(is.na(music_all)),which(music_all=="{}"))]
str(star_music)

dj=gsub(pattern = ".'dj': (\\w+),.+",replacement = "\\1",x = music)
dj[!duplicated(dj)]

dj[which(dj=="{'dj': False}")]="False"
dj[which(dj=="{'live': True}")]="None"
dj[which(dj=="{'dj': True}")]="True"
dj[which(dj=="{'live': False}")]="None"
dj[which(dj=="{'live': False, 'dj': True}")]="True"
dj[which(dj=="{'jukebox': True}")]="None"
dj[which(dj=="{'jukebox': False}")]="None"
dj[which(dj=="{'karaoke': False}")]="None"

boxplot(star_music~dj)

background_music=gsub(pattern = ".+'background_music': (\\w+),.+",replacement = "\\1",x = music)
background_music[!duplicated(background_music)]

background_music[which(background_music=="{'dj': False}")]="None"
background_music[which(background_music=="{'live': True}")]="None"
background_music[which(background_music=="{'dj': True}")]="None"
background_music[which(background_music=="{'live': False, 'dj': True}")]="None"
background_music[which(background_music=="{'dj': False, 'karaoke': False}")]="None"
background_music[which(background_music=="{'jukebox': True}")]="None"
background_music[which(background_music=="{'live': False}")]="None"
background_music[which(background_music=="{'jukebox': False}")]="None"
background_music[which(background_music=="{'karaoke': False}")]="None"
background_music[which(background_music=="{'dj': False, 'live': False, 'video': False, 'jukebox': True}")]="None"

boxplot(star_music~background_music)

no_music=gsub(pattern = ".+'no_music': (\\w+),.+",replacement = "\\1",x = music)
a=no_music[!duplicated(no_music)]

no_music[which(no_music==a[2])]="None"
no_music[which(no_music==a[3])]="None"
no_music[which(no_music==a[4])]="None"
no_music[which(no_music==a[5])]="None"
no_music[which(no_music==a[6])]="None"
no_music[which(no_music==a[8])]="None"
no_music[which(no_music==a[9])]="None"
no_music[which(no_music==a[10])]="None"
no_music[which(no_music==a[11])]="None"
no_music[which(no_music==a[12])]="None"
no_music[which(no_music==a[13])]="None"
no_music[which(no_music==a[14])]="None"
no_music[which(no_music==a[15])]="None"
no_music[which(no_music==a[16])]="None"
no_music[which(no_music==a[17])]="None"
no_music[which(no_music==a[18])]="None"
no_music[which(no_music==a[19])]="None"
no_music[which(no_music==a[20])]="None"
no_music[which(no_music==a[21])]="None"
no_music[which(no_music==a[22])]="None"
no_music[which(no_music==a[23])]="None"
no_music[which(no_music==a[24])]="None"
no_music[which(no_music==a[25])]="None"
no_music[which(no_music==a[26])]="None"
no_music[which(no_music==a[27])]="None"

boxplot(star_music~no_music)

jukebox=gsub(pattern = ".+'jukebox': (\\w+),.+",replacement = "\\1",x = music)
a=jukebox[!duplicated(jukebox)]
jukebox[which(jukebox==a[3])]="None"
jukebox[which(jukebox==a[4])]="None"
jukebox[which(jukebox==a[6])]="None"
jukebox[which(jukebox==a[7])]="None"
jukebox[which(jukebox==a[8])]="None"
jukebox[which(jukebox==a[9])]="True"
jukebox[which(jukebox==a[10])]="None"
jukebox[which(jukebox==a[11])]="False"
jukebox[which(jukebox==a[12])]="None"
jukebox[which(jukebox==a[13])]="True"

boxplot(star_music~jukebox)

live=gsub(pattern = ".+'live': (\\w+),.+",replacement = "\\1",x = music)
a=live[!duplicated(live)]
live[which(live==a[3])]="None"
live[which(live==a[4])]="True"
live[which(live==a[6])]="None"
live[which(live==a[7])]="None"
live[which(live==a[8])]="None"
live[which(live==a[9])]="False"
live[which(live==a[10])]="None"
live[which(live==a[11])]="None"

boxplot(star_music~live)

video=gsub(pattern = ".+'video': (\\w+),.+",replacement = "\\1",x = music)
a=video[!duplicated(video)]
a
video[which(video==a[2])]="None"
video[which(video==a[4])]="None"
video[which(video==a[6])]="None"
video[which(video==a[7])]="None"
video[which(video==a[8])]="None"
video[which(video==a[9])]="None"
video[which(video==a[10])]="None"
video[which(video==a[11])]="None"
video[which(video==a[12])]="None"

boxplot(star_music~video)

karaoke=gsub(pattern = ".+'karaoke': (\\w+).",replacement = "\\1",x = music)
a=karaoke[!duplicated(karaoke)]
karaoke[which(karaoke==a[3])]="None"
karaoke[which(karaoke==a[4])]="None"
karaoke[which(karaoke==a[6])]="None"
karaoke[which(karaoke==a[7])]="None"
karaoke[which(karaoke==a[8])]="None"
karaoke[which(karaoke==a[9])]="None"
karaoke[which(karaoke==a[10])]="None"
karaoke[which(karaoke==a[11])]="None"

boxplot(star_music~karaoke)

#
boxplot(american_traditional_star~american_traditional_attributes$GoodForDancing)

#
boxplot(american_traditional_star~american_traditional_attributes$CoatCheck)

#
boxplot(american_traditional_star~american_traditional_attributes$HappyHour)

###########################################################################################################################
boxplot(american_traditional_star~american_traditional_attributes$BestNights)

#
boxplot(american_traditional_star~american_traditional_attributes$WheelchairAccessible)

# ######################################### it's better to be dogs allowed
boxplot(american_traditional_star~american_traditional_attributes$DogsAllowed)
mean(american_traditional_star[which(american_traditional_attributes$DogsAllowed=="True")])-mean(american_traditional_star[which(american_traditional_attributes$DogsAllowed=="False")])
########################################### it's better to have corkage
byobcorkage=american_traditional_attributes$BYOBCorkage
byobcorkage[c(which(byobcorkage=="'no'"),which(byobcorkage=="u'no'"))]="no"
byobcorkage[c(which(byobcorkage=="'yes_corkage'"),which(byobcorkage=="u'yes_corkage'"))]="yes_corkage"
byobcorkage[which(byobcorkage=="'yes_free")]="yes_free"
boxplot(american_traditional_star~byobcorkage)
mean(american_traditional_star[which(byobcorkage=="'yes_free'")])-mean(american_traditional_star[which(byobcorkage=="yes_corkage")])


########################################### it's better not have drive thru
boxplot(american_traditional_star~american_traditional_attributes$DriveThru)
mean(american_traditional_star[which(american_traditional_attributes$DriveThru=="True")])-mean(american_traditional_star[which(american_traditional_attributes$DriveThru=="False")])

########################################### it's better allow smoking than no than outdoor
smoking=american_traditional_attributes$Smoking
smoking[c(which(smoking=="'no'"),which(smoking=="u'no'"))]="no"
boxplot(american_traditional_star~smoking)
mean(american_traditional_star[which(smoking=="u'outdoor'")])-mean(american_traditional_star[which(smoking=="u'yes'")])

########################################### it's better for all ages than 21 plus than 19 plus
boxplot(american_traditional_star~american_traditional_attributes$AgesAllowed)


#
boxplot(american_traditional_star~american_traditional_attributes$HairSpecializesIn)

########################################### it's better to have corkage
boxplot(american_traditional_star~american_traditional_attributes$Corkage)

#
boxplot(american_traditional_star~american_traditional_attributes$BYOB)

#
boxplot(american_traditional_star~american_traditional_attributes$DietaryRestrictions)

########################################## it's better not open 24 hours
boxplot(american_traditional_star~american_traditional_attributes$Open24Hours)

#
boxplot(american_traditional_star~american_traditional_attributes$RestaurantsCounterService)
american_traditional_attributes$RestaurantsCounterService



#######################################################################################################################
#######################################################################################################################
#######################################################################################################################



