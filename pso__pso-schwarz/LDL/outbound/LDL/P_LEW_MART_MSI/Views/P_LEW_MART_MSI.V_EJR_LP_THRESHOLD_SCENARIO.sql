CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_lp_threshold_scenario (client_id, threshold_group_id,
threshold_group_desc, min_val_retail_ejr, max_val_retail_ejr) AS SELECT client_id,
 threshold_group_id,
 threshold_group_desc,
 min_val_retail_ejr,
 max_val_retail_ejr
FROM ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_scenario
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
 AND approval_fg = 1;