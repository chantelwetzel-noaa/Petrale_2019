#V3.30.13-safe;_2019_03_09;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.0
#Stock Synthesis (SS) is a work of the U.S. Government and is not subject to copyright protection in the United States.
#Foreign copyrights may apply. See copyright.txt for more information.
#_user_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_user_info_available_at:https://vlab.ncep.noaa.gov/group/stock-synthesis
#_data_and_control_files: 2019_petrale.dat // 2019_petrale.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
5 #_Nblock_Patterns
 5 3 3 1 1 #_blocks_per_pattern 
# begin and end years of blocks
 1973 1982 1983 1992 1993 2002 2003 2010 2011 2018
 2003 2009 2010 2010 2011 2018
 2003 2008 2009 2010 2011 2018
 1875 1875
 2004 2009
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
#
# AUTOGEN
1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: null;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  21-24 keep last dev for rest of years
#
#
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement 
#
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
2 #_Age(post-settlement)_for_L1;linear growth below this
17 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
3 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#LO	HI	INIT	PRIOR	PR_SD	 PR_Typ	PHASE	env_var&link	dev_link	dev_minyr	dev_maxyr	dev_PH	Block	Block_Fxn		
0.005	0.5	0.151334	-1.7793	 0.438	3	6	0	0	0	0	0.5	0	0	#NatM_p_1_Fem_GP_1
10	45	15.4987		17.18	 10	0	2	0	0	0	0	0.5	0	0	#L_at_Amin_Fem_GP_1
35	80	53.1287		54.2	 10	0	3	0	0	0	0	0.5	0	0	#L_at_Amax_Fem_GP_1
0.04	0.5	0.142492	0.157	 0.8	0	2	0	0	0	0	0.5	0	0	#VonBert_K_Fem_GP_1
0.01	1	0.188679	3	 0.8	0	3	0	0	0	0	0.5	0	0	#CV_young_Fem_GP_1
0.01	1	0.0344042	0	 1	0	4	0	0	0	0	0	0	0	#CV_old_Fem_GP_1
-3	3	1.99E-06	1.99E-06 0.8	6	-3	0	0	0	0	0.5	0	0	#Wtlen_1_Fem_GP_1
1	5	3.484		3.478	 0.8	6	-3	0	0	0	0	0.5	0	0	#Wtlen_2_Fem_GP_1
10	50	33.1		33.1	 0.8	6	-3	0	0	0	0	0.5	0	0	#Mat50%_Fem_GP_1
-3	3	-0.743		-0.743	 0.8	6	-3	0	0	0	0	0.5	0	0	#Mat_slope_Fem_GP_1
-3	3	1		1	 1	6	-3	0	0	0	0	0.5	0	0	#Eggs/kg_inter_Fem_GP_1
-3	3	0		0	 1	6	-3	0	0	0	0	0.5	0	0	#Eggs/kg_slope_wt_Fem_GP_1
0.005	0.6	0.156867	-1.6809	 0.438	3	6	0	0	0	0	0.5	0	0	#NatM_p_1_Mal_GP_1
10	45	16.2205		17.18	 10	0	2	0	0	0	0	0.5	0	0	#L_at_Amin_Mal_GP_1
35	80	40.8739		41.1	 10	0	3	0	0	0	0	0.5	0	0	#L_at_Amax_Mal_GP_1
0.04	0.5	0.233833	0.247	 0.8	0	2	0	0	0	0	0.5	0	0	#VonBert_K_Mal_GP_1
0.01	1	0.135122	3	 0.8	0	3	0	0	0	0	0.5	0	0	#CV_young_Mal_GP_1
0.01	1	0.059173	0	 1	0	4	0	0	0	0	0	0	0	#CV_old_Mal_GP_1
-3	3	2.98E-06	2.98E-06 0.8	6	-3	0	0	0	0	0.5	0	0	#Wtlen_1_Mal_GP_1
-3	5	3.363		3.363	 0.8	6	-3	0	0	0	0	0.5	0	0	#Wtlen_2_Mal_GP_1
0	1	1		1	 0	0	-4	0	0	0	0	0	0	0	#CohortGrowDev
0.01	0.99	0.5		0.5	 0.5	0	-99	0	0	0	0	0	0	0	#FracFemale_GP_1

