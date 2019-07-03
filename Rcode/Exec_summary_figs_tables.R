# =============================================================================
# R script for Executive summary figures and tables                      
# The script for the tables is in the order they appear in the document!
#                                                                       
# BELOW IS THE ORDER OF THE TABLES & FIGURES IN THIS SCRIPT              
# If you're looking for a particular figure/table to edit you can search by the number
#
# 1. Recent history of catches figure and tables (need to edit Exec_catch_for_figs.csv)
#      OR, you can comment this plot out, and just use the r4ss generated plot included
#      in the in the main R markdown document 
# 2. Spawning stock output and depletion
# 3. Recruitment
# 4. SPR and exploitation
# 5. Reference points
# 6. Management performance (need to edit Exec_mngmt_performance.csv and maybe table)
# 7. OFL projections
# 8. Decision tables  (need to edit DecisionTable_mod1.csv and other if multiple models)
# 9. Base model summary (need to edit)
#
# Melissa Monk, NMFS
# modified by Chantel Wetzel, NFMS
# for the 2019 Petrale Sole Update Assessment
# =============================================================================


print.numeric<-function(x, digits) { formatC(x, digits = digits, format = "f") }
comma <- function(x, digits=0) { formatC(x, big.mark=",", digits, format = "f") }

sb.dig = 0
dep.dig = dig3 = 3
dig1 = 1

#' A subset of rich.colors by Arni Magnusson from the gplots package, with the
#' addition of alpha transparency (which is now available in the gplots version
#' as well)
rich.colors.short <- function(n,alpha=1){
  x <- seq(0, 1, length = n)
  r <- 1/(1 + exp(20 - 35 * x))
  g <- pmin(pmax(0, -0.8 + 6 * x - 5 * x^2), 1)
  b <- dnorm(x, 0.25, 0.15)/max(dnorm(x, 0.25, 0.15))
  rgb.m <- matrix(c(r, g, b), ncol = 3)
  rich.vector <- apply(rgb.m, 1, function(v) rgb(v[1], v[2], v[3], alpha=alpha))
}


# =============================================================================
# Executive Figure A: Catches
#==============================================================================
# Required: Read in CSV file, edit this section depending on # of plots!!
# Read in executive summary catches figure file

#Final_Catch_AllYrs = read.csv("C:/Assessments/POP2017/Data/CommercialCatch/POP2017_PacFIN_catch_forExpansion.csv")

Final_Catch_AllYrs = read.csv('./txt_files/Petrale_2019_PacFIN_catch_forExpansion.csv')
Exec_catch_sep = Final_Catch_AllYrs
#Exec_catch_sep = Exec_catch_sep [,2:ncol(Exec_catch_sep)]
Exec_catch_sep = Exec_catch_sep[Exec_catch_sep$Year != LastYR, ]

colnames(Exec_catch_sep) = c('Year',  'Winter (N)', 'Summer (N)', 'Winter (S)', 'Summer (S)')

#Plot only years where catch is great than 1 mt total
ind = apply(Exec_catch_sep[,2:ncol(Exec_catch_sep )], 1, sum)
ind = ind > 1
Exec_catch_sep  = Exec_catch_sep[ind,]


# Split catch by regions -retaning the colunns for each -you'll have to edit
Exec_region1_catch = Exec_catch_sep

# Melt data so it can be plotted
Exec_region1_catch = melt(Exec_region1_catch, id='Year')

# Reassign column names
colnames(Exec_region1_catch) = c('Year','Fishery','Removals')


# Plot catches function
Plot_catch = function(Catch_df) {
             ggplot(Catch_df, aes(x=Year, y=Removals,fill = Fishery)) +
             geom_area(position='stack') +
             scale_fill_manual(values= rich.colors.short(dim(Exec_catch_sep)[2]-1)) +
             scale_x_continuous(breaks=seq(Dat_start_mod1, Dat_end_mod1, 20)) +
             ylab('Landings (mt)')
}

#==============================================================================
# Executive Table A: Catches
#==============================================================================

# Read in executive summary catches table
Exec_catch_summary_sep = Final_Catch_AllYrs[, 1:ncol(Final_Catch_AllYrs)]

# Bind the data frames together
Exec_catch_summary = cbind(Exec_catch_summary_sep[,1:5], 
                           apply(Exec_catch_summary_sep[,2:ncol(Exec_catch_summary_sep)], 1, sum))

colnames(Exec_catch_summary) = c('Year',
                                 'Winter (N)',
                                 'Summer (N)',
                                 'Winter (S)',
                                 'Summer (S)', 
                                 'Total Landings')

Exec_catch_summary = subset(Exec_catch_summary, Year >= FirstYR-1 & Year <= LastYR-1)
    
# Make executive summary catch xtable
Exec_catch.table = xtable(Exec_catch_summary, 
                          caption = c(paste0('Landings (mt) for the past 10 years for ',spp,' by source.')), 
                          label='tab:Exec_catch')
    
