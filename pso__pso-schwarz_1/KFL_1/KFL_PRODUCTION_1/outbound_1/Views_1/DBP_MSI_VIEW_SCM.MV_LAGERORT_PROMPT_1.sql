CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_lagerort_prompt_1 (lagerort_uid, lagerort_bez, lagerort_bez_de,
lagerort_bez_cz, lagerort_bez_sk, lagerort_bez_hr, lagerort_bez_pl, lagerort_bez_ro, lagerort_bez_bg) AS SELECT
 lagerort_uid,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagerort_bez
   ELSE NULL
   END) AS lagerort_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagerort_bez
   ELSE NULL
   END) AS lagerort_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN lagerort_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerort_bez
    ELSE NULL
    END)) AS lagerort_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN lagerort_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerort_bez
    ELSE NULL
    END)) AS lagerort_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN lagerort_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerort_bez
    ELSE NULL
    END)) AS lagerort_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN lagerort_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerort_bez
    ELSE NULL
    END)) AS lagerort_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN lagerort_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerort_bez
    ELSE NULL
    END)) AS lagerort_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN lagerort_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerort_bez
    ELSE NULL
    END)) AS lagerort_bez_bg
FROM (SELECT 1 AS lagerort_uid,
    'Food' AS lagerort_bez,
    22 AS spr_id
   UNION ALL
   SELECT 2 AS lagerort_uid,
    'Frische' AS lagerort_bez,
    22 AS spr_id
   UNION ALL
   SELECT 3 AS lagerort_uid,
    'TKK' AS lagerort_bez,
    22 AS spr_id
   UNION ALL
   SELECT 4 AS lagerort_uid,
    'Non Food' AS lagerort_bez,
    22 AS spr_id
   UNION ALL
   SELECT 5 AS lagerort_uid,
    'Obst & Gemüse' AS lagerort_bez,
    22 AS spr_id
   UNION ALL
   SELECT 6 AS lagerort_uid,
    'Blumen/Pflanzen' AS lagerort_bez,
    22 AS spr_id
   UNION ALL
   SELECT 1 AS lagerort_uid,
    'Food' AS lagerort_bez,
    124 AS spr_id
   UNION ALL
   SELECT 2 AS lagerort_uid,
    'Fresh' AS lagerort_bez,
    124 AS spr_id
   UNION ALL
   SELECT 3 AS lagerort_uid,
    'Frozen Food' AS lagerort_bez,
    124 AS spr_id
   UNION ALL
   SELECT 4 AS lagerort_uid,
    'Non Food' AS lagerort_bez,
    124 AS spr_id
   UNION ALL
   SELECT 5 AS lagerort_uid,
    'Fruits & Vegetables' AS lagerort_bez,
    124 AS spr_id
   UNION ALL
   SELECT 6 AS lagerort_uid,
    'Flowers/Plants' AS lagerort_bez,
    124 AS spr_id
   UNION ALL
   SELECT 1 AS lagerort_uid,
    'Food' AS lagerort_bez,
    108 AS spr_id
   UNION ALL
   SELECT 2 AS lagerort_uid,
    'Fresh' AS lagerort_bez,
    108 AS spr_id
   UNION ALL
   SELECT 3 AS lagerort_uid,
    'Frozen Food' AS lagerort_bez,
    108 AS spr_id
   UNION ALL
   SELECT 4 AS lagerort_uid,
    'Non Food' AS lagerort_bez,
    108 AS spr_id
   UNION ALL
   SELECT 5 AS lagerort_uid,
    'Fruits & Vegetables' AS lagerort_bez,
    108 AS spr_id
   UNION ALL
   SELECT 6 AS lagerort_uid,
    'Flowers/Plants' AS lagerort_bez,
    108 AS spr_id
   UNION ALL
   SELECT 1 AS lagerort_uid,
    'Food' AS lagerort_bez,
    65 AS spr_id
   UNION ALL
   SELECT 2 AS lagerort_uid,
    'Fresh' AS lagerort_bez,
    65 AS spr_id
   UNION ALL
   SELECT 3 AS lagerort_uid,
    'Frozen Food' AS lagerort_bez,
    65 AS spr_id
   UNION ALL
   SELECT 4 AS lagerort_uid,
    'Non Food' AS lagerort_bez,
    65 AS spr_id
   UNION ALL
   SELECT 5 AS lagerort_uid,
    'Fruits & Vegetables' AS lagerort_bez,
    65 AS spr_id
   UNION ALL
   SELECT 6 AS lagerort_uid,
    'Flowers/Plants' AS lagerort_bez,
    65 AS spr_id
   UNION ALL
   SELECT 1 AS lagerort_uid,
    'Food' AS lagerort_bez,
    90 AS spr_id
   UNION ALL
   SELECT 2 AS lagerort_uid,
    'Fresh' AS lagerort_bez,
    90 AS spr_id
   UNION ALL
   SELECT 3 AS lagerort_uid,
    'Frozen Food' AS lagerort_bez,
    90 AS spr_id
   UNION ALL
   SELECT 4 AS lagerort_uid,
    'Non Food' AS lagerort_bez,
    90 AS spr_id
   UNION ALL
   SELECT 5 AS lagerort_uid,
    'Fruits & Vegetables' AS lagerort_bez,
    90 AS spr_id
   UNION ALL
   SELECT 6 AS lagerort_uid,
    'Flowers/Plants' AS lagerort_bez,
    90 AS spr_id
   UNION ALL
   SELECT 1 AS lagerort_uid,
    'Food' AS lagerort_bez,
    95 AS spr_id
   UNION ALL
   SELECT 2 AS lagerort_uid,
    'Fresh' AS lagerort_bez,
    95 AS spr_id
   UNION ALL
   SELECT 3 AS lagerort_uid,
    'Frozen Food' AS lagerort_bez,
    95 AS spr_id
   UNION ALL
   SELECT 4 AS lagerort_uid,
    'Non Food' AS lagerort_bez,
    95 AS spr_id
   UNION ALL
   SELECT 5 AS lagerort_uid,
    'Fruits & Vegetables' AS lagerort_bez,
    95 AS spr_id
   UNION ALL
   SELECT 6 AS lagerort_uid,
    'Flowers/Plants' AS lagerort_bez,
    95 AS spr_id
   UNION ALL
   SELECT 1 AS lagerort_uid,
    'Food' AS lagerort_bez,
    18 AS spr_id
   UNION ALL
   SELECT 2 AS lagerort_uid,
    'Fresh' AS lagerort_bez,
    18 AS spr_id
   UNION ALL
   SELECT 3 AS lagerort_uid,
    'Frozen Food' AS lagerort_bez,
    18 AS spr_id
   UNION ALL
   SELECT 4 AS lagerort_uid,
    'Non Food' AS lagerort_bez,
    18 AS spr_id
   UNION ALL
   SELECT 5 AS lagerort_uid,
    'Fruits & Vegetables' AS lagerort_bez,
    18 AS spr_id
   UNION ALL
   SELECT 6 AS lagerort_uid,
    'Flowers/Plants' AS lagerort_bez,
    18 AS spr_id)
GROUP BY lagerort_uid;