/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_CAL_WEEK_PARTIAL_WEEK.
#----------------------------------------------------------------------------
# History:
#  1.0  15.09.2021    Syrokosz, Jaroslaw       First draft 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_cal_week_partial_week_2 (cy_week_partial_week_id1, cy_week_partial_week_id2,
cy_week_partial_week_name, cy_month, busyear, cy_week_partial_week_id, partialweek_in_mth_seq_asc,
partialweek_in_mth_seq_desc, cy_partial_week_short_name, cy_partial_week_short_name_de, cy_partial_week_short_name_en,
cy_partial_week_short_name_bg, cy_partial_week_short_name_cs, cy_partial_week_short_name_da,
cy_partial_week_short_name_el, cy_partial_week_short_name_es, cy_partial_week_short_name_fi,
cy_partial_week_short_name_fr, cy_partial_week_short_name_hr, cy_partial_week_short_name_hu,
cy_partial_week_short_name_it, cy_partial_week_short_name_lt, cy_partial_week_short_name_nl,
cy_partial_week_short_name_pl, cy_partial_week_short_name_pt, cy_partial_week_short_name_ro,
cy_partial_week_short_name_sh, cy_partial_week_short_name_sk, cy_partial_week_short_name_sl,
cy_partial_week_short_name_sv) AS SELECT CW.cy_week AS cy_week_partial_week_id1,
  CASE
  WHEN CW.cy_week_part_full_week_fg = 1
  THEN 9
  ELSE CW.week_part_seq
  END AS cy_week_partial_week_id2,
  CASE
  WHEN CASE
    WHEN CW.cy_week_part_full_week_fg = 1
    THEN 9
    ELSE CW.week_part_seq
    END = 9
  THEN TRIM(CAST(CW.cy AS STRING)) || ' KW ' || TRIM(CAST(CW.week_of_year AS STRING FORMAT '00'))
  ELSE TRIM(CAST(CW.cy AS STRING)) || ' KW ' || TRIM(CAST(CW.week_of_year AS STRING FORMAT '00')) || '/' || TRIM(CAST(CW.week_part_seq AS STRING FORMAT '0')
    )
  END AS cy_week_partial_week_name,
 CW.cy_month,
 CW.bus_year AS busyear,
   10 * CW.cy_week + CASE
   WHEN CW.cy_week_part_full_week_fg = 1
   THEN 9
   ELSE CW.week_part_seq
   END AS cy_week_partial_week_id,
 ROW_NUMBER() OVER (PARTITION BY CAST(CW.cy_month AS STRING) ORDER BY CW.cy_week_part IS NULL, CW.cy_week_part) AS
 partialweek_in_mth_seq_asc,
 ROW_NUMBER() OVER (PARTITION BY CAST(CW.cy_month AS STRING) ORDER BY CW.cy_week_part IS NULL DESC, CW.cy_week_part DESC
    ) AS partialweek_in_mth_seq_desc,
   TRIM(FDOW.day_of_week_short_name) || ' - ' || TRIM(LDOW.day_of_week_short_name) AS cy_partial_week_short_name,
   TRIM(FDOW.day_of_week_short_name_de) || ' - ' || TRIM(LDOW.day_of_week_short_name_de) AS
 cy_partial_week_short_name_de,
   TRIM(FDOW.day_of_week_short_name_en) || ' - ' || TRIM(LDOW.day_of_week_short_name_en) AS
 cy_partial_week_short_name_en,
   TRIM(FDOW.day_of_week_short_name_bg) || ' - ' || TRIM(LDOW.day_of_week_short_name_bg) AS
 cy_partial_week_short_name_bg,
   TRIM(FDOW.day_of_week_short_name_cs) || ' - ' || TRIM(LDOW.day_of_week_short_name_cs) AS
 cy_partial_week_short_name_cs,
   TRIM(FDOW.day_of_week_short_name_da) || ' - ' || TRIM(LDOW.day_of_week_short_name_da) AS
 cy_partial_week_short_name_da,
   TRIM(FDOW.day_of_week_short_name_el) || ' - ' || TRIM(LDOW.day_of_week_short_name_el) AS
 cy_partial_week_short_name_el,
   TRIM(FDOW.day_of_week_short_name_es) || ' - ' || TRIM(LDOW.day_of_week_short_name_es) AS
 cy_partial_week_short_name_es,
   TRIM(FDOW.day_of_week_short_name_fi) || ' - ' || TRIM(LDOW.day_of_week_short_name_fi) AS
 cy_partial_week_short_name_fi,
   TRIM(FDOW.day_of_week_short_name_fr) || ' - ' || TRIM(LDOW.day_of_week_short_name_fr) AS
 cy_partial_week_short_name_fr,
   TRIM(FDOW.day_of_week_short_name_hr) || ' - ' || TRIM(LDOW.day_of_week_short_name_hr) AS
 cy_partial_week_short_name_hr,
   TRIM(FDOW.day_of_week_short_name_hu) || ' - ' || TRIM(LDOW.day_of_week_short_name_hu) AS
 cy_partial_week_short_name_hu,
   TRIM(FDOW.day_of_week_short_name_it) || ' - ' || TRIM(LDOW.day_of_week_short_name_it) AS
 cy_partial_week_short_name_it,
   TRIM(FDOW.day_of_week_short_name_lt) || ' - ' || TRIM(LDOW.day_of_week_short_name_lt) AS
 cy_partial_week_short_name_lt,
   TRIM(FDOW.day_of_week_short_name_nl) || ' - ' || TRIM(LDOW.day_of_week_short_name_nl) AS
 cy_partial_week_short_name_nl,
   TRIM(FDOW.day_of_week_short_name_pl) || ' - ' || TRIM(LDOW.day_of_week_short_name_pl) AS
 cy_partial_week_short_name_pl,
   TRIM(FDOW.day_of_week_short_name_pt) || ' - ' || TRIM(LDOW.day_of_week_short_name_pt) AS
 cy_partial_week_short_name_pt,
   TRIM(FDOW.day_of_week_short_name_ro) || ' - ' || TRIM(LDOW.day_of_week_short_name_ro) AS
 cy_partial_week_short_name_ro,
   TRIM(FDOW.day_of_week_short_name_sh) || ' - ' || TRIM(LDOW.day_of_week_short_name_sh) AS
 cy_partial_week_short_name_sh,
   TRIM(FDOW.day_of_week_short_name_sk) || ' - ' || TRIM(LDOW.day_of_week_short_name_sk) AS
 cy_partial_week_short_name_sk,
   TRIM(FDOW.day_of_week_short_name_sl) || ' - ' || TRIM(LDOW.day_of_week_short_name_sl) AS
 cy_partial_week_short_name_sl,
   TRIM(FDOW.day_of_week_short_name_sv) || ' - ' || TRIM(LDOW.day_of_week_short_name_sv) AS
 cy_partial_week_short_name_sv
