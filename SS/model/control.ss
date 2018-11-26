#V3.30.13.00-trans-beta;_2018_11_08;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.0
#Stock Synthesis (SS) is a work of the U.S. Government and is not subject to copyright protection in the United States.
#Foreign copyrights may apply. See copyright.txt for more information.
#_user_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_user_info_available_at:https://vlab.ncep.noaa.gov/group/stock-synthesis
#C 2015 Assessent of Petrale (Fish600 people) run with SS3.24O
#_data_and_control_files: petrale15.dat // petrale15.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
2 # recr_dist_method for parameters:  2=main effects for GP, Settle timing, Area; 3=each Settle entity; 4=none, only when N_GP*Nsettle*pop==1
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
#  autogen
1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
# 
#
#_Available timevary codes
#_Block types: 0: Pblock=Pbase*exp(TVP); 1: Pblock=Pbase+TVP; 2: Pblock=TVP; 3: Pblock=Pblock(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=Pbase*exp(TVP*env(y));  2: P(y)=Pbase+TVP*env(y);  3: null;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=env(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho
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
#LO		HI	 	INIT		PRIOR		PR_SD	PR_type	PHASE	env_var&link	dev_link	dev_minyr	dev_maxyr	dev_PH	Block	Block_Fxn		
0.005	0.5	 	0.145		-1.888		0.3333	3		6	 0	0	0	0	0.5	0	0	#	NatM_p_1_Fem_GP_1
10		45	 	15.8		17.18		10		0		2	 0	0	0	0	0.5	0	0	#	L_at_Amin_Fem_GP_1
35		80	 	54.4		58.7		10		0		3	 0	0	0	0	0.5	0	0	#	L_at_Amax_Fem_GP_1
0.04	0.5	 	0.13		0.13		0.8		0		2	 0	0	0	0	0.5	0	0	#	VonBert_K_Fem_GP_1
0.01	1	 	0.19		3			0.8		0		3	 0	0	0	0	0.5	0	0	#	CV_young_Fem_GP_1
0.01	1	 	0.03		0			1		0		4	 0	0	0	0	0	0	0	#	CV_old_Fem_GP_1
-3		3	 	2.08E-06	2.08E-06	0.8		6		-3	 0	0	0	0	0.5	0	0	#	Wtlen_1_Fem
1		5	 	3.4737		3.4737		0.8		6		-3	 0	0	0	0	0.5	0	0	#	Wtlen_2_Fem
10		50	 	33.1		33.1		0.8		6		-3	 0	0	0	0	0.5	0	0	#	Mat50%_Fem
-3		3	 	-0.743		-0.743		0.8		6		-3	 0	0	0	0	0.5	0	0	#	Mat_slope_Fem
-3		3	 	1			1			1		6		-3	 0	0	0	0	0.5	0	0	#	Eggs/kg_inter_Fem
-3		3		0			0			1		6		-3	 0	0	0	0	0.5	0	0	#	Eggs/kg_slope_wt_Fem
0.005	0.6		0.15		-1.58		0.3326	3		6	 0	0	0	0	0.5	0	0	#	NatM_p_1_Mal_GP_1
10		45		16.6		17.18		10		0		2	 0	0	0	0	0.5	0	0	#	L_at_Amin_Mal_GP_1
35		80		43.2		58.7		10		0		3	 0	0	0	0	0.5	0	0	#	L_at_Amax_Mal_GP_1
0.04	0.5		0.2			0.13		0.8		0		2	 0	0	0	0	0.5	0	0	#	VonBert_K_Mal_GP_1
0.01	1		0.14		3			0.8		0		3	 0	0	0	0	0.5	0	0	#	CV_young_Mal_GP_1
0.01	1		0.05		0			1		0		4	 0	0	0	0	0	0	0	#	CV_old_Mal_GP_1
-3		3		3.05E-06	3.05E-06	0.8		6		-3	 0	0	0	0	0.5	0	0	#	Wtlen_1_Mal
-3		5		3.36054		3.36054		0.8		6		-3	 0	0	0	0	0.5	0	0	#	Wtlen_2_Mal
0		1		1			0.2			9.8		6		-3	 0	0	0	0	0.5	0	0	#	RecrDist_GP_1
0		1		1			1			9.8		6		-3	 0	0	0	0	0.5	0	0	#	RecrDist_Area_1
-4		4		0			1			9.8		6		-3	 0	0	0	0	0.5	0	0	#	RecrDist_timing_1
0		1		1			1			0		0		-4	 0	0	0	0	0	0	0	#	CohortGrowDev
0.01	0.99	0.5			0.5			0.5		0		-99	 0	0	0	0	0	0	0	#	FracFemale_GP_1

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
#_LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
   5            20          9.64             9            10             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
 0.2             1           0.9           0.8          0.09             6          5          0          0          0          0          0          0          0 # SR_BH_steep
   0             2           0.4           0.9             5             6        -99          0          0          0          0          0          0          0 # SR_sigmaR
  -5             5             0             0           0.2             6         -2          0          0          0          0          0          0          0 # SR_regime
   0             0             0             0             0             0        -99          0          0          0          0          0          0          0 # SR_autocorr
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1959 # first year of main recr_devs; early devs can preceed this era
2012 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1845 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 3 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1944 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1964 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2011 #_last_yr_fullbias_adj_in_MPD
 2014 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
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
#  1845E 1846E 1847E 1848E 1849E 1850E 1851E 1852E 1853E 1854E 1855E 1856E 1857E 1858E 1859E 1860E 1861E 1862E 1863E 1864E 1865E 1866E 1867E 1868E 1869E 1870E 1871E 1872E 1873E 1874E 1875E 1876E 1877E 1878E 1879E 1880E 1881E 1882E 1883E 1884E 1885E 1886E 1887E 1888E 1889E 1890E 1891E 1892E 1893E 1894E 1895E 1896E 1897E 1898E 1899E 1900E 1901E 1902E 1903E 1904E 1905E 1906E 1907E 1908E 1909E 1910E 1911E 1912E 1913E 1914E 1915E 1916E 1917E 1918E 1919E 1920E 1921E 1922E 1923E 1924E 1925E 1926E 1927E 1928E 1929E 1930E 1931E 1932E 1933E 1934E 1935E 1936E 1937E 1938E 1939E 1940E 1941E 1942E 1943E 1944E 1945E 1946E 1947E 1948E 1949E 1950E 1951E 1952E 1953E 1954E 1955E 1956E 1957E 1958E 1959R 1960R 1961R 1962R 1963R 1964R 1965R 1966R 1967R 1968R 1969R 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013F 2014F 2015F 2016F 2017F 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
#2026 2035
# F rates by fleet
# Yr:  1876 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886 1887 1888 1889 1890 1891 1892 1893 1894 1895 1896 1897 1898 1899 1900 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# WinterN 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.21316e-05 0.000157436 0.000266742 0.000382828 0.000446495 0.000568244 0.000816857 0.00109023 0.00126569 0.00139305 0.00162204 0.00189618 0.00217118 0.0024263 0.00274173 0.00311279 0.00357011 0.00407063 0.00936609 0.007702 0.00886411 0.00314769 0.00182794 0.00398544 0.00955877 0.0120028 0.00714013 0.0242435 0.0178271 0.0167027 0.0240193 0.0570127 0.0252033 0.0335374 0.0334276 0.0376357 0.0261849 0.0173635 0.038187 0.0724373 0.076552 0.0558514 0.0630067 0.0737372 0.0751024 0.103704 0.116597 0.122182 0.0658497 0.130534 0.179055 0.11822 0.0659827 0.0561884 0.0622329 0.106416 0.0892013 0.0801722 0.0700988 0.0820912 0.0624066 0.062297 0.0437692 0.0466742 0.044338 0.0449887 0.0365136 0.0310239 0.0394149 0.0435818 0.0412078 0.0328892 0.0601489 0.0583242 0.0330207 0.0571997 0.05182 0.0519856 0.0153025 0.0122687 0.021236 0.0258748 0.0433621 0.0464005 0.0496547 0.0916585 0.0916585 0.0916585 0.0916585 0.0916585 0.0916585 0.0916585 0.0916585 0.0916585 0.0916585
# SummerN 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.00872e-06 4.92723e-06 3.84104e-06 3.74997e-06 3.65859e-06 3.56687e-06 3.4748e-06 3.35712e-06 3.26423e-06 3.17093e-06 3.07721e-06 2.98306e-06 2.88847e-06 2.7678e-06 2.67222e-06 2.57616e-06 2.47963e-06 2.3826e-06 2.28508e-06 2.16101e-06 2.06229e-06 1.96562e-06 1.86857e-06 1.76656e-06 1.66032e-06 1.52685e-06 1.42272e-06 1.3202e-06 1.21851e-06 1.11727e-06 1.01488e-06 9.39333e-07 1.34964e-08 4.18847e-05 3.3488e-05 0.00223941 0.00694668 0.0114073 0.0161346 0.0189435 0.022918 0.0320553 0.0374053 0.0507662 0.0597888 0.0646039 0.109859 0.114943 0.0863466 0.0813606 0.114239 0.0865271 0.121322 0.10501 0.151139 0.118382 0.102731 0.0551461 0.0682038 0.0660767 0.0581042 0.0851501 0.0912047 0.0760222 0.111942 0.131358 0.135838 0.0985611 0.107592 0.0952549 0.0983585 0.0810863 0.0828626 0.0898922 0.111376 0.0955944 0.118357 0.15873 0.218595 0.238138 0.15808 0.126681 0.192821 0.203454 0.18967 0.0907332 0.149841 0.179758 0.132988 0.0899107 0.106343 0.0807468 0.0827299 0.0756185 0.0565255 0.0461405 0.039965 0.0398106 0.0334802 0.0398651 0.0366222 0.0344945 0.0445986 0.0372161 0.0416145 0.0413373 0.0483912 0.0472392 0.048893 0.0708176 0.0680436 0.0360791 0.0238171 0.0431093 0.0189614 0.0256089 0.0272884 0.0558608 0.0476682 0.0692568 0.0740619 0.0992382 0.0992382 0.0992382 0.0992382 0.0992382 0.0992382 0.0992382 0.0992382 0.0992382 0.0992382
# WinterS 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00143683 0.000829886 0.000885715 0.00325077 0.00370651 0.00231958 0.001847 0.00122038 0.000815276 0.00444844 0.00314701 0.000719909 0.00222844 0.0027695 0.00337949 0.00248968 0.00559443 0.0105771 0.0261297 0.0197735 0.0103937 0.0166676 0.0273843 0.0414157 0.0275608 0.0266433 0.0278527 0.03067 0.0206922 0.0286574 0.0309367 0.0307681 0.0333382 0.0242763 0.0242472 0.0212015 0.0349957 0.0237276 0.027522 0.0313553 0.0374473 0.0517178 0.0323249 0.054844 0.0505332 0.0681647 0.0468555 0.0412554 0.0364206 0.054781 0.0379744 0.0275996 0.0283107 0.0255325 0.0248754 0.0344713 0.025726 0.0281533 0.0307016 0.0239891 0.032215 0.0186241 0.0153426 0.0150012 0.0136219 0.022581 0.0242778 0.0116442 0.0145904 0.0184537 0.0149272 0.0159603 0.0119703 0.0081836 0.0157952 0.00594339 0.0191904 0.0246773 0.0222851 0.00356872 0.00171491 0.00513835 0.00525266 0.0110688 0.0103198 0.010963 0.0261469 0.0261469 0.0261469 0.0261469 0.0261469 0.0261469 0.0261469 0.0261469 0.0261469 0.0261469
# SummerS 2.03957e-05 2.03961e-05 2.03964e-05 2.03968e-05 0.00023561 0.000450962 0.000666575 0.00088256 0.00109902 0.00131603 0.00153369 0.00175205 0.00197117 0.00219111 0.00241191 0.00263361 0.00285623 0.00308002 0.00330458 0.00353014 0.00375673 0.00398436 0.00421304 0.00444278 0.00467359 0.00490548 0.00513847 0.00537256 0.00560776 0.00584409 0.00608154 0.00632013 0.00655987 0.00680076 0.00704282 0.00728605 0.00753046 0.00777607 0.00802287 0.00827088 0.00841213 0.0115009 0.00929504 0.00732317 0.0050584 0.00643877 0.00931712 0.00939297 0.0117477 0.0116972 0.0115887 0.0141031 0.0139086 0.0159262 0.0149462 0.0121031 0.0119256 0.00905969 0.0210342 0.0186631 0.0105552 0.0185021 0.0228742 0.027436 0.0165586 0.00950067 0.00643892 0.0108519 0.0146638 0.0147957 0.0391957 0.0404104 0.0701629 0.0782206 0.0779985 0.0506906 0.0461759 0.0516664 0.0569428 0.0565581 0.0430373 0.0556478 0.0530327 0.0405172 0.0364501 0.060332 0.0528342 0.0628796 0.0614543 0.0571076 0.0622831 0.0593211 0.0591311 0.0571925 0.0734149 0.0727878 0.0761453 0.0596679 0.0765966 0.0847097 0.0737444 0.0502144 0.0827338 0.102478 0.0756577 0.0994127 0.055747 0.0394591 0.0339417 0.0448664 0.0316773 0.0478583 0.0344556 0.0336717 0.0290196 0.0230874 0.021772 0.0156244 0.0188144 0.0170863 0.0224948 0.0245959 0.0162385 0.0138849 0.0121975 0.012881 0.00949327 0.00857275 0.0125943 0.0255189 0.0219809 0.023025 0.0200943 0.0121367 0.0056791 0.00343241 0.00452519 0.0114349 0.0145873 0.0171112 0.0182154 0.0329999 0.0329999 0.0329999 0.0329999 0.0329999 0.0329999 0.0329999 0.0329999 0.0329999 0.0329999
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
#           -20             5            -9             0            99             0          1          0          1       1987       2009         99          0          0  #  LnQ_base_WinterN(1)
#            -5             5          0.38             0            99             0          3          0          0          0          0          0          0          0  #  Q_power_WinterN(1)
#           -20             5             0            -1            99             0         -1          0          1       1987       2009         99          0          0  #  LnQ_base_WinterS(3)
#            -5             5          0.16             0            99             0          3          0          0          0          0          0          0          0  #  Q_power_WinterS(3)
#           -25            25      -1.71778             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_TriEarly(5)
#         0.001             2          0.28          0.22            99             0          5          0          0          0          0          0          0          0  #  Q_extraSD_TriEarly(5)
#           -25            25      -1.63808             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_TriLate(6)
#         0.001             2          0.15          0.16            99             0          4          0          0          0          0          0          0          0  #  Q_extraSD_TriLate(6)
#           -25            25      0.135325             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_NWFSC(7)
        -20          5   -6.45784          0         99          0       1       0       1    1987    2009      -5       5       1  #  LnQ_base_WinterN(1)
         -5          5  -0.188546          0         -1          0       3       0       0       0       0       0       0       0  #  Q_power_WinterN(1)
        -20          5   -1.15376          0         99          0       1       0       1    1987    2009      -5       5       1  #  LnQ_base_WinterS(3)
         -5          5  -0.875155          0         -1          0       3       0       0       0       0       0       0       0  #  Q_power_WinterS(3)
        -15         15   -0.70123          0          1          0      -1       0       0       0       0       0       0       0  #  LnQ_base_TriEarly(5)
      0.001          2     0.1624       0.22         -1          0       5       0       0       0       0       0       0       0  #  Q_extraSD_TriEarly(5)
        -15         15  -0.321733          0          1          0      -1       0       0       0       0       0       0       0  #  LnQ_base_TriLate(6)
      0.001          2   0.184158       0.16         -1          0       4       0       0       0       0       0       0       0  #  Q_extraSD_TriLate(6)
        -15         15    1.18413          0          1          0      -1       0       0       0       0       0       0       0  #  LnQ_base_NWFSC(7)
