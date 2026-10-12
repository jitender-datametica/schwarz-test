CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_COUNTRY_1
AS
   SELECT
     client_id,
   sales_price_net_fg,
   dwh_created
  FROM p_lew_mart_analytics.t_pit_country_1
;