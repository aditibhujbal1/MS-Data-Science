* WUI data : Area - interface : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Area - WUI 1990-2020 - Interface.csv' out = Interface_Area replace; run;
 
 proc sort data = Interface_Area; by FIPS; run;
 
 /* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/
 PROC TRANSPOSE DATA=Interface_Area OUT=Interface_area_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data Interface_area_reshaped; set Interface_area_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to Interface_area */ 
 data Interface_area_reshaped; set Interface_area_reshaped;
	rename _NAME_ = Year;
	rename COL1 = Interface_area_squareKm;
 run;
 
 data capstone.Interface_Area_reshaped; set Interface_Area_reshaped; run;
 
 *-----------------------------------------------------------------------------------------------------------------------------------------;

* WUI data : Area - Intermix : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Area - WUI 1990-2020 - Intermix.csv' out = Intermix_Area replace; run;
 
 proc sort data = Intermix_Area; by FIPS; run;
 
/* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/ 
 PROC TRANSPOSE DATA=Intermix_Area OUT=Intermix_Area_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data Intermix_Area_reshaped; set Intermix_Area_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to Intermix_area */  
 data Intermix_Area_reshaped; set Intermix_Area_reshaped;
	rename _NAME_ = Year;
	rename COL1 = Intermix_Area_squareKm;
 run;

 data capstone.Intermix_Area_reshaped; set Intermix_Area_reshaped; run;

*-----------------------------------------------------------------------------------------------------------------------------------------;

* WUI data : Area - WUI : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Area - WUI 1990-2020 - WUI Total.csv' out = WUI_Area replace; run;
 
 proc sort data = WUI_Area; by FIPS; run;
 
/* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/ 
 PROC TRANSPOSE DATA=WUI_Area OUT=WUI_Area_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data WUI_Area_reshaped; set WUI_Area_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to WUI_area */  
 data WUI_Area_reshaped; set WUI_Area_reshaped;
	rename _NAME_ = Year;
	rename COL1 = WUI_area_squareKm;
 run;
 
  data capstone.WUI_Area_reshaped; set WUI_Area_reshaped; run;

*-----------------------------------------------------------------------------------------------------------------------------------------;

* Non WUI data : Area - WUI : reshape and merge;
 proc import datafile= '/home/u59954755/Capstone/Data/WUI/Area - WUI 1990-2020 - Non-WUI.csv' out = NonWUI_Area replace; run;
 
 proc sort data = NonWUI_Area; by FIPS; run;
 
/* transpose data to convert columns _1990_, _2000_, _2010_ into categories of variable year*/ 
 PROC TRANSPOSE DATA=NonWUI_Area OUT=NonWUI_Area_reshaped;
    BY FIPS county state;
    VAR _1990_ _2000_ _2010_;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data NonWUI_Area_reshaped; set NonWUI_Area_reshaped;
	if _Name_='_1990_' then _Name_=1990;
	if _Name_ = '_2000_' then _Name_=2000;
	if _Name_= '_2010_' then _Name_ = 2010;
 run;

/*rename column _NAME_ to year and COL1 to WUI_area */   
 data NonWUI_Area_reshaped; set NonWUI_Area_reshaped;
	rename _NAME_ = Year;
	rename COL1 = NonWUI_area_squareKm;
 run;
 
  data capstone.NonWUI_Area_reshaped; set NonWUI_Area_reshaped; run;
