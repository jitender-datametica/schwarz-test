CREATE OR REPLACE VIEW P_LEW_BIL.V_DIM_CURRENCY
(
     curr_cd

,          curr_name
,          curr_name_DE
,          curr_name_EN

,          curr_name_BG
,          curr_name_CS
,          curr_name_DA
,          curr_name_EL
,          curr_name_ES
,          curr_name_FI
,          curr_name_FR
,          curr_name_HR
,          curr_name_HU
,          curr_name_IT
,          curr_name_LT
,          curr_name_NL
,          curr_name_PL
,          curr_name_PT
,          curr_name_RO
,          curr_name_SH
,          curr_name_SK
,          curr_name_SL
,          curr_name_SV

,          used_in_lidl_countries_fg

,          euro_exchange_rate

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      Curr.curr_cd                                   AS curr_cd,
   Curr.curr_name                                 AS curr_name,
   Coalesce(Curr.curr_name_DE, Curr.curr_name)    AS curr_name_DE,
   Coalesce(Curr.curr_name_EN, Curr.curr_name)    AS curr_name_EN,
   Coalesce(Curr.curr_name_BG, Curr.curr_name)    AS curr_name_BG,
   Coalesce(Curr.curr_name_CS, Curr.curr_name)    AS curr_name_CS,
   Coalesce(Curr.curr_name_DA, Curr.curr_name)    AS curr_name_DA,
   Coalesce(Curr.curr_name_EL, Curr.curr_name)    AS curr_name_EL,
   Coalesce(Curr.curr_name_ES, Curr.curr_name)    AS curr_name_ES,
   Coalesce(Curr.curr_name_FI, Curr.curr_name)    AS curr_name_FI,
   Coalesce(Curr.curr_name_FR, Curr.curr_name)    AS curr_name_FR,
   Coalesce(Curr.curr_name_HR, Curr.curr_name)    AS curr_name_HR,
   Coalesce(Curr.curr_name_HU, Curr.curr_name)    AS curr_name_HU,
   Coalesce(Curr.curr_name_IT, Curr.curr_name)    AS curr_name_IT,
   Coalesce(Curr.curr_name_LT, Curr.curr_name)    AS curr_name_LT,
   Coalesce(Curr.curr_name_NL, Curr.curr_name)    AS curr_name_NL,
   Coalesce(Curr.curr_name_PL, Curr.curr_name)    AS curr_name_PL,
   Coalesce(Curr.curr_name_PT, Curr.curr_name)    AS curr_name_PT,
   Coalesce(Curr.curr_name_RO, Curr.curr_name)    AS curr_name_RO,
   Coalesce(Curr.curr_name_SH, Curr.curr_name)    AS curr_name_SH,
   Coalesce(Curr.curr_name_SK, Curr.curr_name)    AS curr_name_SK,
   Coalesce(Curr.curr_name_SL, Curr.curr_name)    AS curr_name_SL,
   Coalesce(Curr.curr_name_SV, Curr.curr_name)    AS curr_name_SV,
   Curr.used_in_lidl_countries_fg                 AS used_in_lidl_countries_fg,
   Curr.euro_exchange_rate                        AS euro_exchange_rate,
   Curr.dwh_load_id                               AS dwh_load_id,
   Curr.dwh_created                               AS dwh_created,
   Curr.dwh_updated                               AS dwh_updated

FROM p_lew_bil.t_dim_currency        AS Curr
   );