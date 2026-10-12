CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_client_2 (int_id OPTIONS(description='Lidl International ID'), client_id
OPTIONS(description='Landeskennzeichen'), country_id OPTIONS(description='Landeskennzeichen'), client_desc_at
OPTIONS(description='Landesspezifische Bezeichnung des Landes AT'), client_desc_be
OPTIONS(description='Landesspezifische Bezeichnung des Landes BE'), client_desc_be_fr
OPTIONS(description='Landesspezifische Bezeichnung des Landes BE_FR'), client_desc_bg
OPTIONS(description='Landesspezifische Bezeichnung des Landes BG'), client_desc_ch
OPTIONS(description='Landesspezifische Bezeichnung des Landes CH'), client_desc_cy
OPTIONS(description='Landesspezifische Bezeichnung des Landes CY'), client_desc_cz
OPTIONS(description='Landesspezifische Bezeichnung des Landes CZ'), client_desc
OPTIONS(description='Bezeichnung des Landes'), client_desc_dk
OPTIONS(description='Landesspezifische Bezeichnung des Landes DK'), client_desc_ee
OPTIONS(description='Landesspezifische Bezeichnung des Landes EE'), client_desc_es
OPTIONS(description='Landesspezifische Bezeichnung des Landes ES'), client_desc_fi
OPTIONS(description='Landesspezifische Bezeichnung des Landes FI'), client_desc_fr
OPTIONS(description='Landesspezifische Bezeichnung des Landes FR'), client_desc_gb
OPTIONS(description='Landesspezifische Bezeichnung des Landes GB'), client_desc_gr
OPTIONS(description='Landesspezifische Bezeichnung des Landes GR'), client_desc_hr
OPTIONS(description='Landesspezifische Bezeichnung des Landes HR'), client_desc_hu
OPTIONS(description='Landesspezifische Bezeichnung des Landes HU'), client_desc_ie
OPTIONS(description='Landesspezifische Bezeichnung des Landes IE'), client_desc_it
OPTIONS(description='Landesspezifische Bezeichnung des Landes IT'), client_desc_lt
OPTIONS(description='Landesspezifische Bezeichnung des Landes LT'), client_desc_lv
OPTIONS(description='Landesspezifische Bezeichnung des Landes LV'), client_desc_ni
OPTIONS(description='Landesspezifische Bezeichnung des Landes NI'), client_desc_nl
OPTIONS(description='Landesspezifische Bezeichnung des Landes NL'), client_desc_de
OPTIONS(description='Landesspezifische Bezeichnung des Landes DE'), client_desc_pl
OPTIONS(description='Landesspezifische Bezeichnung des Landes PL'), client_desc_pt
OPTIONS(description='Landesspezifische Bezeichnung des Landes PT'), client_desc_ro
OPTIONS(description='Landesspezifische Bezeichnung des Landes RO'), client_desc_se
OPTIONS(description='Landesspezifische Bezeichnung des Landes SE'), client_desc_si
OPTIONS(description='Landesspezifische Bezeichnung des Landes SI'), client_desc_sk
OPTIONS(description='Landesspezifische Bezeichnung des Landes SK'), client_desc_cs
OPTIONS(description='Landesspezifische Bezeichnung des Landes CS'), client_desc_mt
OPTIONS(description='Landesspezifische Bezeichnung des Landes MT'), client_desc_us
OPTIONS(description='Landesspezifische Bezeichnung des Landes US'), client_desc_rs
OPTIONS(description='Landesspezifische Bezeichnung des Landes RS_2'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE CLIENT/COUNTRY_2 DESCRIPTIONS`) AS SELECT 1 AS int_id,
 client_id,
 client_id AS country_id,
 MAX(CASE
   WHEN language_id = 1
   THEN client_desc
   ELSE NULL
   END) AS client_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN client_desc
   ELSE NULL
   END) AS client_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN client_desc
   ELSE NULL
   END) AS client_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN client_desc
   ELSE NULL
   END) AS client_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN client_desc
   ELSE NULL
   END) AS client_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN client_desc
   ELSE NULL
   END) AS client_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN client_desc
   ELSE NULL
   END) AS client_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN client_desc
   ELSE NULL
   END) AS client_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN client_desc
   ELSE NULL
   END) AS client_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN client_desc
   ELSE NULL
   END) AS client_desc_ee,
 MAX(CASE
   WHEN language_id = 10
   THEN client_desc
   ELSE NULL
   END) AS client_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN client_desc
   ELSE NULL
   END) AS client_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN client_desc
   ELSE NULL
   END) AS client_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN client_desc
   ELSE NULL
   END) AS client_desc_gb,
 MAX(CASE
   WHEN language_id = 14
   THEN client_desc
   ELSE NULL
   END) AS client_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN client_desc
   ELSE NULL
   END) AS client_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN client_desc
   ELSE NULL
   END) AS client_desc_hu,
 MAX(CASE
   WHEN language_id = 17
   THEN client_desc
   ELSE NULL
   END) AS client_desc_ie,
 MAX(CASE
   WHEN language_id = 18
   THEN client_desc
   ELSE NULL
   END) AS client_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN client_desc
   ELSE NULL
   END) AS client_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN client_desc
   ELSE NULL
   END) AS client_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN client_desc
   ELSE NULL
   END) AS client_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN client_desc
   ELSE NULL
   END) AS client_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN client_desc
   ELSE NULL
   END) AS client_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN client_desc
   ELSE NULL
   END) AS client_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN client_desc
   ELSE NULL
   END) AS client_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN client_desc
   ELSE NULL
   END) AS client_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN client_desc
   ELSE NULL
   END) AS client_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN client_desc
   ELSE NULL
   END) AS client_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN client_desc
   ELSE NULL
   END) AS client_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN client_desc
   ELSE NULL
   END) AS client_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN client_desc
   ELSE NULL
   END) AS client_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN client_desc
   ELSE NULL
   END) AS client_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN client_desc
   ELSE NULL
   END) AS client_desc_rs
FROM ldl_p_lew_core_ac.v_wawi_ref_client_desc_2
GROUP BY int_id,
 client_id,
 country_id;