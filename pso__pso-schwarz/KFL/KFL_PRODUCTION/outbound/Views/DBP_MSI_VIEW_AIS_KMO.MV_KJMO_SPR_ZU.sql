CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_kjmo_spr_zu (mo_bez, mo_bez_de, mo_bez_cz, mo_bez_sk,
mo_bez_hr, mo_bez_pl, mo_bez_ro, mo_bez_bg, kjmo, kj, gjmo, gj, mo_bez_lang, mo_bez_lang_de, mo_bez_lang_cz,
mo_bez_lang_sk, mo_bez_lang_hr, mo_bez_lang_pl, mo_bez_lang_ro, mo_bez_lang_bg) AS SELECT COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN CAST(kjmo_bez AS STRING)
    ELSE NULL
    END), 'N/A') AS mo_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN CAST(kjmo_bez AS STRING)
    ELSE NULL
    END), 'N/A') AS mo_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN CAST(kjmo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(kjmo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN CAST(kjmo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(kjmo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN CAST(kjmo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(kjmo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN CAST(kjmo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(kjmo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN CAST(kjmo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(kjmo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN CAST(kjmo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(kjmo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_bg,
 kjmo,
 ROUND(CAST(SUBSTR(SUBSTR(CAST(kjmo AS STRING), 1, 39), 0, 4) AS BIGNUMERIC), 0) AS kj,
 gjmo,
 ROUND(CAST(SUBSTR(SUBSTR(CAST(gjmo AS STRING), 1, 39), 0, 4) AS BIGNUMERIC), 0) AS gj,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
    ELSE NULL
    END), 'N/A') AS mo_bez_lang,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
    ELSE NULL
    END), 'N/A') AS mo_bez_lang_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(TRIM(kjmo_bez_lang) AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_bg
FROM kfl_production_dbp_view.v_kjmo_spr_zu AS V01
WHERE kjmo >= 200201
GROUP BY kjmo_bez,
 kjmo,
 gjmo,
 kjmo_bez_lang;