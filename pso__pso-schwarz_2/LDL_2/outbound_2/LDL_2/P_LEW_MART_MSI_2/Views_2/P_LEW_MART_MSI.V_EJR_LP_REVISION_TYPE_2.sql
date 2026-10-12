CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_lp_revision_type_2 AS SELECT revision_type_id,
 MAX(CASE
   WHEN language_id = 1
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_ee,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_gb,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_hu,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_ie,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN revision_type_desc
   ELSE NULL
   END) AS revision_type_desc_rs
FROM ldl_p_lew_mart_msi.t_msi_ejr_lp_revision_type_2
GROUP BY revision_type_id;