-- 2023-06-28,dknop, initial
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_tag_incl_null_2 (dat
, kjwo, kjmo, kj, gj) AS SELECT dat,
 kjwo,
 kjmo,
 kj,
 akt_gj AS gj
FROM kfl_production_dbp_view.v_tag_2 AS V01
WHERE akt_gj BETWEEN -11 AND 1
UNION DISTINCT
SELECT CAST('1900-01-01' AS DATE),
 CAST(NULL AS BIGNUMERIC),
 CAST(NULL AS BIGNUMERIC),
 CAST(NULL AS BIGNUMERIC),
 CAST(NULL AS BIGNUMERIC);