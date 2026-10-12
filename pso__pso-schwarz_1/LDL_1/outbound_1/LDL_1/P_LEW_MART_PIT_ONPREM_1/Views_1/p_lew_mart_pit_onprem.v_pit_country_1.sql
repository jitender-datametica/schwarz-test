CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_country_1 AS SELECT client_id,
 sales_price_net_fg,
 dwh_created
FROM ldl_p_lew_mart_pit_onprem.t_pit_country_1;