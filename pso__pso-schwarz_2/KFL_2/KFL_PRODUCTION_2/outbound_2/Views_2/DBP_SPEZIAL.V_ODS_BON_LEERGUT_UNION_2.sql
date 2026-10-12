CREATE OR REPLACE VIEW kfl_production_dbp_spezial.v_ods_bon_leergut_union_2 (bon_id, bon_zeile, ean_kasse, umsatz_brutto,
mandant_id, wup_id, start_bon_zeile, bon_nr_extern, bon_dat) AS SELECT bon_id,
 bon_zeile,
 ean_kasse,
 umsatz_brutto,
 mandant_id,
 wup_id,
 start_bon_zeile,
 bon_nr_extern,
 bon_dat
FROM kfl_production_dbp_ods.ods_bon_leergut_2
UNION ALL
SELECT bon_id,
 bon_zeile,
 ean_kasse,
 umsatz_brutto,
 mandant_id,
 wup_id,
 start_bon_zeile,
 bon_nr_extern,
 bon_dat
FROM kfl_production_dbp_ods_archiv.ods_bon_leergut_2;