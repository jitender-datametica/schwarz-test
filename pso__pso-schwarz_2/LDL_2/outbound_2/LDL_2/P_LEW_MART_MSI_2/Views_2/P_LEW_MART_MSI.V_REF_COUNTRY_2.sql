CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_country_2 (int_id OPTIONS(description='Lidl International ID'), country_id
OPTIONS(description='Landeskennzeichen'), country_iso_cd OPTIONS(description='Landes ISO Code'), cluster_id
OPTIONS(description='Cluster ID'), sorting_order OPTIONS(description='Lisy Sort Wert'), dashboard_relevant_fg
OPTIONS(description='Dashboeard relevant Flag'), country_desc_at
OPTIONS(description='Landesspezifische Bezeichnung des Landes AT'), country_desc_be
OPTIONS(description='Landesspezifische Bezeichnung des Landes BE'), country_desc_be_fr
OPTIONS(description='Landesspezifische Bezeichnung des Landes BE_FR'), country_desc_bg
OPTIONS(description='Landesspezifische Bezeichnung des Landes BG'), country_desc_ch
OPTIONS(description='Landesspezifische Bezeichnung des Landes CH'), country_desc_cy
OPTIONS(description='Landesspezifische Bezeichnung des Landes CY'), country_desc_cz
OPTIONS(description='Landesspezifische Bezeichnung des Landes CZ'), country_desc
OPTIONS(description='Bezeichnung des Landes'), country_desc_dk
OPTIONS(description='Landesspezifische Bezeichnung des Landes DK'), country_desc_ee
OPTIONS(description='Landesspezifische Bezeichnung des Landes EE'), country_desc_es
OPTIONS(description='Landesspezifische Bezeichnung des Landes ES'), country_desc_fi
OPTIONS(description='Landesspezifische Bezeichnung des Landes FI'), country_desc_fr
OPTIONS(description='Landesspezifische Bezeichnung des Landes FR'), country_desc_gb
OPTIONS(description='Landesspezifische Bezeichnung des Landes GB'), country_desc_gr
OPTIONS(description='Landesspezifische Bezeichnung des Landes GR'), country_desc_hr
OPTIONS(description='Landesspezifische Bezeichnung des Landes HR'), country_desc_hu
OPTIONS(description='Landesspezifische Bezeichnung des Landes HU'), country_desc_ie
OPTIONS(description='Landesspezifische Bezeichnung des Landes IE'), country_desc_it
OPTIONS(description='Landesspezifische Bezeichnung des Landes IT'), country_desc_lt
OPTIONS(description='Landesspezifische Bezeichnung des Landes LT'), country_desc_lv
OPTIONS(description='Landesspezifische Bezeichnung des Landes LV'), country_desc_ni
OPTIONS(description='Landesspezifische Bezeichnung des Landes NI'), country_desc_nl
OPTIONS(description='Landesspezifische Bezeichnung des Landes NL'), country_desc_de
OPTIONS(description='Landesspezifische Bezeichnung des Landes DE'), country_desc_pl
OPTIONS(description='Landesspezifische Bezeichnung des Landes PL'), country_desc_pt
OPTIONS(description='Landesspezifische Bezeichnung des Landes PT'), country_desc_ro
OPTIONS(description='Landesspezifische Bezeichnung des Landes RO'), country_desc_se
OPTIONS(description='Landesspezifische Bezeichnung des Landes SE'), country_desc_si
OPTIONS(description='Landesspezifische Bezeichnung des Landes SI'), country_desc_sk
OPTIONS(description='Landesspezifische Bezeichnung des Landes SK'), country_desc_cs
OPTIONS(description='Landesspezifische Bezeichnung des Landes CS'), country_desc_mt
OPTIONS(description='Landesspezifische Bezeichnung des Landes MT'), country_desc_us
OPTIONS(description='Landesspezifische Bezeichnung des Landes US'), country_desc_rs
OPTIONS(description='Landesspezifische Bezeichnung des Landes RS_2'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE COUNTRY_2 REFERENCE`) AS SELECT int_id,
 country_id,
 country_iso_cd,
 cluster_id,
 sorting_order,
 dashboard_relevant_fg,
 MAX(CASE
   WHEN language_id = 1
   THEN country_desc
   ELSE NULL
   END) AS country_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN country_desc
   ELSE NULL
   END) AS country_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN country_desc
   ELSE NULL
   END) AS country_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN country_desc
   ELSE NULL
   END) AS country_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN country_desc
   ELSE NULL
   END) AS country_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN country_desc
   ELSE NULL
   END) AS country_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN country_desc
   ELSE NULL
   END) AS country_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN country_desc
   ELSE NULL
   END) AS country_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN country_desc
   ELSE NULL
   END) AS country_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN country_desc
   ELSE NULL
   END) AS country_desc_ee,
 MAX(CASE
   WHEN language_id = 10
   THEN country_desc
   ELSE NULL
   END) AS country_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN country_desc
   ELSE NULL
   END) AS country_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN country_desc
   ELSE NULL
   END) AS country_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN country_desc
   ELSE NULL
   END) AS country_desc_gb,
 MAX(CASE
   WHEN language_id = 14
   THEN country_desc
   ELSE NULL
   END) AS country_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN country_desc
   ELSE NULL
   END) AS country_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN country_desc
   ELSE NULL
   END) AS country_desc_hu,
 MAX(CASE
   WHEN language_id = 17
   THEN country_desc
   ELSE NULL
   END) AS country_desc_ie,
 MAX(CASE
   WHEN language_id = 18
   THEN country_desc
   ELSE NULL
   END) AS country_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN country_desc
   ELSE NULL
   END) AS country_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN country_desc
   ELSE NULL
   END) AS country_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN country_desc
   ELSE NULL
   END) AS country_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN country_desc
   ELSE NULL
   END) AS country_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN country_desc
   ELSE NULL
   END) AS country_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN country_desc
   ELSE NULL
   END) AS country_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN country_desc
   ELSE NULL
   END) AS country_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN country_desc
   ELSE NULL
   END) AS country_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN country_desc
   ELSE NULL
   END) AS country_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN country_desc
   ELSE NULL
   END) AS country_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN country_desc
   ELSE NULL
   END) AS country_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN country_desc
   ELSE NULL
   END) AS country_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN country_desc
   ELSE NULL
   END) AS country_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN country_desc
   ELSE NULL
   END) AS country_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN country_desc
   ELSE NULL
   END) AS country_desc_rs
FROM ldl_p_lew_core_ac.v_wawi_ref_country_act_2 AS CN
GROUP BY int_id,
 country_id,
 country_iso_cd,
 cluster_id,
 sorting_order,
 dashboard_relevant_fg;