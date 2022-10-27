# creat&ing a dataframe from our dataset 
# when we import a csv file or read any type of file <z
mydata <- read.csv("C:\\Users\\WhiteLuce SIS\\OneDrive\\data analysis\\data analysis basics\\projects\\time series analysis\\opsd_germany_daily.csv",header = TRUE,row.names="Date")
mydata
#view data in a tabular format
View(mydata)

#looking at a part of dataframe using head() or tail()
head(mydata)
tail(mydata)

#retrieve the dimension of the object
dim(mydata)

#check datatype of each column in the dataframe
str(mydata)

#looking at date column (will not show data as its index)
head(mydata$Date)#it returns null seeing that Date as a column doesn't exist in fact Date plays the role of an index

#looking at row names
row.names(mydata)#it displays all the values that are contained into the Date column 

#accessing a specific row
mydata["2006-01-01",]

mydata["2017-08-10",]

#accessing multiple rows 
mydata[c("2006-01-01","2006-01-04"),]
#gives your for each variable min,1st quartile, median,3rd quartile, maximum and the mean
summary(mydata)

#------------ # 
#without parsing date column 
mydata2 <- read.csv("C:\\Users\\WhiteLuce SIS\\OneDrive\\data analysis\\data analysis basics\\projects\\time series analysis\\opsd_germany_daily.csv",header=TRUE)
mydata2
View(mydata2)
#here we can chack differences between both of mydata and mydata2. In the first one , Date is used as an index meanwhile the second one 
#doesn't play Date as an index

#look at date column 
str(mydata2$Date)# seeing that this doesn't display a date format we will convert it into a date format

x<- as.Date(mydata2$Date)
head(x)
class(x)
str(x)

#now we want to extract it and let it be a part of the data frame
#create year,month,day columns

year <- as.numeric(format(x,'%Y'))
head(year)

month <- as.numeric(format(x,'%m'))
head(month)

day <- as.numeric(format(x,'%d'))
head(day)

head(mydata2)

#let's add these extracted columns to the existing dataframe using cbind
mydata2<- cbind(mydata2,year,month,day)
head(mydata2)


mydata2[1:3,]

install.packages("dplyr")
library(dplyr)
sample_n(mydata2,8)     

#let's create a line plot of the full time series of germany's
#daily electricity consumption, using the dataframe's plot() method

#using Plot() 

#option1: 
plot(mydata2$year,mydata2$Consumption,type="l",xlab="year",ylab="Consumption")
#below the plot we can see some peak times
#the data has been divided between 2006 and 2016 by 2 years of difference
#however this opetion doesn't let me see clearly the flow of the data on the screen 

#option 2 
plot(mydata2$year,mydata2$Consumption,type="l",xlab="year",ylab="Consumption",lty=1,ylim=c(800,1700),xlim=c(2006,2018))

#better options
#option 3: 
#for one plot/window

par(mfrow=c(1,1))
plot(mydata2[,2])#here we've chosen to do the plot on column consumption without the need to specify
#y and x axis names
#it shows me a pattern

#option 4 
plot(mydata[,2],xlab="year",ylab="Consumption")
plot(mydata[,2],xlab="year",ylab="Consumption",type="l",lwd=2)
plot(mydata[,2],xlab="year",ylab="Consumption",type="l",lwd=2,xlim=c(2006,2018),ylim=c(0,400),col="blue",main="consumption graph")

#taking log values of consumption and take differences of logs
plot(10*diff(log(mydata2[,2])),xlab="year",ylab="Consumption",type="l",lwd=2,ylim=c(-5,5),main="consumption graph",col="orange",xlim=c(0,5000))

#using the ggplot to visualize consumption over year
install.packages("ggplot2")
library(ggplot2)

#option1 ==> doesn't give enough informations
ggplot(mydata2,type="o")+geom_line(aes(x=year,y=Consumption))

#option2
ggplot(data= mydata2, aes(x=year,y=Consumption,group=1))+ geom_line(linetype="dashed")+geom_point()
ggplot(data=mydata2,mapping=aes(x=year,y=Consumption,col="red"))+geom_point()


#plot the data considering the solar and wind time series too 

#it's cruical to find out the minimum and maximum values in every column 
#it helps to define the limits while visualizing
#wind column 
mydata2
min(mydata2[,3],na.rm=T)#remove the na values 
max(mydata2[,3],na.rm=T)

#consumption column 
min(mydata2[,2],na.rm=T)
max(mydata2[,2],na.rm=T)

#Solar
min(mydata2[,4],na.rm=T)
max(mydata2[,4],na.rm=T)

#wind+solar

min(mydata2[,5],na.rm=T)
max(mydata2[,5],na.rm=T)

#for multiple plots
par(mfrow=c(3,1))

