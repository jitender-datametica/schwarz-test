CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_HIER_LEVEL_1
AS
SELECT
  hier_level_id
, hier_type_id
, hier_level_descr
FROM p_lew_mart_analytics.t_pit_hier_level_1;