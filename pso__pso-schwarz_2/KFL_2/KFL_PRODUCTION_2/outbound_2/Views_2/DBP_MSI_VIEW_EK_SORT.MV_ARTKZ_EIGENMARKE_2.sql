CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_artkz_eigenmarke_2 AS SELECT '-1' AS eigenmarke_id,
 'Potenzial Eigenmarke' AS eigenmarke_bez,
 'Potenzial Eigenmarke' AS eigenmarke_bez_de,
 'Potenzial Eigenmarke' AS eigenmarke_bez_cz,
 'Potenzial Eigenmarke' AS eigenmarke_bez_sk,
 'Potenzial Eigenmarke' AS eigenmarke_bez_hr,
 'Potenzial Eigenmarke' AS eigenmarke_bez_pl,
 'Potenzial Eigenmarke' AS eigenmarke_bez_ro,
 'Potenzial Eigenmarke' AS eigenmarke_bez_bg
UNION ALL
SELECT eigenmarke_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22 AND mandant_id = 1
    THEN eigenmarke_bez
    ELSE NULL
    END), 'N/A') AS eigenmarke_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22 AND mandant_id = 1
    THEN eigenmarke_bez
    ELSE NULL
    END), 'N/A') AS eigenmarke_bez_de,
 MAX(COALESCE(CASE
    WHEN spr_id = 124 AND mandant_id = 2
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 2
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 1
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_cz,
 MAX(COALESCE(CASE
    WHEN spr_id = 108 AND mandant_id = 5
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 5
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 1
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_sk,
 MAX(COALESCE(CASE
    WHEN spr_id = 65 AND mandant_id = 6
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 6
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 1
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_hr,
 MAX(COALESCE(CASE
    WHEN spr_id = 90 AND mandant_id = 3
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 3
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 1
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_pl,
 MAX(COALESCE(CASE
    WHEN spr_id = 95 AND mandant_id = 7
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 7
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 1
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_ro,
 MAX(COALESCE(CASE
    WHEN spr_id = 18 AND mandant_id = 8
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 8
    THEN eigenmarke_bez
    ELSE NULL
    END, CASE
    WHEN spr_id = 22 AND mandant_id = 1
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_bg
FROM kfl_production_dbp_view.v_artkz_eigenmarke_2 AS V01
GROUP BY eigenmarke_id
UNION ALL
SELECT '0' AS eigenmarke_id,
 'Potenzial Marke' AS eigenmarke_bez,
 'Potenzial Marke' AS eigenmarke_bez_de,
 'Potenzial Marke' AS eigenmarke_bez_cz,
 'Potenzial Marke' AS eigenmarke_bez_sk,
 'Potenzial Marke' AS eigenmarke_bez_hr,
 'Potenzial Marke' AS eigenmarke_bez_pl,
 'Potenzial Marke' AS eigenmarke_bez_ro,
 'Potenzial Marke' AS eigenmarke_bez_bg;