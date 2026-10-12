create or replace view DBP_ETL_PROCESS.SNFL_TRACK_TABLES_1(
	OBJECT_NAME,
	TD_UPDATE,
	TD_INSERT
) as
SELECT
*
FROM dbp_process.snfl_track_tables_1;