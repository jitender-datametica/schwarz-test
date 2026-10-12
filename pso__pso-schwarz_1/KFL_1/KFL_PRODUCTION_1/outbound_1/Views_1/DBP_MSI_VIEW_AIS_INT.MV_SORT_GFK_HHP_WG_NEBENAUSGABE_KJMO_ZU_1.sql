CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_gfk_hhp_wg_nebenausgabe_kjmo_zu_1 (mandant_id,
gfk_account_id, gfk_wg_id, kjmo, wrg_id, nebenausgaben_anteil, nebenausgaben_tsd_eur, nebenausgaben_index) AS SELECT V01
 .mandant_id,
 V01.gfk_account_id,
 V01.gfk_wg_id,
 V01.kjmo,
 V01.wrg_id,
 V01.nebenausgaben_anteil,
 V01.nebenausgaben_tsd_eur,
 V01.nebenausgaben_index
FROM kfl_production_dbp_data.gfk_hhp_wg_account_na_kjmo_zu_1 AS V01
 INNER JOIN kfl_production_dbp_data.monat_1 AS V02 ON V01.kjmo = V02.kjmo
WHERE V02.akt_mo BETWEEN - 36 AND 0
 AND (V01.mandant_id IN (1, 5, 6, 8) AND V01.wrg_id = 'EUR' OR V01.mandant_id = 2 AND V01.wrg_id = 'CZK' OR V01.mandant_id
       = 3 AND V01.wrg_id = 'PLN' OR V01.mandant_id = 7 AND V01.wrg_id = 'RON');