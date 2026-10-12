CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_verrechfall_kostenart_spr_zu_1 (verrechfall_kostenart_id,
verrechfall_kostenart_bez, verrechfall_kostenart_bez_de, verrechfall_kostenart_bez_cz, verrechfall_kostenart_bez_sk,
verrechfall_kostenart_bez_hr, verrechfall_kostenart_bez_pl, verrechfall_kostenart_bez_ro, verrechfall_kostenart_bez_b)
AS (((((SELECT verrechfall_kostenart_id,
      MAX(CASE
        WHEN spr_id = 22
        THEN verrechfall_kostenart_bez
        ELSE NULL
        END) AS verrechfall_kostenart_bez,
      MAX(CASE
        WHEN spr_id = 22
        THEN verrechfall_kostenart_bez
        ELSE NULL
        END) AS verrechfall_kostenart_bez_de,
      COALESCE(MAX(CASE
         WHEN spr_id = 124
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END), MAX(CASE
         WHEN spr_id = 22
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END)) AS verrechfall_kostenart_bez_cz,
      COALESCE(MAX(CASE
         WHEN spr_id = 108
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END), MAX(CASE
         WHEN spr_id = 22
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END)) AS verrechfall_kostenart_bez_sk,
      COALESCE(MAX(CASE
         WHEN spr_id = 65
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END), MAX(CASE
         WHEN spr_id = 22
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END)) AS verrechfall_kostenart_bez_hr,
      COALESCE(MAX(CASE
         WHEN spr_id = 90
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END), MAX(CASE
         WHEN spr_id = 22
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END)) AS verrechfall_kostenart_bez_pl,
      COALESCE(MAX(CASE
         WHEN spr_id = 95
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END), MAX(CASE
         WHEN spr_id = 22
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END)) AS verrechfall_kostenart_bez_ro,
      COALESCE(MAX(CASE
         WHEN spr_id = 18
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END), MAX(CASE
         WHEN spr_id = 22
         THEN verrechfall_kostenart_bez
         ELSE NULL
         END)) AS verrechfall_kostenart_bez_b
     FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V01
     GROUP BY verrechfall_kostenart_id
     UNION DISTINCT
     SELECT 'K/NA',
      'manueller Upload',
      'manueller Upload',
      'manueller Upload',
      'manueller Upload',
      'manueller Upload',
      'manueller Upload',
      'manueller Upload',
      'manueller Upload'
     FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V01
     GROUP BY verrechfall_kostenart_id)
    UNION DISTINCT
    SELECT 'MDIES',
     'manuelle Berechnung Diesel-Anteil',
     'manuelle Berechnung Diesel-Anteil',
     'manuelle Berechnung Diesel-Anteil',
     'manuelle Berechnung Diesel-Anteil',
     'manuelle Berechnung Diesel-Anteil',
     'manuelle Berechnung Diesel-Anteil',
     'manuelle Berechnung Diesel-Anteil',
     'manuelle Berechnung Diesel-Anteil')
   UNION DISTINCT
   SELECT 'MSTRO',
    'manuelle Berechnung Strom-Anteil',
    'manuelle Berechnung Strom-Anteil',
    'manuelle Berechnung Strom-Anteil',
    'manuelle Berechnung Strom-Anteil',
    'manuelle Berechnung Strom-Anteil',
    'manuelle Berechnung Strom-Anteil',
    'manuelle Berechnung Strom-Anteil',
    'manuelle Berechnung Strom-Anteil')
  UNION DISTINCT
  SELECT 'MGAS',
   'manuelle Berechnung Gas-Anteil',
   'manuelle Berechnung Gas-Anteil',
   'manuelle Berechnung Gas-Anteil',
   'manuelle Berechnung Gas-Anteil',
   'manuelle Berechnung Gas-Anteil',
   'manuelle Berechnung Gas-Anteil',
   'manuelle Berechnung Gas-Anteil',
   'manuelle Berechnung Gas-Anteil')
 UNION DISTINCT
 SELECT 'MMAUT',
  'manuelle Berechnung Maut-Anteil',
  'manuelle Berechnung Maut-Anteil',
  'manuelle Berechnung Maut-Anteil',
  'manuelle Berechnung Maut-Anteil',
  'manuelle Berechnung Maut-Anteil',
  'manuelle Berechnung Maut-Anteil',
  'manuelle Berechnung Maut-Anteil',
  'manuelle Berechnung Maut-Anteil')
UNION DISTINCT
SELECT 'MKUEH',
 'manuelle Berechnung Kühlung-Anteil',
 'manuelle Berechnung Kühlung-Anteil',
 'manuelle Berechnung Kühlung-Anteil',
 'manuelle Berechnung Kühlung-Anteil',
 'manuelle Berechnung Kühlung-Anteil',
 'manuelle Berechnung Kühlung-Anteil',
 'manuelle Berechnung Kühlung-Anteil',
 'manuelle Berechnung Kühlung-Anteil';