#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             5            20       9.84924             9            10             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1      0.862234           0.8          0.09             6          5          0          0          0          0          0          0          0 # SR_BH_steep
             0             2           0.4           0.9             5             6        -99          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0           0.2             6         -2          0          0          0          0          0          0          0 # SR_regime
             0             0             0             0             0             0        -99          0          0          0          0          0          0          0 # SR_autocorr
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1959 # first year of main recr_devs; early devs can preceed this era
2016 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1845 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 3 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1944 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1964 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2015 #_last_yr_fullbias_adj_in_MPD
 2018 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
 0.8 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -4 #min rec_dev
 4 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1845E 1846E 1847E 1848E 1849E 1850E 1851E 1852E 1853E 1854E 1855E 1856E 1857E 1858E 1859E 1860E 1861E 1862E 1863E 1864E 1865E 1866E 1867E 1868E 1869E 1870E 1871E 1872E 1873E 1874E 1875E 1876E 1877E 1878E 1879E 1880E 1881E 1882E 1883E 1884E 1885E 1886E 1887E 1888E 1889E 1890E 1891E 1892E 1893E 1894E 1895E 1896E 1897E 1898E 1899E 1900E 1901E 1902E 1903E 1904E 1905E 1906E 1907E 1908E 1909E 1910E 1911E 1912E 1913E 1914E 1915E 1916E 1917E 1918E 1919E 1920E 1921E 1922E 1923E 1924E 1925E 1926E 1927E 1928E 1929E 1930E 1931E 1932E 1933E 1934E 1935E 1936E 1937E 1938E 1939E 1940E 1941E 1942E 1943E 1944E 1945E 1946E 1947E 1948E 1949E 1950E 1951E 1952E 1953E 1954E 1955E 1956E 1957E 1958E 1959R 1960R 1961R 1962R 1963R 1964R 1965R 1966R 1967R 1968R 1969R 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017F 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F
