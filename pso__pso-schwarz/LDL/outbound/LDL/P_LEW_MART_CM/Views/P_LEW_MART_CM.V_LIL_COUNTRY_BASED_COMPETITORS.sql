CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_country_based_competitors (client_id, competitor_rank_id,
competitor_rank_name, rtl_id) AS SELECT client_id,
 competitor_rank_id,
 competitor_rank_name,
 retailer_id AS rtl_id
FROM ldl_p_lew_mart_cm.t_lil_country_based_competitors
WHERE active_fg = 1;