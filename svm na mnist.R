library(MASS)
library(corrplot)


library(readr)
mnist_train <- read_csv("mnist_train.csv", 
                        col_names = FALSE)

library(dplyr)
apply(mnist_train, 2, var)%>%as.vector()->variancje
a<-c(1:785)
a[variancje[-1]!=0]
mnist_train%>%select(a[variancje!=0])->bez_kol



bez_kol_train<-bez_kol[1:10000,]


library (e1071)
library(ggplot2)



bez_kol_train$X1<-as.factor(bez_kol_train$X1)
svm_fit<-svm(X1~., data=bez_kol_train, type="C", kernel="")


pred<-predict(svm_fit, bez_kol[10000:11000,-1])
pred<-as.vector(pred)


labels<-as.vector(as.matrix(bez_kol[10000:11000,1]))

a<-as.data.frame(cbind(labels, pred))
mean(a$labels!=a$pred)   #92% 









