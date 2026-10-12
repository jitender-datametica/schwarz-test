CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_ADV_CBX
(
      client_id
    , client_id_order
    , item_ian
    , range_plan_cd
    , adv_dt
    , dwh_updated
)
AS
   SELECT
         client_id,
   client_id_order,
   item_ian,
   range_plan_cd,
   adv_dt,
   dwh_updated
  FROM p_lew_mart_analytics.v_kol_adv_cbx
;