CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_DIM_EXCHANGE_RATE_TYPE_1
(
     exchange_rate_type_cd

,          exchange_rate_type_descr
,          exchange_rate_type_descr_DE
,          exchange_rate_type_descr_EN

,          exchange_rate_type_descr_BG
,          exchange_rate_type_descr_CS
,          exchange_rate_type_descr_DA
,          exchange_rate_type_descr_EL
,          exchange_rate_type_descr_ES
,          exchange_rate_type_descr_FI
,          exchange_rate_type_descr_FR
,          exchange_rate_type_descr_HR
,          exchange_rate_type_descr_HU
,          exchange_rate_type_descr_IT
,          exchange_rate_type_descr_LT
,          exchange_rate_type_descr_NL
,          exchange_rate_type_descr_PL
,          exchange_rate_type_descr_PT
,          exchange_rate_type_descr_RO
,          exchange_rate_type_descr_SH
,          exchange_rate_type_descr_SK
,          exchange_rate_type_descr_SL
,          exchange_rate_type_descr_SV

,          active_for_bus_year_fg

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      Exch.exchange_rate_type_cd          AS exchange_rate_type_cd,
   Exch.exchange_rate_type_descr       AS exchange_rate_type_descr,
   Exch.exchange_rate_type_descr_DE    AS exchange_rate_type_descr_DE,
   Exch.exchange_rate_type_descr_EN    AS exchange_rate_type_descr_EN,
   Exch.exchange_rate_type_descr_BG    AS exchange_rate_type_descr_BG,
   Exch.exchange_rate_type_descr_CS    AS exchange_rate_type_descr_CS,
   Exch.exchange_rate_type_descr_DA    AS exchange_rate_type_descr_DA,
   Exch.exchange_rate_type_descr_EL    AS exchange_rate_type_descr_EL,
   Exch.exchange_rate_type_descr_ES    AS exchange_rate_type_descr_ES,
   Exch.exchange_rate_type_descr_FI    AS exchange_rate_type_descr_FI,
   Exch.exchange_rate_type_descr_FR    AS exchange_rate_type_descr_FR,
   Exch.exchange_rate_type_descr_HR    AS exchange_rate_type_descr_HR,
   Exch.exchange_rate_type_descr_HU    AS exchange_rate_type_descr_HU,
   Exch.exchange_rate_type_descr_IT    AS exchange_rate_type_descr_IT,
   Exch.exchange_rate_type_descr_LT    AS exchange_rate_type_descr_LT,
   Exch.exchange_rate_type_descr_NL    AS exchange_rate_type_descr_NL,
   Exch.exchange_rate_type_descr_PL    AS exchange_rate_type_descr_PL,
   Exch.exchange_rate_type_descr_PT    AS exchange_rate_type_descr_PT,
   Exch.exchange_rate_type_descr_RO    AS exchange_rate_type_descr_RO,
   Exch.exchange_rate_type_descr_SH    AS exchange_rate_type_descr_SH,
   Exch.exchange_rate_type_descr_SK    AS exchange_rate_type_descr_SK,
   Exch.exchange_rate_type_descr_SL    AS exchange_rate_type_descr_SL,
   Exch.exchange_rate_type_descr_SV    AS exchange_rate_type_descr_SV,
   Exch.active_for_bus_year_fg         AS active_for_bus_year_fg,
   Exch.dwh_load_id                    AS dwh_load_id,
   Exch.dwh_created                    AS dwh_created,
   Exch.dwh_updated                    AS dwh_updated

FROM p_lew_bil.v_dim_exchange_rate_type_1        AS Exch
   );