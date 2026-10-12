CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_WE_DOCKING_GATE(
	CLIENT_ID COMMENT 'Indicator of country',
	WH_ID COMMENT 'Warehouse number',
	WH_DOCKING_GATE_NR COMMENT 'Tor',
	WH_STAGING_AREA_CD COMMENT 'Warehouse area number - Anlieferbereich'
) AS
SELECT 
    gate.client_id
    ,wh.src_wh_id AS wh_id
    ,gate.wh_docking_gate_nr
    ,gate.wh_staging_area_cd
FROM p_lew_core_ac.v_ref_warehouse_docking_gate gate
INNER JOIN  p_lew_bil.v_warehouse wh
ON gate.client_id = wh.client_id
AND gate.wh_loc_sid = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
UNION 
SELECT
   gate.client_id
    ,wh.src_wh_id AS wh_id
    ,-1 AS wh_docking_gate_nr
    ,'-1' AS wh_staging_area_cd
FROM p_lew_core_ac.v_ref_warehouse_docking_gate gate
INNER JOIN p_lew_bil.v_warehouse wh
ON gate.client_id = wh.client_id
AND gate.wh_loc_sid = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
;