CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_erwartete_entwicklung_neu_1 (mandant_id, kjmo, kjwo_update,
matching_id, wrg_id, owg_id, wg_id, wug_id, sm_id, ksm_id, ost_basis_pflege, ost_gross_pflege, sued_ost_pflege,
sued_west_pflege, west_pflege, nord_pflege, umsatz_hr, absatz_hr, rohertrag_hr) AS SELECT mandant_id,
 kjmo,
 kjwo_update,
 matching_id,
 wrg_id,
 owg_id,
 wg_id,
 wug_id,
 sm_id,
 ksm_id,
  CASE
  WHEN TRIM(ost_basis_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(ost_basis_pflege) AS STRING)
  END AS ost_basis_pflege,
  CASE
  WHEN TRIM(ost_gross_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(ost_gross_pflege) AS STRING)
  END AS ost_gross_pflege,
  CASE
  WHEN TRIM(sued_ost_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(sued_ost_pflege) AS STRING)
  END AS sued_ost_pflege,
  CASE
  WHEN TRIM(sued_west_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(sued_west_pflege) AS STRING)
  END AS sued_west_pflege,
  CASE
  WHEN TRIM(west_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(west_pflege) AS STRING)
  END AS west_pflege,
  CASE
  WHEN TRIM(nord_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(nord_pflege) AS STRING)
  END AS nord_pflege,
 umsatz_hr,
 absatz_hr,
 rohertrag_hr
FROM kfl_production_dbp_msi_v_view.v_erwartete_entwicklung_1
UNION DISTINCT
SELECT V01.mandant_id,
 V01.kjmo,
 V01.kjwo_update,
 V01.matching_id,
 V01.wrg_id,
 V01.owg_id,
 V01.wg_id,
 V01.wug_id,
 v02.sm_id,
 v02.ksm_id,
  CASE
  WHEN TRIM(V01.ost_basis_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(V01.ost_basis_pflege) AS STRING)
  END AS v01_ost_basis_pflege_v01_ost_basis_pflege,
  CASE
  WHEN TRIM(V01.ost_gross_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(V01.ost_gross_pflege) AS STRING)
  END AS v01_ost_gross_pflege_v01_ost_gross_pflege,
  CASE
  WHEN TRIM(V01.sued_ost_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(V01.sued_ost_pflege) AS STRING)
  END AS v01_sued_ost_pflege_v01_sued_ost_pflege,
  CASE
  WHEN TRIM(V01.sued_west_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(V01.sued_west_pflege) AS STRING)
  END AS v01_sued_west_pflege_v01_sued_west_pflege,
  CASE
  WHEN TRIM(V01.west_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(V01.west_pflege) AS STRING)
  END AS v01_west_pflege_v01_west_pflege,
  CASE
  WHEN TRIM(V01.nord_pflege) = 'u'
  THEN 'x'
  ELSE CAST(TRIM(V01.nord_pflege) AS STRING)
  END AS v01_nord_pflege_v01_nord_pflege,
 0 AS umsatz_hr,
 0 AS absatz_hr,
 0 AS rohertrag_hr
FROM kfl_production_dbp_msi_v_view.v_erwartete_entwicklung_1 AS V01
 INNER JOIN (SELECT - 1 AS sm_id,
    'K1' AS ksm_id
   UNION ALL
   SELECT - 1 AS sm_id,
    'K2' AS ksm_id
   UNION ALL
   SELECT - 1 AS sm_id,
    'K3' AS ksm_id
   UNION ALL
   SELECT - 1 AS sm_id,
    'K4' AS ksm_id
   UNION ALL
   SELECT - 1 AS sm_id,
    'K5' AS ksm_id
   UNION ALL
   SELECT - 1 AS sm_id,
    'K6' AS ksm_id
   UNION ALL
   SELECT - 1 AS sm_id,
    'K7' AS ksm_id
   UNION ALL
   SELECT - 1 AS sm_id,
    'K8' AS ksm_id
   UNION ALL
   SELECT - 1 AS sm_id,
    'K9' AS ksm_id
   UNION ALL
   SELECT 1 AS sm_id,
    '' AS ksm_id
   UNION ALL
   SELECT 2 AS sm_id,
    '' AS ksm_id
   UNION ALL
   SELECT 3 AS sm_id,
    '' AS ksm_id
   UNION ALL
   SELECT 4 AS sm_id,
    '' AS ksm_id
   UNION ALL
   SELECT 5 AS sm_id,
    '' AS ksm_id) AS v02 ON V01.mandant_id = 1 AND v02.ksm_id = ''
WHERE V01.mandant_id <> 1;