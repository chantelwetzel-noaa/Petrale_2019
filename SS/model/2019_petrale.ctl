#V3.30.13.00-trans-beta;_2018_11_08;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.0
#Stock Synthesis (SS) is a work of the U.S. Government and is not subject to copyright protection in the United States.
#Foreign copyrights may apply. See copyright.txt for more information.
#_user_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_user_info_available_at:https://vlab.ncep.noaa.gov/group/stock-synthesis
#C 2019 petrale sole update assessment - Chantel Wetzel
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Settle timing, Area; 3=each Settle entity; 4=none, only when N_GP*Nsettle*pop==1
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
 1973 1982 1983 1992 1993 2002 2003 2010 2011 2014
 2003 2009 2010 2010 2011 2014
 2003 2008 2009 2010 2011 2014
 1875 1875
 2004 2009
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
#  autogen
1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
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
0.005		0.5	 	0.145		-1.7793		0.438		3		6	 0	0	0	0	0.5	0	0	#	NatM_p_1_Fem_GP_1
10		45	 	15.8		17.18		10		0		2	 0	0	0	0	0.5	0	0	#	L_at_Amin_Fem_GP_1
35		80	 	54.4		58.7		10		0		3	 0	0	0	0	0.5	0	0	#	L_at_Amax_Fem_GP_1
0.04		0.5	 	0.13		0.13		0.8		0		2	 0	0	0	0	0.5	0	0	#	VonBert_K_Fem_GP_1
0.01		1	 	0.19		3		0.8		0		3	 0	0	0	0	0.5	0	0	#	CV_young_Fem_GP_1
0.01		1	 	0.03		0		1		0		4	 0	0	0	0	0	0	0	#	CV_old_Fem_GP_1
-3		3	 	2.08E-06	2.08E-06	0.8		6		-3	 0	0	0	0	0.5	0	0	#	Wtlen_1_Fem
1		5	 	3.4737		3.4737		0.8		6		-3	 0	0	0	0	0.5	0	0	#	Wtlen_2_Fem
10		50	 	33.1		33.1		0.8		6		-3	 0	0	0	0	0.5	0	0	#	Mat50%_Fem
-3		3	 	-0.743		-0.743		0.8		6		-3	 0	0	0	0	0.5	0	0	#	Mat_slope_Fem
-3		3	 	1		1		1		6		-3	 0	0	0	0	0.5	0	0	#	Eggs/kg_inter_Fem
-3		3		0		0		1		6		-3	 0	0	0	0	0.5	0	0	#	Eggs/kg_slope_wt_Fem
0.005		0.6		0.15		-1.6809		0.438		3		6	 0	0	0	0	0.5	0	0	#	NatM_p_1_Mal_GP_1
10		45		16.6		17.18		10		0		2	 0	0	0	0	0.5	0	0	#	L_at_Amin_Mal_GP_1
35		80		43.2		58.7		10		0		3	 0	0	0	0	0.5	0	0	#	L_at_Amax_Mal_GP_1
0.04		0.5		0.2		0.13		0.8		0		2	 0	0	0	0	0.5	0	0	#	VonBert_K_Mal_GP_1
0.01		1		0.14		3		0.8		0		3	 0	0	0	0	0.5	0	0	#	CV_young_Mal_GP_1
0.01		1		0.05		0		1		0		4	 0	0	0	0	0	0	0	#	CV_old_Mal_GP_1
-3		3		3.05E-06	3.05E-06	0.8		6		-3	 0	0	0	0	0.5	0	0	#	Wtlen_1_Mal
-3		5		3.36054		3.36054		0.8		6		-3	 0	0	0	0	0.5	0	0	#	Wtlen_2_Mal
#0		1		1		0.2		9.8		6		-3	 0	0	0	0	0.5	0	0	#	RecrDist_GP_1
#0		1		1		1		9.8		6		-3	 0	0	0	0	0.5	0	0	#	RecrDist_Area_1
#-4		4		0		1		9.8		6		-3	 0	0	0	0	0.5	0	0	#	RecrDist_timing_1
0		1		1		1		0		0		-4	 0	0	0	0	0	0	0	#	CohortGrowDev
0.01		0.99		0.5		0.5		0.5		0		-99	 0	0	0	0	0	0	0	#	FracFemale_GP_1
#
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
#_       LO         HI       INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
        -20          5   -6.45784          0         99          0       1       0       0       0    	 0       0       5       1  #  LnQ_base_WinterN(1)
         -5          5  -0.188546          0         -1          0       3       0       0       0       0       0       0       0  #  Q_power_WinterN(1)
        -20          5   -1.15376          0         99          0       1       0       0       0       0       0       5       1  #  LnQ_base_WinterS(3)
         -5          5  -0.875155          0         -1          0       3       0       0       0       0       0       0       0  #  Q_power_WinterS(3)
        -15         15   -0.70123          0          1          0      -1       0       0       0       0       0       0       0  #  LnQ_base_TriEarly(5)
      0.001          2     0.1624       0.22         -1          0       5       0       0       0       0       0       0       0  #  Q_extraSD_TriEarly(5)
        -15         15  -0.321733          0          1          0      -1       0       0       0       0       0       0       0  #  LnQ_base_TriLate(6)
      0.001          2   0.184158       0.16         -1          0       4       0       0       0       0       0       0       0  #  Q_extraSD_TriLate(6)
        -15         15    1.18413          0          1          0      -1       0       0       0       0       0       0       0  #  LnQ_base_NWFSC(7)
# timevary Q parameters 
#_      LO          HI       INIT         PRIOR     PR_SD       PR_type     PHASE  #  parm_name
      -0.99       0.99   0.508819          0        0.5          6      	3  # LnQ_base_WinterN(1)_BLK5add_2004
      -0.99       0.99   0.634646          0        0.5          6      	3  # LnQ_base_WinterS(3)_BLK5add_2004
# info on dev vectors created for Q parms are reported with other devs after tag parameter section 
#_length_selex
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
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
#Discard
2	1	0.02
2	2	0.02
2	3	0.02
2	4	0.02
#Lengths
4	1	1.6867 #2.38
4	2	1.3890 #1.89
4	3	1.0391 #1.25
4	4	1.1611 #1.34
4	5	1.7452 #1.59
4	6	1.2753 #1.19
4	7	0.5824
#Ages
5	1	3.8877 #6.26
5	2	2.5938 #2.21
5	3	1.7180 #1.83
5	4	1.7153 #1.6
5	7	0.2169 #0.22

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
0 # (0/1) read specs for more stddev reporting 
# 0 0 0 0 0 0 0 0 0 # placeholder for # selex_fleet, 1=len/2=age/3=both, year, N selex bins, 0 or Growth pattern, N growth ages, 0 or NatAge_area(-1 for all), NatAge_yr, N Natages
# placeholder for vector of selex bins to be reported
# placeholder for vector of growth ages to be reported
# placeholder for vector of NatAges ages to be reported
999

