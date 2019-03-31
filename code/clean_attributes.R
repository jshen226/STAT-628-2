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

american_traditional_star=read.csv("american_traditional_star_and_count.csv",header=T)$star
head(american_traditional_star)
str(american_traditional_star)

american_traditional_attributes=american_traditional_train_all$attributes
head(american_traditional_attributes)
str(american_traditional_attributes)

attributes=cbind(american_traditional_star,american_traditional_attributes)
head(attributes)
head(attributes$GoodForMeal)

goodforkids=attributes$GoodForKids
goodforkids[!duplicated(goodforkids)]

noiselevel=attributes$NoiseLevel
noiselevel[!duplicated(noiselevel)]
noiselevel[c(which(noiselevel=="u'average'"),which(noiselevel=="'average'"))]="average"
noiselevel[c(which(noiselevel=="u'quiet'"),which(noiselevel=="'quiet'"))]="quiet"
noiselevel[c(which(noiselevel=="u'very_loud'"),which(noiselevel=="'very_loud'"))]="very_loud"
noiselevel[c(which(noiselevel=="u'loud'"),which(noiselevel=="'loud'"))]="loud"

restaurantdelivery=attributes$RestaurantsDelivery
restaurantdelivery[!duplicated(restaurantdelivery)]

dessert=gsub(pattern = ".+dessert': (\\w+).+",replacement="\\1",x=attributes$GoodForMeal)
dessert[!duplicated(dessert)]

latenight=gsub(pattern=".+latenight': (\\w+).+",replacement = "\\1",x=attributes$GoodForMeal)
latenight[!duplicated((latenight))]

lunch=gsub(pattern=".+lunch': (\\w+).+",replacement = "\\1",x=attributes$GoodForMeal)
lunch[!duplicated(lunch)]

dinner=gsub(pattern=".+dinner': (\\w+).+",replacement = "\\1",x=attributes$GoodForMeal)
dinner[!duplicated(dinner)]

brunch=gsub(pattern=".+brunch': (\\w+).+",replacement = "\\1",x=attributes$GoodForMeal)
brunch[!duplicated(brunch)]

breakfast=gsub(pattern=".+breakfast': (\\w+).+",replacement = "\\1",x=attributes$GoodForMeal)
breakfast[!duplicated(breakfast)]

alcohol=attributes$Alcohol
alcohol[!duplicated(alcohol)]
alcohol[c(which(alcohol=="u'full_bar'"),which(alcohol=="'full_bar'"))]="full_bar"
alcohol[c(which(alcohol=="u'beer_and_wine'"),which(alcohol=="'beer_and_wine'"))]="beer_and_wine"
alcohol[c(which(alcohol=="u'none'"),which(alcohol=="'none'"))]="None"

caters=attributes$Caters
caters[!duplicated(caters)]

wifi=attributes$WiFi
wifi[!duplicated(wifi)]
wifi[c(which(wifi=="u'free'"),which(wifi=="'free'"))]="free"
wifi[c(which(wifi=="u'no'"),which(wifi=="'no'"))]="no"
wifi[c(which(wifi=="u'paid'"),which(wifi=="'paid'"))]="paid"

restaurantstakeout=attributes$RestaurantsTakeOut
restaurantstakeout[!duplicated(restaurantstakeout)]

businessacceptcreditcards=attributes$BusinessAcceptsCreditCards
businessacceptcreditcards[!duplicated(businessacceptcreditcards)]

ambience=attributes$Ambience
ambience[1:10]
touristy=gsub(pattern=".+touristy': (\\w+).+",replacement = "\\1",x=ambience)
touristy[!duplicated(touristy)]

hipster=gsub(pattern=".+hipster': (\\w+).+",replacement = "\\1",x=ambience)
hipster[!duplicated(hipster)]
hipster[c(which(hipster=="{'romantic': False, 'intimate': False, 'classy': False, 'upscale': False, 'touristy': False, 'trendy': False, 'casual': False}"),
          which(hipster=="{'romantic': False, 'intimate': False, 'classy': False, 'upscale': False, 'touristy': False, 'trendy': False, 'casual': True}"))]="None"

