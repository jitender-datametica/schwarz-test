CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_ejr_return_text AS SELECT *
FROM ldl_p_lew_core_ac.v_wawi_ref_ejr_return_text
WHERE dat_rec_end = DATE '9999-12-31';