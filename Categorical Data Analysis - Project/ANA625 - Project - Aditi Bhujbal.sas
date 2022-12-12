/* import csv files */
proc import datafile= '/home/u59954755/ANA625/data/Shark_Tank_USA.csv' out = Shark_tank_USA; run;
proc import datafile= '/home/u59954755/ANA625/data/Shark_Tank_India.csv' out = Shark_tank_INDIA; run;

/*proc print data = shark_tank_usa(firstobs=1 obs=10); run;*/
*================================================================================;
/* Data Preparation - shark_tank_USA */
data shark_tank_usa; set shark_tank_usa;
 length country $10. sector $20.;
 country = 'USA';
 *create new variable 'Deal' with values yes/no;
 if deal_yes = 1 then deal=1;
 if deal_no = 1 then deal = 0;
 
 *create new variable 'Sector' using different variables;
 if Automotive = 1 then sector = 'Technology';
 if Business_Services = 1 then sector = 'Business_Services';
 if Education = 1 then sector = 'Technology';
 if Fashion_Beauty = 1 then sector = 'Lifestyle';
 if Fitness = 1 then sector = 'Lifestyle';
 if Food_Beverage=1 then sector = 'Food';
 if CleanTech = 1 then sector = 'Technology';
 if Health_wellness = 1 then sector = 'Health';
 if Lifestyle = 1 then sector = 'Lifestyle';
 if Pet_Products = 1 then sector = 'Lifestyle';
 if Software_Tech = 1 then sector = 'Technology';
 if Entertainment = 1 then sector = 'Other';
 if Travel = 1 then sector = 'Other';
 if Other = 1 then sector = 'Other';
 
 *create new variable 'Sex' using values in variables malespresenter, femalespresenter & mixgenderpresenter;
 if MalePresenter = 1 then Sex = 0;
 if FemalePresenter = 1 then Sex = 1;
 if MixedGenderPresenters = 1 then Sex = 2;
run;

*create new dataset for USA with required variables;

data temp_usa; set shark_tank_usa;
 keep country company sector novelties sex deal;
run;

*================================================================================;

/* data preparation - shark_tank_India */
data shark_tank_india; set shark_tank_india;
 rename cmpany = company;
 rename deal = deal_dum;
 rename novelties = novelties_dum;
 rename sector = sector_dum;
 rename sex = sex_dum;
run;

data shark_tank_India; set shark_tank_India;
 length country $10. sector $20.;
 country = 'India';
 *recode sectors to match with USA data;
 if sector_dum = 'EV' then sector = 'Technology';
 else if sector_dum in ('Restaurant', 'Bag & package') then sector = 'Business_Services';
 else if sector_dum = 'Ed. Tech' then sector = 'Education';
 else if sector_dum = 'Lifestyle/Wearable' then sector = 'Lifestyle';
 else if sector_dum in ('Food', 'Packaged Food') then sector = 'Food';
 else if sector_dum = 'Health Tech' then sector = 'Health';
 else if sector_dum in ('Lifestyle', 'Lifestyle/ bodycare', 'Lifestyle/ Gift & D')
 	then sector = 'Lifestyle'; 
 else if sector_dum ='' then sector = 'Entertainment';
 else if sector_dum = 'Pets' then sector = 'Lifestyle';
 else if sector_dum in ('Insurance', 'Fin Tech', 'Tech') then sector = 'Technology';
 else if sector_dum in ('Entertainment', 'Tourism', 'Storage', 'Agri Tech', 'Toy') then sector = 'Other';
 
 *recode sector to 1/0;
 if deal_dum = 'Y' then deal = 1; else deal = 0;

 *recode SEX to 0,1,2;
 if sex_dum = 'male' then sex = 0; 
 else if sex_dum = 'female' then sex= 1;
 else if sex_dum = 'mix' then sex = 2;
 
 * convert "Novelties" to binary(1/0);
 if novelties_dum = 'yes' then novelties = 1; 
 else if novelties_dum = '0' then novelties = 0;
run;

data shark_tank_india; set shark_tank_india;
 drop deal_dum novelties_dum sector_dum sex_dum;
run;

