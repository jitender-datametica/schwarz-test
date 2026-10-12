CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ods_bon_storno (bon_id, bon_dat, mandant_id, wup_id, bon_nr,
kasse_nr, datei_name) AS SELECT v01.bon_id,
 v01.bon_dat,
 v01.mandant_id,
 v02.aktuell_wup_id AS wup_id,
 v01.bon_nr,
 v01.kasse_nr,
 v01.datei_name
FROM kfl_production_clone_aad_dbp_v_ods.v_ods_bon_storno AS v01
 INNER JOIN kfl_production_dbp_view.v_wup AS v02 ON v01.wup_id = v02.wup_id AND v01.mandant_id = v02.mandant_id;