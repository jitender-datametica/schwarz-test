CREATE OR REPLACE VIEW kfl_production_dbp_spezial.v_ods_bon_storno_union (bon_id, bon_dat, mandant_id, wup_id, bon_nr,
kasse_nr, datei_name) AS SELECT bon_id,
 bon_dat,
 mandant_id,
 wup_id,
 bon_nr,
 kasse_nr,
 datei_name
FROM kfl_production_dbp_ods.ods_bon_storno
UNION ALL
SELECT bon_id,
 bon_dat,
 mandant_id,
 wup_id,
 bon_nr,
 kasse_nr,
 datei_name
FROM kfl_production_dbp_ods_archiv.ods_bon_storno;