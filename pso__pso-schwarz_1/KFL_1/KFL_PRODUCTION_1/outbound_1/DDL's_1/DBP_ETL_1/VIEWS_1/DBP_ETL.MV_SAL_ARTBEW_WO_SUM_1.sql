CREATE OR REPLACE VIEW kfl_production_dbp_etl.mv_sal_artbew_wo_sum_1 (kjwo, art_id, wg_id, bewart_id, mandant_id, wup_id,
nb_id, ek_mep_umsatz, umsatz_netto, vk_menge) AS SELECT kjwo,
 art_id,
 wg_id,
 bewart_id,
 mandant_id,
 wup_id,
 nb_id,
 CAST(ek_mep AS FLOAT64) AS ek_mep_umsatz,
 CAST(umsatz_netto AS FLOAT64) AS umsatz_netto,
 CAST(menge AS FLOAT64) AS vk_menge
FROM kfl_production_dbp_etl.sal_artbew_wg_art_wo_sum_1
WHERE mandant_id = 1;