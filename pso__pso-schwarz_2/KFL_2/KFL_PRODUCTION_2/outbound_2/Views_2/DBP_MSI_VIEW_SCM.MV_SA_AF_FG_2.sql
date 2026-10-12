CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_sa_af_fg_2 AS (SELECT CAST(- 1 AS BIGNUMERIC) AS sa_af_fg,
  'Alle (DIF)' AS sa_af_fg_bez
 UNION DISTINCT
 SELECT 1 AS sa_af_fg,
  'SA' AS sa_af_fg_bez)
UNION DISTINCT
SELECT 0 AS sa_af_fg,
 'AF' AS sa_af_fg_bez;