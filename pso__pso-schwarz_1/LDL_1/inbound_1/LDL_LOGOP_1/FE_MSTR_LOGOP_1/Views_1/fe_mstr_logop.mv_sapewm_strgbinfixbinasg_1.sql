/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_strgbinfixbinasg_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM storage bin fix bin assignment
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_strgbinfixbinasg_1 (
	client_id COMMENT 'Client id - calculated based on the country_1 code'
	,lidl_ctry COMMENT 'Country_1 code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,strg_bin COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'
	,strg_bin_assgn_type_flg COMMENT 'Storage Bin Assignment Type - Technical name: ASTYPE_BIN - Component Type: /SCWM/DE_FIXBIN_ASTYPE_B_MLTPL'
	,prod_nr COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'
	,prod_desc COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'
	,prod_asgmt_type COMMENT 'Product Assignment Type - Technical name: ASTYPE_PRODUCT - Component Type: /SCWM/DE_FIXBIN_ASTYPE_P_MLTPL'
	,party_entitled_dispose COMMENT 'Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED'
	,stock_in_fix_bin_flg COMMENT 'Stock in Fixed Storage Bin - Technical name: STOCK - Component Type: /SCWM/DE_FIXBIN_STOCK_FULL'
	,is_strg_bin_imprvbl COMMENT 'Storage Bin Improvable - Technical name: OUTCON - Component Type: /SCWM/DE_OUTCON'
	,strg_bin_imprvbl_chg_dt COMMENT 'Storage Bin Improvable Changed On - Technical name: DATOUT - Component Type: /SCWM/DE_DATOUT'
	,strg_type COMMENT 'Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP'
	,strg_sec COMMENT 'Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER'
	,strg_bin_empty_flg COMMENT 'Empty Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER'
	,crtd_by COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR'
	,crtd_on_dt COMMENT 'Creation Date of a Fixed Storage Bin - Technical name: CREATED_DATE - Component Type: /SCWM/DE_FIXBIN_CREATED_DATE'
	,crtd_at_tm COMMENT 'Fixed Storage Bin Creation Time - Technical name: CREATED_TIME - Component Type: /SCWM/DE_FIXBIN_CREATED_TIME'
	,ps_area COMMENT 'Production Supply Area(s) - Technical name: PSAS - Component Type: /SCWM/DE_PSAS'
	,campaign_flg COMMENT 'Campaign - Technical name: ZZ_CAMPAIGN - Component Type: ZEWM_E_E323_CAMPAIGN'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT = 'SAP EWM storage bin fix bin assignment (materialized view based on table t_logop_sapewm_storagebinfixbinasg_1)' 
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,strg_bin
	,strg_bin_assgn_type_flg
	,product_nr AS prod_nr
	,product_desc AS prod_desc
	,product_assgn_type AS prod_asgmt_type
	,party_entitled_dispose
	,stock_in_fix_bin_flg
	,is_strg_bin_imprvbl
	,strg_bin_imprvbl_change_dt AS strg_bin_imprvbl_chg_dt
	,strg_type
	,strg_sec
	,strg_bin_empty_flg
	,crtd_by
	,crtd_on_dt
	,crtd_at_tm
	,ps_area
	,campaign_flg
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_logop_sapewm_storagebinfixbinasg_1
;
