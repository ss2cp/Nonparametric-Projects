# Nonparametric Project

##Background

**Another one of my Machine Learning projects predicting people's annual income using Java also applies the same dataset can be found here:* [MachineLearning-NaiveBayesClassifier](https://github.com/ss2cp/MachineLearning-NaiveBayesClassifier)

This project is to study the influence of education level on occupation on people of age 70.

**Data:** 

* "AdultUCI" is from UCI Machine Learning Repository. 
* The AdultUCI data set contains the questionnaire data of the “Adult” database (originally called the “Census Income” Database) formatted as a data.frame. 
* Extraction was done by Barry Becker from the 1994 Census database. 
* The AdultUCI data set contains a data frame with 48842 observations on the following 15 variables. 
* It was originally used to predict whether income exceeds USD 50K/yr based on census data. 

*We chose the group of age 70 as our main interest, because they were the group born around the Great Depression and influenced by the WWII when they entered the workforce, 
two specific time periods that likely impacted the education and occupation of the subject group. 
Our questions are mostly concerned with the relationship between education and occupation of this particular generation, 
due to the special background of this group.*

**Goal:** To study the influence of education level on occupation on people of age 70.

**Language:** R

####*First 20 Lines of Data:*

```
   Age         Workclass fnlwgt     Education EducationNum       MaritalStatus         Occupation    Relationship                Race     Sex CapitalGain CapitalLoss HoursPerWeek  NativeCountry SalaryType
1   70           Private 105376  Some-college           10       Never-married       Tech-support  Other-relative               White    Male           0           0           40  United-States      <=50K
2   70                 ? 167358           9th            5             Widowed                  ?       Unmarried               White  Female        1111           0           15  United-States      <=50K
3   70       Federal-gov 163003       HS-grad            9  Married-civ-spouse       Adm-clerical         Husband               Black    Male           0           0           40  United-States      <=50K
4   70           Private  30713       HS-grad            9  Married-civ-spouse    Farming-fishing         Husband               White    Male           0           0           30  United-States      <=50K
5   70           Private 131060       7th-8th            4  Married-civ-spouse      Other-service         Husband               White    Male           0           0           25  United-States      <=50K
6   70           Private 262345  Some-college           10       Never-married       Adm-clerical   Not-in-family               White  Female           0           0            6  United-States      <=50K
7   70           Private  94692     Bachelors           13  Married-civ-spouse              Sales         Husband               White    Male           0           0           70  United-States       >50K
8   70           Private  35494       HS-grad            9  Married-civ-spouse    Exec-managerial         Husband               White    Male           0           0           30  United-States      <=50K
9   70           Private 121993       HS-grad            9  Married-civ-spouse       Adm-clerical            Wife               White  Female           0           0            5  United-States      <=50K
10  70                 ? 173736     Bachelors           13  Married-civ-spouse                  ?         Husband               White    Male           0           0            6  United-States      <=50K
11  70           Private 642830       HS-grad            9            Divorced    Protective-serv   Not-in-family               White  Female           0           0           32  United-States      <=50K
12  70  Self-emp-not-inc 172370   Prof-school           15  Married-civ-spouse     Prof-specialty         Husband               White    Male           0           0           25  United-States      <=50K
13  70           Private 176285       HS-grad            9            Divorced      Other-service   Not-in-family               White  Female           0           0           23  United-States      <=50K
14  70                 ? 293076  Some-college           10  Married-civ-spouse                  ?         Husband               White    Male           0           0           30  United-States      <=50K
15  70         Local-gov 176493  Some-college           10             Widowed       Adm-clerical   Not-in-family               White  Female           0           0           17  United-States      <=50K
16  70  Self-emp-not-inc 150886  Some-college           10  Married-civ-spouse       Craft-repair         Husband               White    Male           0           0           25  United-States      <=50K
17  70           Private  77219       HS-grad            9  Married-civ-spouse       Craft-repair         Husband               White    Male           0           0           37  United-States      <=50K
18  70           Private 220589  Some-college           10             Widowed    Exec-managerial   Not-in-family               White  Female           0           0           12  United-States      <=50K
19  70         Local-gov  88638       Masters           14       Never-married     Prof-specialty       Unmarried               White  Female        7896           0           50  United-States       >50K
20  70           Private 145419       HS-grad            9             Widowed       Adm-clerical       Unmarried               White  Female           0           0            5  United-States      <=50K
```

