
CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_adv_int_desc_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS cy,
 MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS adv_week_int,
 t.adv_wt_nr_int,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_DE.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_DE.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_AT.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_at,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_AT.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_at,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_BE.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_be,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_BE.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_be,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_BG.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_bg,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_BG.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_bg,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_CH.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_ch,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_CH.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_ch,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_CY.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_cy,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_CY.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_cy,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_CZ.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_cz,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_CZ.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_cz,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_DK.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_dk,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_DK.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_dk,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_EE.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_ee,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_EE.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_ee,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_ES.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_es,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_ES.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_es,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_FI.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_fi,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_FI.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_fi,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_FR.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_fr,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_FR.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_fr,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_GB.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_gb,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_GB.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_gb,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_GR.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_gr,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_GR.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_gr,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_HR.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_hr,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_HR.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_hr,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_HU.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_hu,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_HU.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_hu,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_IE.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_ie,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_IE.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_ie,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_IT.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_it,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_IT.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_it,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_LT.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_lt,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_LT.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_lt,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_LV.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_lv,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_LV.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_lv,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_NI.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_ni,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_NI.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_ni,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_NL.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_nl,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_NL.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_nl,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_DE.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_de,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_DE.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_de,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_PL.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_pl,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_PL.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_pl,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_PT.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_pt,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_PT.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_pt,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_RO.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_ro,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_RO.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_ro,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_SE.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_se,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_SE.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_se,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_SI.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_si,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_SI.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_si,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_SK.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_sk,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_SK.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_sk,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_CS.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_cs,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_CS.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_cs,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_MT.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_mt,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_MT.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_mt,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_US.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_us,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_US.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_us,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(SUBSTR(CAST(SUBSTR(SUBSTR(CAST(WK.cy_week AS STRING), 1, 39), 1, 4) AS STRING), 1, 4) || ' ' || T_RS.kw_name
         || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
   )
  END AS adv_desc_int_rs,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN ' '
  ELSE TRIM(T_RS.kw_name_short || ' ' || CAST(MOD(CAST(WK.cy_week AS BIGNUMERIC), 100) AS STRING) || ' / ' || CAST(t.adv_wt_nr_int AS STRING)
    )
  END AS adv_short_desc_int_rs,
  CASE
  WHEN t.adv_wt_nr_int = 0
  THEN WK.cy_week * 10
  ELSE WK.cy_week
  END AS cy_week
FROM ldl_p_lew_core_ac.v_wawi_cal_week_2 AS WK
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_AT ON T_AT.language_id = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_BE ON T_BE.language_id = 2
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_BG ON T_BG.language_id = 3
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_CH ON T_CH.language_id = 4
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_CY ON T_CY.language_id = 5
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_CZ ON T_CZ.language_id = 6
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_DK ON T_DK.language_id = 8
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_EE ON T_EE.language_id = 9
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_ES ON T_ES.language_id = 10
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_FI ON T_FI.language_id = 11
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_FR ON T_FR.language_id = 12
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_GB ON T_GB.language_id = 13
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_GR ON T_GR.language_id = 14
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_HR ON T_HR.language_id = 15
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_HU ON T_HU.language_id = 16
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_IE ON T_IE.language_id = 17
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_IT ON T_IT.language_id = 18
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_LT ON T_LT.language_id = 19
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_LV ON T_LV.language_id = 20
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_NI ON T_NI.language_id = 21
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_NL ON T_NL.language_id = 22
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_DE ON T_DE.language_id = 23
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_PL ON T_PL.language_id = 24
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_PT ON T_PT.language_id = 25
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_RO ON T_RO.language_id = 26
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_SE ON T_SE.language_id = 27
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_SI ON T_SI.language_id = 28
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_SK ON T_SK.language_id = 29
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_CS ON T_CS.language_id = 31
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_MT ON T_MT.language_id = 32
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_US ON T_US.language_id = 33
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_kw_desc_2 AS T_RS ON T_RS.language_id = 34
 INNER JOIN (SELECT 0 AS adv_wt_nr_int
   UNION ALL
   SELECT 1 AS adv_wt_nr_int
   UNION ALL
   SELECT 2 AS adv_wt_nr_int
   UNION ALL
   SELECT 3 AS adv_wt_nr_int) AS t ON TRUE;

