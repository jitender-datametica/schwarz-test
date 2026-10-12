/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_egritem
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM expected goods receipt item
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_egritem (
	client_id COMMENT 'Client id - calculated based on the country code'
	,lidl_ctry COMMENT 'Country code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,doc_nr COMMENT 'Document Number - Technical name: DOCNO - Component Type: /SCDL/DL_DOCNO_INT'
	,item_nr COMMENT 'Item Number - Technical name: ITEMNO - Component Type: /SCWM/DE_ITEMNO'
	,prod_nr COMMENT 'Product - Technical name: PRODUCTNO - Component Type: /SCDL/DL_PRODUCTNO'
	,stk_type COMMENT 'Stock Type - Technical name: STOCK_CATEGORY - Component Type: /SCDL/DL_STOCK_CATEGORY'
	,qty COMMENT 'Quantity - Technical name: QUANTITY - Component Type: /SCWM/DE_UI_QUAN'
	,uom COMMENT 'Unit of Measure - Technical name: UOM - Component Type: /SCDL/DL_UOM'
	,crtd_by COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/SP_CREUSR'
	,crtd_on_dt COMMENT 'Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT'
	,crtd_at_tm COMMENT 'Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM'
	,ref_code COMMENT 'Administrative Reference Code - Technical name: ZZ_ARC - Component Type: ZEWM_E_ARC'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,is_active_fg COMMENT 'Flag indicating active record'
) COMMENT = 'SAP EWM expected goods receipt item (materialized view based on table t_logop_sapewm_egritem)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,doc_nr
	,item_nr
	,product_nr AS prod_nr
	,stock_type AS stk_type
	,quantity AS qty
	,uom
	,crtd_by
	,crtd_on_dt
	,crtd_at_tm
	,ref_code
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,is_active_fg
FROM DATA.t_logop_sapewm_egritem
;
