-- 15.06.2023 snik: SPEC0200542 Lookup Artikel
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_art (mandant_id
, art_id, mwst_id, kl_art_id, wg_art_fg, gtin_id, dat_von, dat_bis) AS SELECT mandant_id,
 art_id,
 mwst_id,
 kl_art_id,
 wg_art_fg,
 gtin_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_art AS v01;