create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_F_LIFECYCLE_HGA_AVAILABILITY(
	HGA_SID,
	TOTAL_AVAIL_PCT,
	LAST_ONLINE_TMSP
) as
SELECT
 core.t_fact_hga_total_availability.hga_sid
,core.t_fact_hga_total_availability.total_avail_pct
,core.t_fact_hga_total_availability.last_online_tmsp
FROM
core.t_fact_hga_total_availability
;