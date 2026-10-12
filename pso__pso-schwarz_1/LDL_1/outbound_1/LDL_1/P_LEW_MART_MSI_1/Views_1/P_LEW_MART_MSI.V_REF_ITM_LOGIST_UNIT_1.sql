CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_itm_logist_unit_1 (logistic_unit_cd
OPTIONS(description='Kennz. Einheit (Liter, Kilo etc)'), client_id OPTIONS(description='Landeskennzeichen'),
logistic_unit_desc_at OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit AT'), logistic_unit_desc_be
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit BE'), logistic_unit_desc_be_fr
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit BE_FR'), logistic_unit_desc_bg
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit BG'), logistic_unit_desc_ch
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit CH'), logistic_unit_desc_cy
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit CY'), logistic_unit_desc_cz
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit CZ'), logistic_unit_desc
OPTIONS(description='Bezinh Einheit'), logistic_unit_desc_dk
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit DK'), logistic_unit_desc_ee
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit EE'), logistic_unit_desc_es
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit ES'), logistic_unit_desc_fi
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit FI'), logistic_unit_desc_fr
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit FR'), logistic_unit_desc_gb
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit GB'), logistic_unit_desc_gr
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit GR'), logistic_unit_desc_hr
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit HR'), logistic_unit_desc_hu
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit HU'), logistic_unit_desc_ie
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit IE'), logistic_unit_desc_it
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit IT'), logistic_unit_desc_lt
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit LT'), logistic_unit_desc_lv
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit LV'), logistic_unit_desc_ni
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit NI'), logistic_unit_desc_nl
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit NL'), logistic_unit_desc_de
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit DE'), logistic_unit_desc_pl
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit PL'), logistic_unit_desc_pt
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit PT'), logistic_unit_desc_ro
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit RO'), logistic_unit_desc_se
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit SE'), logistic_unit_desc_si
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit SI'), logistic_unit_desc_sk
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit SK'), logistic_unit_desc_cs
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit CS'), logistic_unit_desc_mt
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit MT'), logistic_unit_desc_us
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit US'), logistic_unit_desc_rs
OPTIONS(description='Logistik Landesspezifische Bezeichnung Einheit RS_1'), logistic_base_unit
OPTIONS(description='Logistik Basiseinheit (1kg)'), logistic_base_factor
OPTIONS(description='Logistik Basisfaktor (1000)'), logistic_base_unit_int
OPTIONS(description='Logistik Internationale Einheit (g)'), logistic_base_factor_int
OPTIONS(description='Logistik Internationaler faktor (1000)'))
OPTIONS(DESCRIPTION = `MULTISPRACHE LOGISTIKEINHEITEN REFERENZ`) AS SELECT logistic_unit_cd,
 client_id,
 MAX(CASE
   WHEN language_id = 1
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_ee,
 MAX(CASE
   WHEN language_id = 10
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_gb,
 MAX(CASE
   WHEN language_id = 14
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_hu,
 MAX(CASE
   WHEN language_id IN (17, 21)
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_ie,
 MAX(CASE
   WHEN language_id = 18
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_lv,
 MAX(CASE
   WHEN language_id IN (17, 21)
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN logistic_unit_desc
   ELSE NULL
   END) AS logistic_unit_desc_rs,
 logistic_base_unit,
 logistic_base_factor,
 logistic_base_unit_int,
 logistic_base_factor_int
FROM ldl_p_lew_core_ac.v_wawi_ref_itm_logist_unit_1 AS R
GROUP BY logistic_unit_cd,
 client_id,
 logistic_base_unit,
 logistic_base_factor,
 logistic_base_unit_int,
 logistic_base_factor_int;