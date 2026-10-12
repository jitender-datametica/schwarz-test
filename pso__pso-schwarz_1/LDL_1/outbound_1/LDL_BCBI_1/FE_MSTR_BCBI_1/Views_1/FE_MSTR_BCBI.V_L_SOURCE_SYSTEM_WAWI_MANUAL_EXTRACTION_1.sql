CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_l_source_system_wawi_manual_extraction_1 AS SELECT DISTINCT client_id,
 wh_id,
 wh_desc,
 system_key,
 system_desc
FROM ldl_bcbi_fe_mstr_bcbi.t_dataavail_wh_expected_list_1
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
 AND system_key NOT IN (10, 11, 14, 16);