CREATE OR REPLACE VIEW ldl_s_conl.v_ptm_missingtimes_wh_perf_2 AS -- Auflösung WH
 SELECT TIM.client_id,
 S2WH.src_wh_id AS wh_id,
 TIM.loc_sid_store AS store_id,
 - 999 AS missingtimes_id,
 - 999 AS mis_key,
 - 999 AS dat_modification,
 - 999 AS missingtype_id,
 TIM.dwh_cal_dt AS dat_working,
 - 999 AS dat_valid_from,
 - 999 AS dat_valid_until,
 - 999 AS time_missing_from,
 - 999 AS missing_from_fg,
 - 999 AS time_missing_until,
 - 999 AS missing_until_fg,
 TIM.perform_relev_absence_hr AS time_missing_period,
 - 999 AS val_missing,
 - 999 AS sap_export,
 - 999 AS backoffice_import,
 - 999 AS valid_for,
 TIM.dwh_cal_dt AS dat_dayend,
 TIM.dwh_load_id AS load_id
FROM ldl_p_lew_bil_ac.v_agg_work_time_store_day_2 AS TIM
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS S2WH ON TIM.client_id = S2WH.client_id AND TIM.loc_sid_store
      = S2WH.loc_sid_store AND S2WH.dwh_actual_fg = 1 AND S2WH.active_fg = 1
WHERE TIM.perform_relev_absence_hr IS NOT NULL
 AND TIM.client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_2
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_bil_ac.v_agg_work_time_store_day_2" ***/