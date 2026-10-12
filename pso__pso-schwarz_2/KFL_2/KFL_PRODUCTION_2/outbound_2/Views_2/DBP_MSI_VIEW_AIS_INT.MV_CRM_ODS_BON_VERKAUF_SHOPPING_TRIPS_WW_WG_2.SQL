CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_crm_ods_bon_verkauf_shopping_trips_ww_wg_2 (anz_shopping_trips_wg
, wg_id, mandant_id, bon_dat, kjwo_ww) AS SELECT SUM(anz_shopping_trips_wg) AS anz_shopping_trips_wg,
 wg_id,
 mandant_id,
 bon_dat,
 kjwo_ww
FROM (SELECT V02.wg_id,
   V01.mandant_id,
   V01.bon_dat,
   V04.kjwo_ww,
   COUNT(V02.wg_id) OVER (PARTITION BY V01.mandant_id, V01.bon_id, CAST(V02.wg_id AS STRING), V01.bon_dat RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_shopping_trips_wg
  FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS V01
   INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_verkauf_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.bon_dat = V02
       .bon_dat AND V01.bon_id = V02.bon_id AND V01.wup_id = V02.wup_id
   LEFT JOIN kfl_production_dbp_data.bewart_det_ecommerce_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.kundenkarte_id
      = V03.kundenkarte_id
   LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl_2 AS V04 ON V01.bon_dat = V04.dat AND V01.mandant_id = V04.mandant_id
     
   INNER JOIN kfl_production_dbp_view.v_art_2 AS V05 ON V02.kl_art_id = V05.kl_art_id AND V02.mandant_id = V05.mandant_id
  WHERE V01.turnover_fg = 1
   AND V01.kasse_typ_id <> 5
   AND V01.umsatz_brutto > 0
   AND (V01.mandant_id IN (1, 4, 6) OR V01.mandant_id IN (2, 5, 7, 8) AND CAST(V01.kassierer_nr AS INTEGER) NOT BETWEEN
        800 AND 900 OR V01.mandant_id = 3 AND CAST(V01.kassierer_nr AS INTEGER) NOT BETWEEN 700 AND 900)
   AND V03.kundenkarte_id IS NULL
   AND V04.akt_kjwo_ww BETWEEN - 156 AND 0
   AND V02.wg_id <> 961
   AND (V02.mandant_id, V02.bon_dat, V02.bon_id, V02.bon_zeile) NOT IN (SELECT (mandant_id, bon_dat, bon_id, bon_zeile)
     FROM kfl_production_dbp_ods.ods_bon_retoure_2)
  GROUP BY V02.wg_id,
   V01.mandant_id,
   V01.bon_id,
   V01.bon_dat,
   V04.kjwo_ww) AS v99
GROUP BY wg_id,
 mandant_id,
 bon_dat,
 kjwo_ww;