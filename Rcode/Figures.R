# Create specialized plots
pngfun <- function(wd, file,w=7,h=7,pt=12){
  file <- file.path(wd, file)
  cat('writing PNG to',file,'\n')
  png(filename=file,
      width=w,height=h,
      units='in',res=300,pointsize=pt)
}


#################################################################################################################
# Assessment History
#################################################################################################################
dat = read.csv("C:/Assessments/2019/petrale_2019/Data/Assessment_History/Spawning_biomass.csv")

base.yr  = mod1$timeseries[,"Yr"]
yr = base.yr[base.yr <= 2019]
base.ssb = mod1$timeseries[1:length(yr),"SpawnBio"]

colors = c("black", "red", "blue", "darkgreen", "orange", "purple")

pngfun(wd = 'C:/Assessments/2019/petrale_2019/Data/Assessment_History', file = 'Assessment_History.png', h = 6)
#2019
plot(yr, base.ssb, type = 'l', lwd = 2, col = colors[1], ylim=c(0, 45000), ylab = "Spawning output", xlab = "Year")
lines(dat$Year, dat$X2015, lty = 2, col = colors[2], lwd =2)
ssb = dat$X2013
lines(dat$Year[1:length(ssb)], ssb, lty = 2, col = colors[3], lwd =2)
ssb = dat$X2011
lines(dat$Year[1:length(ssb)], ssb, lty = 2, col = colors[4], lwd =2)
ssb = dat$X2009
lines(dat$Year[1:length(ssb)], ssb, lty = 2, col = colors[5], lwd =2)
ssb = dat$X2005 ; ind = !is.na(ssb)
lines(dat$Year[ind], ssb[ind], lty = 2, col = colors[6], lwd =2)

legend("topright", bty = 'n', legend = c(2019, 2015, 2013, 2011, 2009, 2005), col = colors, 
       lty = c(1,2,3,2,2,2,2,2), lwd = 2)

dev.off()


#################################################################################################################
# Selectivity
#################################################################################################################
selex.yrs = c(1876, 1973, 1983, 1993, 2003, 2011)
colors = c(rep('red',2), rep('orange',2), rep('blue',2), rep('darkorchid',2),rep('darkolivegreen',2), rep('gold',2))
fleetlty = c(rep(c(2,3), 6))
fleetnames = c("1876-1972 (f)", "1876-1972 (m)", 
			   "1973-1982 (f)", "1973-1982 (m)",
			   "1983-1992 (f)", "1983-1992 (m)",
			   "1993-2002 (f)", "1993-2002 (m)",
			   "2003-2010 (f)", "2003-2010 (m)",
			   "2011- (f)", "2011- (m)")

fleets.short = c("Winter (N)", "Summer (N)", "Winter (S)", "Summer (S)", 
          "Triennial Survey - Early", 
          "Triennial Survey - Late", 
          "NWFSC Bottom Trawl Survey")


w.north <- SSplotSelex(mod1, fleets=1, fleetnames=fleets.short, subplot=1, year = selex.yrs)
w.north$infotable$longname <- fleetnames
w.north$infotable$col <- colors 
w.north$infotable$lty <- fleetlty
w.north$infotable$lwd <- 2

s.north <- SSplotSelex(mod1, fleets=2, fleetnames=fleets.short, subplot=1, year = selex.yrs)
s.north$infotable$longname <- fleetnames
s.north$infotable$col <- colors 
s.north$infotable$lty <- fleetlty
s.north$infotable$lwd <- 2

w.south <- SSplotSelex(mod1, fleets=3, fleetnames=fleets.short, subplot=1, year = selex.yrs)
w.south$infotable$longname <- fleetnames
w.south$infotable$col <- colors 
w.south$infotable$lty <- fleetlty
w.south$infotable$lwd <- 2

s.south <- SSplotSelex(mod1, fleets=4, fleetnames=fleets.short, subplot=1, year = selex.yrs)
s.south$infotable$longname <- fleetnames
s.south$infotable$col <- colors 
s.south$infotable$lty <- fleetlty
s.south$infotable$lwd <- 2

tri.early <- SSplotSelex(mod1, fleets=5, fleetnames = fleets.short, subplot=1, year = 1980)
tri.early$infotable$longname <- c("Triennial early (f)", "Triennial early (m)")
tri.early$infotable$col <- c("red", "blue") 
tri.early$infotable$lty <- fleetlty[1:2]
tri.early$infotable$lwd <- 2

tri.late <- SSplotSelex(mod1, fleets = 6,  fleetnames = fleets.short, subplot=1, year = 2004)
tri.late$infotable$longname <- c("Triennial late (f)", "Triennial late (m)")
tri.late$infotable$col <- c("red", "blue") 
tri.late$infotable$lty <- fleetlty[1:2]
tri.late$infotable$lwd <- 2

nwfsc <- SSplotSelex(mod1, fleets=7, fleetnames = fleets.short, subplot=1, year = 2004)
nwfsc$infotable$longname <- c("NWFSC Survey (f)", "NWFSC Survey (m)")
nwfsc$infotable$col <- c("red", "blue")
nwfsc$infotable$lty <- fleetlty[1:2]
nwfsc$infotable$lwd <- 2


