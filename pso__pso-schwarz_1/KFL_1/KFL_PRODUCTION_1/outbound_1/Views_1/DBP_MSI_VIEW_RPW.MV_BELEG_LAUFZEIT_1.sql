CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_beleg_laufzeit_1 (system_id, mandant_id, beleg_id, beleg_gj,
dat_erfasst, dat_buch, dat_beleg, betrag_brutto, gp_id, belegart_id, ersteller_id, wup_id, nb_id,
einkaufsorganisation_id, anz_tage, max_dat, dat_lz) AS SELECT 7 AS system_id,
 BR.mandant_id,
 BR.rech_beleg_id AS beleg_id,
 BR.gj AS beleg_gj,
  CASE
  WHEN BR.rech_beleg_status_id = '5'
  THEN DATE(BR.dat_erfasst)
  ELSE NULL
  END AS dat_erfasst,
 BR.dat_buch,
 BR.dat_beleg,
  CASE
  WHEN BR.belegart_id IN ('HS', 'HK') AND (COALESCE(ROUND(SAFE_CAST(BR.buch_grund_ext_id AS BIGNUMERIC), 0), 0) < 200 OR
        COALESCE(ROUND(SAFE_CAST(BR.buch_grund_ext_id AS BIGNUMERIC), 0), 0) > 299) OR BR.belegart_id IN ('32', 'HB') OR
     BR.belegart_id = '31' AND COALESCE(ROUND(SAFE_CAST(BR.buch_grund_ext_id AS BIGNUMERIC), 0), 0) BETWEEN 200 AND 299
  THEN ABS(BR.betrag_brutto)
  ELSE ABS(BR.betrag_brutto) * - 1
  END AS betrag_brutto,
 BR.gp_id,
 BR.belegart_id,
 ROUND(CAST(lz.ersteller_id AS BIGNUMERIC), 0) AS ersteller_id,
 BR.wup_id,
 BR.nb_id,
 BR.einkaufsorganisation_id,
 DATE_DIFF(lz.dat_max, lz.dat_min, DAY) AS anz_tage,
 lz.dat_max AS max_dat,
 lz.dat_min AS dat_lz
FROM kfl_production_dbp_view.v_besch_rech_1 AS BR
 INNER JOIN (SELECT S.beleg_id,
   S.beleg_gj,
   MIN(DATE(S.zeitstempel)) AS dat_min,
   COALESCE(MAX(CASE
      WHEN sgz.statuscode_id IS NULL
      THEN NULL
      ELSE DATE(S.zeitstempel)
      END), MAX(DATE(S.zeitstempel))) AS dat_max,
   SUBSTR(COALESCE(MAX(CASE
       WHEN sgz.statuscode_id IS NULL
       THEN NULL
       ELSE FORMAT_DATETIME('%F %H:%M:%E6S', S.zeitstempel) || CAST(S.ersteller_id AS STRING)
       END), MAX(FORMAT_DATETIME('%F %H:%M:%E6S', S.zeitstempel) || CAST(S.ersteller_id AS STRING))), 27, 100) AS
   ersteller_id,
   S.mandant_id
  FROM kfl_production_dbp_view.v_statusmeldung_1 AS S
   LEFT JOIN (SELECT *
    FROM kfl_production_dbp_view.v_statuscode_gruppe_zu_1
    WHERE statusgruppe_id = 7) AS sgz ON S.statuscode_id = sgz.statuscode_id AND S.mandant_id = sgz.mandant_id
  WHERE S.beleg_id > 0
  GROUP BY S.beleg_id,
   S.beleg_gj,
   S.mandant_id) AS lz ON BR.gj = lz.beleg_gj AND BR.rech_beleg_id = lz.beleg_id AND BR.mandant_id = lz.mandant_id
WHERE BR.mandant_id = 1;