romantic=gsub(pattern=".+romantic': (\\w+).+",replacement = "\\1",x=ambience)
romantic[!duplicated(romantic)]

divey=gsub(pattern=".+divey': (\\w+).+",replacement = "\\1",x=ambience)
divey[!duplicated(divey)]
divey[-c(which(divey=="False"),which(divey=="None"),which(is.na(divey)))]="None"

intimate=gsub(pattern=".+intimate': (\\w+).+",replacement = "\\1",x=ambience)
intimate[!duplicated(intimate)]

trendy=gsub(pattern=".+trendy': (\\w+).+",replacement = "\\1",x=ambience)
trendy[!duplicated(trendy)]

upscale=gsub(pattern=".+upscale': (\\w+).+",replacement = "\\1",x=ambience)
upscale[!duplicated(upscale)]
upscale[-c(which(upscale=="False"),which(upscale=="None"),which(is.na(upscale)),which(upscale=="True"))]="None"

classy=gsub(pattern=".+classy': (\\w+).+",replacement = "\\1",x=ambience)
classy[!duplicated(classy)]

casual=gsub(pattern=".+casual': (\\w+).+",replacement = "\\1",x=ambience)
casual[!duplicated(casual)]

businessparking=attributes$BusinessParking
head(businessparking)
garage=gsub(pattern = ".+'garage': (\\w+),.+",replacement = "\\1",x = businessparking)
garage[!duplicated(garage)]

street=gsub(pattern = ".+'street': (\\w+), .+",replacement = "\\1",x = businessparking)
street[!duplicated(street)]

validated=gsub(pattern = ".+'validated': (\\w+), .+",replacement = "\\1",x = businessparking)
validated[!duplicated(validated)]
validated[which(validated=="{'valet': False, 'garage': False, 'street': False, 'lot': True, 'validated': False}")]="False"

lot=gsub(pattern = ".+'lot': (\\w+), .+",replacement = "\\1",x = businessparking)
lot[!duplicated(lot)]

valet=gsub(pattern = ".+'valet': (\\w+).",replacement = "\\1",x = businessparking)
valet[!duplicated(valet)]
valet[which(valet=="False 'garage': False, 'street': False, 'lot': True, 'validated': False}")]="None"

restaurantstableservice=attributes$RestaurantsTableService
restaurantstableservice[!duplicated(restaurantstableservice)]

restaurantsgoodforgroups=attributes$RestaurantsGoodForGroups
restaurantsgoodforgroups[!duplicated(restaurantsgoodforgroups)]

outdoorseating=attributes$OutdoorSeating
outdoorseating[!duplicated(outdoorseating)]

hastv=attributes$HasTV
hastv[!duplicated(hastv)]

bikeparking=attributes$BikeParking
bikeparking[!duplicated(bikeparking)]

restaurantsreservations=attributes$RestaurantsReservations
restaurantsreservations[!duplicated(restaurantsreservations)]

restaurantspricerange2=attributes$RestaurantsPriceRange2
restaurantspricerange2[!duplicated(restaurantspricerange2)]

restaurantsattire=attributes$RestaurantsAttire
restaurantsattire[!duplicated(restaurantsattire)]
restaurantsattire[c(which(restaurantsattire=="'casual'"),which(restaurantsattire=="u'casual'"))]="casual"
restaurantsattire[c(which(restaurantsattire=="'dressy'"),which(restaurantsattire=="u'dressy'"))]="dressy"
restaurantsattire[c(which(restaurantsattire=="'formal'"),which(restaurantsattire=="u'formal'"))]="formal"

businessacceptbitcoin=attributes$BusinessAcceptsBitcoin
businessacceptbitcoin[!duplicated(businessacceptbitcoin)]

