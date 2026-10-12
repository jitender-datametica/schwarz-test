CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_zaehl_auftrag_1 (art_id, mandant_id, wup_id, nb_id,
dat_auftrag, zaehl_grund_id, bezugsweg_id, zaehl_sort_id, dat_zaehl, zeit_zaehl, anz_gezaehlt, anz_zaehlauftrag) AS
SELECT AUFTRAG.art_id,
 AUFTRAG.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 AUFTRAG.nb_id,
 AUFTRAG.dat_auftrag,
 AUFTRAG.zaehl_grund_id,
 AUFTRAG.bezugsweg_id,
 AUFTRAG.zaehl_sort_id,
 AUFTRAG.dat_zaehl,
 AUFTRAG.zeit_zaehl,
 SUM(CASE
   WHEN AUFTRAG.dat_zaehl IS NOT NULL
   THEN 1
   ELSE 0
   END) AS anz_gezaehlt,
 COUNT(AUFTRAG.dat_auftrag) AS anz_zaehlauftrag
FROM kfl_production_dbp_data.vis_zaehl_auftrag_1 AS AUFTRAG
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON AUFTRAG.mandant_id = WUP.mandant_id AND AUFTRAG.wup_id = WUP.wup_id
GROUP BY AUFTRAG.art_id,
 AUFTRAG.mandant_id,
 wup_id,
 AUFTRAG.nb_id,
 AUFTRAG.dat_auftrag,
 AUFTRAG.zaehl_grund_id,
 AUFTRAG.bezugsweg_id,
 AUFTRAG.zaehl_sort_id,
 AUFTRAG.dat_zaehl,
 AUFTRAG.zeit_zaehl;