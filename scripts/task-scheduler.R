library(taskscheduleR)

#run the main.R compiler to update ticker data, merge with portfolio and execute
myscript <- "D:/Max Kruisbrink/Developer/R-projects/demo-portfolio-tracker/scripts/main.R"

#run every day at the same time on 18:00, starting today
taskscheduler_create(taskname = "update-portfolio-tracker", 
                     rscript = myscript, 
                     schedule = "DAILY", 
                     starttime = "12:00", 
                     startdate = format(Sys.Date(), "%d/%m/%Y"))


## Run every 15 minutes, starting from 11:10
#taskscheduler_create(taskname = "update-portfolio-tracker-15min",
#                     rscript = myscript,
#                     schedule = "MINUTE",
#                     starttime = "11:10", 
#                     modifier = 15)


