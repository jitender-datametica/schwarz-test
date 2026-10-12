CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_KPGES_PLAN_MTH_COUNTRY_1
 /* 
 #DescStart# 
 #$Revision: 7671 $, $LastChangedBy: rcione $ 
 #SubjectAreas#: KPGES Views 
 #DescEnd# 
 */
(
  client_id
, indicator_id
, cy_month
, val_indicator
, currency_iso_cd
, dat_dayend
 )
AS
   SELECT
    client_id,
   indicator_id,
   cy_month,
   val_indicator,
   currency_iso_cd,
   dat_dayend

   FROM p_lew_mart_lead.v_kpges_plan_mth_country_1
;