#consumption over year
plot1 <- plot(mydata2[,2],xlab="year",ylab="Daily Totals (Gwh)",type="l",lwd=2,main="Consumption",col="orange",ylim=c(840,1750))

# how to extract : test <- mydata3$moddate[mydata3$moddate >= '2006-01-01' & mydata3$moddate <= '2006-01-03']
#plot2 : solar over year
#from 2006 we have only some patterns
plot2 <- plot(mydata2[,4],xlab="year",ylab="Daily Totals(GWH)",type="l"
              ,main="Solar",lwd=2,ylim=c(0,500),col="blue")

#plot3 : wind over year
plot3 <- plot(mydata2[,3],xlab="year",ylab="Daily Totals (GWh)",type="l",lwd=2,main="Wind",ylim=c(0,900),col="red")


#1plot/window
par(mfrow= c(1,1))
#let's plot time series in a single year to investigate further
str(mydata2)
x<-as.Date(mydata2$Date)
head(x)
class(x)
str(x)
#to convert date column into ate format
moddate<-as.Date(x,format="%m%d%Y")
str(moddate)

mydata3<-cbind(moddate,mydata2)
head(mydata3)
str(mydata3)
#let's do data wrangling, by working only on a year 2017
mydata4 =subset(mydata3,subset=mydata3$moddate >= '2017-01-01' & mydata3$moddate <='2017-12-31')
head(mydata4)

plot4<-plot(mydata4[,1],mydata4[,3],xlab="year",ylab="Daily Totals(Gwh)",type="l",
            lwd=2,main="consumption",col="orange")

#zoom in the data further 
mydata4 =subset(mydata3,subset=mydata3$moddate >= '2017-01-01' & mydata3$moddate <='2017-02-28')
head(mydata4)

#let's find the minimum and the maximum 
xmin<-min(mydata4[,1],na.rm=T)
xmax<-max(mydata4[,1],na.rm=T)
xmin
xmax
ymin<-min(mydata3[,3],na.rm=T)
ymax<-max(mydata3[,3],na.rm=T)
ymin
ymax
plot4<-plot(mydata4[,1],mydata4[,3], xlab="year",ylab="Daily Totals (Gwh)",type="l",
            lwd=2,main="Consumption",col="orange",xlim=c(xmin,xmax),ylim=c(ymin,ymax))

#wecan make the graph looks more meaningful 
grid()
#add solid horizontal linesin order to dissect the data which means to cut up the data 
#methodically to study its internal part
abline(h=c(1300,1500,1600),lty=2,col="red")
#add dashed blue vertical lines at x 
abline(v=seq(xmin,xmax,7),lty=2,col="blue")


##################################################

boxplot(mydata3$Consumption)
boxplot(mydata3$Solar)
boxplot(mydata3$Wind)

#boxplot is visual display of 5 number summary 
quantile(mydata3$Consumption,probs=c(0,0.25,0.5,0.75,1))
boxplot(mydata3$Consumption,main="Consumption",ylab="Consumption",ylim=c(600,1800))

#yearly
boxplot(mydata3$Consumption~mydata3$year,main="Consumption",ylab="Consumption",xlab="years",ylim=c(600,1800),las=1)
#monthly 
boxplot(mydata3$Consumption~mydata3$month, main="Consumption",ylab="Consumption",xlab="month",ylim=c(600,1800),las=1)

#multiple boxplots
par(mfrow=c(3,1))

boxplot(mydata3$Consumption~mydata3$month,main="Consumption",
        ylab="Consumption",xlab="month",ylim=c(600,1800),las=1,col="red")

boxplot(mydata3$Wind ~mydata3$month,main="wind",ylab="wind",xlab="month",
        ylim=c(0,900),las=1, col="blue")

boxplot(mydata3$Solar~mydata3$month,main="solar",ylab="solar",xlab="month",
        ylim=c(0,200),las=1, col="green")

#days
#first let's reset it to one plot by graph
install.packages("lubridate")
library(lubridate)
mydata3$weekday <-wday(mydata3$Date,label=TRUE,abbr=FALSE)
par(mfrow=c(1,1))
boxplot(mydata3$Consumption ~ mydata3$weekday,main="Consumption",ylab="Consumption",
        xlab="days",ylim=c(600,1800),las=1, col="green")


mydata3
library(dplyr)
summary(mydata3)
colSums(!is.na(mydata3))#how many entries do we have without counting the na values
sum(is.na(mydata3$Consumption))#find out  if there is any lmissing values
sum(is.na(mydata3$Wind))
sum(is.na(mydata3$Solar))
sum(is.na(mydata3$Wind.Solar))

View(mydata4)
#frequencies
xmin <- min(mydata3[,1],na.rm=T)
xmin
freq1<-seq(from=xmin,by="day",length.out=5)#
freq1
typeof(freq1)
class(freq1)

