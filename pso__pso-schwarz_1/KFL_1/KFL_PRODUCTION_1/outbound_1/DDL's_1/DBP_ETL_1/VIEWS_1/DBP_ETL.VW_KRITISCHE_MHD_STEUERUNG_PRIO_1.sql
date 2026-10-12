CREATE OR REPLACE VIEW kfl_production_dbp_etl.vw_kritische_mhd_steuerung_prio_1 AS WITH BASE_DATA AS (SELECT ROUND(CAST(RA.kunde_id AS BIGNUMERIC)
    , 0) AS filiale,
   RA.mutter_art_id,
   RA.final_art_id,
   RA.mandant_id,
   RA.dat_haltbarkeit AS vfdat,
   RA.lief_typ_id,
   T3.kl_art_id,
   T3.basismenge_einh_id,
   T3.mhd_zeitraum AS art_mhd,
   T3.lager_prozent AS art_lagerprozent,
    T3.mhd_zeitraum * (T3.lager_prozent / 100.0) AS mrlz,
   T4.wg_id,
   T4.wug_id,
    LPAD(SUBSTR(CAST(T4.wg_id AS STRING), 1, 10), 3, '0') || LPAD(SUBSTR(CAST(T4.wug_id AS STRING), 1, 10), 3, '0') AS
   wgi_lookup_key
  FROM kfl_production_dbp_etl.resolved_articles_1 AS RA_1
   INNER JOIN kfl_production_dbp_data.art_1 AS T3 ON RA.mandant_id = T3.mandant_id AND RA.final_art_id = T3.art_id
   INNER JOIN kfl_production_dbp_data.art_wg_zu_per_1 AS T4 ON RA.mandant_id = T4.mandant_id AND RA.final_art_id = T4.art_id
        AND T4.dat_bis = DATE '9999-12-31' AND T4.arthiertyp_id = 2
  WHERE RA.dat_haltbarkeit IS NOT NULL), CALCULATED_RESULTS AS (SELECT b.filiale,
   b.mutter_art_id,
   b.final_art_id,
   b.mandant_id,
   b.vfdat,
   b.lief_typ_id,
   b.kl_art_id,
   b.basismenge_einh_id,
   b.art_mhd,
   b.art_lagerprozent,
   b.mrlz,
   b.wg_id,
   b.wug_id,
   b.wgi_lookup_key,
   T5.owg_id,
   FINAL.rlz_ist,
   DATE_SUB(b.vfdat, INTERVAL CAST(ROUND(FINAL.rlz_ist) AS INTEGER) DAY) AS krlz,
   DATE_DIFF(DATE_SUB(b.vfdat, INTERVAL CAST(ROUND(FINAL.rlz_ist) AS INTEGER) DAY), CURRENT_DATE, DAY) AS
   tage_bis_kritisch
  FROM BASE_DATA AS b
   LEFT JOIN kfl_production_dbp_data.wg_per_1 AS T5 ON b.mandant_id = T5.mandant_id AND b.wg_id = T5.wg_id AND T5.arthiertyp_id
       = 2 AND T5.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_etl.rlz_range_1 AS SPECIFIC ON b.mandant_id = SPECIFIC.mandant_id AND CAST(b.wgi_lookup_key AS FLOAT64)
     = SPECIFIC.wgi
   LEFT JOIN kfl_production_dbp_etl.rlz_range_1 AS FINAL ON b.mandant_id = FINAL.mandant_id AND COALESCE(SPECIFIC.wgi, -1
      ) = FINAL.wgi
  WHERE T5.owg_id <> 1047
   AND T5.owg_id NOT BETWEEN 1011 AND 1014
   AND b.mrlz BETWEEN FINAL.rlz_ab AND FINAL.rlz_bis
   AND (b.lief_typ_id = 'NL' AND b.mandant_id IN (2, 3, 4, 5, 6, 7, 8) OR b.lief_typ_id = 'ZLFI' AND b.mandant_id IN (2
         , 3, 5, 6, 7, 8) OR b.lief_typ_id = 'ZLCC' AND b.mandant_id IN (4, 7))) (SELECT filiale,
   mutter_art_id,
   final_art_id,
   mandant_id,
   vfdat,
   lief_typ_id,
   kl_art_id,
   basismenge_einh_id,
   art_mhd,
   art_lagerprozent,
   mrlz,
   wg_id,
   wug_id,
   wgi_lookup_key,
   owg_id,
   rlz_ist,
   krlz,
   tage_bis_kritisch,
    CASE
    WHEN tage_bis_kritisch <= 0
    THEN '🔥 SOFORT HANDELN (KRLZ erreicht)'
    WHEN tage_bis_kritisch <= 2
    THEN '⚠️ KRITISCH (Nächste 48h)'
    WHEN tage_bis_kritisch <= 5
    THEN '📅 WARNUNG (Diese Woche_1)'
    ELSE '✅ OK'
    END AS prio_status
  FROM CALCULATED_RESULTS
  WHERE krlz >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
  GROUP BY filiale,
   mutter_art_id,
   final_art_id,
   mandant_id,
   vfdat,
   lief_typ_id,
   kl_art_id,
   basismenge_einh_id,
   art_mhd,
   art_lagerprozent,
   mrlz,
   wg_id,
   wug_id,
   wgi_lookup_key,
   owg_id,
   rlz_ist,
   krlz,
   tage_bis_kritisch,
   prio_status);