CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_crm_ods_bon_verkauf_tag_ww_wg_1 (anz_shopping_trips_kdn_wg,
wg_id, mandant_id, bon_dat, kjwo_ww) AS SELECT SUM(anz_shopping_trips_kdn_wg) AS anz_shopping_trips_kdn_wg,
 wg_id,
 mandant_id,
 bon_dat,
 kjwo_ww
FROM (SELECT V01.wg_id,
   V01.mandant_id,
   V01.bon_dat,
   V09.kjwo_ww,
   COUNT(V01.wg_id) OVER (PARTITION BY CAST(V01.mandant_id AS STRING), V01.bon_id, CAST(V01.wg_id AS STRING), V01.bon_dat
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_shopping_trips_kdn_wg
  FROM kfl_production_dbp_v_ods.v_ods_bon_verkauf_1 AS V01
   INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.bon_id = V02.bon_id
          AND V01.bon_dat = V02.bon_dat AND V01.wup_id = V02.wup_id AND V02.kundenkarte_typ_id IN (2) AND V02.kundenkarte_id
    IS NOT NULL
   LEFT JOIN kfl_production_dbp_view.v_bewart_det_ecommerce_1 AS V03 ON FALSE
   INNER JOIN kfl_production_dbp_v_ods.v_ods_promotion_1 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.bon_id = V04.bon_id
          AND V01.bon_dat = V04.bon_dat AND V01.kl_art_id = V04.kl_art_id AND V04.promotion_art = 'CUSTOMER' AND V04.customer_promotion_fg
      = 1
   INNER JOIN kfl_production_dbp_view.v_art_1 AS V05 ON V01.kl_art_id = V05.kl_art_id AND V01.mandant_id = V05.mandant_id
   INNER JOIN kfl_production_dbp_view.v_crm_l_kundenkarte_1 AS V07 ON V02.kundenkarte_id = V07.kundenkarte_id AND V02.mandant_id
      = V07.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS V09 ON V01.bon_dat = V09.dat AND V01.mandant_id = V09.mandant_id
     
  WHERE V02.turnover_fg = 1
   AND V02.kasse_typ_id <> 5
   AND V02.umsatz_brutto > 0
   AND (V01.mandant_id IN (1, 4, 6) OR V01.mandant_id IN (2, 5, 7, 8) AND CAST(V02.kassierer_nr AS INTEGER) NOT BETWEEN
        800 AND 900 OR V01.mandant_id = 3 AND CAST(V02.kassierer_nr AS INTEGER) NOT BETWEEN 700 AND 900)
   AND V09.akt_kjwo_ww BETWEEN - 156 AND 0
   AND V01.wg_id <> 961
   AND (V02.mandant_id, V01.bon_dat, V01.bon_id, V01.bon_zeile) NOT IN (SELECT (mandant_id, bon_dat, bon_id, bon_zeile)
     FROM kfl_production_dbp_ods.ods_bon_retoure_1)
  GROUP BY V01.wg_id,
   V01.mandant_id,
   V01.bon_id,
   V01.bon_dat,
   V09.kjwo_ww) AS v99
GROUP BY wg_id,
 mandant_id,
 bon_dat,
 kjwo_ww;