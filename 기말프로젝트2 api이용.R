

install.packages("XML")
install.packages("colorspace")
library(colorspace)
library(XML)


busRtNm = "11-1" 
API_key = " my key "
url = paste("http://apis.data.go.kr/6410000/busrouteservice/getBusRouteList?serviceKey=", 
            API_key,"&keyword=",busRtNm,sep="")

xmefile = xmlParse(url)
xmlRoot(xmefile)
df = xmlToDataFrame(getNodeSet(xmefile, "//busRouteList"))  # 데이터프레임으로 출력
t(df);
df=head(df)

####

# region_name=df$regionName


suwon_bus =df[df$regionName=="수원",]
suwon_bus_routeID=suwon_bus$routeId


url = paste("http://apis.data.go.kr/6410000/busrouteservice/getBusRouteStationList?serviceKey=",
            API_key,"&routeId=",suwon_bus_routeID,sep="")

xmefile = xmlParse(url)
xmlRoot(xmefile)
df1=xmlToDataFrame(getNodeSet(xmefile,"//busRouteStationList"))
df1


#######################



df2=data.frame(df1[7:8])

colnames(df2)=c("lng","lat")

a= as.numeric(df2$lng)
b= as.numeric(df2$lat)

df3 <- cbind(a, b)


df3

######################3


install.packages('tidyverse')
library('tidyverse')

install.packages('leaflet')
library('leaflet')

leaflet() %>%
  setView(lng=126.9993328621958, lat=37.26855866773837, zoom=13) %>%
  addTiles() %>% 
  addCircleMarkers(data =df2,  color='#006633')






##########################



API_key = "4e8LrQXnJ885Nbj2uv8uoDsutLKVYVpHi43tCpTwjN9QaY4YVmNSDMHtFb6tBGGHvznsaWw9smAkCTXan8j4JQ%3D%3D"
url1 = paste("http://apis.data.go.kr/6410000/buslocationservice/getBusLocationList?serviceKey=", 
            API_key,"&routeId=",suwon_bus_routeID,sep="")

xmefile1 = xmlParse(url1)
xmlRoot(xmefile1)

df0 = xmlToDataFrame(getNodeSet(xmefile1, "//busLocationList"))  
t(df0);
head(df0)

station=data.frame(df0$stationSeq)

station1=as.numeric(station[1,])
station2=as.numeric(station[2,])
station3=as.numeric(station[3,])
station4=as.numeric(station[4,])
station5=as.numeric(station[5,])
station6=as.numeric(station[6,])
station7=as.numeric(station[7,])
station8=as.numeric(station[8,])


busname_id=data.frame(df1[5:8])

a1=busname_id[station1,]
a2=busname_id[station2,]
a3=busname_id[station3,]
a4=busname_id[station4,]
a5=busname_id[station5,]
a6=busname_id[station6,]
a7=busname_id[station7,]
a8=busname_id[station8,]

location_bus =rbind(a1, a2, a3, a4, a5, a6, a7 ,a8)


df4=data.frame(location_bus[3:4])

colnames(df4)=c("lng","lat")

a0= as.numeric(df4$lng)
b0= as.numeric(df4$lat)

df5 <- cbind(a0, b0)


df5

#############################



install.packages('tidyverse')
library('tidyverse')

install.packages('leaflet')
library('leaflet')

leaflet() %>%
  setView(lng=126.9993328621958, lat=37.26855866773837, zoom=13) %>%
  addTiles() %>% 
  addCircleMarkers(data =df3,  color='#006633') %>% 
  addMarkers(data =df5, label=location_bus$stationName)