##Analysis methods
* One-sided Wilcoxon Rank-Sum (WRS) Test
* Two-sided RMD Test to test for equal variance
* Kruskal-Wallis Test
* Jonchheere-Terpstra Test
* Permutation Chi-square Test
* Bootstrap Regression

**Criteria for statistical significance is P<0.05.*

## Parametric versus Nonparametric Methods
Whereas parametric tests make assumptions about the population distribution, nonparametric tests require minimal assumptions about the population distribution. The specific form of our data’s distribution is unknown and we do not have enough evidence to make strong assumptions such as population normality. Also our dataset contains a number of categorical variables of both types: ordinal and nominal. Thus nonparametric is more applicable and should yield more reliable results compared to student t-test and other parametric tests.

##Summary Statistic
The subgroup of data we will be using is extracted from the original “Adult” dataset, and all the observations extracted share a common value of 70 for the Age variable. The new dataset contains 89 observations for each of the original 13 variables, 5 of which are continuous.

##Statistical Tests and Analytical Methodologies

###Any difference in Education Years (EducationNum) between Professional/Specialty and Executive Managerial?
We suspect that people who work as executive managerial could acquire their knowledge from real life experience and other sources, not necessarily dependent on their years of education.  Education years may not be as important for executive managerial occupation as professional specialty. 

We plan to use one-sided Wilcoxon Rank-Sum (WRS) Test for this case. WRS is a two-sample permutation test based on W, the sum of the ranks of the observations from one of the treatments. It simply ranks each observation after combing the groups together, finding all possible permutations of the ranks and calculates the p-value based on the permutation results of the probability of how many number of rank sums are greater than the observed rank sum. As for the hypothesis, the null hypothesis is that *H0: F1(x) = F2(x)*, that people who work as professional specialty and executive manager have same distribution in terms of education years. The alternative hypothesis is that *Ha: F1(x) ≠ F2(x)*, that these two groups of people with different occupation have different distributions of education years.

However, WRS requires some assumptions, and the successful implementation of WRS depends on whether or not these assumptions are met. Firstly, the population distribution needs to depend on location and scale parameters. Secondly, the distribution is continuous. Thirdly, it has identical population distributions. Fourthly, it requires equal variances among groups. The first three assumptions are met here. In order to apply the WRS, we need to test the equal variances.

Here we need to use the RMD to test for the deviances. We do not know the normality of the sample variances and we do not know the location parameters. We will use the sample medians instead of means to obtain the deviances for each group.
The null hypothesis for RMD Test will be: *H0: σ1 = σ2*. It means that the professional speciality and executive manager have the equal variances in education number. The alternative hypothesis for RMD Test will be: *Ha: max(σ1, σ2) / min(σ1, σ2) > 1*. This is a two-sided RMD Test and we will use it to test if the variances for two treatments are different.

###Working Hours and Work Class
We are interested in knowing if working hours per week differs among working classes. Since we have more than two treatments and we want to know if there is difference among these three treatments, we will use a Kruskal-Wallis test to test if at least one work class has different working hours than other classes.

Kruskal-Wallis Test is a nonparametric rank test that compares k treatments by replacing the original observations with ranks and performs the permutation F-test on those ranks. For large samples, KW test statistic follows chi-square distribution approximately with (k-1) degrees of freedom. Before applying Kruskal-Wallis test, we also need to check the Kruskal-Wallis test does require the assumption for homoscedasticity, which we have already checked using the boxplot in the summary statistics. The null hypothesis is that there is no difference in working hours among private, incorporated self-employment, and unincorporated self-employment working class. The alternative hypothesis is that at least one of the working classes has a different working hour from the others.

###Working Hours and Education
We anticipate that higher education lead to more working hours. We suspect that a higher education level will lead to better jobs, and better jobs will likely require more working hours. In this situation, we assume that people with bachelor degrees have longer working hours than those with some college degree than those with bachelor degree. We decide to use Jonchheere-Terpstra Test to test for an increasing trend. Under null hypothesis, the three different population distributions are the same. Therefore, we use a boxplot to check for equal variance cross these three groups before applying Jonchheere-Terpstra Test. 

*H0 : F1(x) = F2(x) = F3(x)*
Our null hypothesis is that population distribution are the same for people with graduate education (HS-grad), some-college and bachelor degree. 

*Ha : F1(x) ≤ F2(x) ≤ F3(x)*
Alternative hypothesis is that working hours increase with education levels.

