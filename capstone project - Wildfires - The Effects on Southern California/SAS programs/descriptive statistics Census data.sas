 
 /* import csv file US Census - Kaggle.csv*/
 proc import datafile= '/home/u59954755/Capstone/Data/Population/US Census - Kaggle.csv' out= Census_bureau_TotPop replace; run;
 proc print data = capstone.Census_bureau_TotPop (firstobs=1 obs = 20); run;

 *data capstone.Census_bureau_TotPop; set Census_bureau_TotPop; run;

/*use PROC CONTENTS to see data fields, record and data field counts. */
 proc contents data=Census_bureau_TotPop; run;
  
*Sort the data by grouping variable (gp, here);
proc sort data = capstone.Census_bureau_TotPop; by county_code; run;

*Compute the means of the variables by grouping variable (gp, here);
 proc means data=capstone.Census_bureau_TotPop n nmiss mean median stddev var min max mode;
	by County_code;
	var TotalPop Income;
 run;
 
 proc univariate data= capstone.Census_bureau_TotPop;
  var TotalPop Income;
  histogram TotalPop Income;
 run;
 
*Distribution of TotalPop;
title 'Distribution of TotalPop';
proc sgplot data=capstone.census_bureau_totpop;
  histogram TotalPop;
  density TotalPop;
run;


*density plot of TotalPop vs County;
title 'Distribution of TotalPop by County';
proc sgplot data=capstone.census_bureau_totpop;
 density TotalPop / group = County_code;
run;

*density plot of Income vs County;
title 'Distribution of Income by County';
proc sgplot data=capstone.census_bureau_totpop;
 density Income / group = County_code;
run;

/*
proc SQL;
 create table Pop_LA as
 select * from capstone.census_bureau_TotPop where county_code = 'LA';
quit;

proc print data = Pop_LA(firstobs=1 obs=10); run;

title 'scatterplot of TotalPop vs Date grouped by County';
proc sgplot data = Pop_LA;
 scatter x=date y=TotalPop / group= County_code;
run;
*/

*Boxplot TotalPop vs County;
title 'TotalPop Vs County';
proc sgplot data = capstone.census_bureau_TotPop;
 vbox TotalPop / group = County_code;
run;

*Boxplot Income vs County;
title 'Income Vs County';
proc sgplot data = capstone.census_bureau_TotPop;
 vbox Income / group = County_code;
run;
*-----------------------------------------------------------------------------------------------------------------------------------------;