#  1.79961e-07 2.09323e-07 2.43446e-07 2.83075e-07 3.29104e-07 3.82525e-07 4.44513e-07 5.164e-07 5.99721e-07 6.96226e-07 8.07918e-07 9.37085e-07 1.08631e-06 1.25853e-06 1.45702e-06 1.68554e-06 1.94822e-06 2.24969e-06 2.59503e-06 2.9899e-06 3.44047e-06 3.95345e-06 4.53609e-06 5.19584e-06 5.93993e-06 6.77576e-06 7.71393e-06 8.77183e-06 9.97084e-06 1.13314e-05 1.28747e-05 1.46252e-05 1.66105e-05 1.88619e-05 2.14151e-05 2.431e-05 2.75914e-05 3.13102e-05 3.55238e-05 4.02971e-05 4.57034e-05 5.18253e-05 5.87563e-05 6.66018e-05 7.54808e-05 8.55275e-05 9.68938e-05 0.000109751 0.000124291 0.000140732 0.000159316 0.000180319 0.000204054 0.000230865 0.000261146 0.000295337 0.000333941 0.000377528 0.000426727 0.000482255 0.000544925 0.000615636 0.000695396 0.00078537 0.000885741 0.000998185 0.00112484 0.00126686 0.00142601 0.00160447 0.00180338 0.00202179 0.00225952 0.00251802 0.00280134 0.00311101 0.00344707 0.00380896 0.00419384 0.00460253 0.00503535 0.00549303 0.00597819 0.00649184 0.00704869 0.00769378 0.00854281 0.00981575 0.0119136 0.0153585 0.020505 0.0273538 0.0351341 0.0414011 0.0409964 0.0268734 -0.00423274 -0.0462569 -0.0819968 -0.0872237 -0.0556619 -0.0270869 -0.0271084 -0.0333565 -0.036726 -0.0347797 -0.0261964 -0.0134464 -0.0146194 -0.0397204 -0.0772964 -0.114438 -0.16481 -0.194744 -0.166635 0.0243544 0.236913 -0.193558 -0.260912 0.206145 -0.0504644 0.733095 -0.114529 -0.0535044 0.0738905 0.188404 0.0200074 -0.251599 -0.371727 -0.151406 -0.138148 0.135555 0.3154 0.148194 -0.124113 -0.0553816 -0.156952 -0.130399 0.0197774 0.382789 -0.152212 -0.531574 -0.37283 0.0497538 0.373205 0.337692 -0.159566 -0.583846 0.0558785 0.219744 -0.341314 -0.22264 -0.213651 0.656089 0.209818 -0.134491 -0.216629 -0.144021 -0.392828 -0.172379 -0.0951134 0.508537 0.715095 0.994069 0.0974426 -0.147875 -0.0118738 0.332876 -0.243944 -0.259906 -0.327975 -0.090728 -0.117789 0 0 0 0 0 0 0 0 0 0 0 0 0
# implementation error by year in forecast:  0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.3 # F ballpark
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
5  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms; count = 0
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#2030 2039
# F rates by fleet
# Yr:  1876 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886 1887 1888 1889 1890 1891 1892 1893 1894 1895 1896 1897 1898 1899 1900 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# WinterN 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.24229e-05 0.000158261 0.000267994 0.000384404 0.000448257 0.0005704 0.000819772 0.00109375 0.00126966 0.00139804 0.00162709 0.00190105 0.00217923 0.0024404 0.00276127 0.00314715 0.00363433 0.00419423 0.00981225 0.00823979 0.00968698 0.00350661 0.00206668 0.00455603 0.0110052 0.0138823 0.00829902 0.0283444 0.0210084 0.0200084 0.0296229 0.0734449 0.034044 0.0469492 0.0476551 0.0542633 0.0381183 0.0253218 0.0550569 0.100665 0.10086 0.0879154 0.0955658 0.110813 0.115456 0.168515 0.209851 0.261809 0.173941 0.422778 0.693631 0.263415 0.15125 0.132676 0.158197 0.310564 0.301034 0.301088 0.29352 0.409618 0.378653 0.492449 0.323178 0.294178 0.254065 0.258985 0.21419 0.17731 0.222348 0.250244 0.233208 0.200068 0.315198 0.281139 0.153106 0.263161 0.246384 0.257649 0.0841218 0.0494791 0.066641 0.0629599 0.0841129 0.0885184 0.0671624 0.0848916 0.0706743 0.0775818 0.0796331 0.129861 0.129099 0.128507 0.12792 0.127175 0.126574 0.125965 0.125195 0.124577 0.123959
# SummerN 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.09085e-06 4.17859e-06 3.26281e-06 3.18052e-06 3.09902e-06 3.01724e-06 2.93517e-06 2.85175e-06 2.76907e-06 2.68606e-06 2.60166e-06 2.51796e-06 2.43392e-06 2.34845e-06 2.26367e-06 2.17852e-06 2.09298e-06 2.00599e-06 1.91967e-06 1.83296e-06 1.74468e-06 1.65914e-06 1.57327e-06 1.48341e-06 1.38912e-06 1.29528e-06 1.20397e-06 1.11294e-06 1.02369e-06 9.34787e-07 8.43827e-07 7.91089e-07 1.12046e-08 3.51254e-05 2.804e-05 0.00187384 0.0058055 0.00951945 0.0134377 0.015737 0.0189899 0.0264799 0.0307787 0.0415674 0.0486692 0.0522647 0.0881432 0.0913024 0.0680424 0.0637994 0.0892001 0.0674883 0.094808 0.0823508 0.118864 0.0932933 0.081222 0.0438298 0.0545639 0.0531663 0.0469495 0.068971 0.0740627 0.0620032 0.0919713 0.109589 0.116263 0.087268 0.0979699 0.0874803 0.0902352 0.0750075 0.0772655 0.083349 0.0994578 0.0804521 0.0946724 0.120572 0.161666 0.174096 0.118236 0.10074 0.168172 0.201605 0.21294 0.110922 0.193027 0.262875 0.203267 0.145083 0.188243 0.163698 0.189629 0.190436 0.160514 0.157871 0.163151 0.156976 0.118821 0.12674 0.114255 0.11332 0.150328 0.123531 0.138636 0.139864 0.154978 0.142218 0.130202 0.18174 0.175645 0.0955428 0.0657107 0.130018 0.0521722 0.0670153 0.0568196 0.092596 0.0637981 0.0720479 0.0739669 0.0787763 0.0788723 0.0836667 0.0792654 0.0929655 0.0924314 0.0920172 0.0916037 0.0910743 0.0906463 0.0902116 0.089664 0.0892243 0.088785
# WinterS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00139581 0.000805946 0.000859973 0.00315532 0.00359684 0.00225104 0.00179253 0.00118445 0.000791313 0.00431855 0.00305566 0.000698765 0.00216326 0.00269112 0.00328964 0.0024319 0.00550818 0.0105364 0.0264509 0.0203771 0.0109086 0.0177458 0.0294606 0.0448757 0.0300442 0.0291441 0.0305487 0.0338213 0.0229894 0.0322137 0.0355759 0.0366476 0.0414397 0.0311915 0.0314138 0.027431 0.0457396 0.0312791 0.0359458 0.0392092 0.044186 0.0587519 0.0343007 0.058006 0.0543036 0.0769067 0.0570904 0.0555456 0.0556768 0.0931869 0.0683117 0.0515894 0.070999 0.0661781 0.066703 0.0992333 0.0834518 0.101945 0.11978 0.103268 0.164919 0.113263 0.114759 0.100215 0.0773139 0.118984 0.131758 0.0652096 0.0797714 0.0990834 0.0815669 0.0846741 0.0587981 0.0347092 0.0639165 0.0235425 0.0777339 0.104659 0.0978849 0.0154045 0.00600694 0.0138598 0.0110756 0.0192582 0.0136056 0.0142215 0.0118754 0.0130544 0.00864863 0.0155518 0.0358666 0.0356602 0.0355004 0.0353411 0.035137 0.0349719 0.0348041 0.0345928 0.0344232 0.0342537
# SummerS 1.96083e-05 1.96086e-05 1.9609e-05 1.96093e-05 0.000226513 0.000433547 0.000640826 0.000848457 0.00105653 0.00126514 0.00147434 0.00168422 0.00189481 0.00210616 0.00231832 0.00253132 0.00274519 0.00296015 0.00317583 0.00339244 0.00361 0.00382853 0.00404804 0.00426853 0.00449001 0.00471249 0.00493598 0.00516049 0.00538602 0.00561257 0.00584016 0.0060688 0.00629847 0.00652919 0.00676096 0.00699378 0.00722765 0.00746258 0.00769856 0.0079356 0.00807012 0.0110314 0.00891414 0.00702227 0.00485015 0.00617296 0.00893077 0.00900146 0.0112553 0.011204 0.0110971 0.0135007 0.01331 0.0152351 0.014292 0.0115688 0.0113939 0.00865206 0.0200756 0.0178004 0.0100628 0.0176297 0.0217811 0.0261019 0.0157389 0.00902154 0.00610372 0.0102711 0.0138737 0.0140118 0.0372156 0.0386308 0.0677552 0.0765558 0.0774331 0.0510631 0.0470836 0.0531911 0.0590436 0.0589882 0.0450388 0.0583826 0.0559161 0.0430311 0.0391617 0.0662656 0.0600156 0.0743445 0.0747995 0.0698549 0.0761627 0.0734214 0.0737175 0.0704721 0.0862008 0.0807363 0.0815382 0.0595606 0.0759561 0.0849686 0.0775121 0.0570154 0.103614 0.145019 0.118497 0.163802 0.0951444 0.0688769 0.0629729 0.0885472 0.0680357 0.113563 0.0879142 0.0929765 0.0915606 0.0870786 0.0922009 0.0909456 0.0969551 0.0778496 0.0996222 0.113533 0.0760356 0.0635691 0.0556235 0.0593798 0.0411205 0.0390214 0.0510146 0.0976841 0.0842978 0.0901801 0.0818807 0.0503212 0.0212443 0.00991025 0.0100897 0.0205438 0.0244278 0.0207157 0.0132171 0.0218063 0.0226517 0.0239541 0.0227226 0.0331836 0.032995 0.0328485 0.0327016 0.032513 0.0323603 0.0322054 0.0320106 0.0318542 0.031698
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         1         3         0         0         1         0  #  WinterN
         3         3         0         0         1         0  #  WinterS
         5         1         0         1         0         1  #  TriEarly
         6         1         0         1         0         1  #  TriLate
         7         1         0         0         0         1  #  NWFSC
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -20             5      -7.33661             0            99             0          1          0          0          0          0          0          5          1  #  LnQ_base_WinterN(1)
            -5             5     -0.078707             0            -1             0          3          0          0          0          0          0          0          0  #  Q_power_WinterN(1)
           -20             5      -1.68912             0            99             0          1          0          0          0          0          0          5          1  #  LnQ_base_WinterS(3)
            -5             5     -0.813913             0            -1             0          3          0          0          0          0          0          0          0  #  Q_power_WinterS(3)
           -15            15     -0.845251             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_TriEarly(5)
         0.001             2      0.210369          0.22            -1             0          5          0          0          0          0          0          0          0  #  Q_extraSD_TriEarly(5)
           -15            15     -0.397712             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_TriLate(6)
         0.001             2      0.306846          0.16            -1             0          4          0          0          0          0          0          0          0  #  Q_extraSD_TriLate(6)
           -15            15        1.0575             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_NWFSC(7)
