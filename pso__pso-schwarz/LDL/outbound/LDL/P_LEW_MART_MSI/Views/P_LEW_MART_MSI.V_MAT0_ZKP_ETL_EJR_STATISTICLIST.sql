CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_statisticlist AS SELECT client_id,
 loc_sid AS store_id,
 cashier_id,
 cashier_status_id AS cashier_status,
 audit_nr,
 dwh_cal_dt AS dat_formdate,
 register_id AS till_nr,
 dwh_cal_dt AS dat_dayend,
 statistic_id AS stat_code,
 statistic_cnt AS stat_count,
 statistic_val AS val_stat_amount,
 dwh_load_id AS load_id
FROM ldl_p_lew_core_ac.v_pos_ctrl_statistic;