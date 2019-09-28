rm(list=ls())

DestinationMap = function(AirportCode) {
  library(threejs)
  AirlineRoutes=read.csv("routes.csv")
  Airport=read.csv("airports.dat.txt")
  Airport=Airport[,c(5,7,8,9)]
  AirlineRoutes2=subset(AirlineRoutes,AirlineRoutes$source.airport==AirportCode & AirlineRoutes$codeshare!="Y")
  AirlineRoutes2=AirlineRoutes2[,c(3,5)]
  Fulldata = merge(AirlineRoutes2,Airport,by.x='destination.apirport',by.y='IATA')
  Fulldata=merge(Fulldata,Airport,by.x='source.airport',by.y='IATA')
  Fulldata=unique(Fulldata)
  arcdf<-data.frame(origin_lat = Fulldata[,6], origin_long = Fulldata[,7], 
                    dest_lat = Fulldata[,3], dest_long = Fulldata[,4])
  earth = "http://eoimages.gsfc.nasa.gov/images/imagerecords/73000/73909/world.topo.bathy.200412.3x5400x2700.jpg"
  globe = globejs(img=earth,lat=Fulldata[,3], long=Fulldata[,4], arcs=arcdf,arcsHeight=0.3, arcsLwd=2, arcsColor="#FF6347", arcsOpacity=0.8,atmosphere=TRUE, height=800, width = 800)
  return(globe)
}
