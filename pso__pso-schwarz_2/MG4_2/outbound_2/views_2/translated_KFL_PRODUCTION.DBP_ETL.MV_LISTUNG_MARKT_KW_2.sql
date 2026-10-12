CREATE OR REPLACE VIEW kfl_production_dbp_etl.mv_listung_markt_kw_2 (mandant_id, wg_id, art_id, wup_id, nb_id,
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
 IFNULL(COUNT(DISTINCT v01.kjwo), 0) AS anzahl_wochen_mit_absatz,
 IFNULL(COUNT(DISTINCT CASE
    WHEN v01.bewart_id = 1002
    THEN v01.kjwo
    ELSE NULL
    END), 0) AS anzahl_wochen_mit_absatz_sa,
 IFNULL(COUNT(DISTINCT CASE
    WHEN v01.bewart_id = 1001
    THEN v01.kjwo
    ELSE NULL
    END), 0) AS anzahl_wochen_mit_absatz_af
FROM kfl_production_dbp_etl.bf_artbew_wg_art_wo_sum_de_2 AS v01
 INNER JOIN kfl_production_dbp_data.art_wg_zu_per_2 AS v03 ON v01.art_id = v03.art_id AND v01.mandant_id = v03.mandant_id
 INNER JOIN kfl_production_dbp_data.wup_2 AS v04 ON v01.wup_id = v04.wup_id AND v01.nb_id = v04.nb_id AND v01.mandant_id =
   v04.mandant_id
WHERE v01.mandant_id = 1
 AND v03.arthiertyp_id = 2
 AND v03.dat_bis = DATE '9999-12-31'
GROUP BY v01.mandant_id,
 v01.wg_id,
 v01.art_id,
 v01.wup_id,
 v01.nb_id,
 v04.kreistyp_gruppe_id,
 v01.kjwo;