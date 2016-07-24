Adult<-read.csv("adult.csv")
attach(Adult)
#getting individual groups of observations
hshour<-subset(Adult,EducationNum==9)
schour<-subset(Adult,EducationNum==10)
bahour<-subset(Adult,EducationNum==13)
#combining the three groups
eduhour<-rbind(hshour,schour,bahour)
#keep only working hours per week and education level indicator
eduhour<-subset(eduhour,select=c(EducationNum,HoursPerWeek))Q

#rank the data based on hoursperweek
eduhour_ranked<-rank(eduhour$HoursPerWeek,ties.method = "average")
#append the ranks
eduhour<-cbind(eduhour,eduhour_ranked)
detach(Adult)
attach(eduhour)

#page test
library(crank)
eduhourm<-as.matrix(eduhour)
#Ho:Working hour is not related to degree earned.
#Ha:Working hour increases for higher degrees.
page.trend.test(eduhourm)
#p value of 0 shows we reject our null hypothesis and conclude that working hours increase in accordance with degrees.

#不确定需不需要图。。。
hist(eduhourm,xlab="work hours per week",
              ylab = "number of observations",
              main="histogram of education level and work hours per week")
qqplot(EducationNum,HoursPerWeek)