# timevary Q parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type     PHASE  #  parm_name
         -0.99          0.99      0.479235             0           0.5             6      3  # LnQ_base_WinterN(1)_BLK5add_2004
         -0.99          0.99      0.637066             0           0.5             6      3  # LnQ_base_WinterS(3)_BLK5add_2004
# info on dev vectors created for Q parms are reported with other devs after tag parameter section 
#
#_size_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for all sizes
#Pattern:_1; parm=2; logistic; with 95% width specification
#Pattern:_5; parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6; parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8; parm=8; New doublelogistic with smooth transitions and constant above Linf option
#Pattern:_9; parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in size
#Pattern:_27; parm=3+special; cubic spline 
#Pattern:_42; parm=2+special+3; // like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 1 3 0 # 1 WinterN
 24 1 3 0 # 2 SummerN
 24 1 3 0 # 3 WinterS
 24 1 3 0 # 4 SummerS
 24 0 3 0 # 5 TriEarly
 24 0 3 0 # 6 TriLate
 24 0 3 0 # 7 NWFSC
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#_Pattern Discard Male Special
 10 0 0 0 # 1 WinterN
 10 0 0 0 # 2 SummerN
 10 0 0 0 # 3 WinterS
 10 0 0 0 # 4 SummerS
 10 0 0 0 # 5 TriEarly
 10 0 0 0 # 6 TriLate
 10 0 0 0 # 7 NWFSC
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   WinterN LenSelex
            15            75       48.6913          43.1             5             0          1          0          0          0          0        0.5          1          1  #  Size_DblN_peak_WinterN(1)
            -5             3             3           0.7             5             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_top_logit_WinterN(1)
            -4            12       4.32519          3.42             5             0          2          0          0          0          0        0.5          0          0  #  Size_DblN_ascend_se_WinterN(1)
            -2            15            14          0.21             5             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_descend_se_WinterN(1)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_start_logit_WinterN(1)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_end_logit_WinterN(1)
            10            40       28.1513            15             9             0          1          0          0          0          0          0          2          1  #  Retain_L_infl_WinterN(1)
           0.1            10       1.84909             3             9             0          2          0          0          0          0          0          2          1  #  Retain_L_width_WinterN(1)
           -10            10       9.03653            10             9             0          4          0          0          0          0          0          2          2  #  Retain_L_asymptote_logit_WinterN(1)
           -10            10             0             0             9             0         -2          0          0          0          0          0          0          0  #  Retain_L_maleoffset_WinterN(1)
           -15            15      -12.0716             0             5             0          3          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_WinterN(1)
           -15            15      -1.48626             0             5             0          4          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_WinterN(1)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_WinterN(1)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_WinterN(1)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_WinterN(1)
