-- 14.06.2023 twie: SPEC0200542 Sprachview Monat_1
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_monat_spr_zu_1 (kjmo, gj,
mo_gj, gjmo, kj, mo_kj, mo_bez, mo_bez_cz, mo_bez_pl, mo_bez_sk, mo_bez_hr, mo_bez_ro, mo_bez_bg, mo_bez_lang,
mo_bez_lang_cz, mo_bez_lang_pl, mo_bez_lang_sk, mo_bez_lang_hr, mo_bez_lang_ro, mo_bez_lang_bg, mo_kbez, mo_kbez_cz,
mo_kbez_pl, mo_kbez_sk, mo_kbez_hr, mo_kbez_ro, mo_kbez_bg, mo_kbez_kj, mo_kbez_kj_cz, mo_kbez_kj_pl, mo_kbez_kj_sk,
mo_kbez_kj_hr, mo_kbez_kj_ro, mo_kbez_kj_bg) AS -- standard=deutsch
 -- standard=deutsch
 -- standard=deutsch

-- standard=deutsch
 SELECT v01.kjmo,
 v01.gj,
 v01.mo_gj,
 v01.gjmo,
 v01.kj,
 v01.mo_kj,
 MAX(CASE
   WHEN v02.spr_id = 22
   THEN CAST(v02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez,
 MAX(CASE
   WHEN v02.spr_id = 124
   THEN CAST(v02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_cz,
 MAX(CASE
   WHEN v02.spr_id = 90
   THEN CAST(v02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_pl,
 MAX(CASE
   WHEN v02.spr_id = 108
   THEN CAST(v02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_sk,
 MAX(CASE
   WHEN v02.spr_id = 65
   THEN CAST(v02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_hr,
 MAX(CASE
   WHEN v02.spr_id = 95
   THEN CAST(v02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_ro,
 MAX(CASE
   WHEN v02.spr_id = 18
   THEN CAST(v02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_bg,
 MAX(CASE
   WHEN v02.spr_id = 22
   THEN TRIM(v02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang,
 MAX(CASE
   WHEN v02.spr_id = 124
   THEN TRIM(v02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_cz,
 MAX(CASE
   WHEN v02.spr_id = 90
   THEN TRIM(v02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_pl,
 MAX(CASE
   WHEN v02.spr_id = 108
   THEN TRIM(v02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_sk,
 MAX(CASE
   WHEN v02.spr_id = 65
   THEN TRIM(v02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_hr,
 MAX(CASE
   WHEN v02.spr_id = 95
   THEN TRIM(v02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_ro,
 MAX(CASE
   WHEN v02.spr_id = 18
   THEN TRIM(v02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_bg,
 MAX(CASE
   WHEN v02.spr_id = 22
   THEN CAST(TRIM(SUBSTR(v02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez,
 MAX(CASE
   WHEN v02.spr_id = 124
   THEN CAST(TRIM(SUBSTR(v02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_cz,
 MAX(CASE
   WHEN v02.spr_id = 90
   THEN CAST(TRIM(SUBSTR(v02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_pl,
 MAX(CASE
   WHEN v02.spr_id = 108
   THEN CAST(TRIM(SUBSTR(v02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_sk,
 MAX(CASE
   WHEN v02.spr_id = 65
   THEN CAST(TRIM(SUBSTR(v02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_hr,
 MAX(CASE
   WHEN v02.spr_id = 95
   THEN CAST(TRIM(SUBSTR(v02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_ro,
 MAX(CASE
   WHEN v02.spr_id = 18
   THEN CAST(TRIM(SUBSTR(v02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_bg,
 MAX(CASE
   WHEN v02.spr_id = 22
   THEN TRIM(SUBSTR(v02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj,
 MAX(CASE
   WHEN v02.spr_id = 124
   THEN TRIM(SUBSTR(v02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_cz,
 MAX(CASE
   WHEN v02.spr_id = 90
   THEN TRIM(SUBSTR(v02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_pl,
 MAX(CASE
   WHEN v02.spr_id = 108
   THEN TRIM(SUBSTR(v02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_sk,
 MAX(CASE
   WHEN v02.spr_id = 65
   THEN TRIM(SUBSTR(v02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_hr,
 MAX(CASE
   WHEN v02.spr_id = 95
   THEN TRIM(SUBSTR(v02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_ro,
 MAX(CASE
   WHEN v02.spr_id = 18
   THEN TRIM(SUBSTR(v02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(v01.kj AS STRING), 1, 10)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_bg
FROM kfl_production_dbp_view.v_monat_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS v02 ON v01.mo_kj = v02.mo_id
WHERE v01.kjmo >= 202301
GROUP BY v01.kjmo,
 v01.gj,
 v01.mo_gj,
 v01.gjmo,
 v01.kj,
 v01.mo_kj;