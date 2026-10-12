CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_competitor_company_group_1 (mandant_id, competitor_sort_id,
competitor_sort_name) AS SELECT CAST(a1 AS BIGNUMERIC) AS mandant_id,
 CAST(a2 AS BIGNUMERIC) AS competitor_sort_id,
 CAST(a3 AS STRING) AS competitor_sort_name
FROM (SELECT 1 AS a1,
    10 AS a2,
    'Lidl' AS a3
   UNION ALL
   SELECT 1 AS a1,
    20 AS a2,
    'Edeka' AS a3
   UNION ALL
   SELECT 1 AS a1,
    30 AS a2,
    'Aldi Nord' AS a3
   UNION ALL
   SELECT 1 AS a1,
    40 AS a2,
    'Aldi Süd' AS a3
   UNION ALL
   SELECT 1 AS a1,
    50 AS a2,
    'REWE' AS a3
   UNION ALL
   SELECT 1 AS a1,
    60 AS a2,
    'Globus' AS a3
   UNION ALL
   SELECT 1 AS a1,
    999 AS a2,
    'undefiniert' AS a3
   UNION ALL
   SELECT 2 AS a1,
    10 AS a2,
    'Lidl' AS a3
   UNION ALL
   SELECT 2,
    20,
    'Albert'
   UNION ALL
   SELECT 2,
    30,
    'Penny'
   UNION ALL
   SELECT 2,
    40,
    'Tesco'
   UNION ALL
   SELECT 2,
    50,
    'Billa'
   UNION ALL
   SELECT 2,
    60,
    'Globus'
   UNION ALL
   SELECT 2,
    70,
    'Coop'
   UNION ALL
   SELECT 2,
    999,
    'undefiniert'
   UNION ALL
   SELECT 3 AS a1,
    10 AS a2,
    'Lidl' AS a3
   UNION ALL
   SELECT 3,
    20,
    'Biedronka'
   UNION ALL
   SELECT 3,
    30,
    'Auchan'
   UNION ALL
   SELECT 3,
    40,
    'Carrefour'
   UNION ALL
   SELECT 3,
    50,
    'Netto'
   UNION ALL
   SELECT 3,
    60,
    'Aldi'
   UNION ALL
   SELECT 3,
    70,
    'Dino'
   UNION ALL
   SELECT 3,
    80,
    'Stokrotka'
   UNION ALL
   SELECT 3,
    999,
    'undefiniert'
   UNION ALL
   SELECT 4 AS a1,
    10 AS a2,
    'Linella' AS a3
   UNION ALL
   SELECT 4,
    20,
    'Metro'
   UNION ALL
   SELECT 4,
    30,
    'Green Hills'
   UNION ALL
   SELECT 4,
    40,
    'NR 1'
   UNION ALL
   SELECT 4,
    50,
    'Fidesco'
   UNION ALL
   SELECT 4,
    60,
    'Fourchette'
   UNION ALL
   SELECT 4,
    70,
    'Velmart'
   UNION ALL
   SELECT 4,
    999,
    'undefiniert'
   UNION ALL
   SELECT 5 AS a1,
    10 AS a2,
    'Lidl' AS a3
   UNION ALL
   SELECT 5,
    20,
    'Coop'
   UNION ALL
   SELECT 5,
    30,
    'Tesco'
   UNION ALL
   SELECT 5,
    40,
    'Billa'
   UNION ALL
   SELECT 5,
    50,
    'Fresh'
   UNION ALL
   SELECT 5,
    60,
    'Terno'
   UNION ALL
   SELECT 5,
    999,
    'undefiniert'
   UNION ALL
   SELECT 6 AS a1,
    10 AS a2,
    'Lidl' AS a3
   UNION ALL
   SELECT 6,
    20,
    'Konzum'
   UNION ALL
   SELECT 6,
    30,
    'Plodine'
   UNION ALL
   SELECT 6,
    40,
    'Interspar'
   UNION ALL
   SELECT 6,
    50,
    'Spar'
   UNION ALL
   SELECT 6,
    60,
    'Tommy'
   UNION ALL
   SELECT 6,
    70,
    'Euro Spin'
   UNION ALL
   SELECT 6,
    999,
    'undefiniert'
   UNION ALL
   SELECT 7 AS a1,
    10 AS a2,
    'Lidl' AS a3
   UNION ALL
   SELECT 7,
    20,
    'Carrefour'
   UNION ALL
   SELECT 7,
    30,
    'Profi'
   UNION ALL
   SELECT 7,
    40,
    'Penny'
   UNION ALL
   SELECT 7,
    50,
    'Auchan'
   UNION ALL
   SELECT 7,
    60,
    'Mega Image'
   UNION ALL
   SELECT 7,
    999,
    'undefiniert'
   UNION ALL
   SELECT 8 AS a1,
    10 AS a2,
    'Lidl' AS a3
   UNION ALL
   SELECT 8,
    20,
    'Billa'
   UNION ALL
   SELECT 8,
    30,
    'Fantastico'
   UNION ALL
   SELECT 8,
    40,
    'T-Market'
   UNION ALL
   SELECT 8,
    50,
    'CBA'
   UNION ALL
   SELECT 8,
    60,
    'Metro'
   UNION ALL
   SELECT 8,
    70,
    'Parkmart'
   UNION ALL
   SELECT 8,
    999,
    'undefiniert') AS sub;