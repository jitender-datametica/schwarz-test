CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_KOL_RANGE_SELECTION_1
(
      client_id
    , range_plan_cd
    , range_advertise_from
    , range_advertise_to
)
AS
   SELECT
         client_id,
   range_plan_cd,
   range_advertise_from,
   range_advertise_to
  FROM p_lew_mart_analytics.t_kol_range_selection_1
;