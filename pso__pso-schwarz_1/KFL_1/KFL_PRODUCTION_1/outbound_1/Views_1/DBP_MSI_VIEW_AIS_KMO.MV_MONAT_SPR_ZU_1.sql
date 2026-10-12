CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_monat_spr_zu_1 (mo_kj, mo_bez, mo_bez_de, mo_bez_cz,
mo_bez_sk, mo_bez_hr, mo_bez_pl, mo_bez_ro, mo_bez_bg, kjmo, kj, mo_bez_lang, mo_bez_lang_de, mo_bez_lang_cz,
mo_bez_lang_sk, mo_bez_lang_hr, mo_bez_lang_pl, mo_bez_lang_ro, mo_bez_lang_bg) AS SELECT V01.mo_id AS mo_kj,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN CAST(V01.mo_bez AS STRING)
    ELSE NULL
    END), 'N/A') AS mo_bez,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN CAST(V01.mo_bez AS STRING)
    ELSE NULL
    END), 'N/A') AS mo_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN CAST(V01.mo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN CAST(V01.mo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN CAST(V01.mo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN CAST(V01.mo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN CAST(V01.mo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN CAST(V01.mo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN CAST(V01.mo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN CAST(V01.mo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN CAST(V01.mo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN CAST(V01.mo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN CAST(V01.mo_bez AS STRING)
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN CAST(V01.mo_bez AS STRING)
     ELSE NULL
     END), 'N/A')) AS mo_bez_bg,
 V02.kjmo,
 V02.kj,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
    ELSE NULL
    END), 'N/A') AS mo_bez_lang,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
    ELSE NULL
    END), 'N/A') AS mo_bez_lang_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN TRIM(V01.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39))
     ELSE NULL
     END), 'N/A')) AS mo_bez_lang_bg
FROM kfl_production_dbp_view.v_monat_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS V02 ON V01.mo_id = V02.mo_kj
GROUP BY V01.mo_id,
 V02.kjmo,
 V02.kj;