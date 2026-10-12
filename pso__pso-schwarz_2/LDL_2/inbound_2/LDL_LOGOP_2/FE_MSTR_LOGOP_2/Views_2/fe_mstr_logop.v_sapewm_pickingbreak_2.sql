/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_pickingbreak_2
Description		|	SAP EWM - base view
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_pickingbreak_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	, lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
	, src_sys COMMENT 'Source system'
	, wh_id COMMENT 'Warehouse ID. Subset of Warehouse Number'
	, mandt COMMENT 'Client of the EWM system'
	, wh_nr COMMENT 'Warehouse Number/Warehouse Complex'
	, crtd_by COMMENT 'Created By'
	, start_dt COMMENT 'Start Date'
	, start_tm COMMENT 'Start Time'
	, start_ts COMMENT 'UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'
	, end_dt COMMENT 'End Date'
	, end_tm COMMENT 'End Time'
	, end_ts COMMENT 'UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'
	, duration COMMENT 'Planned Duration'
	, tm_unit COMMENT 'Time Unit_2'
	, wh_ord_nr COMMENT 'Warehouse Order Number'
	, dwh_load_id COMMENT 'Load id'
	, dwh_created COMMENT 'Record created at'
	, dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM - base view for picking break'
AS
SELECT
	client_id 
	, lidl_country AS lidl_ctry
	, source_system AS src_sys
	, wh_id
	, mandt
	, lgnum AS wh_nr
	, created_by AS crtd_by
	, start_date AS start_dt
	, start_time AS start_tm
	, start_tstamp AS start_ts 
	, end_date AS end_dt
	, end_time AS end_tm
	, end_tstamp AS end_ts
	, duration
	, unit_t AS tm_unit
	, who AS wh_ord_nr
	, dwh_load_id
	, dwh_created
	, dwh_updated
FROM DATA.t_sapewm_pickingbreak_2 -- PK (client_id, lgnum, who, created_by, start_date, start_time)
;
	