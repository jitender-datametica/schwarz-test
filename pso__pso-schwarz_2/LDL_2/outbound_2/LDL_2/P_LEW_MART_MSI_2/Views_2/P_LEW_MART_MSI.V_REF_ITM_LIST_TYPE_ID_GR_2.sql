CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_itm_list_type_id_gr_2 (listing_type_group_id
OPTIONS(description='Guppe Einlistungstype Id'), listing_type_group_desc_at
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung AT'), listing_type_group_desc_be
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung BE'), listing_type_group_desc_be_fr
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung BE_FR'), listing_type_group_desc_bg
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung BG'), listing_type_group_desc_ch
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung CH'), listing_type_group_desc_cy
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung CY'), listing_type_group_desc_cz
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung CZ'), listing_type_group_desc
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung'), listing_type_group_desc_dk
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung DK'), listing_type_group_desc_ee
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung EE'), listing_type_group_desc_es
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung ES'), listing_type_group_desc_fi
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung FI'), listing_type_group_desc_fr
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung FR'), listing_type_group_desc_gb
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung GB'), listing_type_group_desc_gr
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung GR'), listing_type_group_desc_hr
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung HR'), listing_type_group_desc_hu
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung HU'), listing_type_group_desc_ie
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung IE'), listing_type_group_desc_it
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung IT'), listing_type_group_desc_lt
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung LT'), listing_type_group_desc_lv
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung LV'), listing_type_group_desc_ni
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung NI'), listing_type_group_desc_nl
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung NL'), listing_type_group_desc_de
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung DE'), listing_type_group_desc_pl
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung PL'), listing_type_group_desc_pt
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung PT'), listing_type_group_desc_ro
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung RO'), listing_type_group_desc_se
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung SE'), listing_type_group_desc_si
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung SI'), listing_type_group_desc_sk
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung SK'), listing_type_group_desc_cs
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung CS'), listing_type_group_desc_mt
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung MT'), listing_type_group_desc_us
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung US'), listing_type_group_desc_rs
OPTIONS(description='Gruppe_2 Einlistungstype Landesspezifische Bezeichnung RS_2'))
OPTIONS(DESCRIPTION = `MULTISPRACHE EINLISTUNGSTYPE GRUPPEN REFERENZ`) AS SELECT listing_type_group_id,
 MAX(CASE
   WHEN language_id = 1
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_ee,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_gb,
 MAX(CASE
   WHEN language_id IN (14, 5)
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_hu,
 MAX(CASE
   WHEN language_id IN (17, 21)
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_ie,
 MAX(CASE
   WHEN language_id IN (18, 32)
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN listing_type_group_desc
   ELSE NULL
   END) AS listing_type_group_desc_rs
FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_2
GROUP BY listing_type_group_id;