* WUI data : Population - interface : reshape and merge;
 *proc import datafile= '/home/u59954755/Capstone/Data/WUI_Merged_Final.csv' out = WUI_Final replace; run;
 
 proc print data = capstone.wui_merged (firstobs=1 obs=20); run;
 proc sort data = capstone.wui_merged; 
  by FIPS County_Code county STATE Date; 
 run;
 
 /* transpose data to convert columns into categories of variable WUI_Category*/
 PROC TRANSPOSE DATA=capstone.wui_merged OUT=capstone.wui_Population_reshaped;
    BY FIPS County_Code county STATE Date;
    VAR Interface_Population_count Intermix_Population_count WUI_Population_count NonWUI_Population_count;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data capstone.wui_Population_reshaped; set capstone.wui_Population_reshaped;
	if _Name_='Interface_Population_count' then _Name_= 'Interface';
	if _Name_ = 'Intermix_Population_count' then _Name_= 'Intermix';
	if _Name_= 'WUI_Population_count' then _Name_ = 'WUI';
	if _Name_= 'NonWUI_Population_count' then _Name_ = 'NonWUI';
 run;

/*rename column _NAME_ to WUI_Category and COL1 to Population_count*/ 
 data capstone.wui_Population_reshaped; set capstone.wui_Population_reshaped;
	rename _NAME_ = WUI_Category;
	rename COL1 = Population_count;
 run;
