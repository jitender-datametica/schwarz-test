-- , MENGE_RFI
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_check_umsatz_kmo (mandant_id, wup_id, dat,
count_refnum, umsatz_rfi, umsatz_artbew, `artbew_u002b_rfi = mseg`, umsatz_mseg, todo, `update rfi <> artbew`,
`shell-aufruf`) AS -- , MENGE_ARTBEW
 -- , MENGE_MSEG

-- ,( XX.UMSATZ_ARTBEW - XX.UMSATZ_RFI) (NUMBER(18,2)) AS UMSATZ_DIFFERENZ

-- , MENGE_ARTBEW - MENGE_RFI AS MENGE_DIFFERENZ
 -- KEIN ARTBEW BESTÜCKUNG
 -- SQL FÜR DETAILANALYSE

-- DELTA-LIEFERUNG MIT UMSATZ <= 1000 TROTZDEM LADEN
 -- STANDARDFÄLLE
 -- DELTA-LIEFERUNG FÜR SONDERFÄLLE AUS RO

/* NOCH OHNE KURSUMRECHNUNG */ -- AND A.DAT IN ('2014-03-06', '2014-03-11', '2014-03-07')

-- AND A.WUP_ID IN (2900,4760)
 -- AND LBD.DAT_BUCH IN ('2014-03-06', '2014-03-11', '2014-03-07')

