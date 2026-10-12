/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_phyinvdoc_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM pyhsical inventory document
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_phyinvdoc_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,doc_nr COMMENT 'Number of Physical Inventory Document - Technical name: DOC_NUMBER - Component Type: /SCWM/DE_PI_DOC_NUMBER'
	,item_nr COMMENT 'Item_2 - Technical name: ITEM_NO - Component Type: /LIME/LINE_ITEM_ID'
	,doc_year COMMENT 'Document Year of Physical Inventory Document - Technical name: DOC_YEAR - Component Type: /LIME/PI_DOC_YEAR'
	,doc_type COMMENT 'Physical Inventory Procedure (Document Type of Phys. Inv.) - Technical name: DOC_TYPE - Component Type: /LIME/PI_DOCUMENT_TYPE'
	,doc_status COMMENT 'Physical Inventory Status_2 - Technical name: DOC_STATUS - Component Type: /LIME/PI_STATUS'
	,act_area COMMENT 'Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_AAREA'
	,reason COMMENT 'Reason - Technical name: REASON - Component Type: /SCWM/PI_REASON'
	,reason_desc COMMENT 'Reason Description - Technical name: REASON_TXT - Component Type: /SCWM/DE_REASON_TXT'
	,prio COMMENT 'Priority - Technical name: PRIORITY - Component Type: /SCWM/PI_PRIORITY'
	,prio_desc COMMENT 'Priority Description - Technical name: PRIORITY_TXT - Component Type: /SCWM/PI_PRIORITY_TXT'
	,crtd_on_dt COMMENT 'Created On - Technical name: CREATE_DATE - Component Type: /SCWM/DE_CREATED_DATE'
	,crtd_at_tm COMMENT 'Created At - Technical name: CREATE_TIME - Component Type: /SCWM/DE_CREATED_TIME'
	,crtd_by COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR'
	,act_dt COMMENT 'Activation Date - Technical name: ACTI_DATE - Component Type: /SCWM/DE_ACTI_DATE'
	,act_tm COMMENT 'Activation Time - Technical name: ACTI_TIME - Component Type: /SCWM/DE_ACTI_TIME'
	,cnt_dt COMMENT 'Count Date - Technical name: COUNT_DATE - Component Type: /SCWM/DE_COUNT_DATE'
	,cnt_tm COMMENT 'Count Time - Technical name: COUNT_TIME - Component Type: /SCWM/DE_COUNT_TIME'
	,cnt_user COMMENT 'Name of Counter - Technical name: COUNT_USER - Component Type: /SCWM/PI_DE_UI_COUNT_USER'
	,post_dt COMMENT 'Posting Date - Technical name: POST_DATE - Component Type: /SCWM/DE_POSTED_DATE'
	,post_tm COMMENT 'Time of Posting - Technical name: POST_TIME - Component Type: /SCWM/DE_POSTED_TIME'
	,last_changed_by COMMENT 'Changed By - Technical name: LAST_CHANGED_BY - Component Type: /SCWM/DE_CHANGED_BY'
	,strg_bin_empty COMMENT 'Storage Bin Empty - Technical name: IND_BIN_EMPTY - Component Type: /SCWM/DE_IND_BIN_EMPTY'
	,strg_type COMMENT 'Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP'
	,strg_sec COMMENT 'Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER'
	,strg_bin COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'
	,prod_nr COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'
	,prod_desc COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'
	,batch COMMENT 'Batch - Technical name: CHARG - Component Type: /SCWM/DE_CHARG'
	,stk_type COMMENT 'Stock Type - Technical name: CAT - Component Type: /SCWM/DE_CAT'
	,stk_type_desc COMMENT 'Description of Stock Type - Technical name: CAT_TEXT - Component Type: /SCWM/DE_UI_CAT_TEXT'
	,party_entitled_dispose COMMENT 'Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED'
	,partner_role_party_entitled_dispose COMMENT 'Partner Role of Party Entitled to Dispose - Technical name: ENTITLED_ROLE - Component Type: /SCWM/DE_ENTITLED_ROLE'
	,gr_dt COMMENT 'Goods Receipt Date - Technical name: WDATU - Component Type: /SCWM/DE_WDATU'
	,ui_gr_dt COMMENT 'Goods Receipt Date - Technical name: UI_WDATU - Component Type: /SCWM/DE_UI_WDATU'
	,ui_gr_tm COMMENT 'Goods Receipt Time - Technical name: UI_WDATT - Component Type: /SCWM/DE_UI_WDATT'
	,shelf_life_exp_dt COMMENT 'Shelf Life Expiration Date - Technical name: VFDAT - Component Type: /SCWM/SLED'
	,who_nr COMMENT 'Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO'
	,qty_book COMMENT 'Book Inventory Balance Quantity (Physical Inventory) - Technical name: QUAN_BOOK - Component Type: /SCWM/DE_QUAN_BOOK'
	,qty_count COMMENT 'Counted Quantity (Physical Inventory) - Technical name: QUAN_COUNT - Component Type: /SCWM/DE_QUAN_COUNT'
	,qty_diff COMMENT 'Difference Quantity - Technical name: QUAN_DIFF - Component Type: /SCWM/DE_UI_QUAN_DIFF'
	,qty_diff_abs COMMENT 'Absolute Difference Quantity - Technical name: QUAN_DIFF_ABS - Component Type: /SCWM/DE_QUAN_DIFF_ABS'
	,buom COMMENT 'Base Unit_2 of Measure - Technical name: UNIT_2 - Component Type: /SCWM/DE_BASE_UOM'
	,value_diff COMMENT 'Difference Value - Technical name: VALUE_DIFF - Component Type: /SCWM/DE_VALUE_DIFF'
	,value_diff_abs COMMENT 'Absolute Difference Value - Technical name: VALUE_DIFF_ABS - Component Type: /SCWM/DE_VALUE_DIFF_ABS'
	,curr_key COMMENT 'Currency Key - Technical name: WAERS - Component Type: WAERS'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM pyhsical inventory document (materialized view based on table t_logop_sapewm_pidocument_2)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,doc_nr
	,item_nr
	,doc_year
	,doc_type
	,doc_status
	,activity_area AS act_area
	,reason
	,reason_desc
	,prio
	,prio_desc
	,crtd_on_dt
	,crtd_at_tm
	,crtd_by
	,activ_dt AS act_dt
	,activ_tm AS act_tm
	,cnt_dt
	,cnt_tm
	,cnt_user
	,post_dt
	,post_tm
	,last_changed_by
	,strg_bin_empty
	,strg_type
	,strg_sec
	,strg_bin
	,product_nr AS prod_nr
	,product_desc AS prod_desc
	,batch
	,stock_type AS stk_type
	,stock_type_desc AS stk_type_desc
	,party_entitled_dispose
	,partner_role_party_entitled_dispose
	,gr_dt
	,ui_gr_dt
	,ui_gr_tm
	,shelf_life_exp_dt
	,who_nr
	,quan_book AS qty_book
	,quan_count AS qty_count
	,quan_diff AS qty_diff
	,quan_diff_abs AS qty_diff_abs
	,buom
	,value_diff
	,value_diff_abs
	,curr_key
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM DATA.t_logop_sapewm_pidocument_2
;