pngfun(wd = paste0(getwd(), "/Figures"), file = "Petrale_fishery_selectivity.png", w=9,h=9)
	par(mfrow=c(2,2),mar=c(4,4,3,1))
	SSplotSelex(mod1, fleets=1, infotable=w.north$infotable, fleetnames=fleets.short, subplot=1, legendloc='bottomright', showmain=TRUE, year = selex.yrs)
	grid()
	SSplotSelex(mod1, fleets=2, infotable=s.north$infotable, fleetnames=fleets.short,subplot=1, legendloc='bottomright', showmain=TRUE, year = selex.yrs)
	grid()
	SSplotSelex(mod1, fleets=3, infotable=w.south$infotable, fleetnames=fleets.short,subplot=1, legendloc='bottomright', showmain=TRUE, year = selex.yrs)
	grid()	
	SSplotSelex(mod1, fleets=4, infotable=s.south$infotable, fleetnames=fleets.short,subplot=1, legendloc='bottomright', showmain=TRUE, year = selex.yrs)
	grid()
dev.off()

pngfun(wd = paste0(getwd(), "/Figures"), file = "Petrale_survey_selectivity.png", w=7,h=7)
	par(mfrow=c(2,2),mar=c(4,4,3,1))
	SSplotSelex(mod1, fleets=5, infotable=tri.early$infotable, fleetnames=fleets.short, subplot=1, legendloc='bottomright', showmain=FALSE, year = 1980)
	grid()
	SSplotSelex(mod1, fleets=6, infotable=tri.late$infotable,  fleetnames=fleets.short, subplot=1, legendloc='bottomright', showmain=FALSE, year = 2004)
	grid()
	SSplotSelex(mod1, fleets=7, infotable=nwfsc$infotable,  fleetnames=fleets.short, subplot=1, legendloc='bottomright', showmain=FALSE, year = 2004)
	grid()	
dev.off()

#################################################################################################################
# Retention
#################################################################################################################
colors = unique(colors)
ret = mod1$sizeselex[mod1$sizeselex$Factor == "Ret", ]
wn.ret = ret[ret$Fleet == 1 & ret$Sex == 1 & ret$Yr %in% c(2002, 2003, 2010, 2011), ]
sn.ret = ret[ret$Fleet == 2 & ret$Sex == 1 & ret$Yr %in% c(2002, 2003, 2009, 2011), ]
ws.ret = ret[ret$Fleet == 3 & ret$Sex == 1 & ret$Yr %in% c(2002, 2003, 2010, 2011), ]
ss.ret = ret[ret$Fleet == 4 & ret$Sex == 1 & ret$Yr %in% c(2002, 2003, 2009, 2011), ]

lenbins = seq(5, 79, 2)

pngfun(wd = paste0(getwd(), "/Figures"), file = "Petrale_retention.png")
par(mfrow = c(2,2))
plot  (lenbins, wn.ret[1,  6:ncol(wn.ret)], col = colors[1], type = 'l', main = "Winter-North", ylab = "Retention", xlab = "Length (cm)", lwd = 2)
points(lenbins, wn.ret[1,  6:ncol(wn.ret)], pch = 1, col = colors[1])
for(a in 2:nrow(wn.ret)){
	lines (lenbins, wn.ret[a,  6:ncol(wn.ret)], col = colors[a], lty = 1, lwd = 2)
	points(lenbins, wn.ret[a,  6:ncol(wn.ret)], pch = 2, col = colors[a])
}
legend ("bottomright", legend = c("1876-2002", "2003-2009", "2010", "2011-"), col = colors[1:a], pch = 1:a, lty = 1, lwd = 2, bty = 'n')
grid()

plot  (lenbins, sn.ret[1,  6:ncol(sn.ret)], col = colors[1], type = 'l', main = "Summer-North", ylab = "Retention", xlab = "Length (cm)", lwd = 2)
points(lenbins, sn.ret[1,  6:ncol(sn.ret)], pch = 1, col = colors[1])
for(a in 2:nrow(sn.ret)){
	lines (lenbins, sn.ret[a,  6:ncol(sn.ret)], col = colors[a], lty = 1, lwd = 2)
	points(lenbins, sn.ret[a,  6:ncol(sn.ret)], pch = 2, col = colors[a])
}
legend ("bottomright", legend = c("1876-2002", "2003-2008", "2009-2010", "2011-"), col = colors[1:a], pch = 1:a, lty = 1, lwd = 2, bty = 'n')
grid()

plot  (lenbins, ws.ret[1,  6:ncol(ws.ret)], col = colors[1], type = 'l', main = "Winter-South", ylab = "Retention", xlab = "Length (cm)", lwd = 2)
points(lenbins, ws.ret[1,  6:ncol(ws.ret)], pch = 1, col = colors[1])
for(a in 2:nrow(ws.ret)){
	lines (lenbins, ws.ret[a,  6:ncol(ws.ret)], col = colors[a], lty = 1, lwd = 2)
	points(lenbins, ws.ret[a,  6:ncol(ws.ret)], pch = 2, col = colors[a])
}
legend ("bottomright", legend = c("1876-2002", "2003-2009", "2010", "2011-"), col = colors[1:a], pch = 1:a, lty = 1, lwd = 2, bty = 'n')
grid()