# timevary Q parameters 
#_      LO          HI       INIT         PRIOR     PR_SD       PR_type     PHASE  #  parm_name
      -0.99       0.99   0.508819          0        0.5          6      3  # LnQ_base_WinterN(1)_BLK5add_2004
     0.0001          2         99         99        0.5          6      -5  # LnQ_base_WinterN(1)_dev_se
      -0.99       0.99          0          0        0.5          6      -6  # LnQ_base_WinterN(1)_dev_autocorr
      -0.99       0.99   0.634646          0        0.5          6      3  # LnQ_base_WinterS(3)_BLK5add_2004
     0.0001          2         99         99        0.5          6      -5  # LnQ_base_WinterS(3)_dev_se
      -0.99       0.99          0          0        0.5          6      -6  # LnQ_base_WinterS(3)_dev_autocorr
# Transition default lines
#        0.0001             2            99            99           0.5             6      -5  # LnQ_base_WinterN(1)_dev_se
#         -0.99          0.99             0             0           0.5             6      -6  # LnQ_base_WinterN(1)_dev_autocorr
#        0.0001             2            99            99           0.5             6      -5  # LnQ_base_WinterS(3)_dev_se
#         -0.99          0.99             0             0           0.5             6      -6  # LnQ_base_WinterS(3)_dev_autocorr
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
#Pattern:_42; parm=2+nages+1; // cubic spline; with 2 additional param for scaling (average over bin range)
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
            15            75          46.6          43.1             5             0          1          0          0          0          0        0.5          1          1  #  SizeSel_P1_WinterN(1)
            -5             3             3           0.7             5             0         -3          0          0          0          0        0.5          0          0  #  SizeSel_P2_WinterN(1)
            -4            12           3.9          3.42             5             0          2          0          0          0          0        0.5          0          0  #  SizeSel_P3_WinterN(1)
            -2            15            14          0.21             5             0         -3          0          0          0          0        0.5          0          0  #  SizeSel_P4_WinterN(1)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P5_WinterN(1)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P6_WinterN(1)
            10            40         26.19            15             9             0          1          0          0          0          0          0          2          1  #  Retain_P1_WinterN(1)
           0.1            10         1.701             3             9             0          2          0          0          0          0          0          2          1  #  Retain_P2_WinterN(1)
           -10            10       5.19749            10             9             0          4          0          0          0          0          0          2          2  #  Retain_P3_WinterN(1)
           -10            10             0             0             9             0         -2          0          0          0          0          0          0          0  #  Retain_P4_WinterN(1)
           -15            15          -8.8             0             5             0          3          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_WinterN(1)
           -15            15          -1.1             0             5             0          4          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_WinterN(1)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_WinterN(1)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_WinterN(1)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_WinterN(1)