-- AND LBD.WUP_ID IN (2900,4760)
 SELECT YY.mandant_id,
 XX.wup_id,
 DATE(XX.dat) AS dat,
 XX.count_refnum,
 ROUND(CAST(XX.umsatz_rfi AS NUMERIC), 2) AS umsatz_rfi,
 ROUND(CAST(COALESCE(XX.umsatz_artbew, 0) AS NUMERIC), 2) AS umsatz_artbew,
  CASE
  WHEN ROUND(CAST(XX.umsatz_rfi AS NUMERIC), 2) + ROUND(CAST(COALESCE(XX.umsatz_artbew, 0) AS NUMERIC), 2) = CAST(XX.umsatz_mseg AS NUMERIC)
   
  THEN 'JA'
  ELSE 'NEIN'
  END AS `artbew_u002b_rfi = mseg`,
 CAST(XX.umsatz_mseg AS NUMERIC) AS umsatz_mseg,
  CASE
  WHEN XX.umsatz_artbew IS NULL AND TRIM(XX.rfi_feld) = 'ARTNR'
  THEN
  'DETAILPRÜFUNG AUF ARTIKEL-EBENE (ALPHANUMERISCH ODER DATENTYP INTEGER "GESPRENGT") NOTWENDIG. ANALYSE-SQL (RECHTS) AUSFÜHREN!'
  WHEN XX.umsatz_artbew IS NULL AND TRIM(XX.rfi_feld) = 'FILNR'
  THEN 'DETAILPRÜFUNG (KEINE MARKTSTAMM) NOTWENDIG. ANALYSE-SQL (RECHTS) AUSFÜHREN!'
  WHEN XX.umsatz_artbew IS NULL AND TRIM(XX.rfi_feld) = 'LANDKZ, FILNR, BELEGDATUM'
  THEN 'DETAILPRÜFUNG (ÖFFNUNGSDATUM DES MARKTES LIEGT IN DER ZUKUNFT) NOTWENDIG. ANALYSE-SQL (RECHTS) AUSFÜHREN!'
  WHEN XX.umsatz_artbew = XX.umsatz_mseg
  THEN 'UMSATZ ARTBEW ENSTPRICHT UMSATZ MSEG ==> RFI DELETE (RECHTS) AUSFÜHREN!'
  WHEN XX.umsatz_artbew - XX.umsatz_rfi <> 0 AND XX.umsatz_artbew + XX.umsatz_rfi <> XX.umsatz_mseg AND XX.umsatz_rfi <=
    1000
  THEN 'UMSATZ RFI <=1000 TROTZDEM ADDITIV LADEN ==> RFI UPDATE (RECHTS) AUSFÜHREN!'
  -- IDENTISCHE DOPPELLIEFERUNG: RFI-PRÜFUNG

  WHEN XX.count_refnum > 1
  THEN 'REFNUMMER: ' || TRIM(XX.refnum) ||
   ' * MEHRFACHLIEFERUNG FÜR LAND, MARKT, TAG KOMBINATION ==> MSEG-WERT BEOBACHTEN!'
   -- IDENTISCHE LIEFERUNG BEREITS GELADENER LAND, MARKT, TAG KOMBINATION

  WHEN XX.umsatz_artbew - XX.umsatz_rfi = 0
  THEN 'DELETE FROM KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS WHERE LANDKZ = \'\'' || TRIM(YY.mandant_kbez) ||
       '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1, 39)) || ' AND BELEGDATUM IN (\'\'' || TRIM(XX.belegdatum
     ) || '\'\');'
  ELSE 'DIFFERENZ: ' || TRIM(SUBSTR(CAST(ROUND(CAST(XX.umsatz_artbew - XX.umsatz_rfi AS NUMERIC), 2) AS STRING), 1, 19)
     ) || ' ==> MANUELLE PRÜFUNG DURCHFÜHREN GGF. IM LAND NACHFRAGEN. BEI FREIGABE RFI UPDATE (RECHTS) AUSFÜHREN!'
  END AS todo,
  CASE
  WHEN XX.umsatz_artbew IS NULL AND TRIM(XX.rfi_feld) = 'ARTNR'
  THEN 'SELECT * FROM KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS WHERE LANDKZ = \'\'' || TRIM(YY.mandant_kbez) ||
       '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1, 39)) || ' AND BELEGDATUM IN (\'\'' || TRIM(XX.belegdatum
     ) ||
   '\'\') AND (DBP_PROCESS.IS_INTEGER(ARTNR) = 0 OR DBP_PROCESS.IS_INTEGER(FILNR) = 0 OR DBP_PROCESS.IS_INTEGER(ARTNR) = 0 OR DBP_PROCESS.IS_NUM(UMSMENGE) = 0 OR DBP_PROCESS.IS_NUM(UMSWERT) = 0 OR DBP_PROCESS.IS_NUM(UMSPROMOTION) = 0 OR CAST(TRIM(ARTNR) AS INTEGER ) > 2100000000);'
   
  WHEN XX.umsatz_artbew IS NULL AND TRIM(XX.rfi_feld) = 'FILNR'
  THEN 'SELECT * FROM KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS WHERE LANDKZ = \'\'' || TRIM(YY.mandant_kbez) ||
       '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1, 39)) || ' AND BELEGDATUM IN (\'\'' || TRIM(XX.belegdatum
     ) || '\'\');'
  WHEN XX.umsatz_artbew IS NULL AND TRIM(XX.rfi_feld) = 'LANDKZ, FILNR, BELEGDATUM'
  THEN 'SELECT MANDANT_ID, WUP_ID, DAT_VON FROM KFL_PRODUCTION.DBP_DATA.WUP WHERE MANDANT_ID = ' || TRIM(SUBSTR(CAST(XX.mandant_id AS STRING)
              , 1, 39)) || ' AND WUP_ID = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1, 39)) ||
         ';\nDELETE FROM KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS WHERE LANDKZ = \'\'' || TRIM(YY.mandant_kbez) ||
       '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1, 39)) || ' AND BELEGDATUM IN (\'\'' || TRIM(XX.belegdatum
     ) || '\'\');'
  WHEN XX.umsatz_artbew = XX.umsatz_mseg
  THEN 'DELETE FROM KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS WHERE LANDKZ = \'\'' || TRIM(YY.mandant_kbez) ||
       '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1, 39)) || ' AND BELEGDATUM IN (\'\'' || TRIM(XX.belegdatum
     ) || '\'\');' -- DELTA-LIEFERUNG FÜR SONDERFÄLLE AUS RO

  WHEN XX.umsatz_artbew - XX.umsatz_rfi <> 0 AND XX.umsatz_artbew + XX.umsatz_rfi = XX.umsatz_mseg OR XX.umsatz_artbew -
       XX.umsatz_rfi <> 0 AND XX.umsatz_artbew + XX.umsatz_rfi <> XX.umsatz_mseg AND XX.umsatz_rfi <= 1000
  THEN 'UPDATE KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS SET RFI_FREIGABE = "2" WHERE LANDKZ = \'\'' || TRIM(YY.mandant_kbez) ||
       '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1, 39)) || ' AND BELEGDATUM IN (\'\'' || TRIM(XX.belegdatum
     ) || '\'\');' -- IDENTISCHE DOPPELLIEFERUNG: RFI-PRÜFUNG

  WHEN XX.count_refnum > 1
  THEN TRIM('SELECT \n  T01.LANDKZ\n, T01.RFI_FELD\n, T01.FILNR\n, T01.BELEGDATUM\n, T01.REFNUM\n, SUM((CAST(SUBSTRING(T01.UMSWERT FROM 16 FOR 20) AS NUMERIC(18,4)) * (CASE WHEN T01.VORZWERT = "-" THEN (-1) ELSE 1 END)) + (CAST(SUBSTRING(T01.UMSPROMOTION FROM 16 FOR 20) AS NUMERIC(18,4)) * (CASE WHEN T01.VORZPROMOTION = "-" THEN (-1) ELSE 1 END))) AS UMSATZ_BRUTTO_RFI\nFROM KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS T01\nWHERE LANDKZ = \'\''
                                 || TRIM(YY.mandant_kbez) || '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING)
                                 , 1, 39)) || ' AND BELEGDATUM IN (\'\'' || TRIM(XX.belegdatum) ||
                            '\'\')\nGROUP BY 1,2,3,4,5\nERST KONTROLLIEREN ... DANN "FEUERN" ;-)\nUPDATE KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS SET RFI_FREIGABE = "2" WHERE LANDKZ = \'\''
                             || TRIM(YY.mandant_kbez) || '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1
                           , 39)) || ' AND BELEGDATUM IN (\'\'' || TRIM(XX.belegdatum) || '\'\')' || ' AND REFNUM = ' ||
                    TRIM(XX.max_refnum) || ';\nDELETE FROM KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS WHERE LANDKZ = \'\'' ||
                  TRIM(YY.mandant_kbez) || '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1, 39)) ||
               ' AND BELEGDATUM IN (\'\'' || TRIM(XX.belegdatum) || '\'\')' || ' AND REFNUM = ' || TRIM(XX.min_refnum)
          || ';\nDELETE FROM KFL_PRODUCTION.DBP_DATA.ARTBEW_WG_SUM WHERE BEWART_ID <> 1010 AND MANDANT_ID = \'\'' ||
         TRIM(SUBSTR(CAST(YY.mandant_id AS STRING), 1, 39)) || '\'\' AND WUP_ID = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING)
         , 1, 39)) || ' AND DAT IN (\'\'' || FORMAT_DATE('%F', XX.dat) || '\'\');\n')
  WHEN XX.umsatz_artbew - XX.umsatz_rfi <> 0
  THEN 'UPDATE KFL_PRODUCTION.DBP_RFI.KMO_WPUUMS SET RFI_FREIGABE = "2" WHERE LANDKZ = \'\'' || TRIM(YY.mandant_kbez) ||
                   '\'\' AND FILNR = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING), 1, 39)) || ' AND BELEGDATUM IN (\'\''
                || TRIM(XX.belegdatum) ||
               '\'\');\nDELETE FROM KFL_PRODUCTION.DBP_DATA.ARTBEW WHERE BEWART_ID <> 1010 AND MANDANT_ID = \'\'' ||
              TRIM(SUBSTR(CAST(YY.mandant_id AS STRING), 1, 39)) || '\'\' AND WUP_ID = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING)
              , 1, 39)) || ' AND DAT IN (\'\'' || FORMAT_DATE('%F', XX.dat) ||
         '\'\'); \nDELETE FROM KFL_PRODUCTION.DBP_DATA.ARTBEW_WG_SUM WHERE BEWART_ID <> 1010 AND MANDANT_ID = \'\'' ||
        TRIM(SUBSTR(CAST(YY.mandant_id AS STRING), 1, 39)) || '\'\' AND WUP_ID = ' || TRIM(SUBSTR(CAST(XX.wup_id AS STRING)
        , 1, 39)) || ' AND DAT IN (\'\'' || FORMAT_DATE('%F', XX.dat) || '\'\');'
  ELSE 'KEINE AKTION !!!'
  END AS `update rfi <> artbew`,
  CASE
  WHEN XX.umsatz_artbew - XX.umsatz_rfi <> 0 OR XX.count_refnum > 1
  THEN 'SUDO /BIN/SU - U_VE_P \nCD /DWH/DWHPROD/PROJEKT/ARTUMSKASSE/JOB\n./JOB_DWH_KMO_ARTUMS_MIT_VIS.SH'
  ELSE 'KEINE AKTION !!!'
  END AS `shell-aufruf`