byappointmentonly=attributes$ByAppointmentOnly
byappointmentonly[!duplicated(byappointmentonly)]

acceptsinsurance=attributes$AcceptsInsurance
acceptsinsurance[!duplicated(acceptsinsurance)]

music=attributes$Music
head(music)
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
dj[which(dj=="{}")]="None"


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
background_music[which(background_music=="{}")]="None"

no_music=gsub(pattern = ".+'no_music': (\\w+),.+",replacement = "\\1",x = music)
a=no_music[!duplicated(no_music)]
a
no_music[which(no_music==a[3])]="None"
no_music[which(no_music==a[4])]="None"
no_music[which(no_music==a[5])]="None"
no_music[which(no_music==a[6])]="None"
no_music[which(no_music==a[7])]="None"
no_music[which(no_music==a[8])]="None"
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
no_music[which(no_music==a[28])]="None"
no_music[which(no_music==a[29])]="None"


jukebox=gsub(pattern = ".+'jukebox': (\\w+),.+",replacement = "\\1",x = music)
a=jukebox[!duplicated(jukebox)]
a
jukebox[which(jukebox==a[4])]="None"
jukebox[which(jukebox==a[5])]="None"
jukebox[which(jukebox==a[6])]="None"
jukebox[which(jukebox==a[8])]="None"
jukebox[which(jukebox==a[9])]="None"
jukebox[which(jukebox==a[10])]="None"
jukebox[which(jukebox==a[11])]="True"
jukebox[which(jukebox==a[12])]="None"
jukebox[which(jukebox==a[13])]="False"
jukebox[which(jukebox==a[14])]="None"
jukebox[which(jukebox==a[15])]="True"

live=gsub(pattern = ".+'live': (\\w+),.+",replacement = "\\1",x = music)
a=live[!duplicated(live)]
a
live[which(live==a[4])]="None"
live[which(live==a[5])]="None"
live[which(live==a[6])]="True"
live[which(live==a[7])]="None"
live[which(live==a[8])]="None"
live[which(live==a[9])]="None"
live[which(live==a[10])]="None"
live[which(live==a[11])]="False"
live[which(live==a[12])]="None"
live[which(live==a[13])]="None"

video=gsub(pattern = ".+'video': (\\w+),.+",replacement = "\\1",x = music)
a=video[!duplicated(video)]
a
video[which(video==a[3])]="None"
video[which(video==a[4])]="None"
video[which(video==a[6])]="None"
video[which(video==a[8])]="None"
video[which(video==a[9])]="None"
video[which(video==a[10])]="None"
video[which(video==a[11])]="None"
video[which(video==a[12])]="None"
video[which(video==a[13])]="None"
video[which(video==a[14])]="None"

karaoke=gsub(pattern = ".+'karaoke': (\\w+).",replacement = "\\1",x = music)
a=karaoke[!duplicated(karaoke)]
a
karaoke[which(karaoke==a[4])]="None"
karaoke[which(karaoke==a[5])]="None"
karaoke[which(karaoke==a[6])]="None"
karaoke[which(karaoke==a[8])]="None"
karaoke[which(karaoke==a[9])]="None"
karaoke[which(karaoke==a[10])]="None"
karaoke[which(karaoke==a[11])]="None"
karaoke[which(karaoke==a[12])]="None"
karaoke[which(karaoke==a[13])]="None"

goodfordancing=attributes$GoodForDancing
goodfordancing[!duplicated(goodfordancing)]

coatcheck=attributes$CoatCheck
coatcheck[!duplicated(coatcheck)]

happyhour=attributes$HappyHour
happyhour[!duplicated(happyhour)]