# Add alignment - you will have to adjust based on the number of columns you have
# and the desired width, remember to add one leading ghost column for row.names
align(Exec_catch.table) = c('l', 'l', 
                            '>{\\centering}p{0.7in}', 
                            '>{\\centering}p{0.7in}',
                            '>{\\centering}p{0.7in}', 
                            '>{\\centering}p{0.7in}',
                            '>{\\centering}p{0.7in}')  

  
#=============================================================================
# Executive Table B: Spawning Biomass and Relative Biomass
#=============================================================================

# Retreive data on spawning output and depletion
  mod=mod1
  mod_area='mod1'
  
  # Extract biomass/output  
  SpawningB = mod$derived_quants[grep('SSB', mod$derived_quants$Label), ]
  SpawningB = SpawningB[c(-1, -2), ]
     
      
  # Spawning biomass and std.dev data, calculate lower and upper 95% CI                 
  SpawningByrs = SpawningB[SpawningB$Label >= paste('SSB_', FirstYR, sep='') 
                         & SpawningB$Label <= paste('SSB_', LastYR,  sep=''), ]     
  
  SpawningByrs$YEAR = seq(FirstYR, LastYR)
  
  SpawningByrs$lowerCI = SpawningByrs$Value + qnorm(0.025) * SpawningByrs$StdDev
  
  SpawningByrs$upperCI = SpawningByrs$Value - qnorm(0.025) * SpawningByrs$StdDev
  
  #SpawningByrs$Value = as.numeric(print(SpawningByrs$Value, digits = sb.dig))
  SpawningByrs$Value = round(SpawningByrs$Value, digits = sb.dig)
    
  # Save individual depletion table before CI combined to character
  assign(paste('SpawnB_', mod_area, sep = ''), SpawningByrs)
  SpawnB = SpawningByrs  
      
  # Calculate confidence intervals
  SpawningByrs$CI = paste0(print.numeric(SpawningByrs$lowerCI, digits = sb.dig), ' - ', print.numeric(SpawningByrs$upperCI, digits = sb.dig))
  SpawningBtab = subset(SpawningByrs, select = c('YEAR', 'Value', 'CI'))
      
  # Assign column names
  colnames(SpawningBtab) = c('Year', paste('Spawning Biomass (', fecund_unit,')', 
                                           sep=''), '~ 95% confidence interval')
  
  
  # Extract Depletion values  
  Depletion = mod$derived_quants[grep('Bratio', mod$derived_quants$Label), ]
  Depletion = Depletion[c(-1, -2), ]
     
  # Estimated depletion, pull out correct years, list years, and estimate 95% CI
  Depletionyrs = Depletion[Depletion$Label >= paste('Bratio_', FirstYR,sep='') &
                           Depletion$Label <= paste('Bratio_', LastYR,sep=''), ]     
  
  Depletionyrs$YEAR = seq(FirstYR, LastYR)
  
  #Depletion$Value = as.numeric(comma(Depletion$Value, digits=dep.dig))
  
  Depletionyrs$lowerCI = Depletionyrs$Value + qnorm(0.025)*Depletionyrs$StdDev
  
  Depletionyrs$upperCI = Depletionyrs$Value - qnorm(0.025)*Depletionyrs$StdDev
  
  Depletionyrs$Value = round(Depletionyrs$Value, digits = dep.dig)
        
  # Save individual depletion tables
  assign(paste('Deplete_', mod_area, sep=''), Depletionyrs)
  Deplete = Depletionyrs     
    
  Depletionyrs$CI = paste0(print.numeric(Depletionyrs$lowerCI, digits = dep.dig), ' - ', print.numeric(Depletionyrs$upperCI, digits = dep.dig))
  
  Depletiontab = subset(Depletionyrs, select=c('Value', 'CI'))
  
  colnames(Depletiontab) = c('Estimated depletion', '~ 95% confidence interval')
    
  # Bind the spawning output and depletion data together 
  Spawn_Deplete = cbind(SpawningBtab, Depletiontab)
 
  colnames(Spawn_Deplete) = c('Year', 
                              paste('Spawning Biomass (', fecund_unit, ')', sep = ''), 
                              '~ 95% Confidence Interval',
                              'Estimated Relative Spawning Biomass',
                              '~ 95% Confidence Interval')
        
  # Assign a model number to the Spawn_deplete table, if you do cbind within this step
  assign(paste('SpawnDeplete_',mod_area,sep=''), Spawn_Deplete)
    
  # 9.1.15 R now won't read the file with any underscores for xtable,
  # so use SpawnDeplete without spaces for that  
  assign(paste('SpawnDeplete',mod_area, sep=''), Spawn_Deplete)
       
  assign(paste('Depl_',mod_area, sep=''), percent(Deplete[nrow(Deplete), 2]))
          
  assign(paste('Depl_',mod_area,'_CI',sep=''), 
         paste(percent(Deplete[nrow(Deplete), 7]), '-', 
               percent(Deplete[nrow(Deplete), 8]), sep=''))
        
  assign(paste('Spawn_', mod_area, sep=''), SpawnB[nrow(SpawnB), 2])
    
  assign(paste('Spawn_',mod_area,'_CI',sep=''), 
         paste(round(SpawnB[nrow(SpawnB), 7],0), '-', round(SpawnB[nrow(SpawnB), 8],0), sep=''))


