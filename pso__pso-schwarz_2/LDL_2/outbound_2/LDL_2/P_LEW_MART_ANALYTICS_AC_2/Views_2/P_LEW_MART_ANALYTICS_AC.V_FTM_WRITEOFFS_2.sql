CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_ftm_writeoffs_2 (client_id, country_code, dat_formdate, cy_week,
store_id, orig_store_nr, item_id, orig_item_nr, itemgroup_int_id, subitemgroup_id, item_type, wrtoff_val) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_ftm_writeoffs_2;