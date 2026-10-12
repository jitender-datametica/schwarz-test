CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_itm_list_type_brand_gr_1 (brand_type_group_id
OPTIONS(description='Guppen Markenart ID'), brand_type_group_desc_at
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  AT'), brand_type_group_desc_be
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  BE'), brand_type_group_desc_be_fr
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  BE_FR'), brand_type_group_desc_bg
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  BG'), brand_type_group_desc_ch
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  CH'), brand_type_group_desc_cy
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  CY'), brand_type_group_desc_cz
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  CZ'), brand_type_group_desc
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart'), brand_type_group_desc_dk
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  DK'), brand_type_group_desc_ee
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  EE'), brand_type_group_desc_es
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  ES'), brand_type_group_desc_fi
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  FI'), brand_type_group_desc_fr
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  FR'), brand_type_group_desc_gb
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  GB'), brand_type_group_desc_gr
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  GR'), brand_type_group_desc_hr
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  HR'), brand_type_group_desc_hu
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  HU'), brand_type_group_desc_ie
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  IE'), brand_type_group_desc_it
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  IT'), brand_type_group_desc_lt
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  LT'), brand_type_group_desc_lv
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  LV'), brand_type_group_desc_ni
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  NI'), brand_type_group_desc_nl
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  NL'), brand_type_group_desc_de
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  DE'), brand_type_group_desc_pl
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  PL'), brand_type_group_desc_pt
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  PT'), brand_type_group_desc_ro
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  RO'), brand_type_group_desc_se
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  SE'), brand_type_group_desc_si
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  SI'), brand_type_group_desc_sk
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  SK'), brand_type_group_desc_cs
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  CS'), brand_type_group_desc_mt
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  MT'), brand_type_group_desc_us
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  US'), brand_type_group_desc_rs
OPTIONS(description='Landesspezifische Bezeichnung der Gruppe_1 der Markenart  RS_1'))
OPTIONS(DESCRIPTION = `MULTISPRACHE MARKENARTGRUPPEN REFERENZ`) AS SELECT brand_type_group_id,
 MAX(CASE
   WHEN language_id = 1
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_ee,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_gb,
 MAX(CASE
   WHEN language_id IN (14, 5)
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_hu,
 MAX(CASE
   WHEN language_id IN (17, 21)
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_ie,
 MAX(CASE
   WHEN language_id IN (18, 32)
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN brand_type_group_desc
   ELSE NULL
   END) AS brand_type_group_desc_rs
FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_1
GROUP BY brand_type_group_id;