bestnights=attributes$BestNights
bestnights[!duplicated(bestnights)]
monday=gsub(pattern=".+monday': (\\w+).+",replacement = "\\1",x=bestnights)
monday[!duplicated(monday)]
tuesday=gsub(pattern=".+tuesday': (\\w+).+",replacement = "\\1",x=bestnights)
tuesday[!duplicated(tuesday)]
wednesday=gsub(pattern=".+wednesday': (\\w+).+",replacement = "\\1",x=bestnights)
wednesday[!duplicated(wednesday)]
thursday=gsub(pattern=".+thursday': (\\w+).+",replacement = "\\1",x=bestnights)
thursday[!duplicated(thursday)]
friday=gsub(pattern=".+friday': (\\w+).+",replacement = "\\1",x=bestnights)
friday[!duplicated(friday)]
saturday=gsub(pattern=".+saturday': (\\w+).+",replacement = "\\1",x=bestnights)
saturday[!duplicated(saturday)]
sunday=gsub(pattern=".+sunday': (\\w+).+",replacement = "\\1",x=bestnights)
sunday[!duplicated(sunday)]

wheelchairaccessible=attributes$WheelchairAccessible
wheelchairaccessible[!duplicated(wheelchairaccessible)]

dogsallowed=attributes$DogsAllowed
dogsallowed[!duplicated(dogsallowed)]

byobcorkage=attributes$BYOBCorkage
byobcorkage[!duplicated(byobcorkage)]
byobcorkage[c(which(byobcorkage=="'no'"),which(byobcorkage=="u'no'"))]="no"
byobcorkage[c(which(byobcorkage=="'yes_corkage'"),which(byobcorkage=="u'yes_corkage'"))]="yes_corkage"
byobcorkage[which(byobcorkage=="'yes_free")]="yes_free"

drivethru=attributes$DriveThru
drivethru[!duplicated(drivethru)]

smoking=attributes$Smoking
smoking[!duplicated(smoking)]
smoking[c(which(smoking=="'no'"),which(smoking=="u'no'"))]="no"
smoking[c(which(smoking=="u'outdoor'"))]="outdoor"
smoking[c(which(smoking=="u'yes'"))]="yes"

agesallowed=attributes$AgesAllowed
agesallowed[!duplicated(agesallowed)]
agesallowed[which(agesallowed=="u'21plus'")]="21plus"
agesallowed[which(agesallowed=="u'19plus'")]="19plus"
agesallowed[which(agesallowed=="u'allages'")]="allages"

hairspecializesin=attributes$HairSpecializesIn
hairspecializesin[!duplicated(hairspecializesin)]################## NA

corkage=attributes$Corkage
corkage[!duplicated(corkage)]

byob=attributes$BYOB
byob[!duplicated(byob)]

dietaryrestrictions=attributes$DietaryRestrictions
dietaryrestrictions[!duplicated(dietaryrestrictions)]##################### NA

open24hours=attributes$Open24Hours
open24hours[!duplicated(open24hours)]

restaurantscounterservice=attributes$RestaurantsCounterService
restaurantscounterservice[!duplicated(restaurantscounterservice)]



clean_attributes=cbind(american_traditional_star,goodforkids,noiselevel,restaurantdelivery,
                       dessert,latenight,lunch,dinner,brunch,breakfast, #restaurants delivery
                       alcohol,caters,wifi,restaurantstakeout,businessacceptcreditcards,
                       touristy,hipster,romantic,divey,intimate,trendy,upscale,classy,casual, #ambience
                       garage,street,validated,lot,valet, #businessparking
                       restaurantstableservice,restaurantsgoodforgroups,outdoorseating,hastv,bikeparking,restaurantsreservations,
                       restaurantspricerange2,restaurantsattire,businessacceptbitcoin,byappointmentonly,acceptsinsurance,
                       dj,background_music,no_music,jukebox,live,video,karaoke, #music
                       goodfordancing,coatcheck,happyhour,
                       monday,tuesday,wednesday,thursday,friday,saturday,sunday, #bestnights
                       wheelchairaccessible,dogsallowed,byobcorkage,drivethru,smoking,agesallowed,corkage,
                       byob,open24hours,restaurantscounterservice
)
head(clean_attributes)

write.csv(clean_attributes,"clean_attributes.csv")