FROM ldl_p_lew_bil.t_dim_cal_week_partial_2 AS CW
 INNER JOIN ldl_p_lew_bil.t_dim_cal_day_of_week_2 AS FDOW ON CW.cy_week_part_begin_day_of_week = FDOW.day_of_week
 INNER JOIN ldl_p_lew_bil.t_dim_cal_day_of_week_2 AS LDOW ON CW.cy_week_part_end_day_of_week = LDOW.day_of_week
UNION ALL
SELECT CW.cy_week AS cy_week_partial_week_id1,
 9 AS cy_week_partial_week_id2,
   TRIM(CAST(CW.cy AS STRING)) || ' KW ' || TRIM(CAST(CW.week_of_year AS STRING FORMAT '00')) AS
 cy_week_partial_week_name,
 CW.cy_month,
 CW.bus_year AS busyear,
   10 * CW.cy_week + 9 AS cy_week_partial_week_id,
 CAST(NULL AS BIGINT) AS partialweek_in_mth_seq_asc,
 CAST(NULL AS BIGINT) AS partialweek_in_mth_seq_desc,
   TRIM(FDOW.day_of_week_short_name) || ' - ' || TRIM(LDOW.day_of_week_short_name) AS cy_partial_week_short_name,
   TRIM(FDOW.day_of_week_short_name_de) || ' - ' || TRIM(LDOW.day_of_week_short_name_de) AS
 cy_partial_week_short_name_de,
   TRIM(FDOW.day_of_week_short_name_en) || ' - ' || TRIM(LDOW.day_of_week_short_name_en) AS
 cy_partial_week_short_name_en,
   TRIM(FDOW.day_of_week_short_name_bg) || ' - ' || TRIM(LDOW.day_of_week_short_name_bg) AS
 cy_partial_week_short_name_bg,
   TRIM(FDOW.day_of_week_short_name_cs) || ' - ' || TRIM(LDOW.day_of_week_short_name_cs) AS
 cy_partial_week_short_name_cs,
   TRIM(FDOW.day_of_week_short_name_da) || ' - ' || TRIM(LDOW.day_of_week_short_name_da) AS
 cy_partial_week_short_name_da,
   TRIM(FDOW.day_of_week_short_name_el) || ' - ' || TRIM(LDOW.day_of_week_short_name_el) AS
 cy_partial_week_short_name_el,
   TRIM(FDOW.day_of_week_short_name_es) || ' - ' || TRIM(LDOW.day_of_week_short_name_es) AS
 cy_partial_week_short_name_es,
   TRIM(FDOW.day_of_week_short_name_fi) || ' - ' || TRIM(LDOW.day_of_week_short_name_fi) AS
 cy_partial_week_short_name_fi,
   TRIM(FDOW.day_of_week_short_name_fr) || ' - ' || TRIM(LDOW.day_of_week_short_name_fr) AS
 cy_partial_week_short_name_fr,
   TRIM(FDOW.day_of_week_short_name_hr) || ' - ' || TRIM(LDOW.day_of_week_short_name_hr) AS
 cy_partial_week_short_name_hr,
   TRIM(FDOW.day_of_week_short_name_hu) || ' - ' || TRIM(LDOW.day_of_week_short_name_hu) AS
 cy_partial_week_short_name_hu,
   TRIM(FDOW.day_of_week_short_name_it) || ' - ' || TRIM(LDOW.day_of_week_short_name_it) AS
 cy_partial_week_short_name_it,
   TRIM(FDOW.day_of_week_short_name_lt) || ' - ' || TRIM(LDOW.day_of_week_short_name_lt) AS
 cy_partial_week_short_name_lt,
   TRIM(FDOW.day_of_week_short_name_nl) || ' - ' || TRIM(LDOW.day_of_week_short_name_nl) AS
 cy_partial_week_short_name_nl,
   TRIM(FDOW.day_of_week_short_name_pl) || ' - ' || TRIM(LDOW.day_of_week_short_name_pl) AS
 cy_partial_week_short_name_pl,
   TRIM(FDOW.day_of_week_short_name_pt) || ' - ' || TRIM(LDOW.day_of_week_short_name_pt) AS
 cy_partial_week_short_name_pt,
   TRIM(FDOW.day_of_week_short_name_ro) || ' - ' || TRIM(LDOW.day_of_week_short_name_ro) AS
 cy_partial_week_short_name_ro,
   TRIM(FDOW.day_of_week_short_name_sh) || ' - ' || TRIM(LDOW.day_of_week_short_name_sh) AS
 cy_partial_week_short_name_sh,
   TRIM(FDOW.day_of_week_short_name_sk) || ' - ' || TRIM(LDOW.day_of_week_short_name_sk) AS
 cy_partial_week_short_name_sk,
   TRIM(FDOW.day_of_week_short_name_sl) || ' - ' || TRIM(LDOW.day_of_week_short_name_sl) AS
 cy_partial_week_short_name_sl,
   TRIM(FDOW.day_of_week_short_name_sv) || ' - ' || TRIM(LDOW.day_of_week_short_name_sv) AS
 cy_partial_week_short_name_sv
FROM ldl_p_lew_bil.t_dim_cal_week_partial_2 AS CW
 INNER JOIN ldl_p_lew_bil.t_dim_cal_day_of_week_2 AS FDOW ON CW.cy_week_part_begin_day_of_week = FDOW.day_of_week
 INNER JOIN ldl_p_lew_bil.t_dim_cal_day_of_week_2 AS LDOW ON CW.cy_week_part_end_day_of_week = LDOW.day_of_week
WHERE CW.week_part_seq = 2;