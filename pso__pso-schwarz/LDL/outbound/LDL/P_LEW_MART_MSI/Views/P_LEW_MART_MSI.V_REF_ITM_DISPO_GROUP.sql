CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_itm_dispo_group AS SELECT *
FROM ldl_p_lew_core_ac.v_wawi_ref_itm_dispo_group
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
 AND language_id = 7;