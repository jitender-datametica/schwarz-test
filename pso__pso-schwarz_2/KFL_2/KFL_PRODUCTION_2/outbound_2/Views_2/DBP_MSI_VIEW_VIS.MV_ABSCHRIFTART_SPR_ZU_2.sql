CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abschriftart_spr_zu_2 AS SELECT mandant_id,
 abschriftart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschriftart_bez
   ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_id AS STRING), 1, 39))
   END) AS abschriftart_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN abschriftart_bez
   ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_id AS STRING), 1, 39))
   END) AS abschriftart_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN abschriftart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_id AS STRING), 1, 39))
    END)) AS abschriftart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN abschriftart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_id AS STRING), 1, 39))
    END)) AS abschriftart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN abschriftart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_id AS STRING), 1, 39))
    END)) AS abschriftart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN abschriftart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_id AS STRING), 1, 39))
    END)) AS abschriftart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN abschriftart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_id AS STRING), 1, 39))
    END)) AS abschriftart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN abschriftart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abschriftart_bez
    ELSE 'AKZ ' || TRIM(SUBSTR(CAST(abschriftart_id AS STRING), 1, 39))
    END)) AS abschriftart_bez_bg
FROM kfl_production_dbp_view.v_abschriftart_spr_zu_2 AS V01
GROUP BY mandant_id,
 abschriftart_id;