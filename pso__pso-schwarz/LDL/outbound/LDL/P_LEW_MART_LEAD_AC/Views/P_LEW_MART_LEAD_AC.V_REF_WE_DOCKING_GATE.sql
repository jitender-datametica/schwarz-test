CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_we_docking_gate (client_id
OPTIONS(description='Indicator of country'), wh_id OPTIONS(description='Warehouse number'), wh_docking_gate_nr
OPTIONS(description='Tor'), wh_staging_area_cd OPTIONS(description='Warehouse area number - Anlieferbereich')) AS SELECT
 *
FROM ldl_p_lew_mart_lead.v_ref_we_docking_gate;