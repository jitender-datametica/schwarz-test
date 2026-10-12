CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_country_based_competitors (client_id, competitor_rank_id,
competitor_rank_name, rtl_id) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_country_based_competitors;