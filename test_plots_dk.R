
setwd("C:/Repos/two_leaf_at_WTC")

file_list<-list.files(path="outputs",pattern=".csv")

file_list<-file_list[c(1,3,5,7,9,11)]

file_list2<-list()

met <- read.csv("met_data/met_data_gap_fixed.csv",stringsAsFactors=F)
met<-subset(met,chamber %in% c("C01", "C03","C05","C07" ,"C09" ,"C11"))
met$chamber<-factor(met$chamber)

setwd("C:/Repos/two_leaf_at_WTC/outputs")



for(i in 1:length(file_list)){
  
  datatoread<-read.csv(file_list[[i]])
  
  chmb<-c(1,3,5,7,9,11)
  
  datatoread$chamber<-ifelse(i<6,sprintf("C0%s",round(chmb[i],0)),sprintf("C%s",round(chmb[i],0)))
  met_1<-subset(met,met$chamber==unique(datatoread$chamber) & met$Water_treatment=="control")
  
  
  dat <- cbind(met_1,datatoread)
  
  file_list2[[i]]<-tog
  
}

# file_list2[c(2,4,6,8,10,12)]<-NULL
dat<-data.frame(do.call(rbind,file_list2))

setwd("C:/Repos/two_leaf_at_WTC")



#----------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------

dat$Atot <- with(dat,(An_sun*LAI_sun+An_sha*LAI_sha)/LAI_can)
with(dat,plot(LAI_can,APAR_can/par))
with(dat,plot(par,tair))
with(subset(dat,par > 1200),plot(tair,An_sun))
with(subset(dat,par > 1200),plot(tair,An_sha))
with(subset(dat,par > 1000),plot(tair,An_sun*LAI_sun))
with(subset(dat,par > 1000),plot(tair,An_sha*LAI_sha))
with(subset(dat,par > 1000),plot(tair,Atot))
with(dat,plot(tair,Atot))
with(met,plot(tair,FluxCO2*1000/leafArea))
with(dat,points(tair,Atot,col="red"))

with(dat,plot(Atot,FluxCO2*1000/leafArea,xlim=c(0,25),ylim=c(0,25)))
abline(0,1)


with(dat,plot(T_can,T_sun))
with(dat,points(T_can,T_sha,col="red"))
abline(a=0,b=1)

with(subset(dat,LAI_can>1.5),plot(par,APAR_sun))
with(subset(dat,LAI_can>1.5),points(par,APAR_sha,col="red"))

with(subset(dat,LAI_can>1.5),plot(par,APAR_sun+APAR_sha))
abline(a=0,b=1)

with(subset(dat,LAI_can>1.5),plot(LAI_sun,APAR_sha,col="red"))

with(dat,plot(APAR_sun,An_sun/APAR_sun))
with(dat,plot(APAR_sha,An_sha/APAR_sha))
with(dat,plot(APAR_sun,An_sun))
with(dat,plot(APAR_sha,An_sha))

with(dat,plot(APAR_sha,T_sha))


