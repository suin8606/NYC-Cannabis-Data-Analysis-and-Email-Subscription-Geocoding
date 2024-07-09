#List of packages
library(dplyr)
library(forcats)
library(ggplot2)
library(tidytext)
library(tidyr)
library(ggmap)
library(leaflet)
library(tidyverse)
library(tidygeocoder)
mail_df=read.csv("/Users/suinkim/Downloads/Cannabuff_Updated_Mailing.csv")
colnames(mail_df)=tolower(colnames(mail_df))# replace columns to lower
head(mail_df)
geo=mail_df %>% geocode(street=street.address, city=city,postalcode = zip.code, method='census')
manual_lat=c('43.17684595449373')
manual_long=c('-76.29592412924086')
manual_lat = as.numeric(strsplit(manual_lat, ',')[[1]])
manual_long = as.numeric(strsplit(manual_long, ',')[[1]])
geo_map=geo %>% mutate(lat=ifelse(is.na(lat),manual_lat, lat),
                     long=ifelse(is.na(long),manual_long,long))
class(geo_map)
# Create a leaflet map with your data
mymap <- leaflet() %>%
  addTiles() %>%
  addMarkers(data = geo_map, lat = ~lat, lng = ~long, popup = ~street.address)
mymap
geo_map_df=geo_map %>% select_if(~any(.!=0)) #remove empty columns
geo_map_df=geo_map[, colSums(is.na(geo_map))==0] #the same
geo_map_df=geo_map %>% select(-"or.current.resident") #remove specific column
head(geo_map_df)
#Group by States
geo_map_df %>% group_by(state) %>% summarize(count=n())

library(lubridate)
#Convert date format
geo_map_df$end.date <- parse_date_time(geo_map_df$end.date, orders = c("bY", "BY", "B Y",'%b-%y'))
#Categorize either expire or active by end.date
dt_expire=geo_map_df %>% mutate(exp=ifelse(end.date<Sys.Date(),"Expired","Active"))
dt_expire %>% group_by(exp) %>% summarize(count=n())

#Confirm Gary doesn't have an email info.
dt_expire %>% filter(exp =='Active') %>%  select(name,email,exp)

#Sub
sub_df=read.csv("/Users/suinkim/Downloads/Cannabuff_Subscribed_List.csv")
sub_df=sub_df %>% select_if(~any(.!=0))
#No duplicated email address.
sum(duplicated(sub_df$Email.Address))

#install.packages("anytime")
library(anytime)
#Extract Year only for the further analysis.
sub_df=sub_df[order(sub_df$CONFIRM_TIME, decreasing = FALSE),]
#install.packages("anytime")
sub_df$dt=anytime(sub_df$CONFIRM_TIME)
sub_df$yr=as.integer(format(sub_df$dt, "%Y"))
#group by years(CONFIRM_TIME base) & count how many subscription has been increased. 
yr=sub_df %>% group_by(yr) %>% summarize(n_count=n_distinct(Email.Address))
yr=data.frame(yr)
ggplot(yr, aes(x=as.factor(yr),y=n_count))+
  geom_bar(stat='identity',fill='skyblue',color='black')+
  geom_text(aes(label=n_count),vjust=0)+
  labs(title="Email Registeration by Year", x='Year',y='Count')+
  theme(plot.title = element_text(hjust = 0.5))

#assume 3 different categories on email. 1.LLC (by First-name col) 2.@edu 3.@aol and so on.
head(sub_df)
sub_df$frst=c()
for (i in seq(nrow(sub_df))){
  if(nzchar(sub_df$First.Name[i])){
    sub_df$frst[i]='1'
  } else {
    sub_df$frst[i]='0'
  }
}
library(knitr)
#Can assume approximately there are 147 LLC in subscription list.
fst=sub_df %>% group_by(frst) %>% summarize(count=n())
kable(fst, format = "simple",caption='summary table')

#
df=c()
df$pattern[grepl('@gmail\\.com',sub_df$Email.Address)]='gmail'
df$pattern[grepl('\\.edu$',sub_df$Email.Address)]="edu"
df$pattern[is.na(sub_df$Email.Address)]="others"
#df$pattern <- sub("^(.*)@.*\\.edu$", "\\1", sub_df$Email.Address)
df=data.frame(df)
df %>% filter(pattern=='edu')