# 2   SummerN LenSelex
            15            75          53.8          43.1             5             0          1          0          0          0          0        0.5          1          1  #  SizeSel_P1_SummerN(2)
            -5             3             3           0.7             5             0         -3          0          0          0          0        0.5          0          0  #  SizeSel_P2_SummerN(2)
            -4            12           5.3          3.42             5             0          2          0          0          0          0        0.5          0          0  #  SizeSel_P3_SummerN(2)
            -2            15            14          0.21             5             0         -3          0          0          0          0        0.5          0          0  #  SizeSel_P4_SummerN(2)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P5_SummerN(2)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P6_SummerN(2)
            10            40        30.679            15             9             0          1          0          0          0          0          0          3          1  #  Retain_P1_SummerN(2)
           0.1            10        1.1278             3             9             0          2          0          0          0          0          0          3          1  #  Retain_P2_SummerN(2)
           -10            10       9.21024            10             9             0          4          0          0          0          0          0          3          2  #  Retain_P3_SummerN(2)
           -10            10             0             0             9             0         -2          0          0          0          0          0          0          0  #  Retain_P4_SummerN(2)
           -20            15         -13.7             0            -5             0          3          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_SummerN(2)
           -15            15          -1.9             0            -5             0          4          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_SummerN(2)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_SummerN(2)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_SummerN(2)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_SummerN(2)