# 2   SummerN LenSelex
            15            75       45.3007          43.1             5             0          1          0          0          0          0        0.5          1          1  #  Size_DblN_peak_SummerN(2)
            -5             3             3           0.7             5             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_top_logit_SummerN(2)
            -4            12       5.15775          3.42             5             0          2          0          0          0          0        0.5          0          0  #  Size_DblN_ascend_se_SummerN(2)
            -2            15            14          0.21             5             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_descend_se_SummerN(2)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_start_logit_SummerN(2)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_end_logit_SummerN(2)
            10            40        29.211            15             9             0          1          0          0          0          0          0          3          1  #  Retain_L_infl_SummerN(2)
           0.1            10       1.57764             3             9             0          2          0          0          0          0          0          3          1  #  Retain_L_width_SummerN(2)
           -10            10       4.53507            10             9             0          4          0          0          0          0          0          3          2  #  Retain_L_asymptote_logit_SummerN(2)
           -10            10             0             0             9             0         -2          0          0          0          0          0          0          0  #  Retain_L_maleoffset_SummerN(2)
           -20            15      -13.2585             0            -5             0          3          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_SummerN(2)
           -15            15      -2.17725             0            -5             0          4          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_SummerN(2)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_SummerN(2)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_SummerN(2)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_SummerN(2)
