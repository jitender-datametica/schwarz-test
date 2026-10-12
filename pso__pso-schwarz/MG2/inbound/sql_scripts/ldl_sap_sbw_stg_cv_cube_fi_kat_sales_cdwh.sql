SELECT 
  vlxmlcntr
, store_number
, object_type
, business_date
, vlxecukyl
, change_date
, flg_prevmonth
, turnover_net
FROM "_SYS_BIC"."bi.Z09.FI.24/CV_CUBE_FI_KAT_SALES_CDWH"
${WHERE_CONDITION}
