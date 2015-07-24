
#create a dataframe calles datasetTest out of the test files
file_list <- list.files(path="data/", full.names = TRUE)

for(file in file_list){
        #create the new dataset
        if(!exists("datasetTest")){
                datasetTest <- read.table(file, header=FALSE)
        }
        
        #if datasetTest exists append to it
        if(exists("datasetTest")){
                temp_dataset <- read.table(file, header=FALSE)
                datasetTest <- cbind(datasetTest, temp_dataset)
                head(datasetTest)
                rm(temp_dataset)
        }
}

#create a dataframe called datasetTrain out of the train files
file_list <- list.files(path="traindata/", full.names = TRUE)

for(file in file_list){
        #create the new datasetTrain
        if(!exists("datasetTrain")){
                datasetTrain <- read.table(file, header=FALSE)
        }
        
        #if datasetTrain exists append to it
        if(exists("datasetTrain")){
                temp_dataset <- read.table(file, header=FALSE)
                datasetTrain <- cbind(datasetTrain, temp_dataset)
                head(datasetTrain)
                rm(temp_dataset)
        }
}

#rename appropriate columns in each dataset
colnames(datasetTest)[564] <- "activity"
colnames(datasetTest)[1] <- "subject"
colnames(datasetTrain)[564] <- "activity"
colnames(datasetTrain)[1] <- "subject"

#make vector from features.txt
dfeature <- read.table("info/features.txt", header=FALSE)
nvector <- dfeature[['V2']]

library(plyr)
#rename remaining columns in each dataset
names(datasetTest)[3:563]  <- as.character(nvector)
names(datasetTrain)[3:563]  <- as.character(nvector)

#remove extra colums
datasetTest$V1 <- NULL
datasetTrain$V1 <- NULL

#rbind datasetTest and datasetTrain
dataT <- rbind(datasetTest, datasetTrain)

#remove duplicated columns as they do not belong to the scope of this exercise
dataT <- dataT[, !duplicated(colnames(dataT))]

#step 2 extracting only mean and std for each measurement
library(dplyr)
data <- tbl_df(dataT)
arrange(data, subject, activity)
datas <- select(data, subject, activity, contains("mean", ignore.case = TRUE), contains("std", ignore.case = TRUE))
#dim(datas)#10299    88
#View(datas)

#step 3 use descriptive activity name
datas$activity <- as.character(datas$activity)
datas$activity[datas$activity == "1"] <- "WALKING"
datas$activity[datas$activity == "2"] <- "WALKING_UPSTAIRS"
datas$activity[datas$activity == "3"] <- "WALKING_DOWNSTAIRS"
datas$activity[datas$activity == "4"] <- "SITTING"
datas$activity[datas$activity == "5"] <- "STANDING"
datas$activity[datas$activity == "6"] <- "LAYING"
#View(datas)

#step 4 renaming columns names
datase <- datas
nam <- names(datase)
#body and gravity acceleration
nam <- sub("BodyAcc-", "-body acceleration-", nam, ignore.case = FALSE)
nam <- sub("BodyAcc", "-body acceleration-", nam, ignore.case = FALSE)
nam <- sub("GravityAcc-", "-gravity acceleration-", nam, ignore.case = FALSE)
nam <- sub("GravityAcc", "-gravity acceleration-", nam, ignore.case = FALSE)
nam <- sub("^[tbody]", "t-body", nam, ignore.case = FALSE)
nam <- sub("^[t]", "time", nam, ignore.case = FALSE)
#Fast Fourier Transform
nam <- sub("^[fbody]", "f-body", nam, ignore.case = FALSE)
nam <- sub("^[f]", "Fast Fourier Transform", nam, ignore.case = FALSE)
#bodyBody
nam <- sub("bodyBody", "body", nam, ignore.case = FALSE)
#body-body
nam <- sub("body-body", "body", nam, ignore.case = FALSE)

names(datas)[1:88]  <- as.character(nam)

#step 5 create a second dataset with the average of each variable for activity and each subjetc
library(reshape2)
dataMelt <- melt(datas, id=c("subject", "activity"), measure.vars = c(colnames(datas[,3:88])))
averageset <- dcast(dataMelt, formula = subject+activity  ~ variable, mean)

#write new file
write.table(averageset, file="average_data.txt", append = FALSE, quote = FALSE, sep = " ", row.names = FALSE, col.names = TRUE)
