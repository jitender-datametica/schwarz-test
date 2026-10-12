CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_client_advertise_week_2 (kfl_client_id, kfl_adv_week,
kfl_adv_week_begin_dt, kfl_adv_week_end_dt, kfl_adv_week_offset, kfl_completed_adv_week_offset, cal_dt) AS SELECT V01.kfl_client_id
 ,
 V01.kfl_adv_week,
 V01.kfl_adv_week_begin_dt,
 V01.kfl_adv_week_end_dt,
 V01.kfl_adv_week_offset,
 V01.kfl_completed_adv_week_offset,
 V02.cal_dt
FROM nfpow_core.t_dim_kfl_client_advertise_week_2 AS V01
 INNER JOIN nfpow_core.t_dim_kfl_calendar_date_2 AS V02 ON V02.cal_dt BETWEEN V01.kfl_adv_week_begin_dt AND V01.kfl_adv_week_end_dt;