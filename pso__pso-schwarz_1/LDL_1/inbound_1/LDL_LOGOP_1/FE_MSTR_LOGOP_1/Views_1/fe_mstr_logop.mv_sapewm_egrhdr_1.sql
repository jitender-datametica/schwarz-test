/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_egrhdr_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM expected goods receipt header
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_egrhdr_1 (
	client_id COMMENT 'Client id - calculated based on the country_1 code'
	,lidl_ctry COMMENT 'Country_1 code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,doc_nr COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'
	,blocked_stat COMMENT 'Blocked (Overall Status_1) - Technical name: STATUS_BLOCKED_OVERALL - Component Type: /SCWM/SP_OVERALL_BLOCK_STATUS'
	,doc_type COMMENT 'Document Type - Technical name: DOCTYPE - Component Type: /SCDL/DL_DOCTYPE'
	,doc_type_desc COMMENT 'Document Type Description - Technical name: DOCTYPE_TXT - Component Type: /SCWM/SP_DOCTYPE_TXT'
	,ship_from_nr COMMENT 'Ship-from - Technical name: SHIP_FROM - Component Type: /SCWM/DE_SHIP_FROM'
	,plnd_dlv_dt COMMENT 'Delivery Date (Planned) - Technical name: TDELIVERY_DATE - Component Type: /SCWM/SP_DELDATE'
	,plnd_dlv_tm COMMENT 'Delivery Time (Planned) - Technical name: TDELIVERY_TIME - Component Type: /SCWM/SP_DELTIME'
	,crtd_on_dt COMMENT 'Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT'
	,crtd_at_tm COMMENT 'Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM'
	,crtd_by COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/SP_CREUSR'
	,lia_nr COMMENT 'LIA Number - Technical name: ZZ_EXREF - Component Type: ZEWM_E_EXREF'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,is_active_fg COMMENT 'Flag indicating active record'
) COMMENT = 'SAP EWM expected goods receipt header (materialized view based on table t_logop_sapewm_egrheader_1)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,doc_nr
	,blocked_status AS blocked_stat
	,doc_type
	,doc_type_desc
	,ship_from_nr
	,planned_dlv_dt AS plnd_dlv_dt
	,planned_dlv_tm AS plnd_dlv_tm
	,crtd_on_dt
	,crtd_at_tm
	,crtd_by
	,lia_nr
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,is_active_fg
FROM DATA.t_logop_sapewm_egrheader_1
;
