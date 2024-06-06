
balloondata <- read.csv("balloondata.csv", stringsAsFactors = TRUE)
library(dplyr)
library(ggplot2)
balloondatafixed<- balloondata[which(balloondata$tmpc != "M"), ]
balloondatafixed$tmpc<-as.character(balloondatafixed$tmpc)
balloondatafixed$height_m <- as.numeric(as.character(balloondatafixed$height_m))
balloondatafixed$tmpc <- as.numeric(as.character(balloondatafixed$tmpc))
balloondatafixed2 <- subset(balloondatafixed, height_m <= 3000)

date_plots <- list()
for(i in unique(balloondatafixed2$date)){
  p <- ggplot(balloondatafixed2[balloondatafixed2$date == i,], aes(x = tmpc, y = height_m)) + geom_point() +
    theme_classic() + facet_wrap(~ AM_PM) +
    xlab("Temperature") + ylab("Altitude")  + labs(title= paste(i))
  date_plots[[i]] = p
}
for (i in 1:3) {
  print(date_plots[[i]])
}

print(balloondatafixed2[1,])
#date_ams = list()
#am <- filter(balloondatafixed2, AM_PM == 'AM')
#newam <- subset(am, selected = c('tmpc', 'pressure_mb', 'height_m'))
#for (day in unique(am$date)){
# am <-

am<-filter(balloondatafixed2, AM_PM == "AM")

amdata <- am[c("date", "tmpc", "pressure_mb")]


#lapserate function


pm<-filter(balloondatafixed2, AM_PM == "PM")
pmdata <- pm[c("date","tmpc", "pressure_mb")]


#grabs the number of rows with nrow, and creates a range of numbers
nrow(amdata)
i <- 1:(nrow(amdata)-1)
i[1]

j <- 2:nrow(amdata)
length(i) - length(j)
lapserateam<- (amdata$tmpc[j] - amdata$tmpc[i]) /(amdata$pressure_mb[j] - amdata$pressure_mb[i])

class(amdata)

nrow(pmdata)
m <- 1:(nrow(pmdata)-1)
m[1]

n <- 2:nrow(pmdata)
length(m) - length(n)
lapseratepm <- (pmdata$tmpc[n] - pmdata$tmpc[m]) /(pmdata$pressure_mb[n] - pmdata$pressure_mb[m])


#this finds all the am and pm lapserate values

lapserateam
lapseratepm
amlapserate <- data.frame(lapse.rate.am = c(lapserateam))

pmlapserate <- data.frame(lapse.rate.pm = c(lapseratepm))

AMinversions <- filter(amlapserate, lapse.rate.am < 0 )
PMinversions <- filter(pmlapserate, lapse.rate.pm < 0)

#x <- as.numeric(as.character(x))



