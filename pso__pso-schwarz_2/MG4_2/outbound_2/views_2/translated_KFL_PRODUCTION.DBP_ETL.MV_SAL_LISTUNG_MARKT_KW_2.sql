CREATE OR REPLACE VIEW kfl_production_dbp_etl.mv_sal_listung_markt_kw_2 (mandant_id, wg_id, art_id, wup_id, nb_id,
kreistyp_gruppe_id, kjwo, absatz, absatz_sa, absatz_af, anz_wo_mit_absatz, anz_wo_mit_absatz_sa, anz_wo_mit_absatz_af)
AS SELECT v01.mandant_id,
 v01.wg_id,
 v01.art_id,
 v01.wup_id,
 v01.nb_id,
 v04.kreistyp_gruppe_id,
 v01.kjwo,
 IFNULL(SUM(v01.menge), 0) AS absatz,
 IFNULL(SUM(CASE
    WHEN v01.bewart_id = 1002
    THEN v01.menge
    ELSE NULL
    END), 0) AS absatz_sa,
 IFNULL(SUM(CASE
    WHEN v01.bewart_id = 1001
    THEN v01.menge
    ELSE NULL
    END), 0) AS absatz_af,
 IFNULL(CASE
   WHEN IFNULL(SUM(v01.menge), 0) > 0
   THEN COUNT(DISTINCT v01.kjwo)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz,
 IFNULL(CASE
   WHEN IFNULL(SUM(CASE
        WHEN v01.bewart_id = 1002
        THEN v01.menge
        ELSE NULL
        END), 0) > 0 AND IFNULL(SUM(CASE
       WHEN v01.bewart_id = 1002
       THEN v01.menge
       ELSE NULL
       END), 0) IS NOT NULL
   THEN COUNT(DISTINCT CASE
     WHEN v01.bewart_id = 1002
     THEN v01.kjwo
     ELSE NULL
     END)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz_sa,
 IFNULL(CASE
   WHEN IFNULL(SUM(CASE
        WHEN v01.bewart_id = 1001
        THEN v01.menge
        ELSE NULL
        END), 0) > 0 AND IFNULL(SUM(CASE
       WHEN v01.bewart_id = 1001
       THEN v01.menge
       ELSE NULL
       END), 0) IS NOT NULL
   THEN COUNT(DISTINCT CASE
     WHEN v01.bewart_id = 1001
     THEN v01.kjwo
     ELSE NULL
     END)
   ELSE NULL
   END, 0) AS anzahl_wochen_mit_absatz_af
FROM kfl_production_dbp_etl.sal_artbew_wg_art_wo_sum_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS v03 ON v01.art_id = v03.art_id AND v01.mandant_id = v03.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS v04 ON v01.wup_id = v04.wup_id AND v01.nb_id = v04.nb_id AND v01.mandant_id
    = v04.mandant_id
WHERE v01.mandant_id = 1
 AND v03.arthiertyp_id = 2
 AND v03.dat_bis = PARSE_DATE('%F', '9999-12-31')
GROUP BY v01.mandant_id,
 v01.wg_id,
 v01.art_id,
 v01.wup_id,
 v01.nb_id,
 v04.kreistyp_gruppe_id,
 v01.kjwo;