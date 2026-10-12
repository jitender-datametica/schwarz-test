CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_art_1 (mandant_id, in_art_id, in_art_nr, basismenge_einh_id
, artikelart_id, best_menge_einh_id, einkaeufer_int_id, in_wg_id, status_kz) AS SELECT mandant_id,
 in_art_id,
 in_art_nr,
 basismenge_einh_id,
 artikelart_id,
 best_menge_einh_id,
 einkaeufer_bis_int_id AS einkaeufer_int_id,
 in_wg_id,
 status_kz
FROM kfl_production_dbp_view.v_in_art_1 AS V01
WHERE artikelart_id IN ('ZSAK', 'ZSDI', 'ZSKO', 'ZSWG')
 OR SUBSTR(in_art_nr, 1, 1) = 'W'
 OR in_art_id = - 1;