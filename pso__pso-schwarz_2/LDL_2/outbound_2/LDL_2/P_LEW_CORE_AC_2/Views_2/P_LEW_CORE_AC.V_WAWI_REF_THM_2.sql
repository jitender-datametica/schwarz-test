CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_thm_2 (client_id, orig_thm_nr, language_id, thm_desc, factor_ep,
load_id) AS SELECT client_id,
 orig_thm_nr,
 language_id,
 thm_desc,
 factor_ep,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_thm_2;