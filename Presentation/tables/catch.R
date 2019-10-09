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
FirstYR = 2007; LastYR = 2016
Final_Catch_AllYrs = read.csv('C:/Users/Chantel.Wetzel/Documents/GitHub/POP_2017/txt_files/POP2017_PacFIN_catch_forExpansion.csv')
Exec_catch_sep = Final_Catch_AllYrs
Exec_catch_sep = Exec_catch_sep [,2:ncol(Exec_catch_sep)]
Exec_catch_sep = Exec_catch_sep[Exec_catch_sep$Year != LastYR, ]

# Assign column names
survey = apply(Exec_catch_sep[,7:ncol(Exec_catch_sep)], 1, sum)
Exec_catch_sep = cbind(Exec_catch_sep[,1:(ncol(Exec_catch_sep)-6)], survey)
colnames(Exec_catch_sep) = c('Year',  'California', 'Oregon', 'Washington', 'At-sea hake', 'Foreign', 'Survey')

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
    scale_x_continuous(breaks=seq(1918, 2016, 20)) +
    ylab('Landings (mt)')
}