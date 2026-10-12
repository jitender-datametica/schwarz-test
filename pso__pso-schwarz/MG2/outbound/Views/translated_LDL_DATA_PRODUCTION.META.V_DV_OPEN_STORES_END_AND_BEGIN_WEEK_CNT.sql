CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_open_stores_end_and_begin_week_cnt
OPTIONS(DESCRIPTION = `OPEN STORES CNT AT END OF WEEK SHOULD BE EQUAL TO OPEN STORES CNT BEGINNING OF THE WEEK + OPENED STORES DURING THE WEEK - CLOSED STORES DURING THE WEEK\\NINPUT DATASETS:\\NCORE_DIM.T_DIM_CALENDAR_PARTIAL_WEEK\\NCORE_DIM.T_DIM_REAL_ESTATE\\NCORE_DIM.T_FACT_REAL_ESTATE_LIFECYCLE`)
AS WITH wk AS (SELECT part_week,
   part_week_begin_dt,
   part_week_end_dt
  FROM ldl_data_production_core_dim.t_dim_calendar_partial_week
  WHERE part_week_offset = - 1) (SELECT t1.part_week,
   t1.part_week_begin_dt,
   t1.part_week_end_dt,
   open_re_end_of_week.open_re_end_of_week_cnt,
   open_re_begin_of_week.open_re_begin_of_week_cnt,
   open_re_during_week.open_re_during_week_cnt,
   closed_re_during_week.closed_re_during_week_cnt,
    open_re_end_of_week.open_re_end_of_week_cnt - (open_re_begin_of_week.open_re_begin_of_week_cnt + open_re_during_week
       .open_re_during_week_cnt - closed_re_during_week.closed_re_during_week_cnt) AS difference,
    CASE
    WHEN open_re_end_of_week.open_re_end_of_week_cnt - (open_re_begin_of_week.open_re_begin_of_week_cnt +
         open_re_during_week.open_re_during_week_cnt - closed_re_during_week.closed_re_during_week_cnt) <> 0
    THEN 1
    ELSE 0
    END AS failed,
   1 AS total
  FROM wk AS t1
   INNER JOIN (SELECT 1 AS key,
     COUNT(1) AS open_re_end_of_week_cnt
    FROM ldl_data_production_core_dim.t_dim_real_estate AS re
     INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle AS rel ON re.real_estate_sid = rel.real_estate_sid
      
     INNER JOIN wk AS t4 ON t4.part_week_end_dt BETWEEN CAST(re.dwh_valid_from_tmsp AS DATE) AND (CAST(re.dwh_valid_to_tmsp AS DATE)
         ) AND rel.open_dt <= t4.part_week_end_dt AND (rel.close_dt > t4.part_week_end_dt OR rel.close_dt =
         DATE '0001-01-01')
    WHERE rel.open_dt <> DATE '0001-01-01') AS open_re_end_of_week ON TRUE
   INNER JOIN (SELECT 1 AS key,
     COUNT(1) AS open_re_begin_of_week_cnt
    FROM ldl_data_production_core_dim.t_dim_real_estate AS re0
     INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle AS rel0 ON re0.real_estate_sid = rel0.real_estate_sid
      
     INNER JOIN wk AS t11 ON t11.part_week_begin_dt BETWEEN CAST(re0.dwh_valid_from_tmsp AS DATE) AND (CAST(re0.dwh_valid_to_tmsp AS DATE)
         ) AND rel0.open_dt <= DATE_ADD(t11.part_week_begin_dt, INTERVAL - 1 DAY) AND (rel0.close_dt > t11.part_week_begin_dt
          OR rel0.close_dt = DATE '0001-01-01')
    WHERE rel0.open_dt <> DATE '0001-01-01') AS open_re_begin_of_week ON open_re_end_of_week.key = open_re_begin_of_week
    .key
   INNER JOIN (SELECT 1 AS key,
     COUNT(1) AS open_re_during_week_cnt
    FROM ldl_data_production_core_dim.t_dim_real_estate AS re1
     INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle AS rel1 ON re1.real_estate_sid = rel1.real_estate_sid
        AND rel1.open_dt BETWEEN CAST(re1.dwh_valid_from_tmsp AS DATE) AND (CAST(re1.dwh_valid_to_tmsp AS DATE))
     INNER JOIN wk AS t18 ON rel1.open_dt BETWEEN t18.part_week_begin_dt AND t18.part_week_end_dt) AS
   open_re_during_week ON open_re_begin_of_week.key = open_re_during_week.key
   INNER JOIN (SELECT 1 AS key,
     COUNT(1) AS closed_re_during_week_cnt
    FROM ldl_data_production_core_dim.t_dim_real_estate AS re2
     INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle AS rel2 ON re2.real_estate_sid = rel2.real_estate_sid
        AND rel2.close_dt BETWEEN CAST(re2.dwh_valid_from_tmsp AS DATE) AND (CAST(re2.dwh_valid_to_tmsp AS DATE))
     INNER JOIN wk AS t24 ON rel2.close_dt BETWEEN t24.part_week_begin_dt AND t24.part_week_end_dt) AS
   closed_re_during_week ON open_re_during_week.key = closed_re_during_week.key);