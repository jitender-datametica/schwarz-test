CREATE OR REPLACE VIEW ldl_p_lew_bil.v_ref_country_lead (int_id, country_id, country_iso_cd, country_group_id, lisy_sort
, dashboard_relevant_fg, country_desc_at, country_desc_be, country_desc_be_fr, country_desc_bg, country_desc_ch,
country_desc_cy, country_desc_cz, country_desc, country_desc_dk, country_desc_ee, country_desc_es, country_desc_fi,
country_desc_fr, country_desc_gb, country_desc_gr, country_desc_hr, country_desc_hu, country_desc_ie, country_desc_it,
country_desc_lt, country_desc_ni, country_desc_nl, country_desc_de, country_desc_lv, country_desc_pl, country_desc_pt,
country_desc_ro, country_desc_se, country_desc_si, country_desc_sk, country_desc_cs, country_desc_mt, country_desc_us,
country_desc_rs) AS SELECT CN.int_id,
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
   WHEN CN.language_id = 12
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_be_fr,
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
   WHEN CN.language_id = 20
   THEN CN.country_desc
   ELSE NULL
   END) AS country_desc_lv,
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
FROM ldl_p_lew_core_ac.v_wawi_ref_country_act AS CN
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_client_skey AS SKEY ON CN.country_id = SKEY.client_id
GROUP BY CN.int_id,
 CN.country_id,
 CN.country_iso_cd,
 SKEY.country_group_id,
 lisy_sort,
 CN.dashboard_relevant_fg;