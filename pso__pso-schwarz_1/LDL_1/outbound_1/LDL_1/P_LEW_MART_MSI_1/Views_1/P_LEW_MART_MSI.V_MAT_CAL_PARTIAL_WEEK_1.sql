/* #----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_CAL_PARTIAL_WEEK_1
#----------------------------------------------------------------------------
# History:
#  1.0  19.11.2019    Ulrich Meister           Patch 20191113_2286_DM_t_pos_store_vat_avg_DWH20 (IDMO-2460, DWH-4137)
#  1.1 2020-08-07     Roy, Ritanjal            Introduce new country_1 Latviya
#  1.2  16.09.2021    Jaroslaw Syrokosz        Change from using CORE v_wawi_cal_partial_week_1 to views from BIL https://jira.schwarz/browse/REP2-10367
#  1.3  15.12.2021    Michael Morris           Added Estonia EE and BE_FR
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_cal_partial_week_1 (cy_week, cy_partial_week, cy_partial_week_name,
cy_partial_week_short_name, cy_month, cy, byr, dat_valid_from, dat_valid_until, partialweek_in_mth_seq_asc,
partialweek_in_mth_seq_desc, cy_partial_week_short_desc_at, cy_partial_week_short_desc_be,
cy_partial_week_short_desc_be_fr, cy_partial_week_short_desc_bg, cy_partial_week_short_desc_ch,
cy_partial_week_short_desc_cy, cy_partial_week_short_desc_cz, cy_partial_week_short_desc, cy_partial_week_short_desc_dk
, cy_partial_week_short_desc_ee, cy_partial_week_short_desc_es, cy_partial_week_short_desc_fi,
cy_partial_week_short_desc_fr, cy_partial_week_short_desc_gb, cy_partial_week_short_desc_gr,
cy_partial_week_short_desc_hr, cy_partial_week_short_desc_hu, cy_partial_week_short_desc_ie,
cy_partial_week_short_desc_it, cy_partial_week_short_desc_lt, cy_partial_week_short_desc_ni,
cy_partial_week_short_desc_nl, cy_partial_week_short_desc_de, cy_partial_week_short_desc_lv,
cy_partial_week_short_desc_pl, cy_partial_week_short_desc_pt, cy_partial_week_short_desc_ro,
cy_partial_week_short_desc_se, cy_partial_week_short_desc_si, cy_partial_week_short_desc_sk,
cy_partial_week_short_desc_cs, cy_partial_week_short_desc_mt, cy_partial_week_short_desc_us,
cy_partial_week_short_desc_rs) AS SELECT CW.cy_week,
 CW.week_part_seq AS cy_partial_week,
      'TW ' || TRIM(SUBSTR(CAST(MOD(CAST(CW.cy_week AS BIGNUMERIC), 100) AS STRING), 1, 10)) || '/ ' || TRIM(SUBSTR(CAST(CW.week_part_seq AS STRING)
      , 1, 39)) || '   ' || TRIM(SUBSTR(CAST(CW.cy AS STRING), 1, 39)) AS cy_partial_week_name,
    'TW ' || TRIM(SUBSTR(CAST(MOD(CAST(CW.cy_week AS BIGNUMERIC), 100) AS STRING), 1, 10)) || '/ ' || TRIM(SUBSTR(CAST(CW.week_part_seq AS STRING)
    , 1, 39)) AS cy_partial_week_short_name,
 CW.cy_month,
 CW.cy,
 CW.bus_year AS byr,
 CW.cy_week_part_begin_dt AS dat_valid_from,
 CW.cy_week_part_end_dt AS dat_valid_until,
 ROW_NUMBER() OVER (PARTITION BY CAST(CW.cy_month AS STRING) ORDER BY CW.cy_week IS NULL, CW.cy_week) AS
 partialweek_in_mth_seq_asc,
 ROW_NUMBER() OVER (PARTITION BY CAST(CW.cy_month AS STRING) ORDER BY CW.cy_week IS NULL DESC, CW.cy_week DESC) AS
 partialweek_in_mth_seq_desc,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_at, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_at, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_at,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_be, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_be, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_be,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_fr, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_fr, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_be_fr,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_bg, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_bg, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_bg,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_ch, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_ch, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_ch,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_cy, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_cy, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_cy,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_cz, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_cz, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_cz,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN CW.cy_week_part_descr
  ELSE NULL
  END AS cy_partial_week_short_desc,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_dk, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_dk, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_dk,
 CAST(NULL AS STRING) AS cy_partial_week_short_desc_ee,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_es, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_es, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_es,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_fi, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_fi, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_fi,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_fr, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_fr, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_fr,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_gb, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_gb, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_gb,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_gr, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_gr, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_gr,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_hr, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_hr, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_hr,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_hu, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_hu, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_hu,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_ie, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_ie, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_ie,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_it, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_it, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_it,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN CASE
   WHEN CW.cy < 2024
   THEN CASE
    WHEN CW.cy_week_part_full_week_fg = 0
    THEN CW.cy_week_part_descr
    ELSE NULL
    END
   ELSE TRIM(SUBSTR(FDOW.day_of_week_desc_lt, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_lt, 1, 2))
   END
  ELSE NULL
  END AS cy_partial_week_short_desc_lt,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_ni, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_ni, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_ni,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_nl, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_nl, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_nl,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_de, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_de, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_de,
 CAST(NULL AS STRING) AS cy_partial_week_short_desc_lv,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_pl, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_pl, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_pl,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_pt, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_pt, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_pt,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_ro, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_ro, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_ro,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_se, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_se, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_se,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_si, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_si, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_si,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_sk, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_sk, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_sk,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_cs, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_cs, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_cs,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_mt, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_mt, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_mt,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0 AND CW.cy > 2020
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_us, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_us, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_us,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 0 AND CW.cy > 2021
  THEN TRIM(SUBSTR(FDOW.day_of_week_desc_rs, 1, 2)) || ' - ' || TRIM(SUBSTR(LDOW.day_of_week_desc_rs, 1, 2))
  ELSE NULL
  END AS cy_partial_week_short_desc_rs
FROM ldl_p_lew_bil_ac.v_dim_cal_week_partial_1 AS CW
 INNER JOIN ldl_p_lew_mart_msi.v_cal_day_of_week_desc_1 AS FDOW ON CW.cy_week_part_begin_day_of_week = FDOW.day_of_week
 INNER JOIN ldl_p_lew_mart_msi.v_cal_day_of_week_desc_1 AS LDOW ON CW.cy_week_part_end_day_of_week = LDOW.day_of_week
WHERE CW.cy_week <> - 1;