CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_cal_week_desc_1 AS SELECT cy_week,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_at,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_be,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KC ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_bg,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_ch,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' EB ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_cy,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KT ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_cz,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' U ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_dk,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_ee,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' S ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_es,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' vk_1 ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_fi,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' S ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_fr,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' Wk ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_gb,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' EB ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_gr,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KT ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_hr,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' NH ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_hu,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' WK ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_ie,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_it,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_lt,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_lv,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' WK ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_ni,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_nl,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_de,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' TK ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_pl,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_pt,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' ST ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_ro,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' v. ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_se,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KT ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_si,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KT ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_sk,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' S ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_cs,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_mt,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' Wk ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_us,
   SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 1, 4) || ' KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1
     , 39)), 5, 2) AS cy_week_desc_rs,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_at,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_be,
  'KC ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_bg,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_ch,
  'EB ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_cy,
  'KT ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_cz,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short,
  'U ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_dk,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_ee,
  'S ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_es,
  'vk_1 ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_fi,
  'S ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_fr,
  'Wk ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_gb,
  'EB ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_gr,
  'KT ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_hr,
  'NH ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_hu,
  'WK ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_ie,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_it,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_lt,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_lv,
  'WK ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_ni,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_nl,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_de,
  'TK ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_pl,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_pt,
  'ST ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_ro,
  'v. ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_se,
  'KT ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_si,
  'KT ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_sk,
  'S ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_cs,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_mt,
  'Wk ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_us,
  'KW ' || SUBSTR(TRIM(SUBSTR(CAST(cy_week AS STRING), 1, 39)), 5, 2) AS cy_week_desc_short_rs
FROM ldl_p_lew_core_ac.v_cal_week_1 AS T1_1;