###Correlation between Gender and Occupation
Besides the relationship between education and occupation, we are also interested in knowing if gender plays a factor in determining the types of occupation a person of the 70-year-old generation chooses. For this question, we hope to determine if there exists a correlation between the gender of a person and the occupation he or she chooses. The jobs for the age group of people fall into thirteen categories, and observations for the gender only include “Male” and “Female,” another categorical variable. The contingency table is shown below.

|  | Male|Female|
| ------------- | ------------- | ------------- |
|Unknown|15|9|
|Adm-clerical|2|6|
|Craft-repair|4|0|
|Executive-managerial|15|2|
|Farming-fishing|4|0|
|Handlers-cleaners|3|0|
|Machine-op-inspection|3|1|
|Other Services|2|6|
|Professional/Specialty|5|2|
|Protective Service|0|1|
|Sales|5|1|
|Technical Support|2|0|
|Transport-moving|1|0|


To determine if an association between two categorical variables exists, a chi-square test should be used, and in our case we should be employing a permutation chi-square test, because of a violation of one of the two assumptions. A traditional chi-square test requires two assumptions: the independence assumption, that the observations are not dependent, and the sample size assumption, that most of the expected cell counts should be at least 5. The observations in our data violate the second assumption, as more than half of the cell counts are less than 5. Hence we will be using permutation chi-square test, an alternative method that solves the problem by creating a permutation distribution of the X2 statistic. In our case, we will permute the data 1000 times. The p-value of this test is the fraction of the number of test statistics greater than the original chi-square test statistic over the number of all test statistics from our permutation (note that the chi-square test is always an one-tailed test). The null hypothesis is that there is no association between gender and occupation among the surveyees, and the alternative hypothesis is that there exists a correlation between gender and occupation among the 70 year olds.

###The Effect of Education and Capital Gains on the Hours per Week for Working 

We plan to use the regression to address this problem. Regressions are used when we want to find the scale effect of how variables can affect a dependent variable. In this case, we hope to see answers to two basic questions: (1) if people with higher education tend to work shorter and (2) if people with extra capital gains tend to affect their decisions of how long to work. 

To be more specific, we plan to use the Bootstrapping Regression Method to address the problem. Bootstrapping is a nonparametric approach to statistical inference that substitutes computation for more traditional distributional assumptions and asymptotic results. As the simple multiple linear regression requires normal distribution for the data, we can not simply apply that to our analysis as the variables HoursPerWeek, EducationNum and CapitalGain are all skewed and not normally distributed due to our small data size and the nature of those data. The bootstrap can provide more accurate inferences when the data are not well behaved or when the sample size is small. It is also possible to apply the bootstrap to statistics with sampling distributions that are difficult to derive, even asymptotically.  Further, the bootstrap regression will provide us with a narrower confidence interval. 

We are going to construct a bootstrap interval for the slope of the line for predicting HoursPerWeek from numbers of education and extra capital gains. We are performing the standard test of slope: *H0 : β1 = β2 = 0* versus *H1 : β1 ≠0, β2 ≠ 0*.

##Results from Tests and Applications

|Question|Test|Test statistic|Test statistic value|P-value|
| ------------- | ------------- | ------------- | ------------- | ------------- |
|I|RMD Test for Deviances|RMD|1.326797|0.6411|
| |Wilcoxon Rank-sum Test|W_obs|87.5|0.07334|
|II|Kruskal-Wallis Test|KW_X-Sqaure|2.7133|0.2575|
|III|Jonchheere-Terpstra|JT|74|0.0777|
|IV|Chi-square Test|&#935;-Square|26.8|26.8|
|V|**Bootstrap Regression**| | | |
| |**Independent Variable**|**95% Lower Bootstrap Interval**|**95% Upper Bootstrap Interval**|**P-value**|
| |EducationNum|-1.141598|0.9127412|Greater than 0.05|
| |CapitalGain|0.0002935431|0.002403871|Smaller than 0.05|

##Disscussion of Results
###Any difference in Education Years (EducationNum) between Professional/Specialty and Executive Managerial?
The RMD Test gave us the p-value of 0.64385 > 0.5, and hence we fail to reject the null hypothesis that there are equal variances between population distribution of education level for occupation professional specialists and executive managerial at a significance level of 0.05. We came to the conclusion that the two groups (Prof-speciality & Exec-managerial) have equal variances and we can proceed to use the WRS Test.

