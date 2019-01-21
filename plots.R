library(lubridate)
Sys.setenv(TZ="Australia/Sydney")

out <- read.csv("outputs/wtc_two_leaf_C05.csv")
met <- read.csv("met_data_gap_fixed.csv",stringsAsFactors=F)
met$DateTime <- parse_date_time(met$DateTime,"d m y H M")
met <- subset(met,chamber=="C05")
met1 <- met[1:3048,]
tog <- cbind(met,out)
tog$Atot <- with(tog,(An_sun*LAI_sun+An_sha*LAI_sha)/LAI_can)
with(tog,plot(LAI_can,APAR_can/par))
with(tog,plot(par,tair))
with(subset(tog,par > 1500),plot(tair,An_sun))
with(subset(tog,par > 1500),plot(tair,An_sha))
with(subset(tog,par > 1000),plot(tair,An_sun*LAI_sun))
with(subset(tog,par > 1000),plot(tair,An_sha*LAI_sha))
with(subset(tog,par > 1000),plot(tair,Atot))
with(tog,plot(tair,Atot))
with(met,plot(tair,FluxCO2/leafArea))
with(tog,points(tair,Atot,col="red"))

tog[tog$Atot>25,]

with(tog,plot(LAI_can))
with(tog,plot(LAI_can,LAI_sha))

head(met)
head(out)

with(out,plot(T_can,T_sun))
with(out,points(T_can,T_sha,col="red"))
abline(a=0,b=1)

with(subset(tog,LAI_can>1.5),plot(par,APAR_sun))
with(subset(tog,LAI_can>1.5),points(par,APAR_sha,col="red"))

with(subset(tog,LAI_can>1.5),plot(par,APAR_sun+APAR_sha))
abline(a=0,b=1)

with(subset(tog,LAI_can>1.5),plot(LAI_sun,APAR_sha,col="red"))

with(out,plot(APAR_sun,An_sun/APAR_sun))
with(out,plot(APAR_sha,An_sha/APAR_sha))
with(out,plot(APAR_sun,An_sun))
with(out,plot(APAR_sha,An_sha))

with(out,plot(APAR_sha,T_sha))
