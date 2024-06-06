Detect <- function(){
  am<-filter(balloondatafixed2, AM_PM == "AM")

  amdata <- am[c("date", "tmpc", "pressure_mb")]

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

  amlapserate <- data.frame("lapserate" = lapserateam, "date" = amdata$date[j])

  pmlapserate <- data.frame("lapserate" = lapseratepm, "date" = pmdata$date[n])

  AMinversions <- filter(amlapserate, lapse.rate.am < 0 )
  PMinversions <- filter(pmlapserate, lapse.rate.pm < 0)

  AMinversions
  PMinversions

}
