CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_belegklasse_gruppe_spr_zu_1 (system_id, mandant_id, spr_id,
belegklasse_gruppe_id, belegklasse_gruppe_bez) AS SELECT 7 AS system_id,
 mandant_id,
 spr_id,
 belegklasse_gruppe_id,
 belegklasse_gruppe_bez
FROM kfl_production_dbp_view.v_belegklasse_gruppe_spr_zu_1
WHERE spr_id = 22
 AND mandant_id = 1;