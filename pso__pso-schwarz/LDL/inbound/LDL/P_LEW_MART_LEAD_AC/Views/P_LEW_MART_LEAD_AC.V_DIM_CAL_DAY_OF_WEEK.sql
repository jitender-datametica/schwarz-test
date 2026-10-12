CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_DIM_CAL_DAY_OF_WEEK
(
     day_of_week

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

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalDoW.day_of_week                  AS day_of_week,
   CalDoW.day_of_week_short_name       AS day_of_week_short_name,
   CalDoW.day_of_week_short_name_DE    AS day_of_week_short_name_DE,
   CalDoW.day_of_week_short_name_EN    AS day_of_week_short_name_EN,
   CalDoW.day_of_week_short_name_BG    AS day_of_week_short_name_BG,
   CalDoW.day_of_week_short_name_CS    AS day_of_week_short_name_CS,
   CalDoW.day_of_week_short_name_DA    AS day_of_week_short_name_DA,
   CalDoW.day_of_week_short_name_EL    AS day_of_week_short_name_EL,
   CalDoW.day_of_week_short_name_ES    AS day_of_week_short_name_ES,
   CalDoW.day_of_week_short_name_FI    AS day_of_week_short_name_FI,
   CalDoW.day_of_week_short_name_FR    AS day_of_week_short_name_FR,
   CalDoW.day_of_week_short_name_HR    AS day_of_week_short_name_HR,
   CalDoW.day_of_week_short_name_HU    AS day_of_week_short_name_HU,
   CalDoW.day_of_week_short_name_IT    AS day_of_week_short_name_IT,
   CalDoW.day_of_week_short_name_LT    AS day_of_week_short_name_LT,
   CalDoW.day_of_week_short_name_NL    AS day_of_week_short_name_NL,
   CalDoW.day_of_week_short_name_PL    AS day_of_week_short_name_PL,
   CalDoW.day_of_week_short_name_PT    AS day_of_week_short_name_PT,
   CalDoW.day_of_week_short_name_RO    AS day_of_week_short_name_RO,
   CalDoW.day_of_week_short_name_SH    AS day_of_week_short_name_SH,
   CalDoW.day_of_week_short_name_SK    AS day_of_week_short_name_SK,
   CalDoW.day_of_week_short_name_SL    AS day_of_week_short_name_SL,
   CalDoW.day_of_week_short_name_SV    AS day_of_week_short_name_SV,
   CalDoW.day_of_week_name             AS day_of_week_name,
   CalDoW.day_of_week_name_DE          AS day_of_week_name_DE,
   CalDoW.day_of_week_name_EN          AS day_of_week_name_EN,
   CalDoW.day_of_week_name_BG          AS day_of_week_name_BG,
   CalDoW.day_of_week_name_CS          AS day_of_week_name_CS,
   CalDoW.day_of_week_name_DA          AS day_of_week_name_DA,
   CalDoW.day_of_week_name_EL          AS day_of_week_name_EL,
   CalDoW.day_of_week_name_ES          AS day_of_week_name_ES,
   CalDoW.day_of_week_name_FI          AS day_of_week_name_FI,
   CalDoW.day_of_week_name_FR          AS day_of_week_name_FR,
   CalDoW.day_of_week_name_HR          AS day_of_week_name_HR,
   CalDoW.day_of_week_name_HU          AS day_of_week_name_HU,
   CalDoW.day_of_week_name_IT          AS day_of_week_name_IT,
   CalDoW.day_of_week_name_LT          AS day_of_week_name_LT,
   CalDoW.day_of_week_name_NL          AS day_of_week_name_NL,
   CalDoW.day_of_week_name_PL          AS day_of_week_name_PL,
   CalDoW.day_of_week_name_PT          AS day_of_week_name_PT,
   CalDoW.day_of_week_name_RO          AS day_of_week_name_RO,
   CalDoW.day_of_week_name_SH          AS day_of_week_name_SH,
   CalDoW.day_of_week_name_SK          AS day_of_week_name_SK,
   CalDoW.day_of_week_name_SL          AS day_of_week_name_SL,
   CalDoW.day_of_week_name_SV          AS day_of_week_name_SV,
   CalDoW.dwh_load_id                  AS dwh_load_id,
   CalDoW.dwh_created                  AS dwh_created,
   CalDoW.dwh_updated                  AS dwh_updated

FROM p_lew_mart_lead.v_dim_cal_day_of_week        AS CalDoW
   );