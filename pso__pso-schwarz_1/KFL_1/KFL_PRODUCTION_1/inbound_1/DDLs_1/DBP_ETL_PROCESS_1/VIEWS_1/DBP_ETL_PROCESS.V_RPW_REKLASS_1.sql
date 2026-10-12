create or replace view DBP_ETL_PROCESS.V_RPW_REKLASS_1(
	MANDANT_ID,
	WG_ID,
	TD_UPDATE,
	TD_INSERT
) as
SELECT
*
FROM dbp_process.rpw_reklass_1;