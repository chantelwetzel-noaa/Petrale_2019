### Run r4ss and notes for making model comparison plots and editing plots
### Originally developed for the 2015 China Rockfish assessment document, 
### which had three independent assessment models (South of 40-10, 
### 40-10 through OR, and WA). Written for up to 3 assessment models
### Even if you only have 1 assessment model, it will be called mod1 throughout
### 
### Section 1: run r4ss and create plots
###
### Section 2: save the entire myreplist and mod_structure files from r4ss as csv's
###
### Section 3: Copy csv files from working assessment folder into the txt folder 
### within the github directory
# =============================================================================

rm(list=ls(all=TRUE))

model.num = ""

# What model file to use
model.file = "model"
# Cannot change the name below without changing it throughout the Assessment_template file
model.plots = "plots_mod1" #paste0("plot_",model.file)
covar = TRUE

# Give the names of the data and control files, for each model
# Used in the SS_files_linebreaks.R
mod1_dat = "2019_petrale.dat"

# Control file names 
mod1_ctrl = "2019_petrale.ctl"


#=====================================================================================
# SECTION1: Run r4ss, parse plotInfoTable.csv file, & add linebreaks to SS files
#=====================================================================================

requiredPackages = c('xtable', 'ggplot2', 'reshape2', 'scales', 'rmarkdown', 'knitr', 'devtools')
for(p in requiredPackages){
  if(!require(p,character.only = TRUE)) install.packages(p)
  library(p,character.only = TRUE)
}

# Install the latest version of r4ss using devtools
# devtools::install_github("r4ss/r4ss", ref = "development")
library(r4ss)

# CHANGE values in this section ===============================================

# number of assessment models - this is run before the R_preamble.R, which also
# contains this value
n_models = 1
 

# By default, you can only work in the directory containing the project
# Set the directory here if you're getting errors
if (Sys.info()["user"] == "Chantel.Wetzel") {
  #setwd('C:/Users/chantell.Wetzel/Documents/GitHub/Petrale_2019')
  setwd('C:/Users/Chantel.Wetzel/Documents/GitHub/Petrale_2019')
}


# =============================================================================

# set input and output directories
input.dir = file.path(getwd(), 'SS')
output.dir = file.path(getwd(), 'r4ss')

dir.create(file.path(output.dir,model.plots), showWarnings = FALSE)


# BEGIN r4ss===================================================================
# REMOVE OLD r4SS OUTPUT!!!!! -------------------------------------------------

do.call("file.remove", list(list.files(file.path(output.dir, model.plots), 
  full.names=TRUE))) #, pattern = "!Thumb")))


# Run r4ss for each model - **CHANGE DIRECTORY if necessary**
mod1 = SS_output(dir = file.path(input.dir,model.file), forecast=T, printstats = FALSE)


# Save the workspace an image
save.image('./r4ss/SS_output.RData')



#=====================================================================================
# SECTION 2: RUN r4ss plots for each model & save files
#=====================================================================================

out.dir.mod1 = file.path(output.dir,model.plots)

fleets.in = c("Winter (N)", "Summer (N)", "Winter (S)", "Summer (S)", 
           "Triennial - Early", 
           "Triennial - Late", 
          #"AFSC/NFSC West Coast Triennial Shelf Survey - Early", 
          #"AFSC/NWFSC West Coast Triennial Shelf Survey - Late", 
          "NWFSC West Coast Groundfish Bottom Trawl Survey")

# Model 1
SS_plots(mod1,
         png = TRUE,
         html = TRUE,
         datplot = TRUE,
         uncertainty = covar,
         fleetnames = fleets.in,
         maxrows = 4, 
         maxcols = 4, 
         maxrows2 = 4, 
         maxcols2 = 4, 
         printfolder = '',
         bub.scale.dat= 6,
         dir = out.dir.mod1)

#=====================================================================================
# SECTION 3: Source other dependent code
#=====================================================================================

# Source the figures that are created based on the model results
source('./Rcode/Figures.R')


# Run the code to parse the plotInfoTable files
source('./Rcode/Parse_r4ss_plotInfoTable.R')


# Create the SS files for the appendices
# source('./Rcode/SS_files_linebreaks.R')

#=====================================================================================
# SECTION 4: Move Figures & CSV files from working directory to github directory
#=====================================================================================
folders = c(
          "NWFSC_Combo/plots/",
          "Triennial/early/plots/",
          "Triennial/late/plots/",
          "Biology/plots/",
          "Assessment_History/plots/"
           )

HomeDir = "C:/Assessments/2019/petrale_2019/Data/"

for (i in 1:length(folders)){
  files = list.files(paste0(HomeDir, folders[i]))
  for(j in 1:length(files)){
   file.copy(paste0(HomeDir,folders[i], files[j]),
             paste0(getwd(), "/Figures"), overwrite = TRUE)
  }
}

