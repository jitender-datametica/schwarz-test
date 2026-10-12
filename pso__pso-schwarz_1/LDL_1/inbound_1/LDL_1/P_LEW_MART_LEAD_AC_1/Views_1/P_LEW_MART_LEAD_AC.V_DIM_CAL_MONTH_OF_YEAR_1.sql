CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_DIM_CAL_MONTH_OF_YEAR_1
(
     month_of_year
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

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      CalMoY.month_of_year                  AS month_of_year,
   CalMoY.month_of_bus_year              AS month_of_bus_year,
   CalMoY.month_of_year_short_name       AS month_of_year_short_name,
   CalMoY.month_of_year_short_name_DE    AS month_of_year_short_name_DE,
   CalMoY.month_of_year_short_name_EN    AS month_of_year_short_name_EN,
   CalMoY.month_of_year_short_name_BG    AS month_of_year_short_name_BG,
   CalMoY.month_of_year_short_name_CS    AS month_of_year_short_name_CS,
   CalMoY.month_of_year_short_name_DA    AS month_of_year_short_name_DA,
   CalMoY.month_of_year_short_name_EL    AS month_of_year_short_name_EL,
   CalMoY.month_of_year_short_name_ES    AS month_of_year_short_name_ES,
   CalMoY.month_of_year_short_name_FI    AS month_of_year_short_name_FI,
   CalMoY.month_of_year_short_name_FR    AS month_of_year_short_name_FR,
   CalMoY.month_of_year_short_name_HR    AS month_of_year_short_name_HR,
   CalMoY.month_of_year_short_name_HU    AS month_of_year_short_name_HU,
   CalMoY.month_of_year_short_name_IT    AS month_of_year_short_name_IT,
   CalMoY.month_of_year_short_name_LT    AS month_of_year_short_name_LT,
   CalMoY.month_of_year_short_name_NL    AS month_of_year_short_name_NL,
   CalMoY.month_of_year_short_name_PL    AS month_of_year_short_name_PL,
   CalMoY.month_of_year_short_name_PT    AS month_of_year_short_name_PT,
   CalMoY.month_of_year_short_name_RO    AS month_of_year_short_name_RO,
   CalMoY.month_of_year_short_name_SH    AS month_of_year_short_name_SH,
   CalMoY.month_of_year_short_name_SK    AS month_of_year_short_name_SK,
   CalMoY.month_of_year_short_name_SL    AS month_of_year_short_name_SL,
   CalMoY.month_of_year_short_name_SV    AS month_of_year_short_name_SV,
   CalMoY.month_of_year_name             AS month_of_year_name,
   CalMoY.month_of_year_name_DE          AS month_of_year_name_DE,
   CalMoY.month_of_year_name_EN          AS month_of_year_name_EN,
   CalMoY.month_of_year_name_BG          AS month_of_year_name_BG,
   CalMoY.month_of_year_name_CS          AS month_of_year_name_CS,
   CalMoY.month_of_year_name_DA          AS month_of_year_name_DA,
   CalMoY.month_of_year_name_EL          AS month_of_year_name_EL,
   CalMoY.month_of_year_name_ES          AS month_of_year_name_ES,
   CalMoY.month_of_year_name_FI          AS month_of_year_name_FI,
   CalMoY.month_of_year_name_FR          AS month_of_year_name_FR,
   CalMoY.month_of_year_name_HR          AS month_of_year_name_HR,
   CalMoY.month_of_year_name_HU          AS month_of_year_name_HU,
   CalMoY.month_of_year_name_IT          AS month_of_year_name_IT,
   CalMoY.month_of_year_name_LT          AS month_of_year_name_LT,
   CalMoY.month_of_year_name_NL          AS month_of_year_name_NL,
   CalMoY.month_of_year_name_PL          AS month_of_year_name_PL,
   CalMoY.month_of_year_name_PT          AS month_of_year_name_PT,
   CalMoY.month_of_year_name_RO          AS month_of_year_name_RO,
   CalMoY.month_of_year_name_SH          AS month_of_year_name_SH,
   CalMoY.month_of_year_name_SK          AS month_of_year_name_SK,
   CalMoY.month_of_year_name_SL          AS month_of_year_name_SL,
   CalMoY.month_of_year_name_SV          AS month_of_year_name_SV,
   CalMoY.dwh_load_id                    AS dwh_load_id,
   CalMoY.dwh_created                    AS dwh_created,
   CalMoY.dwh_updated                    AS dwh_updated

FROM p_lew_mart_lead.v_dim_cal_month_of_year_1        AS CalMoY
   );