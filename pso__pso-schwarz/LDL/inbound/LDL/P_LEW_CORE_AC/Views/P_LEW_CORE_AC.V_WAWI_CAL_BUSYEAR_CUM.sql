create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_CAL_BUSYEAR_CUM(
	DAT_CALENDAR,
	BUSYEAR,
	DAT_BUSYEAR_CUM,
	DAT_BUSYEAR_CUM_PY,
	DAT_BUSYEAR_CUM_PPY,
	CY_BY_CUM_SEQUENCE
) as
   SELECT
       dat_calendar,
   busyear,
   dat_busyear_cum,
   dat_busyear_cum_py,
   dat_busyear_cum_ppy,
   cy_by_cum_sequence
   FROM p_lew_core.t_wawi_cal_busyear_cum;
