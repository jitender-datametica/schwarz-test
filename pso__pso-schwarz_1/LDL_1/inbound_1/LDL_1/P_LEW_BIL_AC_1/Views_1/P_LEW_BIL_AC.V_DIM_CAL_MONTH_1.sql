CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_DIM_CAL_MONTH_1
(
     cy_month

,          cy
,          bus_year

,          month_of_year
,          month_of_bus_year

,          month_of_year_short_name
,          month_of_year_short_name_DE
,          month_of_year_short_name_EN
,          month_of_year_short_name_BG
,          month_of_year_short_name_CS
,          month_of_year_short_name_DA
,          month_of_year_short_name_EL
,          month_of_year_short_name_ES
,          month_of_year_short_name_FI
,          month_of_year_short_name_FR
,          month_of_year_short_name_HR
,          month_of_year_short_name_HU
,          month_of_year_short_name_IT
,          month_of_year_short_name_LT
,          month_of_year_short_name_NL
,          month_of_year_short_name_PL
,          month_of_year_short_name_PT
,          month_of_year_short_name_RO
,          month_of_year_short_name_SH
,          month_of_year_short_name_SK
,          month_of_year_short_name_SL
,          month_of_year_short_name_SV

,          month_of_year_name
,          month_of_year_name_DE
,          month_of_year_name_EN
,          month_of_year_name_BG
,          month_of_year_name_CS
,          month_of_year_name_DA
,          month_of_year_name_EL
,          month_of_year_name_ES
,          month_of_year_name_FI
,          month_of_year_name_FR
,          month_of_year_name_HR
,          month_of_year_name_HU
,          month_of_year_name_IT
,          month_of_year_name_LT
,          month_of_year_name_NL
,          month_of_year_name_PL
,          month_of_year_name_PT
,          month_of_year_name_RO
,          month_of_year_name_SH
,          month_of_year_name_SK
,          month_of_year_name_SL
,          month_of_year_name_SV

,          cy_month_begin_week_part
,          cy_month_end_week_part
,          cy_month_begin_dt
,          cy_month_end_dt

,          cy_month_week_part_cnt
,          cy_month_day_cnt

,          cy_month_prev_1m
,          cy_month_prev_1y
,          cy_month_prev_2y
,          cy_month_prev_3y
,          cy_month_prev_4y
,          cy_month_prev_5y

,          cy_month_offset
,          cy_offset
,          bus_year_offset

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalMth.cy_month                       AS cy_month,
   CalMth.cy                             AS cy,
   CalMth.bus_year                       AS bus_year,
   CalMth.month_of_year                  AS month_of_year,
   CalMth.month_of_bus_year              AS month_of_bus_year,
   CalMth.month_of_year_short_name       AS month_of_year_short_name,
   CalMth.month_of_year_short_name_DE    AS month_of_year_short_name_DE,
   CalMth.month_of_year_short_name_EN    AS month_of_year_short_name_EN,
   CalMth.month_of_year_short_name_BG    AS month_of_year_short_name_BG,
   CalMth.month_of_year_short_name_CS    AS month_of_year_short_name_CS,
   CalMth.month_of_year_short_name_DA    AS month_of_year_short_name_DA,
   CalMth.month_of_year_short_name_EL    AS month_of_year_short_name_EL,
   CalMth.month_of_year_short_name_ES    AS month_of_year_short_name_ES,
   CalMth.month_of_year_short_name_FI    AS month_of_year_short_name_FI,
   CalMth.month_of_year_short_name_FR    AS month_of_year_short_name_FR,
   CalMth.month_of_year_short_name_HR    AS month_of_year_short_name_HR,
   CalMth.month_of_year_short_name_HU    AS month_of_year_short_name_HU,
   CalMth.month_of_year_short_name_IT    AS month_of_year_short_name_IT,
   CalMth.month_of_year_short_name_LT    AS month_of_year_short_name_LT,
   CalMth.month_of_year_short_name_NL    AS month_of_year_short_name_NL,
   CalMth.month_of_year_short_name_PL    AS month_of_year_short_name_PL,
   CalMth.month_of_year_short_name_PT    AS month_of_year_short_name_PT,
   CalMth.month_of_year_short_name_RO    AS month_of_year_short_name_RO,
   CalMth.month_of_year_short_name_SH    AS month_of_year_short_name_SH,
   CalMth.month_of_year_short_name_SK    AS month_of_year_short_name_SK,
   CalMth.month_of_year_short_name_SL    AS month_of_year_short_name_SL,
   CalMth.month_of_year_short_name_SV    AS month_of_year_short_name_SV,
   CalMth.month_of_year_name             AS month_of_year_name,
   CalMth.month_of_year_name_DE          AS month_of_year_name_DE,
   CalMth.month_of_year_name_EN          AS month_of_year_name_EN,
   CalMth.month_of_year_name_BG          AS month_of_year_name_BG,
   CalMth.month_of_year_name_CS          AS month_of_year_name_CS,
   CalMth.month_of_year_name_DA          AS month_of_year_name_DA,
   CalMth.month_of_year_name_EL          AS month_of_year_name_EL,
   CalMth.month_of_year_name_ES          AS month_of_year_name_ES,
   CalMth.month_of_year_name_FI          AS month_of_year_name_FI,
   CalMth.month_of_year_name_FR          AS month_of_year_name_FR,
   CalMth.month_of_year_name_HR          AS month_of_year_name_HR,
   CalMth.month_of_year_name_HU          AS month_of_year_name_HU,
   CalMth.month_of_year_name_IT          AS month_of_year_name_IT,
   CalMth.month_of_year_name_LT          AS month_of_year_name_LT,
   CalMth.month_of_year_name_NL          AS month_of_year_name_NL,
   CalMth.month_of_year_name_PL          AS month_of_year_name_PL,
   CalMth.month_of_year_name_PT          AS month_of_year_name_PT,
   CalMth.month_of_year_name_RO          AS month_of_year_name_RO,
   CalMth.month_of_year_name_SH          AS month_of_year_name_SH,
   CalMth.month_of_year_name_SK          AS month_of_year_name_SK,
   CalMth.month_of_year_name_SL          AS month_of_year_name_SL,
   CalMth.month_of_year_name_SV          AS month_of_year_name_SV,
   CalMth.cy_month_begin_week_part       AS cy_month_begin_week_part,
   CalMth.cy_month_end_week_part         AS cy_month_end_week_part,
   CalMth.cy_month_begin_dt              AS cy_month_begin_dt,
   CalMth.cy_month_end_dt                AS cy_month_end_dt,
   CalMth.cy_month_week_part_cnt         AS cy_month_week_part_cnt,
   CalMth.cy_month_day_cnt               AS cy_month_day_cnt,
   CalMth.cy_month_prev_1m               AS cy_month_prev_1m,
   CalMth.cy_month_prev_1y               AS cy_month_prev_1y,
   CalMth.cy_month_prev_2y               AS cy_month_prev_2y,
   CalMth.cy_month_prev_3y               AS cy_month_prev_3y,
   CalMth.cy_month_prev_4y               AS cy_month_prev_4y,
   CalMth.cy_month_prev_5y               AS cy_month_prev_5y,
   CalMth.cy_month_offset                AS cy_month_offset,
   CalMth.cy_offset                      AS cy_offset,
   CalMth.bus_year_offset                AS bus_year_offset,
   CalMth.dwh_load_id                    AS dwh_load_id,
   CalMth.dwh_created                    AS dwh_created,
   CalMth.dwh_updated                    AS dwh_updated

FROM p_lew_bil.t_dim_cal_month_1        AS CalMth
   );