* WUI data : Population - interface : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Population - WUI 1990-2010- Interface.csv' out = Interface_Population replace; run;
 
 proc sort data = Interface_Population; by FIPS; run;
 
 /* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/
 PROC TRANSPOSE DATA=Interface_Population OUT=Interface_Population_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data Interface_Population_reshaped; set Interface_Population_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to Interface_Population */ 
 data Interface_Population_reshaped; set Interface_Population_reshaped;
	rename _NAME_ = Year;
	rename COL1 = Interface_Population_count;
 run;

data capstone.Interface_Population_reshaped; set Interface_Population_reshaped; run;
 
 *-----------------------------------------------------------------------------------------------------------------------------------------;

* WUI data : Population - Intermix : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Population - WUI 1990-2010- Intermix.csv' out = Intermix_Population replace; run;
 
 proc sort data = Intermix_Population; by FIPS; run;
 
/* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/ 
 PROC TRANSPOSE DATA=Intermix_Population OUT=Intermix_Population_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data Intermix_Population_reshaped; set Intermix_Population_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to Intermix_Population */  
 data Intermix_Population_reshaped; set Intermix_Population_reshaped;
	rename _NAME_ = Year;
	rename COL1 = Intermix_Population_count;
 run;

data capstone.Intermix_Population_reshaped; set Intermix_Population_reshaped; run;

*-----------------------------------------------------------------------------------------------------------------------------------------;

* WUI data : Population - WUI : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Population - WUI 1990-2010- WUI.csv' out = WUI_Population replace; run;
 
 proc sort data = WUI_Population; by FIPS; run;
 
/* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/ 
 PROC TRANSPOSE DATA=WUI_Population OUT=WUI_Population_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data WUI_Population_reshaped; set WUI_Population_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to WUI_Population */  
 data WUI_Population_reshaped; set WUI_Population_reshaped;
	rename _NAME_ = Year;
	rename COL1 = WUI_Population_count;
 run;
 
 data capstone.WUI_Population_reshaped; set WUI_Population_reshaped; run;
 
*-----------------------------------------------------------------------------------------------------------------------------------------;

* Non WUI data : Population - WUI : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Population - WUI 1990-2010- Non-WUI.csv' out = NonWUI_Population replace; run;
 
 proc sort data = NonWUI_Population; by FIPS; run;
 
/* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/ 
 PROC TRANSPOSE DATA=NonWUI_Population OUT=NonWUI_Population_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data NonWUI_Population_reshaped; set NonWUI_Population_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to WUI_Population */   
 data NonWUI_Population_reshaped; set NonWUI_Population_reshaped;
	rename _NAME_ = Year;
	rename COL1 = NonWUI_Population_count;
 run;

data capstone.NonWUI_Population_reshaped; set NonWUI_Population_reshaped; run;

*-----------------------------------------------------------------------------------------------------------------------------------------;

