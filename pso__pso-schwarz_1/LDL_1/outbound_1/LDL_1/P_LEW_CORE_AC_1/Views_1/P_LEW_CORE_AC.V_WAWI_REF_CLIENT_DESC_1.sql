CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_client_desc_1 (client_id, language_id, client_desc, load_id) AS SELECT
 client_id,
 language_id,
 client_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_client_desc_1;