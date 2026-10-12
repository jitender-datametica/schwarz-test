-- 13 Monate past (bis gestern)
 -- 2020.0818 ssch0611 : Extended weeks (history)
 -- 5 Wochen future (full)

-- 11 Wochen past (bis gestern)
 -- 2020.0204 ssch0611 : Review
 -- 12 Monate future (full)

-- ZEIT_2/HIERARCHIE : flexible/kombinierte Zeitstruktur - Basis Tag_2
 -- akt. GJ (full)
 -- 2020.0121 ssch0611 : Initial

-- 2020.0720 ssch0611 : Multi-Language
 -- 2 GJ past (bis gestern)
 -- 6 + 4 Wochen (full, day level)

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_zeit_tag_zu_2 (zeit_id, dat, akt_tag, wtag_id, kjwo, akt_wo,
kjmo, akt_mo, mo_kj, gj, akt_gj, kj) AS SELECT -10000 + CAST(ROUND(akt_gj * 10000) AS INTEGER) AS zeit_id,
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
FROM kfl_production_dbp_view.v_tag_2
WHERE akt_tag < 1
 AND akt_gj IN (-1, 0)
UNION ALL
SELECT -1000 + akt_mo * 100 + CAST(ROUND(akt_gj * 10000) AS INTEGER) AS zeit_id,
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
FROM kfl_production_dbp_view.v_tag_2
WHERE akt_tag < 1
 AND akt_mo BETWEEN -12 AND 0
UNION ALL
SELECT -100 + CAST(ROUND(akt_wo * 10) AS INTEGER) AS zeitraum_id,
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
FROM kfl_production_dbp_view.v_tag_2
WHERE akt_tag < 1
 AND akt_wo BETWEEN -10 AND 0
UNION ALL
SELECT 100 + CAST(ROUND(akt_wo * 10) AS INTEGER) AS zeitraum_id,
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
FROM kfl_production_dbp_view.v_tag_2
WHERE akt_wo BETWEEN 0 AND 4
UNION ALL
SELECT CAST(ROUND(akt_tag) AS INTEGER) AS zeit_id,
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
FROM kfl_production_dbp_view.v_tag_2
WHERE akt_wo BETWEEN -5 AND 4
UNION ALL
SELECT 1000 + akt_mo * 100 + CAST(ROUND(akt_gj * 10000) AS INTEGER) AS zeit_id,
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
FROM kfl_production_dbp_view.v_tag_2
WHERE akt_mo BETWEEN 0 AND 11
UNION ALL
SELECT 10000 + CAST(ROUND(akt_gj * 10000) AS INTEGER) AS zeit_id,
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
FROM kfl_production_dbp_view.v_tag_2
WHERE akt_gj IN (0);