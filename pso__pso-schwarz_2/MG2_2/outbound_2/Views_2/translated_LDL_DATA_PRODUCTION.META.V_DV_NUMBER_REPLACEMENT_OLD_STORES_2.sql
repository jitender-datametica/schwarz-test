CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_number_replacement_old_stores_2
OPTIONS(DESCRIPTION = `NUMBER OF NEW OPENINGS OF REPLACEMENT STORES = NUMBER OF CLOSURES OF OLD STORES WITHIN THE SAME PARTIAL WEEK\\NINPUT DATASETS:\\NCORE_DIM.T_DIM_CALENDAR_PARTIAL_WEEK_2\\NCORE_DIM.T_DIM_REAL_ESTATE_2\\NCORE_DIM.T_FACT_REAL_ESTATE_LIFECYCLE_2`)
AS WITH wk AS (SELECT part_week,
   part_week_begin_dt,
   part_week_end_dt
  FROM ldl_data_production_core_dim.t_dim_calendar_partial_week_2
  WHERE part_week_offset = - 1) (SELECT t1.part_week,
   t1.part_week_begin_dt,
   t1.part_week_end_dt,
   closed.closed_re_cnt,
   open.open_re_cnt,
    closed.closed_re_cnt - open.open_re_cnt AS difference,
    CASE
    WHEN closed.closed_re_cnt - open.open_re_cnt <> 0
    THEN 1
    ELSE 0
    END AS failed,
   1 AS total
  FROM wk AS t1_2
   INNER JOIN (SELECT 1 AS key,
     COUNT(1) AS closed_re_cnt
    FROM ldl_data_production_core_dim.t_dim_real_estate_2 AS re_2
     INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle_2 AS rel ON re.real_estate_sid = rel.real_estate_sid
        AND rel.close_dt BETWEEN CAST(re.dwh_valid_from_tmsp AS DATE) AND (CAST(re.dwh_valid_to_tmsp AS DATE))
     INNER JOIN wk AS t4 ON rel.close_dt BETWEEN t4.part_week_begin_dt AND t4.part_week_end_dt
    WHERE re.real_estate_type_cd IN ('STORE', 'SPEC')
     AND re.replacement_real_estate_nr > '') AS closed ON TRUE
   INNER JOIN (SELECT 1 AS key,
     COUNT(1) AS open_re_cnt
    FROM ldl_data_production_core_dim.t_dim_real_estate_2 AS re0
     INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle_2 AS rel0 ON re0.real_estate_sid = rel0.real_estate_sid
        AND rel0.open_dt BETWEEN CAST(re0.dwh_valid_from_tmsp AS DATE) AND (CAST(re0.dwh_valid_to_tmsp AS DATE))
     INNER JOIN wk AS t11 ON rel0.open_dt BETWEEN t11.part_week_begin_dt AND t11.part_week_end_dt
    WHERE re0.real_estate_type_cd IN ('STORE', 'SPEC')
     AND re0.real_estate_sid IN (SELECT DISTINCT re1.replacement_real_estate_sid
       FROM ldl_data_production_core_dim.t_dim_real_estate_2 AS re1
        INNER JOIN ldl_data_production_core_dim.t_fact_real_estate_lifecycle_2 AS rel1 ON re1.real_estate_sid = rel1.real_estate_sid
           AND rel1.close_dt BETWEEN CAST(re1.dwh_valid_from_tmsp AS DATE) AND (CAST(re1.dwh_valid_to_tmsp AS DATE))
        INNER JOIN wk AS t14 ON rel1.close_dt BETWEEN t14.part_week_begin_dt AND t14.part_week_end_dt
       WHERE re1.real_estate_type_cd IN ('STORE', 'SPEC')
        AND re1.replacement_real_estate_nr > '')) AS open ON closed.key = open.key);