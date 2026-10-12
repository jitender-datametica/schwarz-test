CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_FACT_EXCHANGE_RATE_2
(
     from_curr_cd
,          to_curr_cd

,          exchange_rate_type_cd

,          active_from_dt
,          active_to_dt
,          active_fg

,          bus_year
,          exchange_rate

,          dwh_load_id
,          dwh_created
,          dwh_updated
)
AS
   (
        SELECT      Exch.from_curr_cd                   AS from_curr_cd,
   Exch.to_curr_cd                     AS to_curr_cd,
   Exch.exchange_rate_type_cd          AS exchange_rate_type_cd,
   Exch.active_from_dt                 AS active_from_dt,
   Exch.active_to_dt                   AS active_to_dt,
   Exch.active_fg                      AS active_fg,
   Exch.bus_year                       AS bus_year,
   Exch.exchange_rate                  AS exchange_rate,
   Exch.dwh_load_id                    AS dwh_load_id,
   Exch.dwh_created                    AS dwh_created,
   Exch.dwh_updated                    AS dwh_updated

FROM p_lew_bil_ac.v_fact_exchange_rate_2        AS Exch
   );