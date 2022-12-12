* WUI data : Housing - interface : reshape and merge;
 *proc import datafile= '/home/u59954755/Capstone/Data/WUI_Merged_Final.csv' out = WUI_Final replace; run;
 
 proc print data = capstone.wui_merged (firstobs=1 obs=20); run;
 proc sort data = capstone.wui_merged; 
  by FIPS County_Code county STATE Date; 
 run;
 
 /* transpose data to convert columns into categories of variable WUI_Category*/
 PROC TRANSPOSE DATA=capstone.wui_merged OUT=capstone.wui_Housing_reshaped;
    BY FIPS County_Code county STATE Date;
    VAR Interface_Housing_number Intermix_Housing_number WUI_Housing_number NonWUI_Housing_number;
 RUN;

/* update values of categories to 1990, 2000, 2010*/
 data capstone.wui_Housing_reshaped; set capstone.wui_Housing_reshaped;
	if _Name_='Interface_Housing_number' then _Name_= 'Interface';
	if _Name_ = 'Intermix_Housing_number' then _Name_= 'Intermix';
	if _Name_= 'WUI_Housing_number' then _Name_ = 'WUI';
	if _Name_= 'NonWUI_Housing_number' then _Name_ = 'NonWUI';
 run;

/*rename column _NAME_ to WUI_Category and COL1 to Housing_number*/ 
 data capstone.wui_Housing_reshaped; set capstone.wui_Housing_reshaped;
	rename _NAME_ = WUI_Category;
	rename COL1 = Housing_number;
 run;
