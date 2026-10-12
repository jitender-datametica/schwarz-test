CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_tms_konto (tms_konto_id, tms_konto_bez) AS (((((SELECT CAST(tms_konto_id AS STRING)
      AS tms_konto_id,
      MAX(tms_konto_bez) AS tms_konto_bez
     FROM kfl_production_dbp_view.v_tms_konto
     GROUP BY tms_konto_id
     UNION DISTINCT
     SELECT 'MFIX',
      'Speditionsfixkosten')
    UNION DISTINCT
    SELECT 'MDIES',
     'Frachtkosten Diesel')
   UNION DISTINCT
   SELECT 'MSTRO',
    'Frachtkosten Strom')
  UNION DISTINCT
  SELECT 'MGAS',
   'Frachtkosten Gas')
 UNION DISTINCT
 SELECT 'MMAUT',
  'Frachtkosten Maut')
UNION DISTINCT
SELECT 'MKUEH',
 'Frachtkosten Kühlung';