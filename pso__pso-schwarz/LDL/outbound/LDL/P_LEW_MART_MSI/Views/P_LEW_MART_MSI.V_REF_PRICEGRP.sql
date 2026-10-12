CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_pricegrp AS SELECT *
FROM ldl_p_lew_core_ac.v_wawi_ref_pricegrp AS T1
WHERE CURRENT_DATE BETWEEN dat_valid_from AND dat_valid_until;