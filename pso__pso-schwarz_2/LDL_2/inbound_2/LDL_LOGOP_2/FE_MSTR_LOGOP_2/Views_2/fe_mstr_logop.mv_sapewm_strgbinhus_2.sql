/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_strgbinhus_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM storage bin handling units
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_strgbinhus_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,hu_ident COMMENT 'Handling Unit_2 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT'
	,act_area COMMENT 'Activity Area - Technical name: ZZ_AAREA - Component Type: /SCWM/DE_AAREA'
	,sub_act_area COMMENT 'cartonization: Sub Activity Area - Technical name: ZZCAP_SUB_AAREA - Component Type: ZEWM_E_CAP_SUB_AAREA'
	,hu_type COMMENT 'Handling Unit_2 Type - Technical name: LETYP - Component Type: /SCWM/DE_HUTYP'
	,zz_hu_type COMMENT 'Handling Unit_2 Type - Technical name: ZZ_HUTYP_ORG - Component Type: /SCWM/DE_HUTYP'
	,crtd_by COMMENT 'User Name - Technical name: CREATED_BY - Component Type: UNAME'
	,crtd_on_dt COMMENT 'Created On - Technical name: CREATED_DATE - Component Type: /SCWM/DE_CREATED_DATE'
	,crtd_at_tm COMMENT 'Created At - Technical name: CREATED_TIME - Component Type: /SCWM/DE_CREATED_TIME'
	,chg_on_dt COMMENT 'Changed On - Technical name: CHANGED_DATE - Component Type: /SCWM/DE_CHANGED_DATE'
	,chg_at_tm COMMENT 'Changed At - Technical name: CHANGED_TIME - Component Type: /SCWM/DE_CHANGED_TIME'
	,hu_weight COMMENT 'Total Weight of Handling Unit_2 - Technical name: G_WEIGHT - Component Type: /SCWM/BRGEW'
	,weight_unit COMMENT 'Weight Unit_2 - Technical name: UNIT_GW - Component Type: /SCWM/DE_WGT_UOM'
	,capa COMMENT 'Total Capacity Key Figure - Technical name: G_CAPA - Component Type: /SCWM/DE_GCAPA'
	,vol_unit COMMENT 'Volume Unit_2 - Technical name: UNIT_GV - Component Type: /SCWM/DE_VOL_UOM'
	,sale_flg COMMENT 'Special Sale Flag - Technical name: ZZ_NF_SPEC_SALE_HU - Component Type: ZEWM_E_NF_SPEC_SALE_HU'
	,cat COMMENT 'Category - Technical name: ZZ_CATEGORY - Component Type: ZEWM_E_NF_CAT'
	,open_hu_wt_flg COMMENT 'Indicator: Handling Unit_2 is Being Moved (Open HU WT) - Technical name: FLGMOVE - Component Type: /SCWM/FLGMOVE'
	,pack_mat COMMENT 'Packaging Material - Technical name: PMAT - Component Type: /SCWM/DE_PMAT'
	,strg_bin COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'
	,sorted_non_food_flg COMMENT 'Sorted Non-Food Flag - Technical name: ZZ_HU_SORTED - Component Type: ZEWM_E_HU_SORTED'
	,pair_bracket COMMENT 'Pair Bracket - Technical name: ZZ_PAIR_BRACK - Component Type: ZEWM_E_PAIR_BRACK'
	,sys_pal COMMENT 'System Pallet - Technical name: ZZ_SYS_PAL - Component Type: ZEWM_E_SYS_PAL'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT = 'SAP EWM storage bin handling units (materialized view based on table t_logop_sapewm_storagebinhus_2)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,hu_ident
	,activity_area AS act_area
	,sub_activity_area AS sub_act_area
	,hu_type
	,zz_hu_type
	,crtd_by
	,crtd_on_dt
	,crtd_at_tm
	,changed_on_dt AS chg_on_dt
	,changed_at_tm AS chg_at_tm
	,hu_weight
	,weight_unit
	,capa
	,vol_unit
	,sale_flg
	,category AS cat
	,open_hu_wt_flg
	,pack_mat
	,strg_bin
	,sorted_non_food_flg
	,pair_bracket
	,sys_pal
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_logop_sapewm_storagebinhus_2
;