# =============================================================================
# =============================================================================
# Create Spawning/Depletion tables for the correct number of models
# Model 1 table ---------------------------------------------------------------
Spawn_Deplete_mod1.table = xtable(SpawnDepletemod1, 
                           caption = paste0('Recent trend in estimated spawning biomass (', fecund_unit, ') and estimated relative spawning biomass (depletion).'), 
                           label='tab:SpawningDeplete_mod1',  
                           digits = c(0, 0, 0, 0, 3, 2)) 

# Add column spacing    
align(Spawn_Deplete_mod1.table) = c('l', 'l', 
                                    '>{\\centering}p{1.3in}', 
                                    '>{\\centering}p{1.2in}', 
                                    '>{\\centering}p{1in}', 
                                    '>{\\centering}p{1.2in}')  


#=============================================================================
# Executive Table C: Recruitment 
#=============================================================================
  mod=mod1
  mod_area='mod1'
  
  # Pull out recuitment  
  Recruit = mod$derived_quants[grep('Recr',mod$derived_quants$Label),]
  Recruit = Recruit[c(-1,-2),]
  
  # Recruitment and std.dev data, calculate lower and upper 95% CI                 
  Recruityrs = Recruit[Recruit$Label >= paste('Recr_', FirstYR, sep = '') &  
                       Recruit$Label <= paste('Recr_', LastYR, sep = ''), ]     
  
  Recruityrs$YEAR = seq(FirstYR, LastYR)
  
  # assume recruitments have log-normal distribution 
  # from first principals (multiplicative survival probabilities)
  Recruityrs$logint  <- sqrt(log(1+(Recruityrs$StdDev/Recruityrs$Value)^2))
  Recruityrs$lowerCI <- exp(log(Recruityrs$Value) + qnorm(0.025)*Recruityrs$logint)
  Recruityrs$upperCI <- exp(log(Recruityrs$Value) + qnorm(0.975)*Recruityrs$logint)
  
  Recruit_units <- "1,000"
  #if(mean(Recruityrs$Value) > 10000){
  #  Recruit_units <- "millions"
  #  Recruityrs$Value <- Recruityrs$Value/1000
  #  Recruityrs$lowerCI <- Recruityrs$lowerCI/1000
  #  Recruityrs$upperCI <- Recruityrs$upperCI/1000
  #}
  
  
  Recruityrs$CI = paste0(print.numeric(Recruityrs$lowerCI, digits = sb.dig), ' - ', print.numeric(Recruityrs$upperCI, digits = sb.dig))
  
  Recruityrs$Value = round(Recruityrs$Value, digits = sb.dig)
  
  Recruittab=subset(Recruityrs, select = c('YEAR', 'Value', 'CI'))
  
  colnames(Recruittab) = c('Year',paste0('Estimated Recruitment'), '~ 95% Confidence Interval')
  
  assign(paste('Recruittab_',mod_area,sep=''), Recruittab)
  
  
  # Recruitment deviations
  RecDevs = mod1$recruitpars[mod1$recruitpars$Yr >= FirstYR & mod1$recruitpars$Yr <= LastYR, c("Value", "Parm_StDev")]
  RecDevs$lowerCI = RecDevs$Value - qnorm(1-(1-0.95)/2)*RecDevs$Parm_StDev
  RecDevs$upperCI = RecDevs$Value + qnorm(1-(1-0.95)/2)*RecDevs$Parm_StDev
  RecDevs$CI = paste0(print.numeric(RecDevs$lowerCI, digits = 3), ' - ', print.numeric(RecDevs$upperCI, digits = 3))
  RecDevs$Value = round(RecDevs$Value, digits = 3)
  RecDevtab=subset(RecDevs, select = c('Value', 'CI'))
  colnames(RecDevtab) = c(paste0('Estimated Recruitment Devs.'), '~ 95% Confidence Interval')
  
  # Paste the data frames together
  Recruit_All = cbind(Recruittab_mod1, RecDevtab)

# -----------------------------------------------------------------------------
# Create recruitment tables

# Model 1 table
Recruit_mod1.table = xtable(Recruit_All, 
                            caption = c(paste('Recent estimated trend in recruitment and estimated recruitment deviations determined from the base model. The recruitment deviations for 2018 and 2019 were fixed at zero within the model.', sep='')),
                            label = 'tab:Recruit_mod1',
                            digits = c(0, 0, 0, 0, 3, 2))

align(Recruit_mod1.table) = c('l',
                              '>{\\centering}p{.8in}',
                              '>{\\centering}p{1.0in}',
                              '>{\\centering}p{1.4in}',
                              '>{\\centering}p{1.0in}',
                              '>{\\centering}p{1.4in}')
        

