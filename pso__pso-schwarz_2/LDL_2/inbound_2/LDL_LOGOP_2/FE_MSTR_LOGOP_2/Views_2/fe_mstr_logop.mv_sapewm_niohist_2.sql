/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_niohist_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM NIO history
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_niohist_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,hu_ident COMMENT 'Handling Unit_2 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT'
	,log_seq COMMENT 'Log Sequence - Technical name: LOG_SEQ - Component Type: /SCWM/DE_LOG_SEQ'
	,com_point COMMENT 'Communication_2 Point for Conveyor Technique - Technical name: CP - Component Type: /SCWM/DE_MFSCP'
	,hu_stat COMMENT 'Object Status_2 - Technical name: HU_STATUS - Component Type: CRM_J_STATUS'
	,crtd_on_dt COMMENT 'Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT'
	,crtd_at_tm COMMENT 'Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM'
	,hu_stat_short COMMENT 'Individual status_2 of an object (short form) - Technical name: HU_STATUS_SHORT - Component Type: J_TXT04'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM NIO history (materialized view based on table t_logop_sapewm_niohistory_2)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,hu_ident
	,log_seq
	,com_point
	,hu_status AS hu_stat
	,crtd_on_dt
	,crtd_at_tm
	,hu_status_short AS hu_stat_short
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM DATA.t_logop_sapewm_niohistory_2
;
