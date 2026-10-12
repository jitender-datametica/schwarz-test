/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_missingitem_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM missing item_2
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_missingitem_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,item_nr COMMENT 'Missing item_2 number - Technical name: ZZ_MI_NO - Component Type: ZEWM_E_MI_NO'
	,item_stat_desc COMMENT 'Description of missing article status_2 - Technical name: ZZ_MI_STATUS_T - Component Type: ZEWM_E_MI_STATUS_T'
	,prod_nr COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'
	,item_desc COMMENT 'Description - Technical name: PRODUCT_TEXT - Component Type: /SCDL/DL_TEXT'
	,party_entitled_dispose COMMENT 'Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED'
	,item_stat COMMENT 'Missing item_2 status_2 - Technical name: ZZ_MI_STATUS - Component Type: ZEWM_E_MI_STATUS'
	,crtd_on_dt COMMENT 'Date on which record was created - Technical name: ZZERDAT - Component Type: ZEWM_E_MI_ERDAT'
	,crtd_at_tm COMMENT 'Entry Time - Technical name: ZZERZET - Component Type: ZEWM_E_MI_ERZET'
	,chg_on_dt COMMENT 'Changed On - Technical name: ZZAEDAT - Component Type: ZEWM_E_MI_AEDAT'
	,chg_at_tm COMMENT 'Time last change was made - Technical name: ZZAEZET - Component Type: ZEWM_E_MI_AEZET'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM missing item_2 (materialized view based on table t_logop_sapewm_missingitems_2)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,item_nr
	,item_status_desc AS item_stat_desc
	,product_nr AS prod_nr
	,item_desc
	,party_entitled_dispose
	,item_status AS item_stat
	,crtd_on_dt
	,crtd_at_tm
	,changed_on_dt AS chg_on_dt
	,changed_at_tm AS chg_at_tm
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM DATA.t_logop_sapewm_missingitems_2
;
