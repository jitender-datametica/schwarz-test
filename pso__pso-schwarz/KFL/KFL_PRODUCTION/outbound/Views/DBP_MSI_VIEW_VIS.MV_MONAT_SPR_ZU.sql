CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_monat_spr_zu (kjmo, kj, mo_kj, gj, mo_gj, gjmo, spr_id, mo_bez
, mo_bez_de, mo_bez_cz, mo_bez_sk, mo_bez_hr, mo_bez_pl, mo_bez_ro, mo_bez_bg, mo_bez_lang, mo_bez_lang_de,
mo_bez_lang_cz, mo_bez_lang_sk, mo_bez_lang_hr, mo_bez_lang_pl, mo_bez_lang_ro, mo_bez_lang_bg, mo_kbez, mo_kbez_de,
mo_kbez_cz, mo_kbez_sk, mo_kbez_hr, mo_kbez_pl, mo_kbez_ro, mo_kbez_bg, mo_kbez_kj, mo_kbez_kj_de, mo_kbez_kj_cz,
mo_kbez_kj_sk, mo_kbez_kj_hr, mo_kbez_kj_pl, mo_kbez_kj_ro, mo_kbez_kj_bg, mo_bez_aufg, mo_bez_aufg_de, mo_bez_aufg_cz,
mo_bez_aufg_sk, mo_bez_aufg_hr, mo_bez_aufg_pl, mo_bez_aufg_ro, mo_bez_aufg_bg, mo_kbez_aufg, mo_kbez_aufg_de,
mo_kbez_aufg_cz, mo_kbez_aufg_sk, mo_kbez_aufg_hr, mo_kbez_aufg_pl, mo_kbez_aufg_ro, mo_kbez_aufg_bg, mo_bez_gj_aufg,
mo_bez_gj_aufg_de, mo_bez_gj_aufg_cz, mo_bez_gj_aufg_sk, mo_bez_gj_aufg_hr, mo_bez_gj_aufg_pl, mo_bez_gj_aufg_ro,
mo_bez_gj_aufg_bg, mo_kbez_gj_aufg, mo_kbez_gj_aufg_de, mo_kbez_gj_aufg_cz, mo_kbez_gj_aufg_sk, mo_kbez_gj_aufg_hr,
mo_kbez_gj_aufg_pl, mo_kbez_gj_aufg_ro, mo_kbez_gj_aufg_bg, mo_kbez_kj_kbez, mo_kbez_kj_kbez_de, mo_kbez_kj_kbez_cz,
mo_kbez_kj_kbez_sk, mo_kbez_kj_kbez_hr, mo_kbez_kj_kbez_pl, mo_kbez_kj_kbez_ro, mo_kbez_kj_kbez_bg) AS SELECT V01.kjmo,
 V01.kj,
 V01.mo_kj,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 0 AS spr_id,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez)
    ELSE NULL
    END) AS STRING) AS mo_bez,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez)
    ELSE NULL
    END) AS STRING) AS mo_bez_de,
 CAST(MAX(CASE
    WHEN v02.spr_id = 124
    THEN TRIM(v02.mo_bez)
    ELSE NULL
    END) AS STRING) AS mo_bez_cz,
 CAST(MAX(CASE
    WHEN v02.spr_id = 108
    THEN TRIM(v02.mo_bez)
    ELSE NULL
    END) AS STRING) AS mo_bez_sk,
 CAST(MAX(CASE
    WHEN v02.spr_id = 65
    THEN TRIM(v02.mo_bez)
    ELSE NULL
    END) AS STRING) AS mo_bez_hr,
 CAST(MAX(CASE
    WHEN v02.spr_id = 90
    THEN TRIM(v02.mo_bez)
    ELSE NULL
    END) AS STRING) AS mo_bez_pl,
 CAST(MAX(CASE
    WHEN v02.spr_id = 95
    THEN TRIM(v02.mo_bez)
    ELSE NULL
    END) AS STRING) AS mo_bez_ro,
 CAST(MAX(CASE
    WHEN v02.spr_id = 18
    THEN TRIM(v02.mo_bez)
    ELSE NULL
    END) AS STRING) AS mo_bez_bg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_de,
 CAST(MAX(CASE
    WHEN v02.spr_id = 124
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_cz,
 CAST(MAX(CASE
    WHEN v02.spr_id = 108
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_sk,
 CAST(MAX(CASE
    WHEN v02.spr_id = 65
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_hr,
 CAST(MAX(CASE
    WHEN v02.spr_id = 90
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_pl,
 CAST(MAX(CASE
    WHEN v02.spr_id = 95
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_ro,
 CAST(MAX(CASE
    WHEN v02.spr_id = 18
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_bez_lang_bg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03)
    ELSE NULL
    END) AS STRING) AS mo_kbez,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03)
    ELSE NULL
    END) AS STRING) AS mo_kbez_de,
 CAST(MAX(CASE
    WHEN v02.spr_id = 124
    THEN TRIM(v02.mo_bez03)
    ELSE NULL
    END) AS STRING) AS mo_kbez_cz,
 CAST(MAX(CASE
    WHEN v02.spr_id = 108
    THEN TRIM(v02.mo_bez03)
    ELSE NULL
    END) AS STRING) AS mo_kbez_sk,
 CAST(MAX(CASE
    WHEN v02.spr_id = 65
    THEN TRIM(v02.mo_bez03)
    ELSE NULL
    END) AS STRING) AS mo_kbez_hr,
 CAST(MAX(CASE
    WHEN v02.spr_id = 90
    THEN TRIM(v02.mo_bez03)
    ELSE NULL
    END) AS STRING) AS mo_kbez_pl,
 CAST(MAX(CASE
    WHEN v02.spr_id = 95
    THEN TRIM(v02.mo_bez03)
    ELSE NULL
    END) AS STRING) AS mo_kbez_ro,
 CAST(MAX(CASE
    WHEN v02.spr_id = 18
    THEN TRIM(v02.mo_bez03)
    ELSE NULL
    END) AS STRING) AS mo_kbez_bg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_de,
 CAST(MAX(CASE
    WHEN v02.spr_id = 124
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_cz,
 CAST(MAX(CASE
    WHEN v02.spr_id = 108
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_sk,
 CAST(MAX(CASE
    WHEN v02.spr_id = 65
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_hr,
 CAST(MAX(CASE
    WHEN v02.spr_id = 90
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_pl,
 CAST(MAX(CASE
    WHEN v02.spr_id = 95
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_ro,
 CAST(MAX(CASE
    WHEN v02.spr_id = 18
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_bg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) || ' aufg.'
    ELSE NULL
    END) AS STRING) AS mo_bez_aufg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) || ' aufg.'
    ELSE NULL
    END) AS STRING) AS mo_bez_aufg_de,
 CAST(MAX(CASE
    WHEN v02.spr_id = 124
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_aufg_cz,
 CAST(MAX(CASE
    WHEN v02.spr_id = 108
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_aufg_sk,
 CAST(MAX(CASE
    WHEN v02.spr_id = 65
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_aufg_hr,
 CAST(MAX(CASE
    WHEN v02.spr_id = 90
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) || ' skum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_aufg_pl,
 CAST(MAX(CASE
    WHEN v02.spr_id = 95
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) || ' cum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_aufg_ro,
 CAST(MAX(CASE
    WHEN v02.spr_id = 18
    THEN TRIM(v02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39)) || ' кум.'
    ELSE NULL
    END) AS STRING) AS mo_bez_aufg_bg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03) || ' aufg.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_aufg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03) || ' aufg.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_aufg_de,
 CAST(MAX(CASE
    WHEN v02.spr_id = 124
    THEN TRIM(v02.mo_bez03) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_aufg_cz,
 CAST(MAX(CASE
    WHEN v02.spr_id = 108
    THEN TRIM(v02.mo_bez03) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_aufg_sk,
 CAST(MAX(CASE
    WHEN v02.spr_id = 65
    THEN TRIM(v02.mo_bez03) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_aufg_hr,
 CAST(MAX(CASE
    WHEN v02.spr_id = 90
    THEN TRIM(v02.mo_bez03) || ' skum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_aufg_pl,
 CAST(MAX(CASE
    WHEN v02.spr_id = 95
    THEN TRIM(v02.mo_bez03) || ' cum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_aufg_ro,
 CAST(MAX(CASE
    WHEN v02.spr_id = 18
    THEN TRIM(v02.mo_bez03) || ' кум.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_aufg_bg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez) || ' GJ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' aufg.'
    ELSE NULL
    END) AS STRING) AS mo_bez_gj_aufg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez) || ' GJ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' aufg.'
    ELSE NULL
    END) AS STRING) AS mo_bez_gj_aufg_de,
 CAST(MAX(CASE
    WHEN v02.spr_id = 124
    THEN TRIM(v02.mo_bez) || ' GJ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_gj_aufg_cz,
 CAST(MAX(CASE
    WHEN v02.spr_id = 108
    THEN TRIM(v02.mo_bez) || ' GJ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_gj_aufg_sk,
 CAST(MAX(CASE
    WHEN v02.spr_id = 65
    THEN TRIM(v02.mo_bez) || ' PG ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_gj_aufg_hr,
 CAST(MAX(CASE
    WHEN v02.spr_id = 90
    THEN TRIM(v02.mo_bez) || ' RO ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' skum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_gj_aufg_pl,
 CAST(MAX(CASE
    WHEN v02.spr_id = 95
    THEN TRIM(v02.mo_bez) || ' AF ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' cum.'
    ELSE NULL
    END) AS STRING) AS mo_bez_gj_aufg_ro,
 CAST(MAX(CASE
    WHEN v02.spr_id = 18
    THEN TRIM(v02.mo_bez) || ' ФГ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' кум.'
    ELSE NULL
    END) AS STRING) AS mo_bez_gj_aufg_bg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03) || ' GJ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' aufg.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_gj_aufg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03) || ' GJ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' aufg.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_gj_aufg_de,
 CAST(MAX(CASE
    WHEN v02.spr_id = 124
    THEN TRIM(v02.mo_bez03) || ' GJ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_gj_aufg_cz,
 CAST(MAX(CASE
    WHEN v02.spr_id = 108
    THEN TRIM(v02.mo_bez03) || ' GJ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_gj_aufg_sk,
 CAST(MAX(CASE
    WHEN v02.spr_id = 65
    THEN TRIM(v02.mo_bez03) || ' PG ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' kum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_gj_aufg_hr,
 CAST(MAX(CASE
    WHEN v02.spr_id = 90
    THEN TRIM(v02.mo_bez03) || ' RO ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' skum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_gj_aufg_pl,
 CAST(MAX(CASE
    WHEN v02.spr_id = 95
    THEN TRIM(v02.mo_bez03) || ' AF ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' cum.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_gj_aufg_ro,
 CAST(MAX(CASE
    WHEN v02.spr_id = 18
    THEN TRIM(v02.mo_bez03) || ' ФГ ' || TRIM(SUBSTR(CAST(V01.gj AS STRING), 1, 39)) || ' кум.'
    ELSE NULL
    END) AS STRING) AS mo_kbez_gj_aufg_bg,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 39), 3, 4))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_kbez,
 CAST(MAX(CASE
    WHEN v02.spr_id = 22
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 39), 3, 4))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_kbez_de,
 CAST(MAX(CASE
    WHEN v02.spr_id = 124
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 39), 3, 4))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_kbez_cz,
 CAST(MAX(CASE
    WHEN v02.spr_id = 108
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 39), 3, 4))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_kbez_sk,
 CAST(MAX(CASE
    WHEN v02.spr_id = 65
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 39), 3, 4))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_kbez_hr,
 CAST(MAX(CASE
    WHEN v02.spr_id = 90
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 39), 3, 4))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_kbez_pl,
 CAST(MAX(CASE
    WHEN v02.spr_id = 95
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 39), 3, 4))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_kbez_ro,
 CAST(MAX(CASE
    WHEN v02.spr_id = 18
    THEN TRIM(v02.mo_bez03) || ' ' || TRIM(SUBSTR(SUBSTR(CAST(V01.kj AS STRING), 1, 39), 3, 4))
    ELSE NULL
    END) AS STRING) AS mo_kbez_kj_kbez_bg
FROM kfl_production_dbp_view.v_monat AS V01
 INNER JOIN (SELECT mo_id,
   spr_id,
   mo_bez,
    CASE
    WHEN spr_id = 124 AND mo_id = 6
    THEN 'Cvn'
    WHEN spr_id = 124 AND mo_id = 7
    THEN 'Cvc'
    ELSE TRIM(SUBSTR(mo_bez, 1, 3))
    END AS mo_bez03
  FROM kfl_production_dbp_view.v_monat_spr_zu AS MSZ) AS v02 ON V01.mo_kj = v02.mo_id
GROUP BY V01.kjmo,
 V01.kj,
 V01.mo_kj,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 spr_id;