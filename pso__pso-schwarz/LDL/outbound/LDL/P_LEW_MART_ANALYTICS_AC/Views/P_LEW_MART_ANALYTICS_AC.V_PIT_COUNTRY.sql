CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_pit_country AS SELECT client_id,
 sales_price_net_fg,
 dwh_created
FROM ldl_p_lew_mart_analytics.t_pit_country;