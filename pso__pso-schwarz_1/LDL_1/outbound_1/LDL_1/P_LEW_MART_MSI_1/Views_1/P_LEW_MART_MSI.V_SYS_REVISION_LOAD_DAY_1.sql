CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sys_revision_load_day_1 (dat_calendar, load_in_progress_fg) AS SELECT
 dat_calendar,
 load_in_progress_fg
FROM ldl_p_lew_mart_msi.t_msi_sys_revision_load_day_1;