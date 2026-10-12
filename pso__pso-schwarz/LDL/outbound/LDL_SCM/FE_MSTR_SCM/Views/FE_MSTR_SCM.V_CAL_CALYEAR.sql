CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_cal_calyear (busyear, py_busyear) AS SELECT DISTINCT busyear,
  busyear - 1 AS py_busyear
FROM ldl_scm_core_rel.v_busyear_month_week;