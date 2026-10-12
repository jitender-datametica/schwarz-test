create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.V_F_LIFECYCLE_HGA_MAINTENANCE(
	HGA_SID,
	REPORT_DT,
	CLEANING_LIQUID_LTR_QTY,
	SERVICE_CNT,
	FILTER_CNT,
	CLEANING_CNT,
	DOOR_OPEN_CNT
) as
SELECT
 CORE.t_fact_hga_maintenance.hga_sid
,CORE.t_fact_hga_maintenance.report_dt
,CORE.t_fact_hga_maintenance.cleaning_liquid_ltr_qty
,CORE.t_fact_hga_maintenance.service_cnt
,CORE.t_fact_hga_maintenance.filter_cnt
,CORE.t_fact_hga_maintenance.cleaning_cnt
,CORE.t_fact_hga_maintenance.door_open_cnt
FROM
CORE.t_fact_hga_maintenance
;