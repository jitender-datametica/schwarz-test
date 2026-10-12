CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_ods_ods_bon_storno_1 (bon_id, bon_dat, mandant_id, wup_id,
bon_nr, kasse_nr, datei_name, td_insert, td_update) AS SELECT bon_id,
 bon_dat,
 mandant_id,
 wup_id,
 bon_nr,
 kasse_nr,
 datei_name,
 td_insert,
 td_update
FROM kfl_production_dbp_ods.ods_bon_storno_1;