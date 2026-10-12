CREATE OR REPLACE VIEW ldl_s_conl.v_cal_month_desc_2 AS SELECT month_id,
 cy_month,
 cy,
 byr,
 MAX(CASE
   WHEN language_id = 1
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_at,
 MAX(CASE
   WHEN language_id = 2
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_be,
 MAX(CASE
   WHEN language_id = 3
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name,
 MAX(CASE
   WHEN language_id = 8
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_dk,
 MAX(CASE
   WHEN language_id = 10
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_es,
 MAX(CASE
   WHEN language_id = 11
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_gb,
 MAX(CASE
   WHEN language_id = 14
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_hu,
 MAX(CASE
   WHEN language_id = 17
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_ie,
 MAX(CASE
   WHEN language_id = 18
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_it,
 MAX(CASE
   WHEN language_id = 19
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_lt,
 MAX(CASE
   WHEN language_id = 21
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_de,
 MAX(CASE
   WHEN language_id = 24
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_se,
 MAX(CASE
   WHEN language_id = 28
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_si,
 MAX(CASE
   WHEN language_id = 29
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_us,
 MAX(CASE
   WHEN language_id = 34
   THEN cy_month_name
   ELSE NULL
   END) AS cy_month_name_rs,
 MAX(CASE
   WHEN language_id = 1
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_at,
 MAX(CASE
   WHEN language_id = 2
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_be,
 MAX(CASE
   WHEN language_id = 3
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short,
 MAX(CASE
   WHEN language_id = 8
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_dk,
 MAX(CASE
   WHEN language_id = 10
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_es,
 MAX(CASE
   WHEN language_id = 11
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_gb,
 MAX(CASE
   WHEN language_id = 14
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_hu,
 MAX(CASE
   WHEN language_id = 17
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_ie,
 MAX(CASE
   WHEN language_id = 18
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_it,
 MAX(CASE
   WHEN language_id = 19
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_lt,
 MAX(CASE
   WHEN language_id = 21
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_de,
 MAX(CASE
   WHEN language_id = 24
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_se,
 MAX(CASE
   WHEN language_id = 28
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_si,
 MAX(CASE
   WHEN language_id = 29
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_us,
 MAX(CASE
   WHEN language_id = 34
   THEN cy_month_name_short
   ELSE NULL
   END) AS cy_month_name_short_rs,
 MAX(CASE
   WHEN language_id = 1
   THEN month_name
   ELSE NULL
   END) AS month_name_at,
 MAX(CASE
   WHEN language_id = 2
   THEN month_name
   ELSE NULL
   END) AS month_name_be,
 MAX(CASE
   WHEN language_id = 3
   THEN month_name
   ELSE NULL
   END) AS month_name_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN month_name
   ELSE NULL
   END) AS month_name_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN month_name
   ELSE NULL
   END) AS month_name_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN month_name
   ELSE NULL
   END) AS month_name_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN month_name
   ELSE NULL
   END) AS month_name,
 MAX(CASE
   WHEN language_id = 8
   THEN month_name
   ELSE NULL
   END) AS month_name_dk,
 MAX(CASE
   WHEN language_id = 10
   THEN month_name
   ELSE NULL
   END) AS month_name_es,
 MAX(CASE
   WHEN language_id = 11
   THEN month_name
   ELSE NULL
   END) AS month_name_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN month_name
   ELSE NULL
   END) AS month_name_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN month_name
   ELSE NULL
   END) AS month_name_gb,
 MAX(CASE
   WHEN language_id = 14
   THEN month_name
   ELSE NULL
   END) AS month_name_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN month_name
   ELSE NULL
   END) AS month_name_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN month_name
   ELSE NULL
   END) AS month_name_hu,
 MAX(CASE
   WHEN language_id = 17
   THEN month_name
   ELSE NULL
   END) AS month_name_ie,
 MAX(CASE
   WHEN language_id = 18
   THEN month_name
   ELSE NULL
   END) AS month_name_it,
 MAX(CASE
   WHEN language_id = 19
   THEN month_name
   ELSE NULL
   END) AS month_name_lt,
 MAX(CASE
   WHEN language_id = 21
   THEN month_name
   ELSE NULL
   END) AS month_name_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN month_name
   ELSE NULL
   END) AS month_name_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN month_name
   ELSE NULL
   END) AS month_name_de,
 MAX(CASE
   WHEN language_id = 24
   THEN month_name
   ELSE NULL
   END) AS month_name_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN month_name
   ELSE NULL
   END) AS month_name_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN month_name
   ELSE NULL
   END) AS month_name_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN month_name
   ELSE NULL
   END) AS month_name_se,
 MAX(CASE
   WHEN language_id = 28
   THEN month_name
   ELSE NULL
   END) AS month_name_si,
 MAX(CASE
   WHEN language_id = 29
   THEN month_name
   ELSE NULL
   END) AS month_name_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN month_name
   ELSE NULL
   END) AS month_name_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN month_name
   ELSE NULL
   END) AS month_name_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN month_name
   ELSE NULL
   END) AS month_name_us,
 MAX(CASE
   WHEN language_id = 34
   THEN month_name
   ELSE NULL
   END) AS month_name_rs
FROM (SELECT C1.month_id,
   C2.cy_month,
   C2.cy,
   C2.busyear AS byr,
   C1.language_id,
     C1.month_name || ' ' || TRIM(SUBSTR(CAST(C2.cy AS STRING), 1, 39)) AS cy_month_name,
   C1.month_name_short AS cy_month_name_short,
   C1.month_name
  FROM ldl_p_lew_core_ac.v_wawi_cal_month_desc_2 AS C1
   INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_month_2 AS C2 ON C1.month_id = C2.month_id) AS x
GROUP BY month_id,
 cy_month,
 cy,
 byr;