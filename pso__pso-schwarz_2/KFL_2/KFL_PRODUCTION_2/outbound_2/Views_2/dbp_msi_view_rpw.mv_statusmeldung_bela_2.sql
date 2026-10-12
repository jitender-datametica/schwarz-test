CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_statusmeldung_bela_2 (ecm_vorgang, mandant_id, system_id,
belegklasse_id, statuscode_id, gp_id, zeitstempel, dat, laufzeit_tage, anzahl_ek, anzahl_mahnung) AS SELECT V01.ecm_vorgang
 ,
 V01.mandant_id,
 7 AS system_id,
 V01.belegklasse_id,
 V01.statuscode_id,
 MAX(V01.gp_id) AS gp_id,
 MIN(V01.zeitstempel) AS zeitstempel,
 MIN(V01.dat) AS dat,
 MIN(v02.laufzeit_min / 1440) AS laufzeit_tage,
 MIN(v02.anzahl_ek) AS anzahl_ek,
 MIN(COALESCE(v03.anzahl_mahnung, 0)) AS anzahl_mahnung
FROM kfl_production_dbp_view.v_statusmeldung_2 AS V01
 INNER JOIN (SELECT ecm_vorgang,
   SUM(`A11866`) AS laufzeit_min,
   SUM(`A11867`) AS anzahl_ek
  FROM (SELECT ecm_vorgang,
     CAST(CASE
       WHEN statuscode_id = 2005 AND COALESCE(MAX(statuscode_id) OVER (PARTITION BY ecm_vorgang ORDER BY zeitstempel IS NULL, zeitstempel, statusmeldung_ecm_lfd_nr IS NULL, statusmeldung_ecm_lfd_nr ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), statuscode_id) = 2004
       THEN CASE
        WHEN zeitstempel IS NOT NULL
        THEN TIMESTAMP_DIFF(COALESCE(MAX(zeitstempel) OVER (PARTITION BY ecm_vorgang ORDER BY zeitstempel IS NULL, zeitstempel, statusmeldung_ecm_lfd_nr IS NULL, statusmeldung_ecm_lfd_nr ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), zeitstempel), zeitstempel, MINUTE)
        ELSE NULL
        END
       ELSE 0
       END AS BIGNUMERIC) AS `A11866`,
      CASE
      WHEN statuscode_id = 2005 AND COALESCE(MAX(statuscode_id) OVER (PARTITION BY ecm_vorgang ORDER BY zeitstempel
            IS NULL, zeitstempel, statusmeldung_ecm_lfd_nr IS NULL, statusmeldung_ecm_lfd_nr ROWS BETWEEN 1 FOLLOWING
          AND 1 FOLLOWING), statuscode_id) = 2004
      THEN 1
      ELSE 0
      END AS `A11867`
    FROM kfl_production_dbp_view.v_statusmeldung_2
    WHERE mandant_id = 1
     AND belegklasse_id = 'BELA'
     AND statuscode_id IN (2004, 2005)) AS t0
  GROUP BY ecm_vorgang
  HAVING anzahl_ek > 0) AS v02 ON V01.ecm_vorgang = v02.ecm_vorgang
 LEFT JOIN (SELECT ecm_vorgang,
   COUNT(statuscode_id) AS anzahl_mahnung
  FROM kfl_production_dbp_view.v_statusmeldung_2
  WHERE mandant_id = 1
   AND belegklasse_id = 'BELA'
   AND statuscode_id = 2012
  GROUP BY ecm_vorgang) AS v03 ON V01.ecm_vorgang = v03.ecm_vorgang
 INNER JOIN (SELECT ecm_vorgang
  FROM kfl_production_dbp_view.v_statusmeldung_2
  WHERE mandant_id = 1
   AND belegklasse_id = 'BELA'
   AND statuscode_id = 2013
  GROUP BY ecm_vorgang) AS v04 ON V01.ecm_vorgang = v04.ecm_vorgang
WHERE V01.mandant_id = 1
 AND V01.belegklasse_id = 'BELA'
 AND V01.statuscode_id = 2001
GROUP BY V01.ecm_vorgang,
 V01.mandant_id,
 system_id,
 V01.belegklasse_id,
 V01.statuscode_id;