CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_monat_spr_zu_1 AS SELECT V01.kjmo,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 V01.kj,
 V01.mo_kj,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_de,
 CAST(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_cz,
 CAST(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_pl,
 CAST(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_sk,
 CAST(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_hr,
 CAST(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_ro,
 CAST(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_bg,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_de,
 CAST(MAX(CASE
    WHEN V02.spr_id = 124
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_cz,
 CAST(MAX(CASE
    WHEN V02.spr_id = 90
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_pl,
 CAST(MAX(CASE
    WHEN V02.spr_id = 108
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_sk,
 CAST(MAX(CASE
    WHEN V02.spr_id = 65
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_hr,
 CAST(MAX(CASE
    WHEN V02.spr_id = 95
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_ro,
 CAST(MAX(CASE
    WHEN V02.spr_id = 18
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_bg,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN CASE
     WHEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) = 'Mae'
     THEN 'Mrz'
     ELSE CAST(TRIM(SUBSTR(V02.mo_bez, 1, 3)) AS STRING)
     END
    ELSE NULL
    END) AS STRING) AS mo_kbez,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN CASE
     WHEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) = 'Mae'
     THEN 'Mrz'
     ELSE CAST(TRIM(SUBSTR(V02.mo_bez, 1, 3)) AS STRING)
     END
    ELSE NULL
    END) AS STRING) AS mo_kbez_de,
 CAST(MAX(CASE
    WHEN V02.spr_id = 124
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_cz,
 CAST(MAX(CASE
    WHEN V02.spr_id = 90
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_pl,
 CAST(MAX(CASE
    WHEN V02.spr_id = 108
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_sk,
 CAST(MAX(CASE
    WHEN V02.spr_id = 65
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_hr,
 CAST(MAX(CASE
    WHEN V02.spr_id = 95
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_ro,
 CAST(MAX(CASE
    WHEN V02.spr_id = 18
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_bg,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_de,
 CAST(MAX(CASE
    WHEN V02.spr_id = 124
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_cz,
 CAST(MAX(CASE
    WHEN V02.spr_id = 90
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_pl,
 CAST(MAX(CASE
    WHEN V02.spr_id = 108
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_sk,
 CAST(MAX(CASE
    WHEN V02.spr_id = 65
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_hr,
 CAST(MAX(CASE
    WHEN V02.spr_id = 95
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_ro,
 CAST(MAX(CASE
    WHEN V02.spr_id = 18
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_bg
FROM kfl_production_dbp_view.v_monat_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS V02 ON V01.mo_kj = V02.mo_id
GROUP BY V01.kjmo,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 V01.kj,
 V01.mo_kj;