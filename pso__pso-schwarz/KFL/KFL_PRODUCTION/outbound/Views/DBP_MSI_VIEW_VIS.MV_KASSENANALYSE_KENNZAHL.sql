CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kassenanalyse_kennzahl (kassenanalyse_kennzahl_id,
kassenanalyse_kennzahl_bez, kassenanalyse_kennzahl_bez_cz, kassenanalyse_kennzahl_bez_sk, kassenanalyse_kennzahl_bez_hr
, kassenanalyse_kennzahl_bez_pl, kassenanalyse_kennzahl_bez_ro, kassenanalyse_kennzahl_bez_bg, kassenanalyse_kennzahl_z1
) AS SELECT CAST(a1 AS BIGNUMERIC) AS kassenanalyse_kennzahl_id,
 CAST(a2 AS STRING) AS kassenanalyse_kennzahl_bez,
 CAST(a2 AS STRING) AS kassenanalyse_kennzahl_bez_cz,
 CAST(a2 AS STRING) AS kassenanalyse_kennzahl_bez_sk,
 CAST(a2 AS STRING) AS kassenanalyse_kennzahl_bez_hr,
 CAST(a2 AS STRING) AS kassenanalyse_kennzahl_bez_pl,
 CAST(a2 AS STRING) AS kassenanalyse_kennzahl_bez_ro,
 CAST(a2 AS STRING) AS kassenanalyse_kennzahl_bez_bg,
 CAST(a3 AS STRING) AS kassenanalyse_kennzahl_z1
FROM (SELECT 10 AS a1,
    'Umsatz netto' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    '0T' AS a3
   UNION ALL
   SELECT 20 AS a1,
    'Anzahl Kunden (Bons)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    '0T' AS a3
   UNION ALL
   SELECT 30 AS a1,
    'Umsatzanteil' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    '0.00%' AS a3
   UNION ALL
   SELECT 40 AS a1,
    'Kundenanteil (Bons)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    '0.00%' AS a3
   UNION ALL
   SELECT 50 AS a1,
    'Bonzeilen je Kunde (Bons)' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    '0.00' AS a3
   UNION ALL
   SELECT 60 AS a1,
    '\u00d8-Bon' AS a2,
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    'TRNSLT',
    '0.00' AS a3) AS metrik;