#=============================================================================
# Executive Table D: Exploitation Rates
#=============================================================================
# Extract exploitation values

  mod = mod1
  mod_area = 'mod1'

  # Extract exploitation and SPR ratio values from r4SS output
  Exploit = mod$derived_quants[grep('F',mod$derived_quants$Label),]
  Exploit = Exploit[c(-1,-2),]
        
  SPRratio = mod$derived_quants[grep('SPRratio',mod$derived_quants$Label),]
  SPRratio = SPRratio[c(-1,-2),]
        
  # Exploitation and calculate lower and upper 95% CI                 
  Exploityrs = Exploit[Exploit$Label >= paste('F_', FirstYR-1, sep='') &
                       Exploit$Label <= paste('F_', LastYR-1, sep=''), ]     
  
  Exploityrs$YEAR = seq(FirstYR-1, LastYR-1)
  
  Exploityrs$lowerCI = Exploityrs$Value + qnorm(0.025) * Exploityrs$StdDev
  
  Exploityrs$upperCI = Exploityrs$Value - qnorm(0.025) * Exploityrs$StdDev
  
  Exploityrs$CI = paste0(print.numeric(Exploityrs$lowerCI, digits = dep.dig), ' - ', print.numeric(Exploityrs$upperCI, digits = dep.dig))
  
  Exploittab = subset(Exploityrs, select=c('Value', 'CI'))
 
   colnames(Exploittab) = c('Exploitation Rate', '~ 95% Confidence Interval')
        
        
  # Spawning potential ratio and calculate lower and upper 95% CI  
  SPRratioyrs = SPRratio[SPRratio$Label >= paste('SPRratio_', FirstYR-1, sep='') 
                       & SPRratio$Label <= paste('SPRratio_', LastYR-1, sep=''), ]     
  
  SPRratioyrs$Year = seq(FirstYR-1, LastYR-1)
  
  SPRratioyrs$lowerCI = SPRratioyrs$Value + qnorm(0.025) * SPRratioyrs$StdDev
  
  SPRratioyrs$upperCI = SPRratioyrs$Value - qnorm(0.025) * SPRratioyrs$StdDev
  
  SPRratioyrs$CI = paste0(print.numeric(SPRratioyrs$lowerCI, digits = dep.dig), ' - ', print.numeric(SPRratioyrs$upperCI, digits = dep.dig))
  
  SPRratiotab = subset(SPRratioyrs, select = c('Year', 'Value', 'CI'))
  
  SPRratiotab$Year = as.factor(SPRratiotab$Year)
  
  colnames(SPRratiotab) = c('Year', '1-SPR', '~ 95% Confidence Interval')
      
  assign(paste('SPRratio_Exploit_', mod_area, sep=''), cbind(SPRratiotab, Exploittab))


# =============================================================================
# Create the three tables for SPR Ratio and Exploitation

SPRratio_Exploit_mod1.table = xtable(SPRratio_Exploit_mod1, 
                              caption=c(paste('Recent trend in spawning potential ratio 1-SPR and summary exploitation rate for age 3+ biomass for ', spp, '.' , sep='')), 
                              label='tab:SPR_Exploit_mod1', digits = 3)  
      
align(SPRratio_Exploit_mod1.table) = c('l','l',
                                       '>{\\centering}p{0.9in}',
                                       '>{\\centering}p{1.2in}',
                                       '>{\\centering}p{1.2in}',
                                       '>{\\centering}p{1.2in}') 
     

#=============================================================================
# Executive Table E: Reference Points
#=============================================================================

# Extract reference points table data
mod = mod1
mod_area = 'mod1'
  
# Rbind all of the data for the big summary reference table  
x = 1:3
Ref_pts = rbind (
    SSB_Unfished    = mod$derived_quants[grep('SSB_un',                  mod$derived_quants$Label)[1], x],
    SmryBio_Unfished = mod$derived_quants[grep('SmryBio_un',               mod$derived_quants$Label), x],
    Recr_Unfished   = mod$derived_quants[grep('Recr_un',                 mod$derived_quants$Label), x],
    SPB_lastyr      = mod$derived_quants[grep(paste0('SSB_', LastYR),    mod$derived_quants$Label), x],
    Depletion_lastyr= mod$derived_quants[grep(paste0('Bratio_', LastYR), mod$derived_quants$Label), x],
    Refpt_sB        = c(NA, NA, NA),
    SSB_Btgt        = mod$derived_quants[grep('SSB_Btgt',      mod$derived_quants$Label), x],
    SPR_Btgt        = mod$derived_quants[grep('SPR_Btgt',      mod$derived_quants$Label), x],
    Fstd_Btgt       = mod$derived_quants[grep('Fstd_Btgt',     mod$derived_quants$Label), x],
    TotYield_Btgt   = mod$derived_quants[grep('Dead_Catch_Btgt', mod$derived_quants$Label), x],
    Refpt_SPR       = c(NA, NA, NA),
    SSB_SPRtgt      = mod$derived_quants[grep('SSB_SPR', mod$derived_quants$Label), x],
    SPR_proxy       = c('SPR_proxy', SPR.target, NA),
    Fstd_SPRtgt     = mod$derived_quants[grep('Fstd_SPR',     mod$derived_quants$Label), x],
    TotYield_SPRtgt = mod$derived_quants[grep('Dead_Catch_SPR', mod$derived_quants$Label), x],
    Refpts_MSY      = c(NA, NA, NA),
    SSB_MSY         = mod$derived_quants[grep('SSB_MSY', mod$derived_quants$Label), x],
    SPR_MSY         = mod$derived_quants[grep('SPR_MSY', mod$derived_quants$Label), x],
    Fstd_MSY        = mod$derived_quants[grep('Fstd_MSY', mod$derived_quants$Label), x],
    TotYield_MSY    = mod$derived_quants[grep('Dead_Catch_MSY', mod$derived_quants$Label), x] )

