CREATE OR REPLACE VIEW kfl_production_dbp_etl.mv_sal_listung_markt_kw (mandant_id, wg_id, art_id, wup_id, nb_id,
kreistyp_gruppe_id, kjwo, absatz, absatz_sa, absatz_af, anz_wo_mit_absatz, anz_wo_mit_absatz_sa, anz_wo_mit_absatz_af)
AS SELECT V01.mandant_id,
 V01.wg_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V04.kreistyp_gruppe_id,
 V01.kjwo,
 IFNULL(SUM(V01.menge), 0) AS absatz,
 IFNULL(SUM(CASE
    WHEN V01.bewart_id = 1002
    THEN V01.menge
    ELSE NULL
    END), 0) AS absatz_sa,
 IFNULL(SUM(CASE
    WHEN V01.bewart_id = 1001
    THEN V01.menge
    ELSE NULL
    END), 0) AS absatz_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(V01.menge), 0) > 0
   THEN COUNT(DISTINCT V01.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz,
 IFNULL(CASE
   WHEN IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
        THEN V01.menge
        ELSE NULL
        END), 0) > 0 AND IFNULL(SUM(CASE
       WHEN V01.bewart_id = 1002
       THEN V01.menge
       ELSE NULL
       END), 0) IS NOT NULL
   THEN COUNT(DISTINCT CASE
     WHEN V01.bewart_id = 1002
     THEN V01.kjwo
     ELSE NULL
     END)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz_sa,
 IFNULL(CASE
   WHEN IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
        THEN V01.menge
        ELSE NULL
        END), 0) > 0 AND IFNULL(SUM(CASE
       WHEN V01.bewart_id = 1001
       THEN V01.menge
       ELSE NULL
       END), 0) IS NOT NULL
   THEN COUNT(DISTINCT CASE
     WHEN V01.bewart_id = 1001
     THEN V01.kjwo
     ELSE NULL
     END)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz_af
FROM kfl_production_dbp_etl.sal_artbew_wg_art_wo_sum AS V01
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_wup AS V04 ON V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
    = V04.mandant_id
WHERE V01.mandant_id = 1
 AND V03.arthiertyp_id = 2
 AND V03.dat_bis = PARSE_DATE('%F', '9999-12-31')
GROUP BY V01.mandant_id,
 V01.wg_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V04.kreistyp_gruppe_id,
 V01.kjwo;