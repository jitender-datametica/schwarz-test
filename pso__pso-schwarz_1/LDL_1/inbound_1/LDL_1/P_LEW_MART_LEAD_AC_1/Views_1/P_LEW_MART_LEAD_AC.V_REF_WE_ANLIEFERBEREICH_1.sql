CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_WE_ANLIEFERBEREICH_1(
	CLIENT_ID COMMENT 'Indicator of country_1',
	WH_ID COMMENT 'Warehouse number',
	WH_STAGING_AREA_CD COMMENT 'Warehouse area number',
	WH_STAGING_AREA_DESCR COMMENT 'Warehouse area description'
) AS
SELECT 
	client_id
	,wh_id
	,wh_staging_area_cd
	,wh_staging_area_descr
FROM p_lew_mart_lead.v_ref_we_anlieferbereich_1
UNION
SELECT 
	client_id
	,wh_id
	,'-1' AS wh_staging_area_cd
	,'Manuelle WE' AS wh_staging_area_descr
FROM p_lew_mart_lead.v_ref_we_anlieferbereich_1
;