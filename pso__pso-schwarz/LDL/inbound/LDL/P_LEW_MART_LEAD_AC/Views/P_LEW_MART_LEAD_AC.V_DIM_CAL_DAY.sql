CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_DIM_CAL_DAY
(
     cal_dt

,          cy
,          bus_year

,          cy_month

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

,          day_of_month

,          cy_week
,          week_of_year

,          cy_week_part
,          week_part_seq

,          day_of_week

,          day_of_week_short_name
,          day_of_week_short_name_DE
,          day_of_week_short_name_EN
,          day_of_week_short_name_BG
,          day_of_week_short_name_CS
,          day_of_week_short_name_DA
,          day_of_week_short_name_EL
,          day_of_week_short_name_ES
,          day_of_week_short_name_FI
,          day_of_week_short_name_FR
,          day_of_week_short_name_HR
,          day_of_week_short_name_HU
,          day_of_week_short_name_IT
,          day_of_week_short_name_LT
,          day_of_week_short_name_NL
,          day_of_week_short_name_PL
,          day_of_week_short_name_PT
,          day_of_week_short_name_RO
,          day_of_week_short_name_SH
,          day_of_week_short_name_SK
,          day_of_week_short_name_SL
,          day_of_week_short_name_SV

,          day_of_week_name
,          day_of_week_name_DE
,          day_of_week_name_EN
,          day_of_week_name_BG
,          day_of_week_name_CS
,          day_of_week_name_DA
,          day_of_week_name_EL
,          day_of_week_name_ES
,          day_of_week_name_FI
,          day_of_week_name_FR
,          day_of_week_name_HR
,          day_of_week_name_HU
,          day_of_week_name_IT
,          day_of_week_name_LT
,          day_of_week_name_NL
,          day_of_week_name_PL
,          day_of_week_name_PT
,          day_of_week_name_RO
,          day_of_week_name_SH
,          day_of_week_name_SK
,          day_of_week_name_SL
,          day_of_week_name_SV

,          day_of_cy
,          day_of_bus_year

,          cal_dt_prev_1d
,          cal_dt_prev_1w
,          cal_dt_prev_1m
,          cal_dt_prev_1y
,          cal_dt_prev_2y
,          cal_dt_prev_3y
,          cal_dt_prev_4y
,          cal_dt_prev_5y

,          cal_dt_swday_prev_1m
,          cal_dt_swday_prev_1y
,          cal_dt_swday_prev_2y
,          cal_dt_swday_prev_3y
,          cal_dt_swday_prev_4y
,          cal_dt_swday_prev_5y

,          first_day_of_week_part_fg
,          last_day_of_week_part_fg
,          first_day_of_week_fg
,          last_day_of_week_fg
,          first_day_of_month_fg
,          last_day_of_month_fg
,          first_day_of_cy_fg
,          last_day_of_cy_fg
,          first_day_of_bus_year_fg
,          last_day_of_bus_year_fg

,          cal_dt_offset
,          cy_week_part_offset
,          cy_week_offset
,          cy_month_offset
,          cy_offset
,          bus_year_offset

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalDay.cal_dt                         AS cal_dt,
   CalDay.cy                             AS cy,
   CalDay.bus_year                       AS bus_year,
   CalDay.cy_month                       AS cy_month,
   CalDay.month_of_year                  AS month_of_year,
   CalDay.month_of_bus_year              AS month_of_bus_year,
   CalDay.month_of_year_short_name       AS month_of_year_short_name,
   CalDay.month_of_year_short_name_DE    AS month_of_year_short_name_DE,
   CalDay.month_of_year_short_name_EN    AS month_of_year_short_name_EN,
   CalDay.month_of_year_short_name_BG    AS month_of_year_short_name_BG,
   CalDay.month_of_year_short_name_CS    AS month_of_year_short_name_CS,
   CalDay.month_of_year_short_name_DA    AS month_of_year_short_name_DA,
   CalDay.month_of_year_short_name_EL    AS month_of_year_short_name_EL,
   CalDay.month_of_year_short_name_ES    AS month_of_year_short_name_ES,
   CalDay.month_of_year_short_name_FI    AS month_of_year_short_name_FI,
   CalDay.month_of_year_short_name_FR    AS month_of_year_short_name_FR,
   CalDay.month_of_year_short_name_HR    AS month_of_year_short_name_HR,
   CalDay.month_of_year_short_name_HU    AS month_of_year_short_name_HU,
   CalDay.month_of_year_short_name_IT    AS month_of_year_short_name_IT,
   CalDay.month_of_year_short_name_LT    AS month_of_year_short_name_LT,
   CalDay.month_of_year_short_name_NL    AS month_of_year_short_name_NL,
   CalDay.month_of_year_short_name_PL    AS month_of_year_short_name_PL,
   CalDay.month_of_year_short_name_PT    AS month_of_year_short_name_PT,
   CalDay.month_of_year_short_name_RO    AS month_of_year_short_name_RO,
   CalDay.month_of_year_short_name_SH    AS month_of_year_short_name_SH,
   CalDay.month_of_year_short_name_SK    AS month_of_year_short_name_SK,
   CalDay.month_of_year_short_name_SL    AS month_of_year_short_name_SL,
   CalDay.month_of_year_short_name_SV    AS month_of_year_short_name_SV,
   CalDay.month_of_year_name             AS month_of_year_name,
   CalDay.month_of_year_name_DE          AS month_of_year_name_DE,
   CalDay.month_of_year_name_EN          AS month_of_year_name_EN,
   CalDay.month_of_year_name_BG          AS month_of_year_name_BG,
   CalDay.month_of_year_name_CS          AS month_of_year_name_CS,
   CalDay.month_of_year_name_DA          AS month_of_year_name_DA,
   CalDay.month_of_year_name_EL          AS month_of_year_name_EL,
   CalDay.month_of_year_name_ES          AS month_of_year_name_ES,
   CalDay.month_of_year_name_FI          AS month_of_year_name_FI,
   CalDay.month_of_year_name_FR          AS month_of_year_name_FR,
   CalDay.month_of_year_name_HR          AS month_of_year_name_HR,
   CalDay.month_of_year_name_HU          AS month_of_year_name_HU,
   CalDay.month_of_year_name_IT          AS month_of_year_name_IT,
   CalDay.month_of_year_name_LT          AS month_of_year_name_LT,
   CalDay.month_of_year_name_NL          AS month_of_year_name_NL,
   CalDay.month_of_year_name_PL          AS month_of_year_name_PL,
   CalDay.month_of_year_name_PT          AS month_of_year_name_PT,
   CalDay.month_of_year_name_RO          AS month_of_year_name_RO,
   CalDay.month_of_year_name_SH          AS month_of_year_name_SH,
   CalDay.month_of_year_name_SK          AS month_of_year_name_SK,
   CalDay.month_of_year_name_SL          AS month_of_year_name_SL,
   CalDay.month_of_year_name_SV          AS month_of_year_name_SV,
   CalDay.day_of_month                   AS day_of_month,
   CalDay.cy_week                        AS cy_week,
   CalDay.week_of_year                   AS week_of_year,
   CalDay.cy_week_part                   AS cy_week_part,
   CalDay.week_part_seq                  AS week_part_seq,
   CalDay.day_of_week                    AS day_of_week,
   CalDay.day_of_week_short_name         AS day_of_week_short_name,
   CalDay.day_of_week_short_name_DE      AS day_of_week_short_name_DE,
   CalDay.day_of_week_short_name_EN      AS day_of_week_short_name_EN,
   CalDay.day_of_week_short_name_BG      AS day_of_week_short_name_BG,
   CalDay.day_of_week_short_name_CS      AS day_of_week_short_name_CS,
   CalDay.day_of_week_short_name_DA      AS day_of_week_short_name_DA,
   CalDay.day_of_week_short_name_EL      AS day_of_week_short_name_EL,
   CalDay.day_of_week_short_name_ES      AS day_of_week_short_name_ES,
   CalDay.day_of_week_short_name_FI      AS day_of_week_short_name_FI,
   CalDay.day_of_week_short_name_FR      AS day_of_week_short_name_FR,
   CalDay.day_of_week_short_name_HR      AS day_of_week_short_name_HR,
   CalDay.day_of_week_short_name_HU      AS day_of_week_short_name_HU,
   CalDay.day_of_week_short_name_IT      AS day_of_week_short_name_IT,
   CalDay.day_of_week_short_name_LT      AS day_of_week_short_name_LT,
   CalDay.day_of_week_short_name_NL      AS day_of_week_short_name_NL,
   CalDay.day_of_week_short_name_PL      AS day_of_week_short_name_PL,
   CalDay.day_of_week_short_name_PT      AS day_of_week_short_name_PT,
   CalDay.day_of_week_short_name_RO      AS day_of_week_short_name_RO,
   CalDay.day_of_week_short_name_SH      AS day_of_week_short_name_SH,
   CalDay.day_of_week_short_name_SK      AS day_of_week_short_name_SK,
   CalDay.day_of_week_short_name_SL      AS day_of_week_short_name_SL,
   CalDay.day_of_week_short_name_SV      AS day_of_week_short_name_SV,
   CalDay.day_of_week_name               AS day_of_week_name,
   CalDay.day_of_week_name_DE            AS day_of_week_name_DE,
   CalDay.day_of_week_name_EN            AS day_of_week_name_EN,
   CalDay.day_of_week_name_BG            AS day_of_week_name_BG,
   CalDay.day_of_week_name_CS            AS day_of_week_name_CS,
   CalDay.day_of_week_name_DA            AS day_of_week_name_DA,
   CalDay.day_of_week_name_EL            AS day_of_week_name_EL,
   CalDay.day_of_week_name_ES            AS day_of_week_name_ES,
   CalDay.day_of_week_name_FI            AS day_of_week_name_FI,
   CalDay.day_of_week_name_FR            AS day_of_week_name_FR,
   CalDay.day_of_week_name_HR            AS day_of_week_name_HR,
   CalDay.day_of_week_name_HU            AS day_of_week_name_HU,
   CalDay.day_of_week_name_IT            AS day_of_week_name_IT,
   CalDay.day_of_week_name_LT            AS day_of_week_name_LT,
   CalDay.day_of_week_name_NL            AS day_of_week_name_NL,
   CalDay.day_of_week_name_PL            AS day_of_week_name_PL,
   CalDay.day_of_week_name_PT            AS day_of_week_name_PT,
   CalDay.day_of_week_name_RO            AS day_of_week_name_RO,
   CalDay.day_of_week_name_SH            AS day_of_week_name_SH,
   CalDay.day_of_week_name_SK            AS day_of_week_name_SK,
   CalDay.day_of_week_name_SL            AS day_of_week_name_SL,
   CalDay.day_of_week_name_SV            AS day_of_week_name_SV,
   CalDay.day_of_cy                      AS day_of_cy,
   CalDay.day_of_bus_year                AS day_of_bus_year,
   CalDay.cal_dt_prev_1d                 AS cal_dt_prev_1d,
   CalDay.cal_dt_prev_1w                 AS cal_dt_prev_1w,
   CalDay.cal_dt_prev_1m                 AS cal_dt_prev_1m,
   CalDay.cal_dt_prev_1y                 AS cal_dt_prev_1y,
   CalDay.cal_dt_prev_2y                 AS cal_dt_prev_2y,
   CalDay.cal_dt_prev_3y                 AS cal_dt_prev_3y,
   CalDay.cal_dt_prev_4y                 AS cal_dt_prev_4y,
   CalDay.cal_dt_prev_5y                 AS cal_dt_prev_5y,
   CalDay.cal_dt_swday_prev_1m           AS cal_dt_swday_prev_1m,
   CalDay.cal_dt_swday_prev_1y           AS cal_dt_swday_prev_1y,
   CalDay.cal_dt_swday_prev_2y           AS cal_dt_swday_prev_2y,
   CalDay.cal_dt_swday_prev_3y           AS cal_dt_swday_prev_3y,
   CalDay.cal_dt_swday_prev_4y           AS cal_dt_swday_prev_4y,
   CalDay.cal_dt_swday_prev_5y           AS cal_dt_swday_prev_5y,
   CalDay.first_day_of_week_part_fg      AS first_day_of_week_part_fg,
   CalDay.last_day_of_week_part_fg       AS last_day_of_week_part_fg,
   CalDay.first_day_of_week_fg           AS first_day_of_week_fg,
   CalDay.last_day_of_week_fg            AS last_day_of_week_fg,
   CalDay.first_day_of_month_fg          AS first_day_of_month_fg,
   CalDay.last_day_of_month_fg           AS last_day_of_month_fg,
   CalDay.first_day_of_cy_fg             AS first_day_of_cy_fg,
   CalDay.last_day_of_cy_fg              AS last_day_of_cy_fg,
   CalDay.first_day_of_bus_year_fg       AS first_day_of_bus_year_fg,
   CalDay.last_day_of_bus_year_fg        AS last_day_of_bus_year_fg,
   CalDay.cal_dt_offset                  AS cal_dt_offset,
   CalDay.cy_week_part_offset            AS cy_week_part_offset,
   CalDay.cy_week_offset                 AS cy_week_offset,
   CalDay.cy_month_offset                AS cy_month_offset,
   CalDay.cy_offset                      AS cy_offset,
   CalDay.bus_year_offset                AS bus_year_offset,
   CalDay.dwh_load_id                    AS dwh_load_id,
   CalDay.dwh_created                    AS dwh_created,
   CalDay.dwh_updated                    AS dwh_updated

FROM p_lew_mart_lead.v_dim_cal_day        AS CalDay
   );