library(ISLR)
library(dplyr)
library(neuralnet)


View(Auto)
summary(Auto)

plot(Auto)


Auto<-Auto[,-8]



College$Private<-as.numeric(College$Private)-1




maxs<-apply(College, 2, max)
mins<-apply(College, 2, min)

scaled<-as.data.frame(scale(College,center = mins, scale = maxs - mins))


library(caTools)
set.seed(101)



split = sample.split(scaled$Private, SplitRatio = 0.70)


train = subset(scaled, split == TRUE)
test<- subset(scaled, split==F)


n<-names(scaled)
f<-paste(n[-1], collapse = " + ")
f<-paste("Private ~ ", f)


nn<-neuralnet(f, data=scaled, hidden = 5 )


predicted <- compute(nn,test[2:18])
predicted<-predicted$net.result
predicted<-round(predicted)


table(predicted, test[,1])


mean(predicted==test[,1])