data temp_india; set shark_tank_india;
 keep country company sector novelties sex deal;
run;

*================================================================================;
* merge both the datasets;

proc sort data = temp_usa; by company; run;
proc sort data = temp_india; by company; run;

data shark_tank; 
 merge temp_usa temp_india; 
 by company; 
run;

*================================================================================;
*display contents of data;
proc contents data = shark_tank; run;

/*data shark_tank; set ana625.shark_tank;run;*/

*================================================================================;
/* Graphical represntation */
 
proc sgplot data=shark_tank;
 vbar SECTOR/ response=DEAL group = country groupdisplay= cluster ;
run;

*================================================================================;
/* checking frequency of each variable*/
proc freq data = shark_tank;
 tables deal country sector novelties sex/ nopercent norow nocol ;
run;

/* updating sector to 'other' where it is missing.*/
data shark_tank; set shark_tank;
 if sector = '' then sector = 'Other';
run;

*Save the final dataset to permanent library ANA625;
data ana625.shark_tank; set shark_tank; run;

/* proc freq for Table 1*/
proc freq data = shark_tank;
 tables sector*(country novelties)/ norow nocol nopercent chisq;
run;

/* proc freq for Table 2*/
proc freq data = shark_tank;
 tables (sector country Novelties)*DEAL/ norow nocol nopercent chisq;
run;

*================================================================================;

/* model - main effects along with deviance & HL test
 Deal = f(Sector, country, novelties)*/

proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology') country (ref = 'USA') Novelties (ref='0')
 /param = reference;
 model DEAL = SECTOR COUNTRY NOVELTIES / aggregate scale = none;
run;

*================================================================================;

/*fully saturated model*/
proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology') country (ref = 'USA')  Novelties (ref='0')
 /param = reference;
 model DEAL = SECTOR COUNTRY NOVELTIES SECTOR*COUNTRY COUNTRY*NOVELTIES SECTOR*NOVELTIES SECTOR*COUNTRY*NOVELTIES
 / aggregate scale = none;
run;

*================================================================================;
/* test for confouding variables*/
/*Full model*/
proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology') country (ref = 'USA')  Novelties (ref='0') sex(ref = '0')
 /param = reference;
 model DEAL = SECTOR COUNTRY NOVELTIES SEX;
run;

*--------------------------------------------------------------------------------;
*Remove Sex;
proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology') country (ref = 'USA')  Novelties (ref='0')
 /param = reference;
 model DEAL = SECTOR COUNTRY NOVELTIES;
run;

*--------------------------------------------------------------------------------;
*Remove Novelties;
proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology') country (ref = 'USA') sex(ref = '0')
 /param = reference;
 model DEAL = SECTOR COUNTRY SEX;
run;

*--------------------------------------------------------------------------------;
*Remove Country;
proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology')  Novelties (ref='0') sex(ref = '0')
 /param = reference;
 model DEAL = SECTOR NOVELTIES SEX;
run;

*--------------------------------------------------------------------------------;
*Remove Novelties & sex;
proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology') country (ref = 'USA') /param = reference;
 model DEAL = SECTOR COUNTRY;
run;

*--------------------------------------------------------------------------------;
*Remove Country & sex;
proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology')  Novelties (ref='0') 
 /param = reference;
 model DEAL = SECTOR NOVELTIES;
run;

*--------------------------------------------------------------------------------;
*Remove country & Novelties;
proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology')  sex(ref = '0')
 /param = reference;
 model DEAL = SECTOR SEX;
run;

*--------------------------------------------------------------------------------;
*Remove country, Novelties & Sex;
proc logistic data = shark_tank;
 class Deal (ref = '0') sector (ref = 'Technology') /param = reference;
 model DEAL = SECTOR;
run;

*================================================================================;

*ROC curve;

proc logistic data=shark_tank descending;
class deal (ref='0') sector (ref='Technology') COUNTRY (ref='USA') NOVELTIES (ref = '0') SEX (ref='0')/param=ref;
model deal = SECTOR COUNTRY NOVELTIES SEX; 
roc 'omit sex'SECTOR COUNTRY NOVELTIES;
run;







 