SELECT   
  vlxmlcntr 			
, calmonth 			
, vlxecukyl 			
, kalk_repr_ist		
, kalk_repr_plan		
, kalkulation_ist		
, kalkulation_plan	
, steuern_ist			
, steuern_plan		
, rvg_ist				
, rvg_plan			
, nrv_ist 			
, nrv_plan			
, spedition_ist		
, spedition_plan 		
, whrgdiff_ist 		
, whrgdiff_plan		
FROM "_SYS_BIC"."bi.Z09.FI.24/CV_CUBE_KER_VALUES_CDWH"
${WHERE_CONDITION}
--WHERE calmonth between '202303' AND '202402'