freq2<- seq(from=xmin,by="month",length.out=5)
freq2

freq3<- seq(from=xmin,by="year",length.out=5)
freq3

#let's select data which has na values for wind 

selwind1 <-mydata3[which(is.na(mydata3$Wind)),names(mydata3)%in% c("moddate","Consumption","wind","Solar")]
selwind1[1:10,]
View(selwind1)

#let's select data which does not have NA values for wind

selwind2 <-mydata3[which(!is.na(mydata3$Wind)),names(mydata3)%in% c("moddate","Consumption","wind","Solar")]
selwind2[1:10,]
View(selwind2)

#looking at result of the above two, we know that year 2011 haw wind column with some missing values

selwind3 <- mydata3[which(mydata3$year=="2011"),names(mydata3) %in% c("moddate","Consumption","Wind","Solar")]
selwind3[1:10,]
class(selwind3)
View(selwind3)

#number of rows of the previous data frame

nrow(selwind3)

#we earlier checked total number of na values per column(line 265-269)
#now we will find the number of na values for a particular year
sum(is.na(mydata3$Wind[which(mydata3$year=="2011")]))

#how many non na values for a particular year
sum(!is.na(mydata3$Wind[which(mydata3$year=="2011")]))

str(selwind3)

#now we want to find that one particular row which has na value in wind column for year 2011
selwind4<-selwind3[which(is.na(selwind3$Wind)),names(selwind3)%in% c("moddate","Consumption","Wind","Solar")]
selwind4

#we know the data follows a day wise frequency 
#let's select data which has na and non na values
#we do this kind of operation in case that we want a particular data
#but it can contain missing values
#in that case we can fill those missing with true values

#sometimes when we have the data for 2017, 2018 all month consumption for the both of them
#however for 2019 we don't have the consumption values
#for few month 
#the we can fill tehese missing with pthe previous values 
test1<- selwind3[which(selwind3$moddate>"2011-12-12" & selwind3$moddate < "2011-12-16"),
                 names(selwind3) %in% c("moddate","Consumption","Wind","Solar")]

test1
class(test1)
str(test1)

library(tidyr)
#we will fill the wind columns which has a missing value 
test1 %>% fill(Wind)

#we can do trends by working on the zoo packages
#then we can use a rolling mean, and we can see what frequency with which 
#we want to calculate the rollingmean

install.packages("zoo")
library(zoo)
test_03da = zoo::rollmean(mydata3$Consumption, k=3, fill=NA)
str(test_03da)

#trend analysis, looking at rolling mean in another way 
#arrange the data in a descending way
#group the data by year
#the mutate function allows me to use the roll mean function
#we will calculate the roll mean every three days
mydata3

threedayTest <- mydata3 %>%
  dplyr::arrange(desc(year)) %>%
  dplyr::group_by(year) %>%
  dplyr::mutate(test_03da=zoo::rollmean(Consumption,k=3,fill=NA),) %>%
  dplyr::ungroup()

threedayTest
#the first value in our new test_03da variable(1367.) is the average consumption in 2017 
#from the first date with a data point on either side of it 
#(i.e the date 2017-01-01 preceding it , and 2017-01-03 following it)
#for example mean(c(1130,1441,1530)) #---for 3 day average
#mean (c(1130,1141,15330,1553,1547)) #---for 5day average

#now let's calculate 7 day and 365 day rolling mean for consumption 
mydataTest <- mydata3 %>%
  dplyr::arrange(desc(year)) %>%
  dplyr::group_by(year) %>%
  dplyr::mutate(test_07da=zoo::rollmean(Consumption,k=7,fill=NA),
                test_365da=zoo::rollmean(Consumption,k=365,fill=NA)) %>%
  dplyr::ungroup()
#we choose ayear on which we will look for the roll mean 
#check our result

mydataTest%>% 
  dplyr::arrange(moddate)%>%
  dplyr::filter(year==2017)%>%
  dplyr::select(Consumption,moddate,year,
                test_07da:test_365da)%>%
  utils::head(7)

View(mydataTest)

#now let's plot it 
par(mfrow=c(1,1))
plot(mydataTest$Consumption,xlab="year",ylab="Consumption",type="l",lwd=2,col="blue",main="Consumption Graph")

points(mydataTest$test_07da,type="l",lwd=2,
       xlim=c(2000,2018),ylim=c(900,2000),col="orange")
lines(mydataTest$test_365da,type = "l",lwd=8,xlim=c(2000,2018),
      ylim=c(900,2000),col="black")
legend(2500,1600,legend=c("Daily","rolling mean(7 days)",
                          "rolling mean(yearly)"),col = c("blue","orange","black"),pch=c("o","*","+"),lty=c(1,2,3),ncol=1)

