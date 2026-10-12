CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_vorgangsklasse_1 (system_id, mandant_id, vorgangsklasse_id) AS SELECT
 system_id,
 mandant_id,
 vorgangsklasse_id
FROM kfl_production_dbp_data.l_vorgangsklasse_1;