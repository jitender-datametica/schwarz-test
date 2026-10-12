/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_strgbinphystk
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM storage bin physical stock
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_strgbinphystk (
	client_id COMMENT 'Client id - calculated based on the country code'
	,lidl_ctry COMMENT 'Country code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,log_pos COMMENT 'Logical Position of Handling Unit - Technical name: LOGPOS - Component Type: /SCWM/DE_LOGPOS'
	,hu_ident COMMENT 'Handling Unit Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT'
	,prod_nr COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'
	,prod_desc COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'
	,qty COMMENT 'Quantity - Technical name: QUAN - Component Type: /SCWM/DE_UI_QUAN'
	,buom COMMENT 'Base Unit of Measure - Technical name: UNIT - Component Type: /SCWM/DE_BASE_UOM'
	,packed_qnty_auom COMMENT 'Packed Quantity in Alternative Unit of Measure - Technical name: QUANA - Component Type: /SCWM/DE_UI_QUAN_PACKED'
	,stock_type COMMENT 'Stock Type - Technical name: CAT - Component Type: /SCWM/DE_CAT'
	,batch COMMENT 'Batch - Technical name: CHARG - Component Type: /SCWM/DE_CHARG'
	,shelf_life_exp_date COMMENT 'Shelf Life Expiration Date - Technical name: VFDAT - Component Type: /SCWM/SLED'
	,gr_dt COMMENT 'Goods Receipt Date - Technical name: UI_WDATU - Component Type: /SCWM/DE_UI_WDATU'
	,gr_tm COMMENT 'Goods Receipt Time - Technical name: UI_WDATT - Component Type: /SCWM/DE_UI_WDATT'
	,doc_cat_doc_ref COMMENT 'Doc. Category for Doc. Reference and Doc.-Related Stocks - Technical name: DOCCAT - Component Type: /SCWM/DE_DOCCAT'
	,doc_nr COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'
	,strg_bin COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'
	,auom COMMENT 'Alternative Unit of Measure for Stockkeeping Unit - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT = 'SAP EWM storage bin physical stock (materialized view based on table t_logop_sapewm_storagebinphystk)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,log_pos
	,hu_ident
	,product_nr AS prod_nr
	,product_desc AS prod_desc
	,quantity AS qty
	,buom
	,packed_qnty_auom
	,stock_type
	,batch
	,shelf_life_exp_date
	,gr_dt
	,gr_tm
	,doc_cat_doc_ref
	,doc_nr
	,strg_bin
	,auom
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_logop_sapewm_storagebinphystk
;
