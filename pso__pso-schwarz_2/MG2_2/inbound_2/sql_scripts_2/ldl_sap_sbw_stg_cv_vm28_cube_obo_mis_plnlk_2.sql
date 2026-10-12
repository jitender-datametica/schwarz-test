SELECT
  kyf_id
, kyf_type 
, org_unit
, vlxmlcntr
, calyear
, calmonth2
, vlxecukyl
, fiscyear
, vlxmvers
, kyf_all
FROM "_SYS_BIC"."bi.Z09.VM.28.DL.OB.MIS/CV_VM28_CUBE_OBO_MIS_PLNLK"
${WHERE_CONDITION}
