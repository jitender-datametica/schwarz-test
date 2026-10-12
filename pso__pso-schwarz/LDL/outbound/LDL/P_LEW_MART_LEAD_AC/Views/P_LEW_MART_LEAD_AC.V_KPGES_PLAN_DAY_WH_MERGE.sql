/* #DescStart# 
 #$Revision: 7671 $, $LastChangedBy: rcione $ 
 #SubjectAreas#: KPGES Views 
 #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_kpges_plan_day_wh_merge (client_id, wh_id, loc_sid_wh, aspect_id,
indicator_id, dat_formdate, val_indicator, currency_iso_cd, dat_dayend) AS SELECT *
FROM ldl_p_lew_mart_lead.v_kpges_plan_day_wh_merge;