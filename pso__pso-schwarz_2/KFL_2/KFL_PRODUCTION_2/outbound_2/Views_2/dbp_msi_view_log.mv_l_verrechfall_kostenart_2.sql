CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_verrechfall_kostenart_2 (verrechfall_kostenart_id,
verrechnungsart_id, verrechfall_kostentyp_id) AS (((((SELECT verrechfall_kostenart_id,
      verrechnungsart_id,
      verrechfall_kostentyp_id
     FROM kfl_production_dbp_view.v_l_verrechfall_kostenart_2 AS V01
     GROUP BY verrechfall_kostenart_id,
      verrechfall_kostentyp_id,
      verrechnungsart_id
     UNION DISTINCT
     SELECT 'K/NA',
      'K/NA',
      'K/NA'
     FROM kfl_production_dbp_view.v_l_verrechfall_kostenart_2 AS V01
     GROUP BY verrechfall_kostenart_id,
      verrechfall_kostentyp_id,
      verrechnungsart_id)
    UNION DISTINCT
    SELECT 'MDIES',
     'M',
     CAST(NULL AS STRING))
   UNION DISTINCT
   SELECT 'MSTRO',
    'M',
    CAST(NULL AS STRING))
  UNION DISTINCT
  SELECT 'MGAS',
   'M',
   CAST(NULL AS STRING))
 UNION DISTINCT
 SELECT 'MMAUT',
  'M',
  CAST(NULL AS STRING))
UNION DISTINCT
SELECT 'MKUEH',
 'M',
 CAST(NULL AS STRING);