The Wilcoxon Rank Sum Test gave us the W test statistic as 87.5 with p-value 0.07334 >0.05. We fail to reject the null hypothesis at a significance level of 0.05. We have weak evidence to show there is a difference between adult occupation professional specialty and executive managerial. We came to the conclusion that there is not much difference in distribution of education years(EducationNum) between occupation professional speciality and executive managerial.

###Working Hours and Work Class
The box plot shows that there is not significant difference in variances of working hours for these three work classes. The magnitude is about the same across these three different groups. 

The Kruskal-Wallis test gives us the KW test statistic of 2.7133 with p-value 0.2575, which is higher than the significant level of 0.05. Hence we fail to reject the null hypothesis and conclude that there is not a significant difference in working hours among these three working classes.

###Working Hours and Education
From the boxplot, variances do not differ much cross these three population distributions. Thus, our assumption that population distributions for these three groups have equal variance is met and we could continue to run the Jonckheere-Terpstra Test. 

Jonckheere-Terpstra Test gives JT test statistic 748 with p-value 0.0777>0.05. Even though p-value is small, we still fail to reject the null hypothesis at a significance level of 0.07. Therefore, we conclude that the distributions for working hours are the same among people with high school graduate education (HS-grad), some-college and bachelor degree. There is not an increasing trend in working hours with education levels. 

### Correlation between Gender and Occupation

The permutation chi-square test yields test statistic of 26.8 and a p-value of 0.004. Under the conventional significance level of 0.05, we reject the null hypothesis in favor of the alternative hypothesis, and conclude that strong evidence suggests that there exists an association between gender and occupation choice.

One thing noticeable is that one of the occupation categories is “Unknown,” and it has the biggest cell counts in both genders. This category may be a result of the surveyee’s reluctance to answer or the surveyors’ failure to properly record the data. In either case, this category may negatively contribute to the inaccuracy of our test results. However, since they are only one of the thirteen categories and their cell counts are not huge outliers, this little uncertain element will not affect our conclusion and test results.

###The Effect of Education and Capital Gains on the Hours per Week for Working 

The 95% bootstrap confidence interval for the slope of Education Numbers is (-1.141598, 0.9127412). The p−value will be greater than 0.05 because 0 is in the confidence interval. We can make a conclusion that we have strong evidence that the slope may be equal to 0. Education may not affect working hours per week.

The 95% bootstrap confidence interval for the slope of Extra Capital Gains is (0.0002935431, 0.002403871). The p−value will be less than 0.05 because 0 is not in the confidence interval. Since the bootstrap interval is so close to 0, we can make a conclusion that we have weak evidence indicating that the slope may be equal to 0. Capital Gains may affect working hours per week. 

##Conclusion
As indicated by our test results, we can say that level of education results in the difference of participants’ occupations, especially in the area of government related jobs. The positive relationship between higher education level and government jobs may have to do with the fact that government jobs, in comparison to some other jobs, are considered highly demanding for theoretical knowledge, and hence the employees generally have higher degrees to be competent for their jobs.

We also find that for participants from private, incorporated self-employment, and unincorporated self-employment working class, the lengths of their working hours do not have a significant difference. Such a result may indicate a nationwide commonly practiced working schedule, and that in order for someone to at least support him or herself, a fixed amount of working hours is necessary.

The above induction about fixed working hours may be reinforced by the next test we performed on the working hours and school degrees. Our test results show that the working hours for people with different degrees are mostly similar, and no increasing or decreasing trends are found. The fact that survey participants with high school graduate education having work hours similar to those with some college education and/or complete college education, along with the working hours and working class relationship we found, may indicate that the society has a set of working schedule that is sufficient to support basic needs of the working population. 

We have also performed a test on the correlation between gender and occupations, and our results show that gender is related to people’s choice of jobs. This can be seen in our table of gender and jobs. We have more male participants than female participants, and 7.5 times more male working as executive-managerial personnel than female. We can also see that male participants are more involved in labor works such as farming, fishing, craft repairing and cleaning. 

The last test we performed determines the effect of education and capital gains on working hours per week. As stated earlier, the questions we wish to solve are first, if people with higher education tend to work shorter; and two, if capital gains stimulate people to be flexible with their working schedules. Our test results show that education level may not affect working hours per week, which agrees with the hypothesis we set in the earlier steps - people need to work for a certain length to support themselves. Capital gains, however, may affect working hours per week. This also can be related to our earlier hypothesis, as the reasoning behind working every week is to earn money to live better, and an extra amount of capital gain leads people directly to the final step of living better, therefore affecting working hours per week. 