folders = c("_profiles/plots/", "_retro/plots/", "_sensitivities/plots/", "3.0_base/data_plots/")
HomeDir = "C:/Assessments/2019/petrale_2019/Models/"
for (i in 1:length(folders)){
  files = list.files(paste0(HomeDir, folders[i]))
  for(j in 1:length(files)){
    file.copy(paste0(HomeDir,folders[i], files[j]),
              paste0(getwd(), "/Figures"), overwrite = TRUE)
  }
}

location = c("C:/Assessments/2019/petrale_2019/Data/NWFSC_Combo/VAST/gamma/QQ_Fn/",
             rep("C:/Assessments/2019/petrale_2019/Data/NWFSC_Combo/VAST/gamma/",3),
             "C:/Assessments/2019/petrale_2019/Data/Triennial/VAST/gamma/early/QQ_Fn/",
             rep("C:/Assessments/2019/petrale_2019/Data/Triennial/VAST/gamma/early/",3), 
             "C:/Assessments/2019/petrale_2019/Data/Triennial/VAST/gamma/late/QQ_Fn/",
             rep("C:/Assessments/2019/petrale_2019/Data/Triennial/VAST/gamma/late/",3)
            )

files = c(
          rep(c("Posterior_Predictive-Histogram-1.jpg",
          "maps--catchrate_pearson_resid.png",
          "maps--encounter_pearson_resid.png",
          "Dens.png"), 3)
          )

files.new = c(rep("nwfsc_", 4), 
              rep("tri_early_", 4),
              rep("tri_late_", 4))

for(j in 1:length(files)){
  file.copy(paste0(location[j], files[j]), paste0(getwd(), "/Figures"), overwrite = TRUE)
  file.rename(paste0(getwd(), "/Figures/",files[j]), paste0(getwd(), "/Figures/", files.new[j], files[j]))
}

# CSV files ------------------------------
folders = c(
  "NWFSC_Combo/forSS/nwfsc_combo_length_sample_size.csv",
  "NWFSC_Combo/forSS/nwfsc_combo_age_sample_size.csv",
  "Triennial/early/forSS/triennial_early_length_sample_size.csv",
  "Triennial/late/forSS/triennial_late_length_sample_size.csv"
)

HomeDir = "C:/Assessments/2019/petrale_2019/Data/"

for (i in 1:length(folders)){
  file.copy(paste0(HomeDir,folders[i]),
              paste0(getwd(), "/txt_files"), overwrite = TRUE)
}

file.copy("C:/Assessments/2019/petrale_2019/Models/_sensitivities/tables/Sensitivities.csv", paste0(getwd(), "/txt_files"), overwrite = TRUE)
file.copy(paste0(HomeDir, "Commercial_Comps/forSS/Fishery_Age_Samples.csv"), paste0(getwd(), "/txt_files"), overwrite = TRUE)
file.copy(paste0(HomeDir, "Commercial_Comps/forSS/Fishery_Length_Samples.csv"), paste0(getwd(), "/txt_files"), overwrite = TRUE)
 
#=====================================================================================
# SECTION 5: Create Numbers at Age Table
#=====================================================================================
base      <- readLines( paste0(getwd(),"/SS/", model.file, "/Report.sso"))

# First and last years of model model 1
startyr = mod1$startyr # year model 1 data starts 
endyr   = mod1$endyr   # year model 1 data ends

maxAge = length(strsplit(base[grep(paste("1 1 1 1 1 1 1", startyr,sep=" "),base)]," ")[[1]]) - 14


temp = mapply(function(x) temp = as.numeric(strsplit(base[grep(paste("1 1 1 1 1 1 1", x,sep=" "),base)]," ")[[1]][14:(14+maxAge)]), x = startyr:endyr)
natage.f = t(temp) 
temp = mapply(function(x) temp = as.numeric(strsplit(base[grep(paste("1 1 2 1 1 1 2", x,sep=" "),base)]," ")[[1]][14:(14+maxAge)]), x = startyr:endyr)
natage.m = t(temp) 

colnames(natage.f) = 0:maxAge; colnames(natage.m) = 0:maxAge		
rownames(natage.f) <- startyr:endyr ; rownames(natage.m) <- startyr:endyr

write.csv(natage.f, paste0(getwd(), "/txt_files/Petrale_natage_f.csv"))
write.csv(natage.m, paste0(getwd(), "/txt_files/Petrale_natage_m.csv"))	


#=====================================================================================
# SECTION 6: Functions
#=====================================================================================

print.numeric<-function(x, digits) { formatC(x, digits = digits, format = "f") }
comma <- function(x, digits=0) { formatC(x, big.mark=",", digits, format = "f") }



