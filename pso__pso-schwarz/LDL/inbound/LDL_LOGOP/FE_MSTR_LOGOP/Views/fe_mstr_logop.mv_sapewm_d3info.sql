/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_d3info
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM D3 info
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_d3info (
	client_id COMMENT 'Client id - calculated based on the country code'
	,lidl_ctry COMMENT 'Country code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,freight_unit_id COMMENT 'Freight Unit ID - Technical name: FU_ID - Component Type: ZEWM_E_FUID'
	,pshu_id COMMENT 'Handling Unit Identification - Technical name: PSHUIDENT - Component Type: /SCWM/DE_HUIDENT'
	,hu_id COMMENT 'Handling Unit Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT'
	,tu_nr COMMENT 'Internal Number of Transportation Unit - Technical name: TU_NUM - Component Type: /SCWM/DE_TU_NUM'
	,act_area COMMENT 'Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_AAREA'
	,sub_act_area COMMENT 'cartonization: Sub Activity Area - Technical name: AAREA_SUB - Component Type: ZEWM_E_CAP_SUB_AAREA'
	,bus_partner_nr COMMENT 'Business Partner Number - Technical name: STORE - Component Type: /SCDL/DL_PARTYNO'
	,wave COMMENT 'Wave - Technical name: WAVE - Component Type: /SCWM/DE_WAVE'
	,guid_pshu_id COMMENT 'Unique Internal Identification of a Handling Unit - Technical name: GUID_PSHU - Component Type: /SCWM/GUID_HU'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
) COMMENT = 'SAP EWM D3 info (materialized view based on table t_logop_sapewm_d3info)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,freight_unit_id
	,pshu_id
	,hu_id
	,tu_nr
	,activity_area AS act_area
	,sub_activity_area AS sub_act_area
	,bus_partner_nr
	,wave
	,guid_pshu_id
	,dwh_load_id
	,dwh_created
	,dwh_updated
FROM DATA.t_logop_sapewm_d3info
;
