create or replace view DBP_ETL_PROCESS.LEAD_WUP_REGION_1(
	REGION_ID,
	WUP_ID,
	MANDANT_ID,
	LAND_ID,
	TD_UPDATE,
	TD_INSERT
) as
SELECT
*
FROM dbp_process.lead_wup_region_1;