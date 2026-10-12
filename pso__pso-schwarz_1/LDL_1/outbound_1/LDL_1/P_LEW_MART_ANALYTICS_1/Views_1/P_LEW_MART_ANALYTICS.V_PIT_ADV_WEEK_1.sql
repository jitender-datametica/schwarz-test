CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_pit_adv_week_1 AS SELECT client_id,
 adv_week_id,
   ((ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING) ORDER BY adv_week_id IS NULL DESC, adv_week_id DESC)) - 1
    ) * - 1 AS adv_week_seq,
 adv_week_descr,
   SUBSTR(CAST(CAST(adv_week_week_num AS STRING FORMAT '99') AS STRING), 1, 3) || '/' || SUBSTR(CAST(adv_week_year_num AS STRING)
   , 1, 4) AS adv_week_long_descr,
 adv_week_year_num,
 adv_week_week_num,
 adv_week_start_dt,
 adv_week_end_dt,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_analytics.t_advert_week_1;