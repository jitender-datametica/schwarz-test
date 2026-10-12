CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_we_docking_gate_1 (client_id OPTIONS(description='Indicator of country_1'),
wh_id OPTIONS(description='Warehouse number'), wh_docking_gate_nr OPTIONS(description='Tor'), wh_staging_area_cd
OPTIONS(description='Warehouse area number - Anlieferbereich')) AS SELECT GATE.client_id,
 WH.src_wh_id AS wh_id,
 GATE.wh_docking_gate_nr,
 GATE.wh_staging_area_cd
FROM ldl_p_lew_core_ac.v_ref_warehouse_docking_gate_1 AS GATE
 INNER JOIN ldl_p_lew_bil.v_warehouse_1 AS WH ON GATE.client_id = WH.client_id AND GATE.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
UNION DISTINCT
SELECT GATE.client_id,
 WH.src_wh_id AS wh_id,
 - 1 AS wh_docking_gate_nr,
 '-1' AS wh_staging_area_cd
FROM ldl_p_lew_core_ac.v_ref_warehouse_docking_gate_1 AS GATE
 INNER JOIN ldl_p_lew_bil.v_warehouse_1 AS WH ON GATE.client_id = WH.client_id AND GATE.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1;