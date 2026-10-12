CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbnk_gruppe_zu_1 (system_id, mandant_id, wbnk_id, wbnk_gruppe_id) AS
SELECT system_id,
 mandant_id,
 wbnk_id,
 wbnk_gruppe_id
FROM kfl_production_dbp_data.wbnk_gruppe_zu_1;