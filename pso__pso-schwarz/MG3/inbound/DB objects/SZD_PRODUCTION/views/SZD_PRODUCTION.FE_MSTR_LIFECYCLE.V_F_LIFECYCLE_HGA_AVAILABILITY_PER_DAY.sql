create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_F_LIFECYCLE_HGA_AVAILABILITY_PER_DAY(
	HGA_SID,
	AVAIL_DT,
	DAILY_AVAIL_PCT,
	NO_SALE_DAILY_VAL,
	LAST_ONLINE_TMSP
) as SELECT
 core.t_fact_hga_availability_per_day.hga_sid
,core.t_fact_hga_availability_per_day.avail_dt
,core.t_fact_hga_availability_per_day.daily_avail_pct
,core.t_fact_hga_availability_per_day.no_sale_daily_val
,core.t_fact_hga_availability_per_day.last_online_tmsp
FROM
core.t_fact_hga_availability_per_day
;