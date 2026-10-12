CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_RANGE_SELECTION
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
  FROM p_lew_mart_analytics.t_kol_range_selection
;