CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_WE_ANLIEFERBEREICH(
	CLIENT_ID COMMENT 'Indicator of country',
	WH_ID COMMENT 'Warehouse number',
	WH_STAGING_AREA_CD COMMENT 'Warehouse area number',
	WH_STAGING_AREA_DESCR COMMENT 'Warehouse area description'
) AS
SELECT 
	sta.client_id
	,w.src_wh_id AS wh_id
	,sta.wh_staging_area_cd
	,sta.wh_staging_area_descr
FROM p_lew_core_ac.v_ref_warehouse_staging_area sta
INNER JOIN p_lew_bil_ac.v_warehouse w
ON sta.client_id = w.client_id
AND sta.wh_loc_sid = w.loc_sid_wh
AND w.dwh_actual_fg = 1
AND CURRENT_DATE BETWEEN w.dwh_valid_from AND w.dwh_valid_to
;