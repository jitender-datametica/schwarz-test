CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_shift_2 (shift_id, shift_type_id, shift_start_dt, shift_end_dt
, shift_type_descr, shift_start_tm, shift_end_tm) AS SELECT shift_id,
 shift_type_id,
 shift_start_dt,
 shift_end_dt,
 shift_type_descr,
 shift_start_tm,
 shift_end_tm
FROM produktion_core.t_dim_shift_2;