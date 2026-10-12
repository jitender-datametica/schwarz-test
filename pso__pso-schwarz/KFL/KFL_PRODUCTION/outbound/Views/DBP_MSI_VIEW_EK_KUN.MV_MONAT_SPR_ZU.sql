CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_monat_spr_zu (kjmo, gj, mo_gj, gjmo, kj, mo_kj, mo_bez_en,
mo_bez, mo_bez_cz, mo_bez_pl, mo_bez_sk, mo_bez_hr, mo_bez_ro, mo_bez_bg, mo_bez_lang, mo_bez_lang_cz, mo_bez_lang_pl,
mo_bez_lang_sk, mo_bez_lang_hr, mo_bez_lang_ro, mo_bez_lang_bg) AS SELECT V01.kjmo,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 V01.kj,
 V01.mo_kj,
 CAST(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN V02.spr_id = 24
     THEN V02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN V02.spr_id = 24
     THEN V02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN V02.spr_id = 24
     THEN V02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN V02.spr_id = 24
     THEN V02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN V02.spr_id = 24
     THEN V02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN V02.spr_id = 24
     THEN V02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN V02.spr_id = 24
     THEN V02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_bg,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang,
 MAX(CASE
   WHEN V02.spr_id = 124
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_cz,
 MAX(CASE
   WHEN V02.spr_id = 90
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_pl,
 MAX(CASE
   WHEN V02.spr_id = 108
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_sk,
 MAX(CASE
   WHEN V02.spr_id = 65
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_hr,
 MAX(CASE
   WHEN V02.spr_id = 95
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_ro,
 MAX(CASE
   WHEN V02.spr_id = 18
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_bg
FROM kfl_production_dbp_data.monat AS V01
 INNER JOIN kfl_production_dbp_data.monat_spr_zu AS V02 ON V01.mo_kj = V02.mo_id
GROUP BY V01.kjmo,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 V01.kj,
 V01.mo_kj;