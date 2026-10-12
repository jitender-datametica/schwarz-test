CREATE OR REPLACE VIEW kfl_production_dbp_etl.mv_listung_markt_tag (mandant_id, wg_id, art_id, dat, kjwo, wup_id, absatz
, absatz_sa, absatz_af, anz_tage_mit_absatz, anz_tage_mit_absatz_sa, anz_tage_mit_absatz_af) AS SELECT v01.mandant_id,
 v03.wg_id,
 v01.art_id,
 v01.dat,
 v02.kjwo,
 v01.wup_id,
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
 IFNULL(COUNT(DISTINCT v02.dat), 0) AS anz_tage_mit_absatz,
 IFNULL(COUNT(DISTINCT CASE
    WHEN v01.bewart_id = 1002
    THEN v02.dat
    ELSE NULL
    END), 0) AS anz_tage_mit_absatz_sa,
 IFNULL(COUNT(DISTINCT CASE
    WHEN v01.bewart_id = 1001
    THEN v02.dat
    ELSE NULL
    END), 0) AS anz_tage_mit_absatz_af
FROM kfl_production_dbp_view.v_artbew AS v01
 INNER JOIN kfl_production_dbp_view.v_tag AS v02 ON v01.dat = v02.dat
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS v03 ON v01.art_id = v03.art_id AND v01.mandant_id = v03.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_wup AS v04 ON v01.wup_id = v04.wup_id AND v01.nb_id = v04.nb_id AND v01.mandant_id
    = v04.mandant_id
WHERE v01.mandant_id = 1
 AND v03.arthiertyp_id = 2
 AND v03.dat_bis = DATE '9999-12-31'
GROUP BY v01.mandant_id,
 v03.wg_id,
 v01.art_id,
 v01.dat,
 v02.kjwo,
 v01.wup_id;