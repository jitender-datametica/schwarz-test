CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_ITEM_PREDECESSOR
(
      item_ian
    , pre_item_ian
    , pre_range_plan_cd
    , dwh_created
)
AS
   SELECT
         item_ian,
   pre_item_ian,
   pre_range_plan_cd,
   dwh_created
  FROM p_lew_mart_analytics.t_kol_item_predecessor
;