CREATE OR REPLACE VIEW ldl_s_conl.v_ptm_working_time_store_2 AS SELECT client_id,
 loc_sid_store AS store_id,
 dwh_cal_dt AS dat_working,
 work_time_gross_hr AS working_time_brutto_std,
 break_hr AS break_std,
 work_time_net_hr AS time_working_netto_std
FROM ldl_p_lew_bil_ac.v_agg_work_time_store_day_2
WHERE (work_time_gross_hr IS NOT NULL OR break_hr IS NOT NULL OR work_time_net_hr IS NOT NULL)
 AND client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_2
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_core_ac.v_wawi_ref_currency_act_2" ***/