# 3   WinterS LenSelex
            15            75       38.7137          43.1             5             0          1          0          0          0          0        0.5          1          1  #  Size_DblN_peak_WinterS(3)
            -5             3             3           0.7             5             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_top_logit_WinterS(3)
            -4            12       4.41461          3.42             5             0          2          0          0          0          0        0.5          0          0  #  Size_DblN_ascend_se_WinterS(3)
            -2            15            14          0.21             5             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_descend_se_WinterS(3)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_start_logit_WinterS(3)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_end_logit_WinterS(3)
            10            40       29.4209            15             9             0          1          0          0          0          0          0          2          1  #  Retain_L_infl_WinterS(3)
           0.1            10       1.61088             3             9             0          2          0          0          0          0          0          2          1  #  Retain_L_width_WinterS(3)
           -10            10       8.67923            10             9             0          4          0          0          0          0          0          2          2  #  Retain_L_asymptote_logit_WinterS(3)
           -10            10             0             0             9             0         -2          0          0          0          0          0          0          0  #  Retain_L_maleoffset_WinterS(3)
           -15            15      -7.48802             0             5             0          3          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_WinterS(3)
           -15            15      -1.26686             0             5             0          4          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_WinterS(3)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_WinterS(3)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_WinterS(3)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_WinterS(3)
# 4   SummerS LenSelex
            15            75       40.6087          43.1             5             0          1          0          0          0          0        0.5          1          1  #  Size_DblN_peak_SummerS(4)
            -5             3             3           0.7             5             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_top_logit_SummerS(4)
            -4            12         4.923          3.42             5             0          2          0          0          0          0        0.5          0          0  #  Size_DblN_ascend_se_SummerS(4)
            -2            15            14          0.21             5             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_descend_se_SummerS(4)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_start_logit_SummerS(4)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_end_logit_SummerS(4)
            10            40        28.936            15             9             0          1          0          0          0          0          0          3          1  #  Retain_L_infl_SummerS(4)
           0.1            10       1.04009             3             9             0          2          0          0          0          0          0          3          1  #  Retain_L_width_SummerS(4)
           -10            10       9.52099            10             9             0          4          0          0          0          0          0          3          2  #  Retain_L_asymptote_logit_SummerS(4)
           -10            10             0             0             9             0         -2          0          0          0          0          0          0          0  #  Retain_L_maleoffset_SummerS(4)
           -15            15      -12.8125             0             5             0          3          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_SummerS(4)
           -15            15      -1.93303             0             5             0          4          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_SummerS(4)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_SummerS(4)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_SummerS(4)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_SummerS(4)
# 5   TriEarly LenSelex
            15            61       34.9276          43.1             5             0          1          0          0          0          0        0.5          0          0  #  Size_DblN_peak_TriEarly(5)
            -5             3             3           0.7             5             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_top_logit_TriEarly(5)
            -4            12       4.14085          3.42             5             0          1          0          0          0          0        0.5          0          0  #  Size_DblN_ascend_se_TriEarly(5)
            -2            15            14          0.21             5             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_descend_se_TriEarly(5)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_start_logit_TriEarly(5)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_end_logit_TriEarly(5)
           -15            15       -3.4918             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_TriEarly(5)
           -15            15     -0.491136             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_TriEarly(5)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_TriEarly(5)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_TriEarly(5)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_TriEarly(5)
# 6   TriLate LenSelex
            15            61       36.5552          43.1             5             0          1          0          0          0          0        0.5          0          0  #  Size_DblN_peak_TriLate(6)
            -5             3             3           0.7             5             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_top_logit_TriLate(6)
            -4            12       4.64973          3.42             5             0          1          0          0          0          0        0.5          0          0  #  Size_DblN_ascend_se_TriLate(6)
            -2            15            14          0.21             5             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_descend_se_TriLate(6)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_start_logit_TriLate(6)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_end_logit_TriLate(6)
           -15            15      -2.11797             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_TriLate(6)
           -15            15    -0.0242089             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_TriLate(6)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_TriLate(6)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_TriLate(6)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_TriLate(6)
# 7   NWFSC LenSelex
            15            61       42.7668          43.1             5             0          1          0          0          0          0        0.5          0          0  #  Size_DblN_peak_NWFSC(7)
            -5             3             3           0.7             5             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_top_logit_NWFSC(7)
            -4            12       5.13924          3.42             5             0          1          0          0          0          0        0.5          0          0  #  Size_DblN_ascend_se_NWFSC(7)
            -2            15            14          0.21             5             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_descend_se_NWFSC(7)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_start_logit_NWFSC(7)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  Size_DblN_end_logit_NWFSC(7)
           -15            15      -4.91699             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_NWFSC(7)
           -15            15       -0.4041             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_NWFSC(7)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_NWFSC(7)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_NWFSC(7)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_NWFSC(7)
