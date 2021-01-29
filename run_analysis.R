#Merging x ,y and z Training and Testing Data

rm(list=ls())
list.files()
library(tidyverse)
install.packages("fs")
library(fs)
library(dplyr)
library(reshape2)

file_path <- fs::dir_ls("D:/COUSERA COUSES/Data Science John Hopkins/2.Getting and Cleaning Data/Week 4/UCI Common")
file_path

#acc test
body_acc_x_test <- read.delim("body_acc_x_test.txt")
body_acc_y_test <- read.delim("body_acc_y_test.txt")
body_acc_z_test <- read.delim("body_acc_z_test.txt")

#acc train
body_acc_x_train <- read.delim("body_acc_x_train.txt")
body_acc_y_train <- read.delim("body_acc_y_train.txt")
body_acc_z_train <- read.delim("body_acc_z_train.txt")

#gyro test
body_gyro_x_test <- read.delim("body_acc_x_test.txt")
body_gyro_y_test <- read.delim("body_acc_y_test.txt")
body_gyro_z_test <- read.delim("body_acc_z_test.txt")

#gyro train
body_gyro_x_train <- read.delim("body_gyro_x_train.txt")
body_gyro_y_train <- read.delim("body_gyro_y_train.txt")
body_gyro_z_train <- read.delim("body_gyro_z_train.txt")


#total acc test
total_acc_x_test <- read.delim("total_acc_x_test.txt")
total_acc_y_test <- read.delim("total_acc_y_test.txt")
total_acc_z_test <- read.delim("total_acc_z_test.txt")

#total acc train
total_acc_x_train <- read.delim("total_acc_x_train.txt")
total_acc_y_train <- read.delim("total_acc_y_train.txt")
total_acc_z_train <- read.delim("total_acc_z_train.txt")

#x
X_test <- read.delim("X_test.txt")
X_train <- read.delim("X_train.txt")


#y
y_test <- read.delim("y_test.txt")
y_train <- read.delim("y_train.txt")

#Subject

subject_test<- read.delim("subject_test.txt")
subject_train <- read.delim("subject_train.txt")



#merging 

body_acc_x  <- rbind(body_acc_x_test,body_acc_x_train)
body_acc_y  <- rbind(body_acc_y_test,body_acc_y_train)
body_acc_z  <- rbind(body_acc_z_test,body_acc_z_train)


body_gyro_x <- rbind(body_gyro_x_test,body_gyro_x_train)
body_gyro_x <- rbind(body_gyro_x_test,body_gyro_x_train)
body_gyro_x <- rbind(body_gyro_x_test,body_gyro_x_train)


total_acc_x <- rbind(total_acc_x_test,total_acc_x_train)
total_acc_y <- rbind(total_acc_y_test,total_acc_y_train)
total_acc_z <- rbind(total_acc_z_test,total_acc_z_train)


#load feature & activity info

feature <- read.delim(paste(sep = "","features.txt"))

# activity labels
a_label <- read.delim(paste(sep = "", "activity_labels.txt"))
a_label[,1] <- as.character(a_label[,1])

# extract feature cols & names named 'mean, std'
selectedCols <- grep("-(mean|std).*", as.character(feature[,1]))
selectedColNames <- feature[selectedCols, 1]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)


#4. extract data by cols & using descriptive name
x_data <- x_data[selectedCols]
body_Data <- cbind(body_acc_x, body_acc_y, body_acc_z)
body_gyro <- cbind(body_gyro_x, body_gyro_y, body_gyro_z)
total_acc <- cbind(total_acc_x, total_acc_x, total_acc_x)

allData <- cbind(body_Data,body_gyro,total_acc) 


colnames(allData) <- c("Subject", "Activity", selectedColNames)

allData$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
allData$Subject <- as.factor(allData$Subject)


#5. generate tidy data set
meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)

