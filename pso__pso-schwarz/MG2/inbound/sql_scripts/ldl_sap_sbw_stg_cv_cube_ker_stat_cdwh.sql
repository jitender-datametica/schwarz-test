SELECT 
  vlxmlcntr 	
, calmonth 	
, gxxmlklag	
, unit 		
, ist 		
, plan 
FROM "_SYS_BIC"."bi.Z09.FI.24/CV_CUBE_KER_STAT_CDWH"
${WHERE_CONDITION}
