CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_belegklasse_gruppe_2 (belegklasse_gruppe_id, mandant_id, system_id) AS
SELECT belegklasse_gruppe_id,
 mandant_id,
 system_id
FROM kfl_production_dbp_data.l_belegklasse_gruppe_2;