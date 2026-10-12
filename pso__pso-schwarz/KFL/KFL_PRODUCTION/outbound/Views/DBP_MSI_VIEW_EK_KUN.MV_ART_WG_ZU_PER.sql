CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_art_wg_zu_per (art_id, mandant_id, arthiertyp_id, wug_id,
wg_id, dat_von, dat_bis) AS SELECT art_id,
 mandant_id,
 arthiertyp_id,
 wug_id,
 wg_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.art_wg_zu_per AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';