plot  (lenbins, ss.ret[1,  6:ncol(ss.ret)], col = colors[1], type = 'l', main = "Summer-South", ylab = "Retention", xlab = "Length (cm)", lwd = 2)
points(lenbins, ss.ret[1,  6:ncol(ss.ret)], pch = 1, col = colors[1])
for(a in 2:nrow(ss.ret)){
	lines (lenbins, ss.ret[a,  6:ncol(ss.ret)], col = colors[a], lty = 1, lwd = 2)
	points(lenbins, ss.ret[a,  6:ncol(ss.ret)], pch = 2, col = colors[a])
}
legend ("bottomright", legend = c("1876-2002", "2003-2008", "2009-2010", "2011-"), col = colors[1:a], pch = 1:a, lty = 1, lwd = 2, bty = 'n')
grid()

dev.off()

#################################################################################################################
# Unavailable Biomass
#################################################################################################################
# pngfun('POP_unavailable_biomass.png',h=8.5)
# SSunavailableSpawningOutput(mod1, plot=TRUE)
# dev.off()
# 
# pngfun('POP_index_data.png',h=8.5)
# par(mfrow=c(2,2),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
# for(a in 1:4){
#   f = c(4,6,7,8)[a]
#   SSplotIndices(mod1,fleets=f,subplot=1,datplot=TRUE,fleetnames=fleets)
# }
# mtext(side=1,line=1,outer=TRUE,'Year')
# mtext(side=2,line=1,outer=TRUE,'Index')
# dev.off()
# 
# # index fits
# pngfun('POP_index_fits.png',h=8.5)
# par(mfrow=c(2,2),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
# for(a in 1:4){
#   f = c(4,6,7,8)[a]
#   SSplotIndices(mod1, fleets=f, subplot=2, fleetnames=fleets)
# }
# mtext(side=1,line=1,outer=TRUE,'Year')
# mtext(side=2,line=1,outer=TRUE,'Index')
# dev.off()
# 
# # index fits
# pngfun('POP_index_fits_alt.png',h=5, w=6)
# par(mfrow=c(2,3),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
# for(a in 1:6){
#   f = c(1, 4:8)[a]
#   SSplotIndices(mod1, fleets=f, subplot=2, fleetnames=fleets)
# }
# mtext(side=1,line=1,outer=TRUE,'Year')
# mtext(side=2,line=1,outer=TRUE,'Index')
# dev.off()

# discard fits
# pngfun('POP_discard_fits.png')
# par(mfcol=c(1,1),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
# for(f in 1:1){
#   SSplotDiscard(mod1, fleets=f,subplot=2,fleetnames=fleets, datplot = TRUE)
# }
# mtext(side=1,line=1,outer=TRUE,'Year')
# mtext(side=2,line=1,outer=TRUE,'Discard fraction')
# dev.off()
# 
# # discard without fits
# pngfun('POP_discard_data.png')
# par(mfcol=c(1,1),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
# for(f in 1:1){
#   SSplotDiscard(mod1, fleets=f,subplot=1,fleetnames=fleets, datplot = TRUE)
# }
# mtext(side=1,line=1,outer=TRUE,'Year')
# mtext(side=2,line=1,outer=TRUE,'Discard fraction')
# dev.off()
# 
# ### biology stuff
# # see function maturity/SST_maturity_notes.R
# pngfun('POP_weight_vs_fecundity.png',h=5,w=6.5)
# par(mar=c(5,4,1,1))
# plot(0, type='n', ylim=c(0,2.1),xlim=c(10,50),xaxs='r',axes=FALSE,
#      xlab='Length (cm)',ylab="Weight or  Fecundity x Maturity")
# abline(h=0,col='grey')
# lines(mod1$biology$Mean_Size, mod1$biology$Wt_len_F,
#       type='o', lwd=3, pch=16, col=1)
# lines(mod1$biology$Mean_Size, mod1$biology$Spawn,
#       type='o', lwd=3, pch=16, col=2, lty=2, ylim=c(0,3),xlim=c(0,50))
# legend('topleft',lwd=3,pch=16,col=1:2,c("Weight","Fecundity x Maturity"),lty=1:2, bty = 'n')
# axis(1)
# axis(2)
# box()
# dev.off()

#################################################################################################################
# Bias Ramp Figure
#################################################################################################################

SS_fitbiasramp (mod1,  method="BFGS", twoplots=FALSE,
                transform=FALSE, print=TRUE, plotdir=out.dir.mod1 ,shownew=FALSE,
                pwidth=6.5, pheight=5.0, punits="in", ptsize=10, res=300, cex.main=1)

#################################################################################################################
# End
#################################################################################################################