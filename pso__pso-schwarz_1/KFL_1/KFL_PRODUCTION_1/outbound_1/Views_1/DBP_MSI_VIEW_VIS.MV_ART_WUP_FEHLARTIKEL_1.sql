CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_wup_fehlartikel_1 (mandant_id, art_id, wup_id, nb_id,
dat_letzter_we, dat_letzter_umsatz, fehlartikel_kz) AS SELECT AWF.mandant_id,
 AWF.art_id,
 WUP.aktuell_wup_id AS wup_id,
 AWF.nb_id,
 AWF.dat_letzter_we,
 AWF.dat_letzter_umsatz,
 AWF.fehlartikel_kz
FROM kfl_production_dbp_view.v_art_wup_fehlartikel_1 AS AWF
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON AWF.mandant_id = WUP.mandant_id AND AWF.wup_id = WUP.wup_id;