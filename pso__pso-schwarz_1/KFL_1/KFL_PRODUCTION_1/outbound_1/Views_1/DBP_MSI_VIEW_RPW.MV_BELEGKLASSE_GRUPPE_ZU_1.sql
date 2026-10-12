CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_belegklasse_gruppe_zu_1 (system_id, mandant_id, belegklasse_id,
belegklasse_gruppe_id) AS SELECT 7 AS system_id,
 mandant_id,
 belegklasse_id,
 belegklasse_gruppe_id
FROM kfl_production_dbp_view.v_belegklasse_gruppe_zu_1
WHERE mandant_id = 1;