# 1   WinterN AgeSelex
# 2   SummerN AgeSelex
# 3   WinterS AgeSelex
# 4   SummerS AgeSelex
# 5   TriEarly AgeSelex
# 6   TriLate AgeSelex
# 7   NWFSC AgeSelex
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
         -31.6          28.4        1.9551             0          14.2             6      4  # Size_DblN_peak_WinterN(1)_BLK1add_1973
         -31.6          28.4      -1.97291             0          14.2             6      4  # Size_DblN_peak_WinterN(1)_BLK1add_1983
         -31.6          28.4     -0.789171             0          14.2             6      4  # Size_DblN_peak_WinterN(1)_BLK1add_1993
         -31.6          28.4      0.485316             0          14.2             6      4  # Size_DblN_peak_WinterN(1)_BLK1add_2003
         -31.6          28.4      0.916987             0          14.2             6      4  # Size_DblN_peak_WinterN(1)_BLK1add_2011
        -16.19         13.81      -2.40321             0         6.905             6      4  # Retain_L_infl_WinterN(1)_BLK2add_2003
        -16.19         13.81       1.52172             0         6.905             6      4  # Retain_L_infl_WinterN(1)_BLK2add_2010
        -16.19         13.81      -3.39699             0         6.905             6      4  # Retain_L_infl_WinterN(1)_BLK2add_2011
        -1.601         8.299      0.116126             0        0.8005             6      4  # Retain_L_width_WinterN(1)_BLK2add_2003
        -1.601         8.299      0.384528             0        0.8005             6      4  # Retain_L_width_WinterN(1)_BLK2add_2010
        -1.601         8.299     -0.690633             0        0.8005             6      4  # Retain_L_width_WinterN(1)_BLK2add_2011
           -10            10       6.61377            10             9             0      4  # Retain_L_asymptote_logit_WinterN(1)_BLK2repl_2003
           -10            10       2.10248            10             9             0      4  # Retain_L_asymptote_logit_WinterN(1)_BLK2repl_2010
           -10            10       9.96042            10             9             0      4  # Retain_L_asymptote_logit_WinterN(1)_BLK2repl_2011
         -38.8          21.2       -0.4095             0          10.6             6      4  # Size_DblN_peak_SummerN(2)_BLK1add_1973
         -38.8          21.2      0.981231             0          10.6             6      4  # Size_DblN_peak_SummerN(2)_BLK1add_1983
         -38.8          21.2    -0.0735326             0          10.6             6      4  # Size_DblN_peak_SummerN(2)_BLK1add_1993
         -38.8          21.2       1.07942             0          10.6             6      4  # Size_DblN_peak_SummerN(2)_BLK1add_2003
         -38.8          21.2       4.35803             0          10.6             6      4  # Size_DblN_peak_SummerN(2)_BLK1add_2011
       -20.679         9.321     -0.198357             0        4.6605             6      4  # Retain_L_infl_SummerN(2)_BLK3add_2003
       -20.679         9.321       1.94573             0        4.6605             6      4  # Retain_L_infl_SummerN(2)_BLK3add_2009
       -20.679         9.321      -1.45955             0        4.6605             6      4  # Retain_L_infl_SummerN(2)_BLK3add_2011
       -1.0278        8.8722      0.319789             0        0.5139             6      4  # Retain_L_width_SummerN(2)_BLK3add_2003
       -1.0278        8.8722      0.267803             0        0.5139             6      4  # Retain_L_width_SummerN(2)_BLK3add_2009
       -1.0278        8.8722    -0.0105716             0        0.5139             6      4  # Retain_L_width_SummerN(2)_BLK3add_2011
           -10            10       5.68752            10             9             0      4  # Retain_L_asymptote_logit_SummerN(2)_BLK3repl_2003
           -10            10       9.55626            10             9             0      4  # Retain_L_asymptote_logit_SummerN(2)_BLK3repl_2009
           -10            10       6.25184            10             9             0      4  # Retain_L_asymptote_logit_SummerN(2)_BLK3repl_2011
       -25.422        34.578      -4.28962             0        12.711             6      4  # Size_DblN_peak_WinterS(3)_BLK1add_1973
       -25.422        34.578       2.78231             0        12.711             6      4  # Size_DblN_peak_WinterS(3)_BLK1add_1983
       -25.422        34.578       4.57917             0        12.711             6      4  # Size_DblN_peak_WinterS(3)_BLK1add_1993
       -25.422        34.578       5.27907             0        12.711             6      4  # Size_DblN_peak_WinterS(3)_BLK1add_2003
       -25.422        34.578       6.22985             0        12.711             6      4  # Size_DblN_peak_WinterS(3)_BLK1add_2011
       -18.816        11.184     -0.767558             0         5.592             6      4  # Retain_L_infl_WinterS(3)_BLK2add_2003
       -18.816        11.184       2.26849             0         5.592             6      4  # Retain_L_infl_WinterS(3)_BLK2add_2010
       -18.816        11.184      -3.01204             0         5.592             6      4  # Retain_L_infl_WinterS(3)_BLK2add_2011
       -1.0443        8.8557     -0.176178             0       0.52215             6      4  # Retain_L_width_WinterS(3)_BLK2add_2003
       -1.0443        8.8557     -0.172343             0       0.52215             6      4  # Retain_L_width_WinterS(3)_BLK2add_2010
       -1.0443        8.8557    -0.0975636             0       0.52215             6      4  # Retain_L_width_WinterS(3)_BLK2add_2011
           -10            10       9.80678            10             9             0      4  # Retain_L_asymptote_logit_WinterS(3)_BLK2repl_2003
           -10            10       5.57119            10             9             0      4  # Retain_L_asymptote_logit_WinterS(3)_BLK2repl_2010
           -10            10       7.34024            10             9             0      4  # Retain_L_asymptote_logit_WinterS(3)_BLK2repl_2011
      -28.0793       31.9207      -4.81708             0       14.0397             6      4  # Size_DblN_peak_SummerS(4)_BLK1add_1973
      -28.0793       31.9207      -11.3425             0       14.0397             6      4  # Size_DblN_peak_SummerS(4)_BLK1add_1983
      -28.0793       31.9207       3.92846             0       14.0397             6      4  # Size_DblN_peak_SummerS(4)_BLK1add_1993
      -28.0793       31.9207       6.48698             0       14.0397             6      4  # Size_DblN_peak_SummerS(4)_BLK1add_2003
      -28.0793       31.9207       6.27675             0       14.0397             6      4  # Size_DblN_peak_SummerS(4)_BLK1add_2011
       -19.055        10.945      -1.45406             0        5.4725             6      4  # Retain_L_infl_SummerS(4)_BLK3add_2003
       -19.055        10.945      -1.70934             0        5.4725             6      4  # Retain_L_infl_SummerS(4)_BLK3add_2009
       -19.055        10.945      -2.14155             0        5.4725             6      4  # Retain_L_infl_SummerS(4)_BLK3add_2011
        -0.876         9.024      0.627828             0         0.438             6      4  # Retain_L_width_SummerS(4)_BLK3add_2003
        -0.876         9.024      0.488692             0         0.438             6      4  # Retain_L_width_SummerS(4)_BLK3add_2009
        -0.876         9.024      0.609335             0         0.438             6      4  # Retain_L_width_SummerS(4)_BLK3add_2011
           -10            10       7.41647            10             9             0      4  # Retain_L_asymptote_logit_SummerS(4)_BLK3repl_2003
           -10            10       8.69003            10             9             0      4  # Retain_L_asymptote_logit_SummerS(4)_BLK3repl_2009
           -10            10       7.65847            10             9             0      4  # Retain_L_asymptote_logit_SummerS(4)_BLK3repl_2011
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      2      1      0.02
      2      2      0.02
      2      3      0.02
      2      4      0.02
      4      1     1.377
      4      2      0.94
      4      3     0.897
      4      4     1.157
      4      5     1.822
      4      6      1.27
      4      7     0.568
      5      1     2.904
      5      2     2.421
      5      3     1.744
      5      4     1.583
      5      7     0.216
 -9999   1    0  # terminator
#
15 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 10 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 1 1 1 1 1
 1 3 1 1 1
 5 1 1 0.5 1
 5 2 1 0.5 1
 5 3 1 0.5 1
 5 4 1 0.5 1
 4 1 1 0.5 1
 4 2 1 0.5 1
 4 3 1 0.5 1
 4 4 1 0.5 1
-9999  1  1  1  1  #  terminator
0 # (0/1) read specs for more stddev reporting 
 # 0 0 0 0 0 0 0 0 0 # placeholder for # selex_fleet, 1=len/2=age/3=both, year, N selex bins, 0 or Growth pattern, N growth ages, 0 or NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

