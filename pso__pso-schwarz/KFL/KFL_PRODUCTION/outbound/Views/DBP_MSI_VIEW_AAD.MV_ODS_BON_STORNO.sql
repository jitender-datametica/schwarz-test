CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ods_bon_storno (bon_id, bon_dat, mandant_id, wup_id, bon_nr,
kasse_nr, datei_name) AS SELECT V01.bon_id,
 V01.bon_dat,
 V01.mandant_id,
 V02.aktuell_wup_id AS wup_id,
 V01.bon_nr,
 V01.kasse_nr,
 V01.datei_name
FROM kfl_production_dbp_v_ods.v_ods_bon_storno AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id;