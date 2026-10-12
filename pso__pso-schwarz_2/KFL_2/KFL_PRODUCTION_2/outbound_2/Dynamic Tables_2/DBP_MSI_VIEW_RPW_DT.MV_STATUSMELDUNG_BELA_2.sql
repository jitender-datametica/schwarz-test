
CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_statusmeldung_bela_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT V01.ecm_vorgang,
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
       WHEN statuscode_id = 2005 AND COALESCE(MAX(statuscode_id) OVER (PARTITION BY ecm_vorgang ORDER BY zeitstempel NULLS LAST, statusmeldung_ecm_lfd_nr NULLS LAST ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), statuscode_id) = 2004
       THEN CASE
        WHEN zeitstempel IS NOT NULL
        THEN TIMESTAMP_DIFF(COALESCE(MAX(zeitstempel) OVER (PARTITION BY ecm_vorgang ORDER BY zeitstempel NULLS LAST, statusmeldung_ecm_lfd_nr NULLS LAST ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), zeitstempel), zeitstempel, MINUTE)
        ELSE NULL
        END
       ELSE 0
       END AS BIGNUMERIC) AS `A11866`,
      CASE
      WHEN statuscode_id = 2005 AND COALESCE(MAX(statuscode_id) OVER (PARTITION BY ecm_vorgang ORDER BY zeitstempel
            NULLS LAST, statusmeldung_ecm_lfd_nr NULLS LAST ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), statuscode_id) =
        2004
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
