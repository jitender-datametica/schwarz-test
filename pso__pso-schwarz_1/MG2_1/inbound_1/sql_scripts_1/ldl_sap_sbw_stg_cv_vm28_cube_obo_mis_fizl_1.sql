SELECT 
  kyf_id    
, kyf_type  
, org_unit  
, vlxmstore 
, fiscyear  
, calyear   
, calday    
, vlxecukyl 
, vlxmvers  
, vlxmlcntr 
, keyfigure 
FROM "_SYS_BIC"."bi.Z09.VM.28.DL.OB.MIS/CV_VM28_CUBE_OBO_MIS_FIZL"
${WHERE_CONDITION}
