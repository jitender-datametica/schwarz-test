CREATE OR REPLACE TABLE FUNCTION ldl_production_p_lew_mart_pit.get_table_adv_week_start_day()
RETURNS TABLE<
  client_id INT64,
  country_iso_cd STRING,
  country_descr STRING,
  lang_sid INT64,
  curr_sid INT64,
  curr_cd STRING,
  ctr_adv_week_start_weekday_id INT64
>
AS (
  SELECT
    a.client_id,
    a.country_iso_cd,
    a.country_descr,
    a.lang_sid,
    a.curr_sid,
    a.curr_cd,
    a.ctr_adv_week_start_weekday_id
  FROM (
    SELECT
      client_id,
      country_iso_cd,
      country_descr,
      lang_sid,
      curr_sid,
      curr_cd,
      ctr_adv_week_start_weekday_id
    FROM
      ldl_production_p_lew_mart_pit.t_dim_client_1 AS a
    WHERE
      a.deleted_fg = 0
      AND a.current_fg = 1
      AND a.pit_country_fg = 1
    QUALIFY
      ROW_NUMBER() OVER (
        PARTITION BY a.client_id, a.valid_from_dt, a.deleted_fg
        ORDER BY a.dwh_updated_ts
      ) = 1
  ) AS a
);