Ref_pts$Value   = as.numeric(Ref_pts$Value)
Ref_pts$StdDev  = as.numeric(Ref_pts$StdDev)
Ref_pts$Value1  = ifelse(Ref_pts$Value >= 1, as.character(round(Ref_pts$Value, dig1)), 
                           as.character(round(Ref_pts$Value, dig3)))   
        
Ref_pts$lowerCI  = Ref_pts$Value + qnorm(0.025) * Ref_pts$StdDev
Ref_pts$upperCI  = Ref_pts$Value - qnorm(0.025) * Ref_pts$StdDev

Which = which(Ref_pts$Label=="Recr_Unfished")
logint  <- sqrt(log(1+(Ref_pts[Which,"StdDev"]/Ref_pts[Which, "Value"])^2))
Ref_pts[Which, "lowerCI"] <- exp(log(Ref_pts[Which, "Value"]) + qnorm(0.025)*logint)
Ref_pts[Which, "upperCI"] <- exp(log(Ref_pts[Which, "Value"]) + qnorm(0.975)*logint)

Ref_pts$lowerCI1 = ifelse(Ref_pts$lowerCI >= 1, as.character(round(Ref_pts$lowerCI, dig1)), 
                          as.character(round(Ref_pts$lowerCI, dig3))) 

Ref_pts$upperCI1 = ifelse(Ref_pts$upperCI>=1, as.character(round(Ref_pts$upperCI,dig1)), 
                          as.character(round(Ref_pts$upperCI, dig3))) 

      
Quantity = c(paste('Unfished spawning biomass (', fecund_unit, ')', sep = ''),
                     paste('Unfished age ', min_age, ' biomass (mt)', sep = ''),
                    'Unfished recruitment (R0, thousands)',
                     paste('Spawning biomass', '(', LastYR, ' ', fecund_unit, ')', sep = ''),
                     paste('Relative spawning biomass (depletion) (', LastYR,')',sep=''),
                    '\\textbf{$\\text{Reference points based on } \\mathbf{SB_{25\\%}}$}',
                    'Proxy spawning biomass ($B_{25\\%}$)',
                    'SPR resulting in $B_{25\\%}$ ($SPR_{B25\\%}$)',
                    'Exploitation rate resulting in $B_{25\\%}$',
                    'Yield with $SPR_{B25\\%}$ at $B_{25\\%}$ (mt)',
                    '\\textbf{\\textit{Reference points based on SPR proxy for MSY}}',
                    'Spawning biomass',
                    '$SPR_{30\\%}$',
                    'Exploitation rate corresponding to $SPR_{30\\%}$',
                    'Yield with $SPR_{30\\%}$ at $SB_{SPR}$ (mt)',
                    '\\textbf{\\textit{Reference points based on estimated MSY values}}',
                    'Spawning biomass at $MSY$ ($SB_{MSY}$)',
                    '$SPR_{MSY}$',
                    'Exploitation rate at $MSY$',
                    '$MSY$ (mt) ')
        
Ref_pts = cbind(Quantity, Ref_pts$Value1, Ref_pts$lowerCI1, Ref_pts$upperCI1)
Ref_pts[c(6, 11, 13, 16), 2:4] = ''
colnames(Ref_pts) = c('\\textbf{Quantity}', '\\textbf{Estimate}', 
                      '\\textbf{$\\sim$2.5\\%  Confidence Interval}',
                      '\\textbf{$\\sim$97.5\\%  Confidence Interval}')
assign(paste('Ref_pts_', mod_area, sep = ''), Ref_pts)


# =============================================================================
# Create reference point table(s)----------------------------------------------