# 3   WinterS LenSelex
            15            75        40.422          43.1             5             0          1          0          0          0          0        0.5          1          1  #  SizeSel_P1_WinterS(3)
            -5             3             3           0.7             5             0         -3          0          0          0          0        0.5          0          0  #  SizeSel_P2_WinterS(3)
            -4            12        4.5999          3.42             5             0          2          0          0          0          0        0.5          0          0  #  SizeSel_P3_WinterS(3)
            -2            15            14          0.21             5             0         -3          0          0          0          0        0.5          0          0  #  SizeSel_P4_WinterS(3)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P5_WinterS(3)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P6_WinterS(3)
            10            40        28.816            15             9             0          1          0          0          0          0          0          2          1  #  Retain_P1_WinterS(3)
           0.1            10        1.1443             3             9             0          2          0          0          0          0          0          2          1  #  Retain_P2_WinterS(3)
           -10            10        4.2546            10             9             0          4          0          0          0          0          0          2          2  #  Retain_P3_WinterS(3)
           -10            10             0             0             9             0         -2          0          0          0          0          0          0          0  #  Retain_P4_WinterS(3)
           -15            15       -14.995             0             5             0          3          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_WinterS(3)
           -15            15       -2.4591             0             5             0          4          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_WinterS(3)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_WinterS(3)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_WinterS(3)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_WinterS(3)
