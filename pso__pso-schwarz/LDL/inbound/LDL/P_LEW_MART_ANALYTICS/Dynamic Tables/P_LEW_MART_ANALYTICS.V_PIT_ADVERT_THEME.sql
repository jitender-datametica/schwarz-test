
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_ADVERT_THEME
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     client_id,
   adv_theme_sid,
   CAST(adv_theme_sid *100 + client_id AS INTEGER)   AS adv_theme_mstr_sid,
   adv_theme_descr                                   AS advert_theme,
   dwh_created
  FROM p_lew_mart_analytics.t_advert_theme
  UNION ALL
  SELECT
    client_id,
   -2,
   CAST(-2 *100 + client_id AS INTEGER)              AS adv_theme_mstr_sid,
   'TOT'                                             AS advert_theme,
   TIMESTAMP'1900-01-01 00:00:00'                    AS dwh_created
  FROM p_lew_mart_analytics.t_pit_country
;
