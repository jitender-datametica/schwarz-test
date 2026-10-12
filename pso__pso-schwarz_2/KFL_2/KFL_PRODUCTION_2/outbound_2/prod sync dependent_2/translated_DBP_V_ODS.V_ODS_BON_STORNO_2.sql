CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_bon_storno_2 (bon_id, bon_dat, mandant_id, wup_id, bon_nr, kasse_nr
, datei_name, td_insert, td_update) AS SELECT bon_id,
 bon_dat,
 mandant_id,
 wup_id,
 bon_nr,
 kasse_nr,
 datei_name,
 td_insert,
 td_update
FROM kfl_production_dbp_ods.ods_bon_storno_2;