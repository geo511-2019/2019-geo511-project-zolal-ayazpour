#setwd("C:/Users/ovpr.nimamaso/Box/Desktop/GEO511 - Spatial Data Science/Project")
rm(list=ls())
`%!in%` = Negate(`%in%`)
##########
#Packages#
##########
library(raster)
library(rgdal)

###############################################################################
# Loading files #
#################
# for(Y in c(2017:2018)){
#   for(M in c(1:12)){
#     
#     length(list.files(paste0(,'/NY/Y2018'), recursive = TRUE))
#   }
# }
# 
# f_name <- paste0("C:/Users/ovpr.nimamaso/Box/Desktop/GEO511 - Spatial Data Science/Project/",
#                 'NY/Y2018/M06/D13/CONUS_2D_20180613.nc')
# f_data <- nc_open(f_name)
# #f_data <- st_read(f_name)
# a=ncvar_get(f_data, f_data$var[[13]])
# 
# 
# b=array(list(),dim = c(3,3,2))
# 
# 
# 




############
## Raster ##
############
# f_name <- paste0("C:/Users/ovpr.nimamaso/Box/Desktop/GEO511 - Spatial Data Science/Project/",
#                                   'NY/Y2018/M06/D13/CONUS_2D_20180613.nc')
# c<-brick(f_name, varname='t2m')
# 
# f_name2 <- paste0("C:/Users/ovpr.nimamaso/Box/Desktop/GEO511 - Spatial Data Science/Project/",
#                   'NY/Y2017/M06/D13/CONUS_2D_20170613.nc')
# d<- brick(f_name2, varname='t2m')
# 
# # this usage of overlay is hour-based
# e <- overlay(c,d,fun=function(arg1,arg2){return((arg1+arg2)/2)})
# plot(e)
# 
# # this usage of statistics incorporate all raster layers
# f <- mean(c,d)
# plot(f)
# 
# # returns the mean across the space for each hour
# g<-cellStats(c,mean)
# plot(g,type='b')
# 
# 
# calc(c, sd)
# 
# 
# list.files(paste0(getwd(),'/NY/Y2017'), recursive = TRUE)
# 




for(Y in c(2017)){
  seasonal_data= list()
  monthly_data= list()
  ls= list.files(paste0(getwd(),'/NY/Y2017/'), recursive = TRUE)
  l= length(ls)
  daily_df= data.frame(Date= numeric(),
                       Mean= numeric(),
                       SD= numeric(),
                       Median= numeric(),
                       Min= numeric(),
                       Max= numeric())
  
  
  for(M in c(5)){
    ls= list.files(paste0(getwd(),'/NY/Y2017/M05/'), recursive = TRUE)
    l= length(ls)
    
    
    for(i in c(1:l)){
      f_name= paste0(getwd(),'/NY/Y2017/M05/',ls[i])
      day_brick= brick(f_name, varname='t2m')
      daily_df[i,1]= i
      daily_df[i,2]= calc(day_brick, mean)
      daily_df[i,2]= calc(day_brick, sd)
      daily_df[i,3]= calc(day_brick, min)
      daily_df[i,4]= calc(day_brick, max)
      daily_df[i,5]= calc(day_brick, median)
      
    }
    # this is the brick of the every hours in a month
    #monthly_data = brick(daily_data)
  }
}

# calculation over time: result is one raster
mean(monthly_data)
# calculation over space: result is 24 values for each hour across the space
length(cellStats(monthly_data,'sd'))
stackApply(monthly_data, fun='sd')



# THIS IS IT!!
calc(monthly_data,sd)
calc(monthly_data,mean)
calc(monthly_data,min)
