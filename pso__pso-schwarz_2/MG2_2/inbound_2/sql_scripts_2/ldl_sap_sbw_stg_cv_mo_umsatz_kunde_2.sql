SELECT 
  kyf_id     
, kyf_type   
, urgunit    
, vlxmlcntr  
, calyear    
, calday     
, vlxecukyl  
, fiscyear   
, vlxmvers   
, kyf_all    
FROM "_SYS_BIC"."bi.Z09.VM.28.DL.OB.MIS/CV_MO_UMSATZ_KUNDE"
${WHERE_CONDITION}
