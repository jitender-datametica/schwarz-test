CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_l_warehouse_wawi_manual_extraction_2 AS SELECT DISTINCT client_id,
 wh_id,
 wh_desc,
 wh_type,
 wh_active_fg
FROM ldl_bcbi_fe_mstr_bcbi.t_dataavail_wh_expected_list_2
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end;