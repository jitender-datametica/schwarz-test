CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hyg_thema_gruppen_zu_2 AS SELECT FK.frage_katalog_id,
 TGZ.hyg_thema_gruppe_mutter_id,
 TGZ.hyg_thema_gruppe_id,
 TGZ.gj,
 TGZ.hyg_thema_id
FROM kfl_production_dbp_msi_view_vis.ts_hyg_thema_gruppen_zu_2 AS TGZ
 INNER JOIN kfl_production_dbp_view.v_hyg_frage_katalog_2 AS FK ON TGZ.gj = FK.gj;