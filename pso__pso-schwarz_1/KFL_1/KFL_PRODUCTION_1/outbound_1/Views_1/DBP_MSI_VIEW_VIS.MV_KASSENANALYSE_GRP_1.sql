CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kassenanalyse_grp_1 (kassenanalyse_grp_id, kassenanalyse_grp_bez
, kassenanalyse_grp_bez_cz, kassenanalyse_grp_bez_sk, kassenanalyse_grp_bez_hr, kassenanalyse_grp_bez_pl,
kassenanalyse_grp_bez_ro, kassenanalyse_grp_bez_bg, kassenanalyse_grp_block) AS SELECT CAST(a1 AS BIGNUMERIC) AS
 kassenanalyse_grp_id,
 CAST(a2 AS STRING) AS kassenanalyse_grp_bez,
 CAST(a2 AS STRING) AS kassenanalyse_grp_bez_cz,
 CAST(a2 AS STRING) AS kassenanalyse_grp_bez_sk,
 CAST(a2 AS STRING) AS kassenanalyse_grp_bez_hr,
 CAST(a2 AS STRING) AS kassenanalyse_grp_bez_pl,
 CAST(a2 AS STRING) AS kassenanalyse_grp_bez_ro,
 CAST(a2 AS STRING) AS kassenanalyse_grp_bez_bg,
 CAST(a3 AS BIGNUMERIC) AS kassenanalyse_grp_block
FROM (SELECT 0 AS a1,
    'Filiale (ohne Info und Imbiss)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    0 AS a3
   UNION ALL
   SELECT 1 AS a1,
    'Filiale inkl. Info und Imbiss' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    1 AS a3
   UNION ALL
   SELECT 2 AS a1,
    'Konventionelle Kassen (ohne K-Scan)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    2 AS a3
   UNION ALL
   SELECT 3 AS a1,
    'SCO Kassen (ohne K-Scan)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    3 AS a3
   UNION ALL
   SELECT 4 AS a1,
    'davon SCO cash (ohne K-Scan)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    3 AS a3
   UNION ALL
   SELECT 5 AS a1,
    'davon SCO cashless (ohne K-Scan)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    3 AS a3
   UNION ALL
   SELECT 6 AS a1,
    'K-Scan Gesamt' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    4 AS a3
   UNION ALL
   SELECT 7 AS a1,
    'davon K-Scan an Paystation' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    4 AS a3
   UNION ALL
   SELECT 8 AS a1,
    'Info (ohne K-Scan)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    5 AS a3
   UNION ALL
   SELECT 9 AS a1,
    'Imbiss (ohne K-Scan)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    6 AS a3) AS grp;