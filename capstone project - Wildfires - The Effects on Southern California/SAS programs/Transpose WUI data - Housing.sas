* WUI data : Housing - interface : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Housing - WUI 1990-2010- Interface.csv' out = Interface_Housing replace; run;
 
 proc sort data = Interface_Housing; by FIPS; run;
 
 /* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/
 PROC TRANSPOSE DATA=Interface_Housing OUT=Interface_Housing_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data Interface_Housing_reshaped; set Interface_Housing_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to Interface_Housing */ 
 data Interface_Housing_reshaped; set Interface_Housing_reshaped;
	rename _NAME_ = Year;
	rename COL1 = Interface_Housing_number;
 run;
 
  data capstone.Interface_Housing_reshaped; set Interface_Housing_reshaped; run;

 *-----------------------------------------------------------------------------------------------------------------------------------------;

* WUI data : Housing - Intermix : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Housing - WUI 1990-2010- Intermix.csv' out = Intermix_Housing replace; run;
 
 proc sort data = Intermix_Housing; by FIPS; run;
 
/* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/ 
 PROC TRANSPOSE DATA=Intermix_Housing OUT=Intermix_Housing_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data Intermix_Housing_reshaped; set Intermix_Housing_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to Intermix_Housing */  
 data Intermix_Housing_reshaped; set Intermix_Housing_reshaped;
	rename _NAME_ = Year;
	rename COL1 = Intermix_Housing_number;
 run;
 
 data capstone.Intermix_Housing_reshaped; set Intermix_Housing_reshaped; run;

*-----------------------------------------------------------------------------------------------------------------------------------------;

* WUI data : Housing - WUI : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Housing - WUI 1990-2010- WUI.csv' out = WUI_Housing replace; run;
 
 proc sort data = WUI_Housing; by FIPS; run;
 
/* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/ 
 PROC TRANSPOSE DATA=WUI_Housing OUT=WUI_Housing_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data WUI_Housing_reshaped; set WUI_Housing_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to WUI_Housing */  
 data WUI_Housing_reshaped; set WUI_Housing_reshaped;
	rename _NAME_ = Year;
	rename COL1 = WUI_Housing_number;
 run;

 data capstone.WUI_Housing_reshaped; set WUI_Housing_reshaped; run;

*-----------------------------------------------------------------------------------------------------------------------------------------;

* Non WUI data : Housing - WUI : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Housing - WUI 1990-2010- Non-WUI.csv' out = NonWUI_Housing replace; run;
 
 proc sort data = NonWUI_Housing; by FIPS; run;
 
/* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/ 
 PROC TRANSPOSE DATA=NonWUI_Housing OUT=NonWUI_Housing_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data NonWUI_Housing_reshaped; set NonWUI_Housing_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to WUI_Housing */   
 data NonWUI_Housing_reshaped; set NonWUI_Housing_reshaped;
	rename _NAME_ = Year;
	rename COL1 = NonWUI_Housing_number;
 run;
 
 data capstone.NonWUI_Housing_reshaped; set NonWUI_Housing_reshaped; run;