FROM (SELECT RFI.wup_id,
   COALESCE(RFI.dat, ARTBEW.dat) AS dat,
   COALESCE(RFI.mandant_id, ARTBEW.mandant_id) AS mandant_id,
   RFI.belegdatum,
   RFI.rfi_feld,
   RFI.refnum,
   RFI.count_refnum,
   RFI.min_refnum,
   RFI.max_refnum,
   SUM(RFI.menge_rfi) AS menge_rfi,
   SUM(RFI.umsatz_brutto_rfi) AS umsatz_rfi,
   SUM(ARTBEW.menge) AS menge_artbew,
   SUM(ARTBEW.umsatz) AS umsatz_artbew,
   SUM(MSEG.menge_lagerbew_bme) AS menge_mseg,
   SUM(MSEG.betrag_verkauf_ist) AS umsatz_mseg
  FROM (SELECT t0.mandant_id,
     t0.landkz,
     t0.rfi_feld,
     t0.wup_id,
     t0.dat,
     t0.belegdatum,
     t0.refnum,
     MIN(t0.refnum) OVER (PARTITION BY CAST(t0.mandant_id AS STRING), CAST(t0.wup_id AS STRING), t0.dat RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS min_refnum,
     MAX(t0.refnum) OVER (PARTITION BY CAST(t0.mandant_id AS STRING), CAST(t0.wup_id AS STRING), t0.dat RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_refnum,
     COUNT(*) OVER (PARTITION BY CAST(t0.mandant_id AS STRING), CAST(t0.wup_id AS STRING), t0.dat RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS count_refnum,
     t0.umsatz_brutto_rfi,
     t0.menge_rfi
    FROM (SELECT T02.mandant_id,
       T01.landkz,
       T01.rfi_feld,
       ROUND(CAST(T01.filnr AS BIGNUMERIC), 0) AS wup_id,
       PARSE_DATE('%Y%m%d', T01.belegdatum) AS dat,
       T01.belegdatum,
       T01.refnum,
       SUM(ROUND(CAST(SUBSTR(T01.umswert, 16, 20) AS NUMERIC), 4) * CASE
           WHEN T01.vorzwert = '-'
           THEN - 1
           ELSE 1
           END + ROUND(CAST(SUBSTR(T01.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
           WHEN T01.vorzpromotion = '-'
           THEN - 1
           ELSE 1
           END) AS umsatz_brutto_rfi,
       SUM(ROUND(CAST(SUBSTR(T01.umsmenge, 16, 20) AS NUMERIC), 4) * CASE
           WHEN T01.vorzmenge = '-'
           THEN - 1
           ELSE 1
           END * - 1) AS menge_rfi
      FROM kfl_production_dbp_rfi.kmo_wpuums AS T01
       INNER JOIN kfl_production_dbp_view.v_mandant AS T02 ON T01.landkz = T02.mandant_kbez
      GROUP BY T02.mandant_id,
       T01.landkz,
       T01.rfi_feld,
       wup_id,
       dat,
       T01.belegdatum,
       T01.refnum) AS t0) AS RFI
   LEFT JOIN (SELECT wup_id,
     dat,
     mandant_id,
     SUM(menge) AS menge,
     SUM(umsatz_netto + umsatz_mwst_betrag) AS umsatz
    FROM kfl_production_dbp_view.v_artbew AS A
    WHERE bewart_id <> 1010
     AND mandant_id <> 1
     AND dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY wup_id,
     dat,
     mandant_id) AS ARTBEW ON RFI.dat = ARTBEW.dat AND RFI.wup_id = ARTBEW.wup_id AND RFI.mandant_id -- MSEG-VERGLEICH

     = ARTBEW.mandant_id
   LEFT JOIN (SELECT wup_id,
     dat_buch,
     mandant_id,
      SUM(menge_lagerbew_bme) * - 1 AS menge_lagerbew_bme,
      SUM(betrag_verkauf_ist) * - 1 AS betrag_verkauf_ist
    FROM kfl_production_dbp_view.v_lagerbew_det AS LBD
    WHERE mandant_id <> 1
     AND lager_bewart_id IN ('251', '252')
     AND dat_buch BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY wup_id,
     dat_buch,
     mandant_id) AS MSEG ON RFI.dat = MSEG.dat_buch AND RFI.wup_id = MSEG.wup_id AND RFI.mandant_id = MSEG.mandant_id
  GROUP BY RFI.wup_id,
   dat,
   mandant_id,
   RFI.belegdatum,
   RFI.rfi_feld,
   RFI.refnum,
   RFI.count_refnum,
   RFI.min_refnum,
   RFI.max_refnum) AS XX
 INNER JOIN kfl_production_dbp_view.v_mandant AS YY ON XX.mandant_id = YY.mandant_id
GROUP BY YY.mandant_id,
 XX.wup_id,
 dat,
 XX.count_refnum,
 umsatz_rfi,
 umsatz_artbew,
 `artbew_u002b_rfi = mseg`,
 umsatz_mseg,
 todo,
 `update rfi <> artbew`,
 `shell-aufruf`;