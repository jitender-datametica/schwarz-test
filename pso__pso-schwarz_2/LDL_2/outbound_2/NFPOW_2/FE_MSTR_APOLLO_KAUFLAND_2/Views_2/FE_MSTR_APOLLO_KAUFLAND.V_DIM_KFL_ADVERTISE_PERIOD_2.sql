CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_advertise_period_2 (kfl_client_id, kfl_adv_period_type_id,
cal_week, kfl_adjust_adv_period_fg, kfl_adv_period_begin_dt, kfl_adv_period_end_dt) AS SELECT kfl_client_id,
 kfl_adv_period_type_id,
 cal_week,
 kfl_adjust_adv_period_fg,
 kfl_adv_period_begin_dt,
 kfl_adv_period_end_dt
FROM nfpow_core.t_dim_kfl_advertise_period_2;