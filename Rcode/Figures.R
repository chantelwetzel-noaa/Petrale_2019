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