# Model 1 
Ref_pts_mod1.table = xtable(Ref_pts_mod1, 
                            caption=c('Summary of reference 
                                      points and management quantities for the 
                                      base case.'), 
                            label='tab:Ref_pts_mod1', digits = dig3)  
# Add alignment      
align(Ref_pts_mod1.table) = c('l',
                              '>{\\raggedright}p{4.1in}',
                              '>{\\centering}p{.65in}',
                              '>{\\centering}p{.65in}',
                              '>{\\centering}p{.65in}')  


#=============================================================================
# Executive Table F: Management performance
#==============================================================================
# Required: EDIT and READ IN Exec_mngmt_performance.csv FILE ------------------
# Read in the management performance table - get from John Devore
# Will have to change the column names, caption, and the alignment
  
mngmnt = read.csv('./txt_files/ESF_Exec_mngmt_performance.csv')
find.yr = as.numeric(substring(mngmnt$Year, 7, 10))
temp.manage = cbind(mngmnt, find.yr)
mngmnt = temp.manage[temp.manage$find.yr < LastYR, -dim(temp.manage)[2]]

# Add the total landings and totality mortality
totdead = print(aggregate(kill_bio ~ Yr, FUN = sum, mod1$catch[mod1$catch$Yr>=2009,])$kill_bio,digits = 0)
landings  = print(aggregate(Obs ~ Yr, FUN = sum, mod1$catch[mod1$catch$Yr>=2009,])$Obs, digits = 0)
mngmnt = cbind(mngmnt, landings, totdead)

colnames(mngmnt) = c('Year',
                     'OFL (mt; ABC prior to 2011)',  
                     'ACL (mt; OY prior to 2011)', 
                     'Total Landings (mt)',
                     'Estimated Total Catch (mt)')

# Create the management performance table
mngmnt.table = xtable(mngmnt, 
                      caption=c('Recent trend in total catch and  
                              landings (mt) relative to the management guidelines. 
                              Estimated total catch reflect the landings 
                              plus the model estimated discarded biomass based on discard rate data.'), 
                      label='tab:mnmgt_perform')
# Add alignment
align(mngmnt.table) = c('l',
                        '>{\\raggedleft}p{0.5in}',
                        '>{\\centering}p{1.1in}',
                        '>{\\centering}p{1.1in}',
                        '>{\\centering}p{1.1in}', 
                        '>{\\centering}p{1.1in}')  


#=============================================================================
# Executive Table G: OFL Projections
#==============================================================================

# Extract OFLs for next 10 years for each model
#Fore_Table = read.csv('./txt_files/OFL_forecast.csv')
OFL_mod1 = mod1$derived_quants[grep('OFL',mod1$derived_quants$Label),]
OFL_mod1 = OFL_mod1[, 2]    

ACL_mod1 = mod1$derived_quants[grep('ForeCatch_',mod1$derived_quants$Label),]
ACL_mod1 = ACL_mod1[,2]

OFL = as.data.frame(cbind(OFL_mod1, ACL_mod1))
OFL$Year=seq(Project_firstyr,Project_lastyr, 1)
OFL$Year = as.factor(OFL$Year)

OFL = OFL[,c(3, 1, 2)]
OFL[,2] =  print.numeric(OFL$OFL_mod1, digits = 0)
OFL[,3] =  print.numeric(OFL$ACL_mod1, digits = 0)

# Extract biomass/output  
SpawningB = mod$derived_quants[grep('SSB', mod$derived_quants$Label), ]
SpawningB = SpawningB[c(-1, -2), ]
Spawn.fore = SpawningB[SpawningB$Label >= paste('SSB_', Project_firstyr, sep='') 
                         & SpawningB$Label <= paste('SSB_', Project_lastyr,  sep=''), "Value"]  
Spawn.fore = print(Spawn.fore, digits = 0)

Bratio = mod$derived_quants[grep('Bratio', mod$derived_quants$Label), ]
Bratio = Bratio[c(-1, -2), ]
Bratio.fore = Bratio[Bratio$Label >= paste('Bratio_', Project_firstyr, sep='') 
                       & Bratio$Label <= paste('Bratio_', Project_lastyr,  sep=''), "Value"]
Bratio.fore = print(Bratio.fore, digits = 3)

Fore_Table = cbind(OFL, Spawn.fore, Bratio.fore)
colnames(Fore_Table) = c('Year','OFL', "ABC", paste0('Spawning Biomass (',fecund_unit,')'), "Relative Depletion") 

# Create the table
OFL.table = xtable(Fore_Table, caption=c('Projections of potential OFL (mt) and ABC (mt) and the estimated spawning biomass and relative depletion based on ABC removals.  The 2019 and 2020 
                                          removals are set at the harvest limits currently set by management of XXX mt per year.'),
                  label = 'tab:OFL_projection',
                  digits = 0)
      
# Add alignment
align(OFL.table) = c('l',
                        '>{\\raggedleft}p{0.5in}',
                        '>{\\centering}p{1.1in}',
                        '>{\\centering}p{1.1in}', 
                        '>{\\centering}p{1.6in}',
                        '>{\\centering}p{1.1in}')    

#=============================================================================
# Executive Table h: Decision Table
#==============================================================================      
# Required: READ in the DecisionTable_mod CSV files ---------------------------

# Model 1
# Read in decision table file
decision_mod1 = read.csv('./txt_files/DecisionTable_mod1.csv')
colnames(decision_mod1) = c('', 
                            'Year',  
                            'Catch',	
                            'Spawning Biomass',	
                            'Depletion', 
                            'Spawning Biomass',	
                            'Depletion',	
                            'Spawning Biomass',	
                            'Depletion')
      
decision_mod1.table = xtable( decision_mod1, 
                              caption = c(paste('Decision table summary of 10-year projections beginning in ', LastYR+2,' for alternate states of nature based on 
                                             an axis of uncertainty about female natural mortality for the base model. The removals in 2019 and 2020 were set at the defined management specification 
                                             of 2908 and 2845 mt, respectively, assuming full attainment. Columns range over low, mid, and high states of nature, and rows range over different 
                                             assumptions of catch levels. The SPR30 catch stream is based on the equilibrium yield applying the SPR30 harvest rate.', sep = '')), 
                              label='tab:Decision_table_mod1', 
                              digits = c(0,0,0,0,0,1,0,1,0,1)) 
      
# Assign alignment and add the header columns
align(decision_mod1.table) = c('l','l|','c','c|','>{\\centering}p{.7in}','c|','>{\\centering}p{.7in}','c|','>{\\centering}p{.7in}','c') 
    
addtorow <- list()
addtorow$pos <- list()
addtorow$pos[[1]] <- -1
addtorow$pos[[2]] <- -1
addtorow$command <- c( ' \\multicolumn{3}{c}{}  &  \\multicolumn{2}{c}{} 
                       & \\multicolumn{2}{c}{\\textbf{States of nature}} 
                       & \\multicolumn{2}{c}{} \\\\\n', 
                       ' \\multicolumn{3}{c}{}  &  \\multicolumn{2}{c}{M = 0.12} 
                       & \\multicolumn{2}{c}{M = 0.151} 
                       &  \\multicolumn{2}{c}{M = 0.18} \\\\\n')
        
#=============================================================================
# Executive Summary Table I: Summary of Results
#=============================================================================
# Required: PARTIALLY READS CSV FILE ------------------------------------------

# Collect the data from all the tables
# Read in the management table that includs the managment history Landings, EstCatch, OFL, ACLs
#mngmt = read.csv('./txt_files/Exec_basemodel_summary.csv')
#mngmt = mngmt[,-1]
  mngmnt = read.csv('./txt_files/ESF_Exec_mngmt_performance.csv')
  find.yr = as.numeric(substring(mngmnt$Year, 7, 10))
  temp.manage = cbind(mngmnt, find.yr)
  OFL = temp.manage$OFL[temp.manage$find.yr >= FirstYR & temp.manage$find.yr <= LastYR]
  ACL = temp.manage$ACL[temp.manage$find.yr >= FirstYR & temp.manage$find.yr <= LastYR]

  totdead = c( as.numeric(print(aggregate(kill_bio ~ Yr, FUN = sum, mod1$catch[mod1$catch$Yr>= FirstYR,])$kill_bio,digits = 0)), NA)
  landings  = c( as.numeric(print(aggregate(Obs ~ Yr, FUN = sum, mod1$catch[mod1$catch$Yr>= FirstYR,])$Obs, digits = 0)), NA)
    
# Model 1
  # SPR ratio and exploitation
  #assign(paste('SPRratio_Exploit_', mod_area, sep=''), cbind(SPRratiotab, Exploittab))
  SPRratio_Exploit_mod1 = SPRratio_Exploit_mod1[2:nrow(SPRratio_Exploit_mod1),c(2,4)] # Grab the SPR and the exploitation rates
  SPRratio_Exploit_mod1[,c(1,2)] = round(SPRratio_Exploit_mod1[,c(1,2)],3)

  # SPR blanks for the last year
  blanks = c(NA,NA)
  SPRratio_Exploit_mod1 = rbind(SPRratio_Exploit_mod1,blanks)
  rownames(SPRratio_Exploit_mod1)[10]='Lastyear'

  
  # Age + biomass
  AgeBiomass_mod1 = mod1$timeseries[,c('Yr','Bio_smry')]
  AgeBiomassyrs_mod1 = subset(AgeBiomass_mod1, Yr>=(FirstYR) & Yr<=(LastYR))
  AgeBiomassyrs_mod1 = AgeBiomassyrs_mod1[,2]
  AgeBiomassyrs_mod1 = round(AgeBiomassyrs_mod1,2)
  
  # Spawning biomass and depltion
  # assign(paste('SpawnDeplete',mod_area, sep=''), Spawn_Deplete)
  SpawnDeplete_mod1 = SpawnDeplete_mod1[,c(2:5)]
  SpawnDeplete_mod1[,1] = round(SpawnDeplete_mod1[,1],dig1)
  SpawnDeplete_mod1[,3] = round(SpawnDeplete_mod1[,3],dig3)
  
  # Recruitment
  #assign(paste('Recruittab_',mod_area,sep=''), Recruittab)
  Recruittab_mod1 = Recruittab_mod1[,c(2,3)]
  #Recruittab_mod1[,2] = Recruittab_mod1[,2]
  
  # BIND ALL DATA TOGETHER
  mod1_summary = cbind(SPRratio_Exploit_mod1,
  						         AgeBiomassyrs_mod1,
  						         SpawnDeplete_mod1,
  						         Recruittab_mod1)
    

# -----------------------------------------------------------------------------    
# CREATE TABLES BASED ON HOW MANY MODELS AND MANAGEMENT AREAS YOU HAVE

  # Bind data from all three models together
  base_summary = cbind(OFL, ACL, landings, totdead, mod1_summary)
  base_summary1 = as.data.frame(cbind(OFL, ACL, landings, totdead, mod1_summary))
  
  # Transpose the dataframe to create the table and create data Labels  
  base_summary = as.data.frame(t(base_summary1))
  base_summary$names=c(
                       'OFL (mt)', 
                       'ACL (mt)',
                       'Landings (mt)',
                       'Total Est. Catch (mt)',
                      '1-$SPR$',
                       'Exploitation rate',
                       paste('Age ',min_age,' biomass (mt)',sep=''),
                       'Spawning Biomass',
                       '~95\\% CI',
                       'Relative Depletion',
                       '~95\\% CI',
                       'Recruits',
                       '~95\\% CI')
  
  base_summary = base_summary[,c(ncol(base_summary),1:(ncol(base_summary)-1))]
  base_summary = base_summary
  colnames(base_summary) = c('Quantity',FirstYR:LastYR)
  
  # Create the table
  base_summary.table = xtable(base_summary, caption=c('Base model results summary.'), 
                              label='tab:base_summary',digits=0) 
  # Add alignment   
  align(base_summary.table) = c('l',
                                'r', 
                                '>{\\centering}p{1.1in}',
                                '>{\\centering}p{1.1in}',
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}', 
                                '>{\\centering}p{1.1in}')    
  
  ################################################################################################################################################################
  # Executive summary values
  ################################################################################################################################################################
  
  # Lowest four recruitment years 
  RecDevs.all = mod1$recruitpars[grep('Main_RecrDev', rownames(mod1$recruitpars)), c("Value", "Parm_StDev")]
  ind = sort(RecDevs.all[, "Value"], index.return = TRUE)$ix[1:4]
  find.yr = rownames(mod1$recruitpars[grep('Main_RecrDev', rownames(mod1$recruitpars)), ])
  temp = substring(find.yr,14)
  recdev.lowest = temp[ind]
  ind = sort(RecDevs.all[, "Value"], index.return = TRUE)$ix[(dim(RecDevs.all)[1]-4):dim(RecDevs.all)[1]]
  recdev.highest = temp[ind]
  
  # Lowest SB
  find.sb = mod1$derived_quants[grep('SSB', mod1$derived_quants$Label), ]
  temp = find.sb[find.sb$Label >= paste('SSB_', Dat_start_mod1, sep='') & find.sb$Label <= paste('SSB_', Dat_end_mod1,  sep=''), ]  
  ind = sort(temp$Value, index.return = TRUE)$ix[1]
  ssb.yr = substring(temp$Label, 5)
  
  # Lowest depletion year
  low.ssb = ssb.yr[ind]
  
  low.dep.value = paste0( round(100*mod1$derived_quants[mod1$derived_quants$Label == paste0("SSB_", low.ssb), 'Value'] / 
                         mod1$derived_quants[mod1$derived_quants$Label == "SSB_Virgin", 'Value'],1), "%")
  
  # Depletion
  find.dep = mod1$derived_quants[grep('Bratio', mod1$derived_quants$Label), ]
  temp = find.dep[find.dep$Label >= paste('Bratio_', Dat_start_mod1, sep='') & find.dep$Label <= paste('Bratio_', Dat_end_mod1,  sep=''), ] 
  dep.vector = temp$Value
  ind = which(dep.vector < 0.25)
  first.yr.below.target = substring(temp$Label[ind[1]], 8)
  value.below.target = temp$Value[ind[1]]
  
  find = max(ind) + 1
  yr.rebuilt = substring(temp$Label[find], 8)
  
  ind = which(dep.vector < 0.125)
  first.yr.below.thresh = substring(temp$Label[ind[1]], 8)
  value.below.thresh = temp$Value[ind[1]]
  
  
  ind = sort(temp$Value, index.return = TRUE)$ix[1]
  
  Tot.catch = aggregate(ret_bio ~ Yr, FUN = sum, mod1$catch)$ret_bio
  Tot.catch.df = cbind((Dat_start_mod1-1):Dat_end_mod1, Tot.catch)
  temp = sort(Tot.catch.df[,2], index.return = TRUE)$ix
  max.catch.5 = Tot.catch.df[(temp[length(temp)]-5):temp[length(temp)],]
  
  Tot.catch.df = as.data.frame(Tot.catch.df)
  colnames(Tot.catch.df)<-c("Year", "Catch")
  