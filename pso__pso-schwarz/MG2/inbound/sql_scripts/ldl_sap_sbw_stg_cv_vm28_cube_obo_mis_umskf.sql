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
, vlxmstore
, vlxmwrnfl
, kyf_all
FROM "_SYS_BIC"."bi.Z09.VM.28.DL.OB.MIS/CV_VM28_CUBE_OBO_MIS_UMSKF"
${WHERE_CONDITION}
