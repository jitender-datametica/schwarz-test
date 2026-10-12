
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_cal_week_partial_week_desc_1
OPTIONS(DESCRIPTION='MULTI LANGUAGE PARZTIAL WEEK DECSRIPTIONS', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90)
AS
SELECT A.cy_week_partial_week_id1,
 A.cy_week_partial_week_id2,
 A.cy_week_partial_week_id,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_at || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_at
  END AS cy_week_partial_week_desc_at,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_be || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_be
  END AS cy_week_partial_week_desc_be,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_fr || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_fr
  END AS cy_week_partial_week_desc_be_fr,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_bg || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_bg
  END AS cy_week_partial_week_desc_bg,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_ch || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_ch
  END AS cy_week_partial_week_desc_ch,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_cy || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_cy
  END AS cy_week_partial_week_desc_cy,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_cz || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_cz
  END AS cy_week_partial_week_desc_cz,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc
  END AS cy_week_partial_week_desc,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_dk || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_dk
  END AS cy_week_partial_week_desc_dk,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_ee || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_ee
  END AS cy_week_partial_week_desc_ee,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_es || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_es
  END AS cy_week_partial_week_desc_es,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_fi || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_fi
  END AS cy_week_partial_week_desc_fi,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_fr || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_fr
  END AS cy_week_partial_week_desc_fr,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_gb || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_gb
  END AS cy_week_partial_week_desc_gb,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_gr || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_gr
  END AS cy_week_partial_week_desc_gr,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_hr || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_hr
  END AS cy_week_partial_week_desc_hr,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_hu || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_hu
  END AS cy_week_partial_week_desc_hu,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_ie || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_ie
  END AS cy_week_partial_week_desc_ie,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_it || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_it
  END AS cy_week_partial_week_desc_it,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_lt || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_lt
  END AS cy_week_partial_week_desc_lt,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_lv || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_lv
  END AS cy_week_partial_week_desc_lv,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_ni || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_ni
  END AS cy_week_partial_week_desc_ni,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_nl || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_nl
  END AS cy_week_partial_week_desc_nl,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_de || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_de
  END AS cy_week_partial_week_desc_de,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_pl || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_pl
  END AS cy_week_partial_week_desc_pl,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_pt || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_pt
  END AS cy_week_partial_week_desc_pt,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_ro || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_ro
  END AS cy_week_partial_week_desc_ro,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_se || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_se
  END AS cy_week_partial_week_desc_se,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_si || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_si
  END AS cy_week_partial_week_desc_si,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_sk || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_sk
  END AS cy_week_partial_week_desc_sk,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_cs || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_cs
  END AS cy_week_partial_week_desc_cs,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_mt || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_mt
  END AS cy_week_partial_week_desc_mt,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_us || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_us
  END AS cy_week_partial_week_desc_us,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_rs || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_rs
  END AS cy_week_partial_week_desc_rs,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_at || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_at
  END AS cy_week_partial_week_desc_s_at,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_be || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_be
  END AS cy_week_partial_week_desc_s_be,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_fr || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_fr
  END AS cy_week_partial_week_desc_s_be_fr,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_bg || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_bg
  END AS cy_week_partial_week_desc_s_bg,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_ch || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_ch
  END AS cy_week_partial_week_desc_s_ch,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_cy || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_cy
  END AS cy_week_partial_week_desc_s_cy,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_cz || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_cz
  END AS cy_week_partial_week_desc_s_cz,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short
  END AS cy_week_partial_week_desc_s,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_dk || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_dk
  END AS cy_week_partial_week_desc_s_dk,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_ee || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_ee
  END AS cy_week_partial_week_desc_s_ee,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_es || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_es
  END AS cy_week_partial_week_desc_s_es,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_fi || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_fi
  END AS cy_week_partial_week_desc_s_fi,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_fr || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_fr
  END AS cy_week_partial_week_desc_s_fr,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_gb || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_gb
  END AS cy_week_partial_week_desc_s_gb,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_gr || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_gr
  END AS cy_week_partial_week_desc_s_gr,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_hr || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_hr
  END AS cy_week_partial_week_desc_s_hr,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_hu || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_hu
  END AS cy_week_partial_week_desc_s_hu,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_ie || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_ie
  END AS cy_week_partial_week_desc_s_ie,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_it || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_it
  END AS cy_week_partial_week_desc_s_it,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_lt || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_lt
  END AS cy_week_partial_week_desc_s_lt,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_lv || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_lv
  END AS cy_week_partial_week_desc_s_lv,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_ni || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_ni
  END AS cy_week_partial_week_desc_s_ni,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_nl || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_nl
  END AS cy_week_partial_week_desc_s_nl,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_de || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_de
  END AS cy_week_partial_week_desc_s_de,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_pl || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_pl
  END AS cy_week_partial_week_desc_s_pl,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_pt || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_pt
  END AS cy_week_partial_week_desc_s_pt,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_ro || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_ro
  END AS cy_week_partial_week_desc_s_ro,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_se || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_se
  END AS cy_week_partial_week_desc_s_se,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_si || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_si
  END AS cy_week_partial_week_desc_s_si,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_sk || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_sk
  END AS cy_week_partial_week_desc_s_sk,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_cs || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_cs
  END AS cy_week_partial_week_desc_s_cs,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_mt || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_mt
  END AS cy_week_partial_week_desc_s_mt,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_us || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_us
  END AS cy_week_partial_week_desc_s_us,
  CASE
  WHEN A.cy_week_partial_week_id2 IN (1, 2)
  THEN B.cy_week_desc_short_rs || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
  ELSE B.cy_week_desc_short_rs
  END AS cy_week_partial_week_desc_s_rs,
 SUBSTR(CASE
   WHEN A.cy_week_partial_week_id2 IN (1, 2)
   THEN B.cy_week_desc || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
   ELSE B.cy_week_desc
   END, INSTR(CASE
     WHEN A.cy_week_partial_week_id2 IN (1, 2)
     THEN B.cy_week_desc || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
     ELSE B.cy_week_desc
     END, ' K') + 1, LENGTH(CASE
      WHEN A.cy_week_partial_week_id2 IN (1, 2)
      THEN B.cy_week_desc || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
      ELSE B.cy_week_desc
      END) - INSTR(CASE
      WHEN A.cy_week_partial_week_id2 IN (1, 2)
      THEN B.cy_week_desc || '/' || TRIM(SUBSTR(CAST(A.cy_week_partial_week_id2 AS STRING), 1, 39))
      ELSE B.cy_week_desc
      END, ' K') + 1) AS desc_wo_year
FROM ldl_p_lew_core_ac.v_wawi_cal_week_partial_week_1 AS A
 INNER JOIN ldl_p_lew_mart_msi.v_cal_week_desc_1 AS B ON A.cy_week_partial_week_id1 = B.cy_week;


