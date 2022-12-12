proc import datafile='/home/u59954755/Capstone/Data/Concat_CY2013_to_2020_Emission_CA_SOUTHERN.csv' out=Carbon_Data replace; run;

*data carbon_data; set carbon_data (drop= VAR18 VAR19 VAR20 VAR21 VAR22 VAR23 VAR24 VAR25 VAR26 VAR27 VAR28); run;

proc contents data= Carbon_Data; run;

proc sort data = carbon_Data; by County; run;

proc freq data = Carbon_Data;
 tables county;
run;

proc freq data = Carbon_Data;
 tables Sector_Group;
run;

proc means data = Carbon_Data n nmiss mean stddev stderr var min max; 
var CO2_Emissions_MetricTons; run;
   
*Sort the data by grouping variable (county_code);
 proc sort data = Carbon_Data; 
  by Sector_Group;
 run;
 
*Compute the means of the variables by grouping variable (county_code);
 proc means data = Carbon_Data;
  by Sector_Group;
  var CO2_Emissions_MetricTons Total_Fuel_Consumption;
 run;

*Call MANOVA procedure with proc glm; 
 PROC GLM data=Carbon_Data;          
  CLASS Sector_Group;
  MODEL  CO2_Emissions_MetricTons Total_Fuel_Consumption = Sector_Group/ SS3;       
  MANOVA H = Sector_Group/PRINTE PRINTH; 
  MEANS Sector_Group;                    
 RUN;
 
 
 *--------------------------------------------------------------------------------------------;
*Sort the data by grouping variable (Fire_ACTIVE_IND);
 proc sort data = Carbon_Data; 
  by Fire_ACTIVE_IND;
 run;
 
*Compute the means of the variables by grouping variable (Fire_ACTIVE_IND);
 proc means data = Carbon_Data;
  by Fire_ACTIVE_IND;
  var PRECIPITATION Temp_Max;
 run;

*Call MANOVA procedure with proc glm; 
 PROC GLM data=Carbon_Data;          
  CLASS Fire_ACTIVE_IND;
  MODEL PRECIPITATION Temp_Max = Fire_ACTIVE_IND/ SS3;       
  MANOVA H = Fire_ACTIVE_IND/PRINTE PRINTH; 
  MEANS Fire_ACTIVE_IND;                    
 RUN;