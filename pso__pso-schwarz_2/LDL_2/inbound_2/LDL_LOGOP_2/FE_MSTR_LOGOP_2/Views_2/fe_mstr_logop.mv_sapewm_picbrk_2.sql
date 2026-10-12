/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_picbrk_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM picking break
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_picbrk_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,crtd_by COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATED_BY'
	,start_dt COMMENT 'Start Date - Technical name: START_DATE - Component Type: /SCWM/DE_STARTED_DATE'
	,start_tm COMMENT 'Start Time - Technical name: START_TIME - Component Type: /SCWM/DE_STARTED_TIME'
	,end_dt COMMENT 'End Date - Technical name: END_DATE - Component Type: /SCWM/DE_ENDED_DATE'
	,end_tm COMMENT 'End Time - Technical name: END_TIME - Component Type: /SCWM/DE_ENDED_TIME'
	,wh_ord_nr COMMENT 'Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM picking break (materialized view based on table t_logop_sapewm_picbrk_2)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,crtd_by
	,start_dt
	,start_tm
	,end_dt
	,end_tm
	,who_nr AS wh_ord_nr
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM DATA.t_logop_sapewm_picbrk_2
;
