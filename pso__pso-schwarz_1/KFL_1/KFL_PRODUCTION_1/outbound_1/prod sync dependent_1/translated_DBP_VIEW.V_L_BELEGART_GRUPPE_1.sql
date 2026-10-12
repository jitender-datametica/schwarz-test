CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_belegart_gruppe_1 (system_id, mandant_id, belegart_gruppe_id) AS SELECT
 system_id,
 mandant_id,
 belegart_gruppe_id
FROM kfl_production_dbp_data.l_belegart_gruppe_1;