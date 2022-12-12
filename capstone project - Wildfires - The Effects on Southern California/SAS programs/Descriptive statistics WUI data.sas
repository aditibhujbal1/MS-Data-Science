/*import data from WUI_Merged_Final datafile*/
*proc import datafile= '/home/u59954755/Capstone/Data/WUI_Merged_Final.csv' out = WUI_Merged replace; run;
/*data capstone.WUI_Merged; set WUI_Merged; run;*/

*to check contents of data set;
proc contents data = capstone.WUI_Final; run;
  
*Sort the data by grouping variable (gp, here);
proc sort data = capstone.WUI_Final; by WUI_Category; run;

*Compute the means of the variables by grouping variable (gp, here);
 proc means data=capstone.WUI_Final n nmiss mean median stddev var min max mode;
	by WUI_Category;
	var Area_squareKm Housing_Number Population_count;
 run;
 
 proc univariate data= capstone.WUI_Final;
  var Area_SquareKm Housing_Number Population_Count;
  histogram Area_SquareKm Housing_Number Population_Count;
 run;
 
*Distribution of TotalPop;
title 'Distribution of TotalPop';
proc sgplot data=capstone.WUI_Final;
  histogram TotalPop;
  density TotalPop;
run;

*Boxplot TotalPop vs County;
title 'TotalPop Vs County';
proc sgplot data = capstone.WUI_Final;
 vbox TotalPop / group = County_code;
run;

*Boxplot Income vs County;
title 'Income Vs County';
proc sgplot data = capstone.WUI_Final;
 vbox Income / group = County_code;
run;