CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belegart_gruppe_zu AS SELECT system_id,
 mandant_id,
 belegart_gruppe_id,
 belegart_id
FROM kfl_production_dbp_data.belegart_gruppe_zu;