# 4   SummerS LenSelex
            15            75       43.0793          43.1             5             0          1          0          0          0          0        0.5          1          1  #  SizeSel_P1_SummerS(4)
            -5             3             3           0.7             5             0         -3          0          0          0          0        0.5          0          0  #  SizeSel_P2_SummerS(4)
            -4            12        4.7717          3.42             5             0          2          0          0          0          0        0.5          0          0  #  SizeSel_P3_SummerS(4)
            -2            15            14          0.21             5             0         -3          0          0          0          0        0.5          0          0  #  SizeSel_P4_SummerS(4)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P5_SummerS(4)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P6_SummerS(4)
            10            40        29.055            15             9             0          1          0          0          0          0          0          3          1  #  Retain_P1_SummerS(4)
           0.1            10         0.976             3             9             0          2          0          0          0          0          0          3          1  #  Retain_P2_SummerS(4)
           -10            10        7.6004            10             9             0          4          0          0          0          0          0          3          2  #  Retain_P3_SummerS(4)
           -10            10             0             0             9             0         -2          0          0          0          0          0          0          0  #  Retain_P4_SummerS(4)
           -15            15       -11.004             0             5             0          3          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_SummerS(4)
           -15            15         -1.44             0             5             0          4          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_SummerS(4)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_SummerS(4)
           -15            15             0             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_SummerS(4)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_SummerS(4)
