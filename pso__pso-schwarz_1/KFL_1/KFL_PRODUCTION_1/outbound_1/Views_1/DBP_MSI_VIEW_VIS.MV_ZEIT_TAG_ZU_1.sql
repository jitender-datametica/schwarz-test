CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_zeit_tag_zu_1 AS SELECT - 10000 + CAST(akt_gj * 10000 AS BIGNUMERIC)
   AS zeit_id,
 dat,
 akt_tag,
 wtag_id,
 kjwo,
 akt_wo,
 kjmo,
 akt_mo,
 mo_kj,
 gj,
 akt_gj,
 kj
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_tag < 1
 AND akt_gj IN (- 1, 0)
UNION ALL
SELECT - 1000 + akt_mo * 100 + CAST(akt_gj * 10000 AS BIGNUMERIC) AS zeit_id,
 dat,
 akt_tag,
 wtag_id,
 kjwo,
 akt_wo,
 kjmo,
 akt_mo,
 mo_kj,
 gj,
 akt_gj,
 kj
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_tag < 1
 AND akt_mo BETWEEN - 12 AND 0
UNION ALL
SELECT - 100 + CAST(akt_wo * 10 AS BIGNUMERIC) AS zeitraum_id,
 dat,
 akt_tag,
 wtag_id,
 kjwo,
 akt_wo,
 kjmo,
 akt_mo,
 mo_kj,
 gj,
 akt_gj,
 kj
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_tag < 1
 AND akt_wo BETWEEN - 10 AND 0
UNION ALL
SELECT 100 + CAST(akt_wo * 10 AS BIGNUMERIC) AS zeitraum_id,
 dat,
 akt_tag,
 wtag_id,
 kjwo,
 akt_wo,
 kjmo,
 akt_mo,
 mo_kj,
 gj,
 akt_gj,
 kj
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_wo BETWEEN 0 AND 4
UNION ALL
SELECT CAST(akt_tag AS BIGNUMERIC) AS zeit_id,
 dat,
 akt_tag,
 wtag_id,
 kjwo,
 akt_wo,
 kjmo,
 akt_mo,
 mo_kj,
 gj,
 akt_gj,
 kj
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_wo BETWEEN - 5 AND 4
UNION ALL
SELECT 1000 + akt_mo * 100 + CAST(akt_gj * 10000 AS BIGNUMERIC) AS zeit_id,
 dat,
 akt_tag,
 wtag_id,
 kjwo,
 akt_wo,
 kjmo,
 akt_mo,
 mo_kj,
 gj,
 akt_gj,
 kj
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_mo BETWEEN 0 AND 11
UNION ALL
SELECT 10000 + CAST(akt_gj * 10000 AS BIGNUMERIC) AS zeit_id,
 dat,
 akt_tag,
 wtag_id,
 kjwo,
 akt_wo,
 kjmo,
 akt_mo,
 mo_kj,
 gj,
 akt_gj,
 kj
FROM kfl_production_dbp_view.v_tag_1
WHERE akt_gj IN (0);