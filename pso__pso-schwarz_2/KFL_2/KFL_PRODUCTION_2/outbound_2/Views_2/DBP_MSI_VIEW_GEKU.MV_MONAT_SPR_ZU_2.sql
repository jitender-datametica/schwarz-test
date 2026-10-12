CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_monat_spr_zu_2 (kjmo, gj, mo_gj, gjmo, kj, mo_kj, mo_bez,
mo_bez_cz, mo_bez_pl, mo_bez_sk, mo_bez_hr, mo_bez_ro, mo_bez_bg, mo_bez_lang, mo_bez_lang_cz, mo_bez_lang_pl,
mo_bez_lang_sk, mo_bez_lang_hr, mo_bez_lang_ro, mo_bez_lang_bg, mo_kbez, mo_kbez_cz, mo_kbez_pl, mo_kbez_sk, mo_kbez_hr
, mo_kbez_ro, mo_kbez_bg, mo_kbez_kj, mo_kbez_kj_cz, mo_kbez_kj_pl, mo_kbez_kj_sk, mo_kbez_kj_hr, mo_kbez_kj_ro,
mo_kbez_kj_bg) AS SELECT V01.kjmo,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 V01.kj,
 V01.mo_kj,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN CAST(V02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez,
 MAX(CASE
   WHEN V02.spr_id = 124
   THEN CAST(V02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_cz,
 MAX(CASE
   WHEN V02.spr_id = 90
   THEN CAST(V02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_pl,
 MAX(CASE
   WHEN V02.spr_id = 108
   THEN CAST(V02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_sk,
 MAX(CASE
   WHEN V02.spr_id = 65
   THEN CAST(V02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_hr,
 MAX(CASE
   WHEN V02.spr_id = 95
   THEN CAST(V02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_ro,
 MAX(CASE
   WHEN V02.spr_id = 18
   THEN CAST(V02.mo_bez AS STRING)
   ELSE NULL
   END) AS mo_bez_bg,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang,
 MAX(CASE
   WHEN V02.spr_id = 124
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_cz,
 MAX(CASE
   WHEN V02.spr_id = 90
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_pl,
 MAX(CASE
   WHEN V02.spr_id = 108
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_sk,
 MAX(CASE
   WHEN V02.spr_id = 65
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_hr,
 MAX(CASE
   WHEN V02.spr_id = 95
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_ro,
 MAX(CASE
   WHEN V02.spr_id = 18
   THEN TRIM(V02.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_bez_lang_bg,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN CAST(TRIM(SUBSTR(V02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez,
 MAX(CASE
   WHEN V02.spr_id = 124
   THEN CAST(TRIM(SUBSTR(V02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_cz,
 MAX(CASE
   WHEN V02.spr_id = 90
   THEN CAST(TRIM(SUBSTR(V02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_pl,
 MAX(CASE
   WHEN V02.spr_id = 108
   THEN CAST(TRIM(SUBSTR(V02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_sk,
 MAX(CASE
   WHEN V02.spr_id = 65
   THEN CAST(TRIM(SUBSTR(V02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_hr,
 MAX(CASE
   WHEN V02.spr_id = 95
   THEN CAST(TRIM(SUBSTR(V02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_ro,
 MAX(CASE
   WHEN V02.spr_id = 18
   THEN CAST(TRIM(SUBSTR(V02.mo_bez, 1, 3)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_bg,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj,
 MAX(CASE
   WHEN V02.spr_id = 124
   THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_cz,
 MAX(CASE
   WHEN V02.spr_id = 90
   THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_pl,
 MAX(CASE
   WHEN V02.spr_id = 108
   THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_sk,
 MAX(CASE
   WHEN V02.spr_id = 65
   THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_hr,
 MAX(CASE
   WHEN V02.spr_id = 95
   THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_ro,
 MAX(CASE
   WHEN V02.spr_id = 18
   THEN TRIM(SUBSTR(V02.mo_bez, 1, 3)) || ' ' || CAST(TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) AS STRING)
   ELSE NULL
   END) AS mo_kbez_kj_bg
FROM kfl_production_dbp_view.v_monat_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_2 AS V02 ON V01.mo_kj = V02.mo_id
GROUP BY V01.kjmo,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 V01.kj,
 V01.mo_kj;