# 5   TriEarly LenSelex
            15            61       35.8319          43.1             5             0          1          0          0          0          0        0.5          0          0  #  SizeSel_P1_TriEarly(5)
            -5             3             3           0.7             5             0         -2          0          0          0          0        0.5          0          0  #  SizeSel_P2_TriEarly(5)
            -4            12        4.2596          3.42             5             0          1          0          0          0          0        0.5          0          0  #  SizeSel_P3_TriEarly(5)
            -2            15            14          0.21             5             0         -2          0          0          0          0        0.5          0          0  #  SizeSel_P4_TriEarly(5)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P5_TriEarly(5)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P6_TriEarly(5)
           -15            15       -3.7323             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_TriEarly(5)
           -15            15       -0.5322             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_TriEarly(5)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_TriEarly(5)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_TriEarly(5)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_TriEarly(5)
# 6   TriLate LenSelex
            15            61       36.9845          43.1             5             0          1          0          0          0          0        0.5          0          0  #  SizeSel_P1_TriLate(6)
            -5             3             3           0.7             5             0         -2          0          0          0          0        0.5          0          0  #  SizeSel_P2_TriLate(6)
            -4            12        4.6735          3.42             5             0          1          0          0          0          0        0.5          0          0  #  SizeSel_P3_TriLate(6)
            -2            15            14          0.21             5             0         -2          0          0          0          0        0.5          0          0  #  SizeSel_P4_TriLate(6)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P5_TriLate(6)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P6_TriLate(6)
           -15            15       -4.0542             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_TriLate(6)
           -15            15       -0.1367             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_TriLate(6)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Descend_TriLate(6)
           -15            15             0             0             5             0         -3          0          0          0          0        0.5          0          0  #  SzSel_Male_Final_TriLate(6)
           -15            15             1             0             5             0         -4          0          0          0          0        0.5          0          0  #  SzSel_Male_Scale_TriLate(6)
