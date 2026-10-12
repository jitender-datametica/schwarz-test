CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PVT_PERIOD
(
      period_id
    , period_desc
)
AS
   SELECT
         period_id,
   period_desc
  FROM p_lew_mart_analytics.t_pvt_period
;