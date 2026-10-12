CREATE OR REPLACE VIEW kfl_production_dbp_data_center.tv_artbew_wo_sum_1 (mandant_id, art_id, wup_id, kjwo, menge1,
umsatz_netto1) AS SELECT mandant_id,
 kl_art_id AS art_id,
 wup_id,
 kjwo,
 absatz AS menge1,
 umsatz_netto AS umsatz_netto1
FROM kfl_production_dbp_data_center.wasa_artbew_woche_1;