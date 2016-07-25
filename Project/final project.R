Directory <- "~/Documents/University of Virginia/2016 SPRING/STAT 3480/Final Project/Adult.csv"
Adult <- read.csv(Directory)
attach(Adult)

library(jmuOutlier)
## Warning: package 'jmuOutlier' was built under R version 3.2.4
# RMD test
# Test if people who work as professional sepciality have larger education num than people who work as executive managerial. 

index.prof = which(Occupation ==" Prof-specialty")
index.Exec = which(Occupation ==" Exec-managerial")
EducationNum[index.Exec]
##  [1]  9 10 13 13 10 10 10  9 14  9 16 13 10 14 10 10 13
EducationNum[index.prof]
## [1] 15 14 13 13 14  9 15
rmd.test(EducationNum[index.Exec],EducationNum[index.prof], alternative = "two.sided")
## [[1]]
## [1] "p-value was estimated based on 20000 simulations."
## 
## $alternative
## [1] "two.sided"
## 
## $rmd.hat
## [1] 1.326797
## 
## $p.value
## [1] 0.6411
wilcox.test(EducationNum[index.prof],EducationNum[index.Exec],alternative = "two.sided")
## Warning in wilcox.test.default(EducationNum[index.prof],
## EducationNum[index.Exec], : cannot compute exact p-value with ties
## 
##  Wilcoxon rank sum test with continuity correction
## 
## data:  EducationNum[index.prof] and EducationNum[index.Exec]
## W = 87.5, p-value = 0.07334
## alternative hypothesis: true location shift is not equal to 0


##ii. Working Hours and Work Class


index.private = which(Workclass==" Private")
index.Selfempnotinc= which(Workclass==" Self-emp-not-inc")
index.Selfempinc = which(Workclass==" Self-emp-inc")

adult.new = adult[c(index.private,index.Selfempinc,index.Selfempnotinc),]
boxplot(HoursPerWeek[index.private],HoursPerWeek[index.Selfempinc],HoursPerWeek[index.Selfempnotinc])


kruskal.test(HoursPerWeek~Workclass,data = adult.new)
## 
##  Kruskal-Wallis rank sum test
## 
## data:  HoursPerWeek by Workclass
## Kruskal-Wallis chi-squared = 2.7133, df = 2, p-value = 0.2575


##iii. Working Hours and School Degree

#Boxplot
HSgrad=HoursPerWeek[which(Education==" HS-grad")]
SomeCollege=HoursPerWeek[which(Education==" Some-college")]
Bachelor=HoursPerWeek[which(Education==" Bachelors")]

boxplot(HSgrad,SomeCollege,Bachelor,main="JT Test Box Plot")

#Jonckheere-Terpstra Test
library(clinfun)
pieces<-list(HSgrad,SomeCollege,Bachelor)
n<-c(28,21,14)
grp<-as.ordered(factor(rep(1:length(n),n)))
jonckheere.test(unlist(pieces),grp,alternative="increasing")
## Warning in jonckheere.test(unlist(pieces), grp, alternative = "increasing"): Sample size > 100 or data with ties 
##  p-value based on normal approximation. Specify nperm for permutation p-value
## 
##  Jonckheere-Terpstra test
## 
## data:  
## JT = 748, p-value = 0.07777
## alternative hypothesis: increasing


##iv. Correlation between Gender and Occupation


### CONTINGENCY TABLE & DATA MANIPUTATION

MaleOcc <- table(Occupation[which(Sex == " Male")])
FemaleOcc <- table(Occupation[which(Sex == " Female")])
Row1 <- as.numeric(MaleOcc)     # Male
Row2 <- as.numeric(FemaleOcc)   # Female
table(Occupation)
## Occupation
##                  ?       Adm-clerical       Craft-repair 
##                 24                  8                  4 
##    Exec-managerial    Farming-fishing  Handlers-cleaners 
##                 17                  4                  3 
##  Machine-op-inspct      Other-service     Prof-specialty 
##                  4                  8                  7 
##    Protective-serv              Sales       Tech-support 
##                  1                  6                  2 
##   Transport-moving 
##                  1
sum(Sex == " Male")        # number of males
## [1] 61
sum(Sex == " Female")      # number of females
## [1] 28
### RUNNING THE PERMUTATION CHI-SQUARE TEST

### Make observed contingency table and calculate stat
Table = rbind(Row1,Row2)
teststat.obs = chisq.test(Table)$statistic
## Warning in chisq.test(Table): Chi-squared approximation may be incorrect
teststat.obs
## X-squared 
##  26.84885
### create the prefernce data and the gender data
preference = c(rep("Unknown",24), rep("AdmClerical",8),
               rep("CraftRepair",4), rep("Exec",17),
               rep("FarmFish",4), rep("Handler",3),
               rep("MachineOpIns",4), rep("Other",8),
               rep("Prof",7), rep("Protect",1),
               rep("Sales",6), rep("Tech-support",2),
               rep("Transport",1))
gender = c( rep("Male",61), rep("Female",28) )
table(preference); table(gender)
## preference
##  AdmClerical  CraftRepair         Exec     FarmFish      Handler 
##            8            4           17            4            3 
## MachineOpIns        Other         Prof      Protect        Sales 
##            4            8            7            1            6 
## Tech-support    Transport      Unknown 
##            2            1           24
## gender
## Female   Male 
##     28     61
y = preference; x = gender
teststat = rep(NA, 1000)
for(i in 1:1000) {
  ### randomly "shuffle" the y data between the x groups
  ySHUFFLE = sample(y)
  ### compute chi-square stat for the shuffled data
  TableSHUFFLE = table(x,ySHUFFLE)
  teststat[i] = chisq.test(TableSHUFFLE)$statistic
}
### calculate the approximate p-value
sum(teststat >= teststat.obs)/1000
## [1] 0.004


##v. The Effect of Education and Capital Gains on the Hours per Week for Working 

### create our data
oursample = adult
ENthetahat = lm(HoursPerWeek~EducationNum+CapitalGain,data=oursample)$coeff[2]
CGthetahat = lm(HoursPerWeek~EducationNum+CapitalGain,data=oursample)$coeff[3]
ENthetahat; CGthetahat; 
## EducationNum 
##   -0.1740954
##  CapitalGain 
## 0.0009557792
ENthetahat.b = rep(NA,1000); CGthetahat.b = rep(NA,1000); 
for (i in 1:1000) {
  ### draw the bootstrap sample and calculate thetahat.b
  index = 1:89
  bootindex = sample(index, 89, replace=T)
  bootsample = oursample[bootindex,]
  ENthetahat.b[i] = lm(HoursPerWeek~EducationNum+CapitalGain,data=bootsample)$coeff[2]
  CGthetahat.b[i] = lm(HoursPerWeek~EducationNum+CapitalGain,data=bootsample)$coeff[3]
}
par(mfrow=c(1,2))
hist(ENthetahat.b); hist(CGthetahat.b);
