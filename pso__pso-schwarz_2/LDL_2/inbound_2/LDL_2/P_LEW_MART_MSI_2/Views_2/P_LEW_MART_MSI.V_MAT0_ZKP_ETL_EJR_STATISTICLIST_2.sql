CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_STATISTICLIST_2 as
   SELECT	
      client_id         AS client_id,	
   loc_sid           AS store_id,	
   cashier_id        AS cashier_id,	
   cashier_status_id AS cashier_status,	
   audit_nr          AS audit_nr,	
   dwh_cal_dt        AS dat_formdate,	
   register_id       AS till_nr,	
   dwh_cal_dt        AS dat_dayend,	
   statistic_id      AS stat_code,	
   statistic_cnt     AS stat_count,	
   statistic_val     AS val_stat_amount,	
   dwh_load_id       AS load_id	
   FROM p_lew_core_ac.v_pos_ctrl_statistic_2	
;