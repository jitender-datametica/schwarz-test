CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_woche_wup_ereignis_zu_1 (mandant_id, art_id, kjwo, wup_id,
nb_id, ereignis_id, ereignistyp_id) AS SELECT EZ.mandant_id,
 EZ.art_id,
 EZ.kjwo,
 WUP.aktuell_wup_id AS wup_id,
 EZ.nb_id,
 EZ.ereignis_id,
 EZ.ereignistyp_id
FROM kfl_production_dbp_view.v_art_woche_wup_ereignis_zu_1 AS EZ
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON EZ.mandant_id = WUP.mandant_id AND EZ.wup_id = WUP.wup_id;