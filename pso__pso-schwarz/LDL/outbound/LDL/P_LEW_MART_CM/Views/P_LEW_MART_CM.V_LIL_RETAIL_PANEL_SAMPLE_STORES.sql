CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_retail_panel_sample_stores (client_id, orig_store_nr, partner_name,
datetime_updated) AS SELECT client_id,
 orig_store_nr,
 partner_name,
 datetime_updated
FROM ldl_p_lew_mart_cm.t_lil_retail_panel_sample_stores;