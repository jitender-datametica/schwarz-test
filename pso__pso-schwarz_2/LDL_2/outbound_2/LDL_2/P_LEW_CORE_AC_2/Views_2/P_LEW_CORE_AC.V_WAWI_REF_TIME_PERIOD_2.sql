CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_time_period_2 (period_id, dat_calendar_from, dat_calendar_to) AS
SELECT period_id,
 dat_calendar_from,
 dat_calendar_to
FROM ldl_p_lew_core.t_wawi_ref_time_period_2;