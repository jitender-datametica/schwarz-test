CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_pricegrp_2 AS SELECT *
FROM ldl_p_lew_core_ac.v_wawi_ref_pricegrp_2 AS T1_2
WHERE CURRENT_DATE BETWEEN dat_valid_from AND dat_valid_until;