CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_country_lead_2 (int_id OPTIONS(description='Lidl International ID'),
country_id OPTIONS(description='Landeskennzeichen'), country_iso_cd OPTIONS(description='Landeskürzel'),
country_group_id OPTIONS(description='Landesgruppen Kennzeichen'), lisy_sort OPTIONS(description='lisy sort Wert'),
dashboard_relevant_fg OPTIONS(description='Dashboardrelevant'), country_desc_at
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung AT'), country_desc_be
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung BE'), country_desc_bg
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung BG'), country_desc_ch
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung CH'), country_desc_cy
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung CY'), country_desc_cz
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung CZ'), country_desc
OPTIONS(description='Filial-Land_2 Bezeichnung'), country_desc_dk
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung DK'), country_desc_ee
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung EE'), country_desc_es
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung ES'), country_desc_fi
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung FI'), country_desc_fr
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung FR'), country_desc_gb
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung GB'), country_desc_gr
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung GR'), country_desc_hr
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung HR'), country_desc_hu
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung HU'), country_desc_ie
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung IE'), country_desc_it
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung IT'), country_desc_lt
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung LT'), country_desc_lv
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung LV'), country_desc_ni
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung NI'), country_desc_nl
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung NL'), country_desc_de
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung DE'), country_desc_pl
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung PL'), country_desc_pt
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung PT'), country_desc_ro
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung RO'), country_desc_se
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung SE'), country_desc_si
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung SI'), country_desc_sk
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung SK'), country_desc_cs
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung CS'), country_desc_mt
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung MT'), country_desc_us
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung US'), country_desc_rs
OPTIONS(description='Filial-Land_2 Landesspezifische Bezeichnung RS_2'))
OPTIONS(DESCRIPTION = `LEAD PROJECT : COUNTRY_2 LEAD REFERENCE VIEW`) AS SELECT CN.int_id,
 CN.country_id,
 CN.country_iso_cd,
 COALESCE(SKEY.country_group_id, 99) AS country_group_id,
  CASE
  WHEN CN.country_id = 23
  THEN 1
  WHEN CN.country_id = 12
  THEN 2
  WHEN CN.country_id = 18
  THEN 3
  WHEN CN.country_id = 32
  THEN 4
  WHEN CN.country_id = 1
  THEN 5
  WHEN CN.country_id = 14
  THEN 6
  WHEN CN.country_id = 5
  THEN 7
  WHEN CN.country_id = 10
  THEN 8
  WHEN CN.country_id = 31
  THEN 9
  WHEN CN.country_id = 2
  THEN 10
  WHEN CN.country_id = 25
  THEN 12
  WHEN CN.country_id = 22
  THEN 13
  WHEN CN.country_id = 4
  THEN 14
  WHEN CN.country_id = 19
  THEN 15
  WHEN CN.country_id = 13
  THEN 16
  WHEN CN.country_id = 17
  THEN 17
  WHEN CN.country_id = 21
  THEN 18
  WHEN CN.country_id = 11
  THEN 19
  WHEN CN.country_id = 27
  THEN 20
  WHEN CN.country_id = 8
  THEN 21
  WHEN CN.country_id = 33
  THEN 22
  WHEN CN.country_id = 24
  THEN 23
  WHEN CN.country_id = 6
  THEN 24
  WHEN CN.country_id = 29
  THEN 25
  WHEN CN.country_id = 16
  THEN 26
  WHEN CN.country_id = 15
  THEN 27
  WHEN CN.country_id = 28
  THEN 28
  WHEN CN.country_id = 26
  THEN 29
  WHEN CN.country_id = 3
  THEN 30
  WHEN CN.country_id = 34
  THEN 31
  WHEN CN.country_id = 20
  THEN 32
  WHEN CN.country_id = 9
  THEN 33
  ELSE 99
  END AS lisy_sort,
 CN.dashboard_relevant_fg,
 MAX(CASE
   WHEN CN.language_id = 1
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_at,
 MAX(CASE
   WHEN CN.language_id = 2
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_be,
 MAX(CASE
   WHEN CN.language_id = 3
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_bg,
 MAX(CASE
   WHEN CN.language_id = 4
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_ch,
 MAX(CASE
   WHEN CN.language_id = 5
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_cy,
 MAX(CASE
   WHEN CN.language_id = 6
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_cz,
 MAX(CASE
   WHEN CN.language_id = 7
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc,
 MAX(CASE
   WHEN CN.language_id = 8
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_dk,
 MAX(CASE
   WHEN CN.language_id = 9
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_ee,
 MAX(CASE
   WHEN CN.language_id = 10
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_es,
 MAX(CASE
   WHEN CN.language_id = 11
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_fi,
 MAX(CASE
   WHEN CN.language_id = 12
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_fr,
 MAX(CASE
   WHEN CN.language_id = 13
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_gb,
 MAX(CASE
   WHEN CN.language_id = 14
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_gr,
 MAX(CASE
   WHEN CN.language_id = 15
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_hr,
 MAX(CASE
   WHEN CN.language_id = 16
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_hu,
 MAX(CASE
   WHEN CN.language_id = 17
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_ie,
 MAX(CASE
   WHEN CN.language_id = 18
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_it,
 MAX(CASE
   WHEN CN.language_id = 19
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_lt,
 MAX(CASE
   WHEN CN.language_id = 20
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_lv,
 MAX(CASE
   WHEN CN.language_id = 21
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_ni,
 MAX(CASE
   WHEN CN.language_id = 22
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_nl,
 MAX(CASE
   WHEN CN.language_id = 23
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_de,
 MAX(CASE
   WHEN CN.language_id = 24
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_pl,
 MAX(CASE
   WHEN CN.language_id = 25
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_pt,
 MAX(CASE
   WHEN CN.language_id = 26
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_ro,
 MAX(CASE
   WHEN CN.language_id = 27
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_se,
 MAX(CASE
   WHEN CN.language_id = 28
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_si,
 MAX(CASE
   WHEN CN.language_id = 29
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_sk,
 MAX(CASE
   WHEN CN.language_id = 31
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_cs,
 MAX(CASE
   WHEN CN.language_id = 32
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_mt,
 MAX(CASE
   WHEN CN.language_id = 33
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_us,
 MAX(CASE
   WHEN CN.language_id = 34
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_rs
FROM ldl_p_lew_core_ac.v_wawi_ref_country_act_2 AS CN
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_client_skey_2 AS SKEY ON CN.country_id = SKEY.client_id
GROUP BY CN.int_id,
 CN.country_id,
 CN.country_iso_cd,
 SKEY.country_group_id,
 lisy_sort,
 CN.dashboard_relevant_fg;