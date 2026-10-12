CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_mov_deliverytype_2 (client_id OPTIONS(description='Landeskennzeichen'),
deliverytype_id OPTIONS(description='Anlieferart - Konstanten: 1 = Zuteilungen / 2 = Kommisionierlisten'),
deliverytype_desc_at OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung AT'), deliverytype_desc_be
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung BE'), deliverytype_desc_be_fr
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung BE_FR'), deliverytype_desc_bg
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung BG'), deliverytype_desc_ch
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung CH'), deliverytype_desc_cy
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung CY'), deliverytype_desc_cz
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung CZ'), deliverytype_desc
OPTIONS(description='Anlieferart - Bezeichnung'), deliverytype_desc_dk
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung DK'), deliverytype_desc_ee
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung EE'), deliverytype_desc_es
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung ES'), deliverytype_desc_fi
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung FI'), deliverytype_desc_fr
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung FR'), deliverytype_desc_gb
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung GB'), deliverytype_desc_gr
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung GR'), deliverytype_desc_hr
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung HR'), deliverytype_desc_hu
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung HU'), deliverytype_desc_ie
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung IE'), deliverytype_desc_it
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung IT'), deliverytype_desc_lt
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung LT'), deliverytype_desc_lv
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung LV'), deliverytype_desc_ni
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung NI'), deliverytype_desc_nl
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung NL'), deliverytype_desc_de
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung DE'), deliverytype_desc_pl
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung PL'), deliverytype_desc_pt
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung PT'), deliverytype_desc_ro
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung RO'), deliverytype_desc_se
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung SE'), deliverytype_desc_si
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung SI'), deliverytype_desc_sk
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung SK'), deliverytype_desc_cs
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung CS'), deliverytype_desc_mt
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung MT'), deliverytype_desc_us
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung US'), deliverytype_desc_rs
OPTIONS(description='Anlieferart - Landesspezifische Bezeichnung RS_2'))
OPTIONS(DESCRIPTION = `MULTISPRACHE ANLIEFERARTEN REFERENZ`) AS SELECT client_id,
 deliverytype_id,
 MAX(CASE
   WHEN language_id = 1
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_ee,
 MAX(CASE
   WHEN language_id = 10
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_gb,
 MAX(CASE
   WHEN language_id = 14
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_hu,
 MAX(CASE
   WHEN language_id = 17
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_ie,
 MAX(CASE
   WHEN language_id = 18
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN deliverytype_desc
   ELSE NULL
   END) AS deliverytype_desc_rs
FROM ldl_p_lew_core_ac.v_wawi_ref_mov_deliverytype_2 AS RMD
GROUP BY client_id,
 deliverytype_id;