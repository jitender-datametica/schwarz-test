CREATE OR REPLACE VIEW kfl_production_dbp_etl.mv_listung_markt_tag_2 (mandant_id, wg_id, art_id, dat, kjwo, wup_id, absatz
, absatz_sa, absatz_af, anz_tage_mit_absatz, anz_tage_mit_absatz_sa, anz_tage_mit_absatz_af) AS SELECT V01.mandant_id,
 V03.wg_id,
 V01.art_id,
 V01.dat,
 V02.kjwo,
 V01.wup_id,
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
 IFNULL(COUNT(DISTINCT V02.dat), 0) AS anz_tage_mit_absatz,
 IFNULL(COUNT(DISTINCT CASE
    WHEN V01.bewart_id = 1002
    THEN V02.dat
    ELSE NULL
    END), 0) AS anz_tage_mit_absatz_sa,
 IFNULL(COUNT(DISTINCT CASE
    WHEN V01.bewart_id = 1001
    THEN V02.dat
    ELSE NULL
    END), 0) AS anz_tage_mit_absatz_af
FROM kfl_production_dbp_view.v_artbew_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V01.dat = V02.dat
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_2 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V04 ON V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
    = V04.mandant_id
WHERE V01.mandant_id = 1
 AND V03.arthiertyp_id = 2
 AND V03.dat_bis = DATE '9999-12-31'
GROUP BY V01.mandant_id,
 V03.wg_id,
 V01.art_id,
 V01.dat,
 V02.kjwo,
 V01.wup_id;