# 7   NWFSC LenSelex
            15            61       43.5877          43.1             5             0          1          0          0          0          0        0.5          0          0  #  SizeSel_P1_NWFSC(7)
            -5             3             3           0.7             5             0         -2          0          0          0          0        0.5          0          0  #  SizeSel_P2_NWFSC(7)
            -4            12        5.2029          3.42             5             0          1          0          0          0          0        0.5          0          0  #  SizeSel_P3_NWFSC(7)
            -2            15            14          0.21             5             0         -2          0          0          0          0        0.5          0          0  #  SizeSel_P4_NWFSC(7)
           -15             5          -999          -8.9             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P5_NWFSC(7)
            -5             5          -999          0.15             5             0         -4          0          0          0          0        0.5          0          0  #  SizeSel_P6_NWFSC(7)
           -15            15       -5.8784             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Peak_NWFSC(7)
           -15            15       -0.4792             0             5             0          2          0          0          0          0        0.5          0          0  #  SzSel_Male_Ascend_NWFSC(7)
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
         -31.6          28.4             0             0          14.2             6      4  # SizeSel_P1_WinterN(1)_BLK1add_1973
         -31.6          28.4             0             0          14.2             6      4  # SizeSel_P1_WinterN(1)_BLK1add_1983
         -31.6          28.4             0             0          14.2             6      4  # SizeSel_P1_WinterN(1)_BLK1add_1993
         -31.6          28.4             0             0          14.2             6      4  # SizeSel_P1_WinterN(1)_BLK1add_2003
         -31.6          28.4             0             0          14.2             6      4  # SizeSel_P1_WinterN(1)_BLK1add_2011
        -16.19         13.81             0             0         6.905             6      4  # Retain_P1_WinterN(1)_BLK2add_2003
        -16.19         13.81             0             0         6.905             6      4  # Retain_P1_WinterN(1)_BLK2add_2010
        -16.19         13.81             0             0         6.905             6      4  # Retain_P1_WinterN(1)_BLK2add_2011
        -1.601         8.299             0             0        0.8005             6      4  # Retain_P2_WinterN(1)_BLK2add_2003
        -1.601         8.299             0             0        0.8005             6      4  # Retain_P2_WinterN(1)_BLK2add_2010
        -1.601         8.299             0             0        0.8005             6      4  # Retain_P2_WinterN(1)_BLK2add_2011
           -10            10       5.19749            10             9             0      4  # Retain_P3_WinterN(1)_BLK2repl_2003
           -10            10       5.19749            10             9             0      4  # Retain_P3_WinterN(1)_BLK2repl_2010
           -10            10       5.19749            10             9             0      4  # Retain_P3_WinterN(1)_BLK2repl_2011
         -38.8          21.2             0             0          10.6             6      4  # SizeSel_P1_SummerN(2)_BLK1add_1973
         -38.8          21.2             0             0          10.6             6      4  # SizeSel_P1_SummerN(2)_BLK1add_1983
         -38.8          21.2             0             0          10.6             6      4  # SizeSel_P1_SummerN(2)_BLK1add_1993
         -38.8          21.2             0             0          10.6             6      4  # SizeSel_P1_SummerN(2)_BLK1add_2003
         -38.8          21.2             0             0          10.6             6      4  # SizeSel_P1_SummerN(2)_BLK1add_2011
       -20.679         9.321             0             0        4.6605             6      4  # Retain_P1_SummerN(2)_BLK3add_2003
       -20.679         9.321             0             0        4.6605             6      4  # Retain_P1_SummerN(2)_BLK3add_2009
       -20.679         9.321             0             0        4.6605             6      4  # Retain_P1_SummerN(2)_BLK3add_2011
       -1.0278        8.8722             0             0        0.5139             6      4  # Retain_P2_SummerN(2)_BLK3add_2003
       -1.0278        8.8722             0             0        0.5139             6      4  # Retain_P2_SummerN(2)_BLK3add_2009
       -1.0278        8.8722             0             0        0.5139             6      4  # Retain_P2_SummerN(2)_BLK3add_2011
           -10            10       9.21024            10             9             0      4  # Retain_P3_SummerN(2)_BLK3repl_2003
           -10            10       9.21024            10             9             0      4  # Retain_P3_SummerN(2)_BLK3repl_2009
           -10            10       9.21024            10             9             0      4  # Retain_P3_SummerN(2)_BLK3repl_2011
       -25.422        34.578             0             0        12.711             6      4  # SizeSel_P1_WinterS(3)_BLK1add_1973
       -25.422        34.578             0             0        12.711             6      4  # SizeSel_P1_WinterS(3)_BLK1add_1983
       -25.422        34.578             0             0        12.711             6      4  # SizeSel_P1_WinterS(3)_BLK1add_1993
       -25.422        34.578             0             0        12.711             6      4  # SizeSel_P1_WinterS(3)_BLK1add_2003
       -25.422        34.578             0             0        12.711             6      4  # SizeSel_P1_WinterS(3)_BLK1add_2011
       -18.816        11.184             0             0         5.592             6      4  # Retain_P1_WinterS(3)_BLK2add_2003
       -18.816        11.184             0             0         5.592             6      4  # Retain_P1_WinterS(3)_BLK2add_2010
       -18.816        11.184             0             0         5.592             6      4  # Retain_P1_WinterS(3)_BLK2add_2011
       -1.0443        8.8557             0             0       0.52215             6      4  # Retain_P2_WinterS(3)_BLK2add_2003
       -1.0443        8.8557             0             0       0.52215             6      4  # Retain_P2_WinterS(3)_BLK2add_2010
       -1.0443        8.8557             0             0       0.52215             6      4  # Retain_P2_WinterS(3)_BLK2add_2011
           -10            10        4.2546            10             9             0      4  # Retain_P3_WinterS(3)_BLK2repl_2003
           -10            10        4.2546            10             9             0      4  # Retain_P3_WinterS(3)_BLK2repl_2010
           -10            10        4.2546            10             9             0      4  # Retain_P3_WinterS(3)_BLK2repl_2011
      -28.0793       31.9207             0             0       14.0397             6      4  # SizeSel_P1_SummerS(4)_BLK1add_1973
      -28.0793       31.9207             0             0       14.0397             6      4  # SizeSel_P1_SummerS(4)_BLK1add_1983
      -28.0793       31.9207             0             0       14.0397             6      4  # SizeSel_P1_SummerS(4)_BLK1add_1993
      -28.0793       31.9207             0             0       14.0397             6      4  # SizeSel_P1_SummerS(4)_BLK1add_2003
      -28.0793       31.9207             0             0       14.0397             6      4  # SizeSel_P1_SummerS(4)_BLK1add_2011
       -19.055        10.945             0             0        5.4725             6      4  # Retain_P1_SummerS(4)_BLK3add_2003
       -19.055        10.945             0             0        5.4725             6      4  # Retain_P1_SummerS(4)_BLK3add_2009
       -19.055        10.945             0             0        5.4725             6      4  # Retain_P1_SummerS(4)_BLK3add_2011
        -0.876         9.024             0             0         0.438             6      4  # Retain_P2_SummerS(4)_BLK3add_2003
        -0.876         9.024             0             0         0.438             6      4  # Retain_P2_SummerS(4)_BLK3add_2009
        -0.876         9.024             0             0         0.438             6      4  # Retain_P2_SummerS(4)_BLK3add_2011
           -10            10        7.6004            10             9             0      4  # Retain_P3_SummerS(4)_BLK3repl_2003
           -10            10        7.6004            10             9             0      4  # Retain_P3_SummerS(4)_BLK3repl_2009
           -10            10        7.6004            10             9             0      4  # Retain_P3_SummerS(4)_BLK3repl_2011
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      3     1     1     0     0     0     0     1     1  1987  2009     5      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0
#      3     3     3     0     0     0     0     2     1  1987  2009     5      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0      0
#      5     1     5     1     1     2     0     0     0     0     0     0
#      5     7    10     2     1     2     0     0     0     0     0     0
#      5     8    13     2     1     2     0     0     0     0     0     0
#      5     9    16     2     2     2     0     0     0     0     0     0
#      5    16    19     1     1     2     0     0     0     0     0     0
#      5    22    24     3     1     2     0     0     0     0     0     0
#      5    23    27     3     1     2     0     0     0     0     0     0
#      5    24    30     3     2     2     0     0     0     0     0     0
#      5    31    33     1     1     2     0     0     0     0     0     0
#      5    37    38     2     1     2     0     0     0     0     0     0
#      5    38    41     2     1     2     0     0     0     0     0     0
#      5    39    44     2     2     2     0     0     0     0     0     0
#      5    46    47     1     1     2     0     0     0     0     0     0
#      5    52    52     3     1     2     0     0     0     0     0     0
#      5    53    55     3     1     2     0     0     0     0     0     0
#      5    54    58     3     2     2     0     0     0     0     0     0
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
      4      1      2.38
      5      1      6.26
      2      2      0.02
      4      2      1.89
      5      2      2.21
      2      3      0.02
      4      3      1.25
      5      3      1.83
      2      4      0.02
      4      4      1.34
      5      4       1.6
      4      5      1.59
      4      6      1.19
      4      7      0.59
      5      7      0.22
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
#
# lambdas (for info only; columns are phases)
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_1
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_CPUE/survey:_2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_3
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_CPUE/survey:_4
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_5
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_6
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_7
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_discard:_1
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_discard:_2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_discard:_3
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_discard:_4
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_discard:_5
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_discard:_6
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_discard:_7
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_meanbodywt:1
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_meanbodywt:2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_meanbodywt:3
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_meanbodywt:4
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_meanbodywt:5
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_meanbodywt:6
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_meanbodywt:7
#  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 #_lencomp:_1
#  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 #_lencomp:_2
#  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 #_lencomp:_3
#  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 #_lencomp:_4
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_5
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_6
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_7
#  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 #_agecomp:_1
#  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 #_agecomp:_2
#  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 #_agecomp:_3
#  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 #_agecomp:_4
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_agecomp:_5
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_agecomp:_6
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_agecomp:_7
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_init_equ_catch
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_recruitments
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_parameter-priors
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_crashPenLambda
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 0 0 0 0 0 0 0 0 # placeholder for # selex_fleet, 1=len/2=age/3=both, year, N selex bins, 0 or Growth pattern, N growth ages, 0 or NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

