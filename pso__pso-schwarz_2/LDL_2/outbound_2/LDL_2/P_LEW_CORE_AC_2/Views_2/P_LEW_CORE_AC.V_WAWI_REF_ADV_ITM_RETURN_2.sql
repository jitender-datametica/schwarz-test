CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_adv_itm_return_2 (country_iso_cd, receipt_nr_sfo_prefix) AS SELECT
 country_iso_cd,
 receipt_nr_sfo_prefix
FROM ldl_p_lew_core.t_wawi_ref_adv_itm_return_2;