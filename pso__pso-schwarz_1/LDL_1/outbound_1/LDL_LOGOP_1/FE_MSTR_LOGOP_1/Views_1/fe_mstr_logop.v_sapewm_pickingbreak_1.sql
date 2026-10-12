/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_pickingbreak_1
Description		|	SAP EWM - base view
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_pickingbreak_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), lidl_ctry
OPTIONS(description='Country_1 code. Original field name bic_zmlila'), src_sys OPTIONS(description='Source system'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number'), mandt OPTIONS(description='Client of the EWM system'),
wh_nr OPTIONS(description='Warehouse Number/Warehouse Complex'), crtd_by OPTIONS(description='Created By'), start_dt
OPTIONS(description='Start Date'), start_tm OPTIONS(description='Start Time'), start_ts
OPTIONS(description='UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'), end_dt OPTIONS(description='End Date'), end_tm
OPTIONS(description='End Time'), end_ts OPTIONS(description='UTC Time Stamp in Short Form (YYYYMMDDhhmmss)'), duration
OPTIONS(description='Planned Duration'), tm_unit OPTIONS(description='Time Unit_1'), wh_ord_nr
OPTIONS(description='Warehouse Order Number'), dwh_load_id OPTIONS(description='Load id'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'))
OPTIONS(DESCRIPTION = `SAP EWM - BASE VIEW FOR PICKING BREAK`) AS SELECT client_id,
 lidl_country AS lidl_ctry,
 source_system AS src_sys,
 wh_id,
 mandt,
 lgnum AS wh_nr,
 created_by AS crtd_by,
 start_date AS start_dt,
 start_time AS start_tm,
 start_tstamp AS start_ts,
 end_date AS end_dt,
 end_time AS end_tm,
 end_tstamp AS end_ts,
 duration,
 unit_t AS tm_unit,
 who AS wh_ord_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_sapewm_pickingbreak_1;