CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_WE_DOCKING_GATE_2(
	CLIENT_ID COMMENT 'Indicator of country_2',
	WH_ID COMMENT 'Warehouse number',
	WH_DOCKING_GATE_NR COMMENT 'Tor',
	WH_STAGING_AREA_CD COMMENT 'Warehouse area number - Anlieferbereich'
) AS 
SELECT 
    client_id
    ,wh_id
    ,wh_docking_gate_nr
    ,wh_staging_area_cd
FROM p_lew_mart_lead.v_ref_we_docking_gate_2
;