create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_F_LIFECYCLE_HGA_AVAILABILITY_PER_WEEK_2(
	HGA_SID,
	CY_WEEK,
	WEEKLY_AVAIL_PCT,
	NO_SALE_WEEKLY_VAL
) as SELECT
 core.t_fact_hga_availability_per_week.hga_sid
,core.t_fact_hga_availability_per_week.cy_week
,core.t_fact_hga_availability_per_week.weekly_avail_pct
,core.t_fact_hga_availability_per_week.no_sale_weekly_val
FROM
core.t_fact_hga_availability_per_week_2
;