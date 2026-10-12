CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_art_1 (mandant_id, art_id, mwst_id, kl_art_id, wg_art_fg,
gtin_id, dat_von, dat_bis) AS SELECT mandant_id,
 TRUNC(CASE
   WHEN mandant_id = 1
   THEN art_id / 100
   ELSE art_id / 10
   END, 0) AS art_id,
 mwst_id,
 kl_art_id,
 wg_art_fg,
 gtin_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_art_1 AS V01;