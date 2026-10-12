CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_check_umsatz_kmo_2 (mandant_id, wup_id, dat, count_refnum,
umsatz_rfi, umsatz_artbew, artbew_rfi_mseg, umsatz_mseg, todo, update_rfi_artbew, shell_aufruf) AS SELECT YY.mandant_id
 ,
 xx.wup_id,
 DATE(xx.dat) AS dat,
 xx.count_refnum,
 ROUND(CAST(xx.umsatz_rfi AS NUMERIC), 2) AS umsatz_rfi,
 ROUND(CAST(COALESCE(xx.umsatz_artbew, 0) AS NUMERIC), 2) AS umsatz_artbew,
  CASE
  WHEN ROUND(CAST(xx.umsatz_rfi AS NUMERIC), 2) + ROUND(CAST(COALESCE(xx.umsatz_artbew, 0) AS NUMERIC), 2) = CAST(xx.umsatz_mseg AS NUMERIC)
   
  THEN 'Ja'
  ELSE 'Nein'
  END AS artbew_rfi_mseg,
 CAST(xx.umsatz_mseg AS NUMERIC) AS umsatz_mseg,
  CASE
  WHEN xx.umsatz_artbew IS NULL AND TRIM(xx.rfi_feld) = 'artnr'
  THEN
  'Detailprüfung auf Artikel_2-Ebene (AlphaNumerisch oder Datentyp Integer "gesprengt") notwendig. Analyse-SQL (rechts) ausführen!'
  WHEN xx.umsatz_artbew IS NULL AND TRIM(xx.rfi_feld) = 'filnr'
  THEN 'Detailprüfung (keine Marktstamm) notwendig. Analyse-SQL (rechts) ausführen!'
  WHEN xx.umsatz_artbew IS NULL AND TRIM(xx.rfi_feld) = 'landkz, filnr, belegdatum'
  THEN 'Detailprüfung (Öffnungsdatum des Marktes liegt in der Zukunft) notwendig. Analyse-SQL (rechts) ausführen!'
  WHEN xx.umsatz_artbew = xx.umsatz_mseg
  THEN 'Umsatz ARTBEW_2 enstpricht Umsatz MSEG ==> RFI DELETE (rechts) ausführen!'
  WHEN xx.umsatz_artbew - xx.umsatz_rfi <> 0 AND xx.umsatz_artbew + xx.umsatz_rfi <> xx.umsatz_mseg AND xx.umsatz_rfi <=
    1000
  THEN 'Umsatz RFI <=1000 trotzdem additiv laden ==> RFI Update (rechts) ausführen!'
  WHEN xx.count_refnum > 1
  THEN 'Refnummer: ' || TRIM(xx.refnum) ||
   ' * Mehrfachlieferung für Land_2, Markt, Tag_2 Kombination ==> MSEG-Wert beobachten!'
  WHEN xx.umsatz_artbew - xx.umsatz_rfi = 0
  THEN 'DELETE FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = \'\'' || TRIM(YY.mandant_kbez) || '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING)
        , 1, 10)) || ' AND belegdatum IN (\'\'' || TRIM(xx.belegdatum) || '\'\');'
  ELSE 'Differenz: ' || TRIM(SUBSTR(CAST(ROUND(CAST(xx.umsatz_artbew - xx.umsatz_rfi AS NUMERIC), 2) AS STRING), 1, 19)
     ) || ' ==> manuelle Prüfung durchführen ggf. im Land_2 nachfragen. Bei Freigabe RFI UPDATE (rechts) ausführen!'
  END AS todo,
  CASE
  WHEN xx.umsatz_artbew IS NULL AND TRIM(xx.rfi_feld) = 'artnr'
  THEN 'SELECT * FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = \'\'' || TRIM(YY.mandant_kbez) || '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING)
        , 1, 10)) || ' AND belegdatum IN (\'\'' || TRIM(xx.belegdatum) ||
   '\'\') AND (dbp_process.is_integer(artnr) = 0 OR dbp_process.is_integer(filnr) = 0 OR dbp_process.is_integer(artnr) = 0 OR dbp_process.is_num(umsmenge) = 0 OR dbp_process.is_num(umswert) = 0 OR dbp_process.is_num(umspromotion) = 0 OR CAST(TRIM(artnr) AS NUMERIC(18,0)) > 2100000000);'
   
  WHEN xx.umsatz_artbew IS NULL AND TRIM(xx.rfi_feld) = 'filnr'
  THEN 'SELECT * FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = \'\'' || TRIM(YY.mandant_kbez) || '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING)
        , 1, 10)) || ' AND belegdatum IN (\'\'' || TRIM(xx.belegdatum) || '\'\');'
  WHEN xx.umsatz_artbew IS NULL AND TRIM(xx.rfi_feld) = 'landkz, filnr, belegdatum'
  THEN 'SELECT mandant_id, wup_id, dat_von FROM dbp_data.wup_2 WHERE mandant_id = ' || TRIM(SUBSTR(CAST(xx.mandant_id AS STRING)
              , 1, 10)) || ' AND wup_id = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING), 1, 10)) ||
         ';\nDELETE FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = \'\'' || TRIM(YY.mandant_kbez) || '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING)
        , 1, 10)) || ' AND belegdatum IN (\'\'' || TRIM(xx.belegdatum) || '\'\');'
  WHEN xx.umsatz_artbew = xx.umsatz_mseg
  THEN 'DELETE FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = \'\'' || TRIM(YY.mandant_kbez) || '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING)
        , 1, 10)) || ' AND belegdatum IN (\'\'' || TRIM(xx.belegdatum) || '\'\');'
  WHEN xx.umsatz_artbew - xx.umsatz_rfi <> 0 AND xx.umsatz_artbew + xx.umsatz_rfi = xx.umsatz_mseg OR xx.umsatz_artbew -
       xx.umsatz_rfi <> 0 AND xx.umsatz_artbew + xx.umsatz_rfi <> xx.umsatz_mseg AND xx.umsatz_rfi <= 1000
  THEN 'UPDATE dbp_rfi.kmo_wpuums_2 SET rfi_freigabe = \'\'2\'\' WHERE landkz = \'\'' || TRIM(YY.mandant_kbez) ||
       '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING), 1, 10)) || ' AND belegdatum IN (\'\'' || TRIM(xx.belegdatum
     ) || '\'\');'
  WHEN xx.count_refnum > 1
  THEN TRIM('SELECT \n  t01.landkz\n, t01.rfi_feld\n, t01.filnr\n, t01.belegdatum\n, t01.refnum\n, SUM((CAST(SUBSTRING(t01.umswert FROM 16 FOR 20) AS NUMERIC(18,4)) * (CASE WHEN t01.vorzwert = \'\'-\'\' THEN (-1) ELSE 1 END)) + (CAST(SUBSTRING(t01.umspromotion FROM 16 FOR 20) AS NUMERIC(18,4)) * (CASE WHEN t01.vorzpromotion = \'\'-\'\' THEN (-1) ELSE 1 END))) AS umsatz_brutto_rfi\nFROM dbp_rfi.kmo_wpuums_2 t01\nWHERE landkz = \'\''
                                 || TRIM(YY.mandant_kbez) || '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING)
                                 , 1, 10)) || ' AND belegdatum IN (\'\'' || TRIM(xx.belegdatum) ||
                            '\'\')\nGROUP BY 1,2,3,4,5\nERST KONTROLLIEREN ... DANN "FEUERN" ;-)\nUPDATE dbp_rfi.kmo_wpuums_2 SET rfi_freigabe = \'\'2\'\' WHERE landkz = \'\''
                             || TRIM(YY.mandant_kbez) || '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING), 1
                           , 10)) || ' AND belegdatum IN (\'\'' || TRIM(xx.belegdatum) || '\'\')' || ' AND refnum = ' ||
                    TRIM(xx.max_refnum) || ';\nDELETE FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = \'\'' || TRIM(YY.mandant_kbez
                   ) || '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING), 1, 10)) ||
               ' AND belegdatum IN (\'\'' || TRIM(xx.belegdatum) || '\'\')' || ' AND refnum = ' || TRIM(xx.min_refnum)
          || ';\nDELETE FROM dbp_data.artbew_wg_sum_2 WHERE bewart_id <> 1010 AND mandant_id = \'\'' || TRIM(SUBSTR(CAST(YY.mandant_id AS STRING)
           , 1, 10)) || '\'\' AND wup_id = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING), 1, 10)) || ' AND dat IN (\'\'' ||
     FORMAT_DATE('%F', xx.dat) || '\'\');\n')
  WHEN xx.umsatz_artbew - xx.umsatz_rfi <> 0
  THEN 'UPDATE dbp_rfi.kmo_wpuums_2 SET rfi_freigabe = \'\'2\'\' WHERE landkz = \'\'' || TRIM(YY.mandant_kbez) ||
                   '\'\' AND filnr = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING), 1, 10)) || ' AND belegdatum IN (\'\''
                || TRIM(xx.belegdatum) ||
               '\'\');\nDELETE FROM dbp_data.artbew_2 WHERE bewart_id <> 1010 AND mandant_id = \'\'' || TRIM(SUBSTR(CAST(YY.mandant_id AS STRING)
                , 1, 10)) || '\'\' AND wup_id = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING), 1, 10)) ||
           ' AND dat IN (\'\'' || FORMAT_DATE('%F', xx.dat) ||
         '\'\'); \nDELETE FROM dbp_data.artbew_wg_sum_2 WHERE bewart_id <> 1010 AND mandant_id = \'\'' || TRIM(SUBSTR(CAST(YY.mandant_id AS STRING)
          , 1, 10)) || '\'\' AND wup_id = ' || TRIM(SUBSTR(CAST(xx.wup_id AS STRING), 1, 10)) || ' AND dat IN (\'\'' ||
    FORMAT_DATE('%F', xx.dat) || '\'\');'
  ELSE 'keine Aktion_2 !!!'
  END AS update_rfi_artbew,
  CASE
  WHEN xx.umsatz_artbew - xx.umsatz_rfi <> 0 OR xx.count_refnum > 1
  THEN 'sudo /bin/su - u_ve_p \ncd /dwh/dwhprod/projekt/ARTUMSKASSE/job\n./job_dwh_kmo_ArtUms_mit_VIS.sh'
  ELSE 'keine Aktion_2 !!!'
  END AS shell_aufruf
FROM (SELECT rfi.wup_id,
   COALESCE(rfi.dat, artbew.dat) AS dat,
   COALESCE(rfi.mandant_id, artbew.mandant_id) AS mandant_id,
   rfi.belegdatum,
   rfi.rfi_feld,
   rfi.refnum,
   rfi.count_refnum,
   rfi.min_refnum,
   rfi.max_refnum,
   SUM(rfi.menge_rfi) AS menge_rfi,
   SUM(rfi.umsatz_brutto_rfi) AS umsatz_rfi,
   SUM(artbew.menge) AS menge_artbew,
   SUM(artbew.umsatz) AS umsatz_artbew,
   SUM(mseg.menge_lagerbew_bme) AS menge_mseg,
   SUM(mseg.betrag_verkauf_ist) AS umsatz_mseg
  FROM (SELECT t0.mandant_id,
     t0.landkz,
     t0.rfi_feld,
     t0.wup_id,
     t0.dat,
     t0.belegdatum,
     t0.refnum,
     MIN(t0.refnum) OVER (PARTITION BY t0.mandant_id, t0.wup_id, t0.dat RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS min_refnum,
     MAX(t0.refnum) OVER (PARTITION BY t0.mandant_id, t0.wup_id, t0.dat RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS max_refnum,
     COUNT(*) OVER (PARTITION BY t0.mandant_id, t0.wup_id, t0.dat RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS count_refnum,
     t0.umsatz_brutto_rfi,
     t0.menge_rfi
    FROM (SELECT T02.mandant_id,
       T01.landkz,
       T01.rfi_feld,
       CAST(ROUND(CAST(T01.filnr AS FLOAT64)) AS INTEGER) AS wup_id,
       PARSE_DATE('%Y%m%d', T01.belegdatum) AS dat,
       T01.belegdatum,
       T01.refnum,
       SUM(ROUND(CAST(SUBSTR(T01.umswert, 16, 20) AS NUMERIC), 4) * CASE
           WHEN T01.vorzwert = '-'
           THEN -1
           ELSE 1
           END + ROUND(CAST(SUBSTR(T01.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
           WHEN T01.vorzpromotion = '-'
           THEN -1
           ELSE 1
           END) AS umsatz_brutto_rfi,
       SUM(ROUND(CAST(SUBSTR(T01.umsmenge, 16, 20) AS NUMERIC), 4) * CASE
           WHEN T01.vorzmenge = '-'
           THEN -1
           ELSE 1
           END * -1) AS menge_rfi
      FROM kfl_production_dbp_rfi.kmo_wpuums_2 AS T01
       INNER JOIN kfl_production_dbp_view.v_mandant_2 AS T02 ON T01.landkz = T02.mandant_kbez
      GROUP BY T02.mandant_id,
       T01.landkz,
       T01.rfi_feld,
       wup_id,
       dat,
       T01.belegdatum,
       T01.refnum) AS t0) AS rfi
   LEFT JOIN (SELECT wup_id,
     dat,
     mandant_id,
     SUM(menge) AS menge,
     SUM(umsatz_netto + umsatz_mwst_betrag) AS umsatz
    FROM kfl_production_dbp_view.v_artbew_2 AS A
    WHERE bewart_id <> 1010
     AND mandant_id <> 1
     AND dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY wup_id,
     dat,
     mandant_id) AS artbew_2 ON rfi.dat = artbew.dat AND rfi.wup_id = artbew.wup_id AND rfi.mandant_id = artbew.mandant_id
     
   LEFT JOIN (SELECT wup_id,
     dat_buch,
     mandant_id,
      SUM(menge_lagerbew_bme) * -1 AS menge_lagerbew_bme,
      SUM(betrag_verkauf_ist) * -1 AS betrag_verkauf_ist
    FROM kfl_production_dbp_view.v_lagerbew_det_2 AS LBD
    WHERE mandant_id <> 1
     AND lager_bewart_id IN ('251', '252')
     AND dat_buch BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY wup_id,
     dat_buch,
     mandant_id) AS mseg ON rfi.dat = mseg.dat_buch AND rfi.wup_id = mseg.wup_id AND rfi.mandant_id = mseg.mandant_id
  GROUP BY rfi.wup_id,
   dat,
   mandant_id,
   rfi.belegdatum,
   rfi.rfi_feld,
   rfi.refnum,
   rfi.count_refnum,
   rfi.min_refnum,
   rfi.max_refnum) AS xx
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS YY ON xx.mandant_id = YY.mandant_id
GROUP BY YY.mandant_id,
 xx.wup_id,
 dat,
 xx.count_refnum,
 umsatz_rfi,
 umsatz_artbew,
 artbew_rfi_mseg,
 umsatz_mseg,
 todo,
 update_rfi_artbew,
 shell_aufruf;