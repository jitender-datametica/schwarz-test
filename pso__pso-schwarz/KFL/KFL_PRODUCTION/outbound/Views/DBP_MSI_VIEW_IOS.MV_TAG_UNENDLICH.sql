CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_tag_unendlich (dat, kj, akt_kj) AS SELECT dat,
 kj,
 akt_kj
FROM kfl_production_dbp_view.v_tag AS V01
WHERE akt_kj > - 3
UNION ALL
SELECT DISTINCT CAST('9999-12-31' AS DATE) AS dat,
 9999 AS kj,
 9999 AS akt_kj
FROM kfl_production_dbp_view.v_tag;