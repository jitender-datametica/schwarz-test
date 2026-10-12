CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_tag_listung (dat, kjmo, kjwo, kj, akt_kj) AS SELECT dat,
 kjmo,
 kjwo,
 kj,
 akt_kj
FROM kfl_production_dbp_view.v_tag AS V01
WHERE akt_kj > - 3
UNION ALL
SELECT DISTINCT CAST('9999-12-31' AS DATE) AS dat,
 999912 AS kjmo,
 999952 AS kjwo,
 9999 AS kj,
 9999 AS akt_kj
FROM kfl_production_dbp_view.v_tag;