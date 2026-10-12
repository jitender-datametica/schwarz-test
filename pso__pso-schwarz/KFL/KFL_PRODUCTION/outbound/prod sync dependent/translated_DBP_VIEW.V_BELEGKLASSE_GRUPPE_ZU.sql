CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belegklasse_gruppe_zu (system_id, mandant_id, belegklasse_id,
belegklasse_gruppe_id) AS SELECT system_id,
 mandant_id,
 belegklasse_id,
 belegklasse_gruppe_id
FROM kfl_production_dbp_data.belegklasse_gruppe_zu;