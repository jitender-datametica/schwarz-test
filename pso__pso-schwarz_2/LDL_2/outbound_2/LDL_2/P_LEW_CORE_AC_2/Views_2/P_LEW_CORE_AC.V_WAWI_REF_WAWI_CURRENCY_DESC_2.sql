CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_desc_2 (client_id, currency_iso_cd, currency_desc,
load_id) AS SELECT client_id,
 currency_iso_cd,
 currency_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_wawi_currency_desc_2;