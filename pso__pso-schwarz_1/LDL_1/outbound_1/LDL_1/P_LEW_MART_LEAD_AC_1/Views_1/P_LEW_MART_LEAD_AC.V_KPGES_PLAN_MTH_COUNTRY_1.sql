/* #DescStart# 
 #$Revision: 7671 $, $LastChangedBy: rcione $ 
 #SubjectAreas#: KPGES Views 
 #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_kpges_plan_mth_country_1 (client_id, indicator_id, cy_month, val_indicator
, currency_iso_cd, dat_dayend) AS SELECT *
FROM ldl_p_lew_mart_lead.v_kpges_plan_mth_country_1;