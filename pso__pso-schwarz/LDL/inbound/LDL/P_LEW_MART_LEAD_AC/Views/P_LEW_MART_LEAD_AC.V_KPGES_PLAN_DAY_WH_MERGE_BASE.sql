CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_KPGES_PLAN_DAY_WH_MERGE_BASE
(
   client_id
 , wh_id
 , aspect_id
 , indicator_id
 , dat_formdate
 , val_indicator
 , currency_iso_cd
 , dat_dayend                      
)
AS 
SELECT 
   client_id
 , wh_id
 , aspect_id
 , indicator_id
 , dat_formdate
 , val_indicator
 , currency_iso_cd
 , dat_dayend
FROM  p_lew_mart_lead.v_kpges_plan_day_wh_merge_base;