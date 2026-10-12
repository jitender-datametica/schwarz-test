
MERGE INTO ldl_data_production_core_dim.t_dim_business_year_2 AS N USING (
  SELECT
      B.BUS_YEAR,
      CASE
        WHEN B.BUS_YEAR = C.BUS_YEAR THEN true
        ELSE false
      END AS CURR_BUS_YEAR_FG,
      B.BUS_YEAR - C.BUS_YEAR AS BUS_YEAR_OFFSET
    FROM
      ldl_data_production_core_dim.t_dim_business_year_2 AS B
      CROSS JOIN (
        SELECT
            BUS_YEAR
          FROM
            ldl_data_production_core_dim.t_dim_business_year_2
          WHERE current_date() BETWEEN BUS_YEAR_BEGIN_DT AND BUS_YEAR_END_DT
      ) AS C
    WHERE B.BUS_YEAR <> -NUMERIC '1'
) AS O
ON N.BUS_YEAR = O.BUS_YEAR
   WHEN MATCHED AND NOT N.CURR_BUS_YEAR_FG IS NOT DISTINCT FROM O.CURR_BUS_YEAR_FG
   OR NOT N.BUS_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_OFFSET THEN UPDATE SET
    CURR_BUS_YEAR_FG = O.CURR_BUS_YEAR_FG, 
    BUS_YEAR_OFFSET = O.BUS_YEAR_OFFSET, 
    DWH_UPDATED_TMSP = current_timestamp(), 
    DWH_LOAD_ID = cast('LOAD_ID'  as bignumeric), 
    DWH_NODE_CD = 'MANUAL'
    ;
-- Calendar_2 Half Year
MERGE INTO ldl_data_production_core_dim.t_dim_calendar_half_year_2 AS N USING (
  SELECT
      B.CAL_HALF_YEAR,
      CASE
        WHEN B.CAL_HALF_YEAR = C.CAL_HALF_YEAR THEN true
        ELSE false
      END AS CURR_CAL_HALF_YEAR_FG,
      dense_rank() OVER (ORDER BY if(B.CAL_YEAR IS NULL, 0, 1) DESC, B.CAL_YEAR) - C.OFFSET_YEAR AS CAL_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_HALF_YEAR IS NULL, 0, 1) DESC, B.CAL_HALF_YEAR) - C.OFFSET_HALF_YEAR AS CAL_HALF_YEAR_OFFSET
    FROM
      ldl_data_production_core_dim.t_dim_calendar_half_year_2 AS B
      CROSS JOIN (
        SELECT
            subselect.CAL_HALF_YEAR,
            subselect.OFFSET_YEAR,
            subselect.OFFSET_HALF_YEAR
          FROM
            (
              SELECT
                  CAL_HALF_YEAR,
                  CAL_HALF_YEAR_BEGIN_DT,
                  CAL_HALF_YEAR_END_DT,
                  dense_rank() OVER (ORDER BY if(CAL_HALF_YEAR IS NULL, 0, 1) DESC, CAL_HALF_YEAR) AS OFFSET_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(CAL_YEAR IS NULL, 0, 1) DESC, CAL_YEAR) AS OFFSET_YEAR
                FROM
                  ldl_data_production_core_dim.t_dim_calendar_half_year_2
                WHERE CAL_HALF_YEAR <> -NUMERIC '1'
            ) AS subselect
          WHERE current_date() BETWEEN subselect.CAL_HALF_YEAR_BEGIN_DT AND subselect.CAL_HALF_YEAR_END_DT
      ) AS C
    WHERE B.CAL_HALF_YEAR <> -NUMERIC '1'
) AS O
ON N.CAL_HALF_YEAR = O.CAL_HALF_YEAR
   WHEN MATCHED AND NOT N.CURR_CAL_HALF_YEAR_FG IS NOT DISTINCT FROM O.CURR_CAL_HALF_YEAR_FG
   OR NOT N.CAL_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_YEAR_OFFSET
   OR NOT N.CAL_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_HALF_YEAR_OFFSET THEN UPDATE SET
    CURR_CAL_HALF_YEAR_FG = O.CURR_CAL_HALF_YEAR_FG, 
    CAL_YEAR_OFFSET = O.CAL_YEAR_OFFSET, 
    CAL_HALF_YEAR_OFFSET = O.CAL_HALF_YEAR_OFFSET, 
    DWH_UPDATED_TMSP = current_timestamp(), 
    DWH_LOAD_ID = cast('LOAD_ID'  as BIGNUMERIC), 
    DWH_NODE_CD = 'MANUAL'
;
-- Business Half Year
MERGE INTO ldl_data_production_core_dim.t_dim_business_half_year_2 AS N USING (
  SELECT
      B.BUS_HALF_YEAR,
      CASE
        WHEN B.BUS_HALF_YEAR = C.BUS_HALF_YEAR THEN true
        ELSE false
      END AS CURR_BUS_HALF_YEAR_FG,
      dense_rank() OVER (ORDER BY if(B.BUS_YEAR IS NULL, 0, 1) DESC, B.BUS_YEAR) - C.OFFSET_YEAR AS BUS_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_HALF_YEAR IS NULL, 0, 1) DESC, B.BUS_HALF_YEAR) - C.OFFSET_HALF_YEAR AS BUS_HALF_YEAR_OFFSET
    FROM
      ldl_data_production_core_dim.t_dim_business_half_year_2 AS B
      CROSS JOIN (
        SELECT
            subselect.BUS_HALF_YEAR,
            subselect.OFFSET_HALF_YEAR,
            subselect.OFFSET_YEAR
          FROM
            (
              SELECT
                  BUS_HALF_YEAR,
                  BUS_HALF_YEAR_BEGIN_DT,
                  BUS_HALF_YEAR_END_DT,
                  dense_rank() OVER (ORDER BY if(BUS_HALF_YEAR IS NULL, 0, 1) DESC, BUS_HALF_YEAR) AS OFFSET_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(BUS_YEAR IS NULL, 0, 1) DESC, BUS_YEAR) AS OFFSET_YEAR
                FROM
                  ldl_data_production_core_dim.t_dim_business_half_year_2
                WHERE BUS_HALF_YEAR <> -NUMERIC '1'
            ) AS subselect
          WHERE current_date() BETWEEN subselect.BUS_HALF_YEAR_BEGIN_DT AND subselect.BUS_HALF_YEAR_END_DT
      ) AS C
    WHERE B.BUS_HALF_YEAR <> -NUMERIC '1'
) AS O
ON N.BUS_HALF_YEAR = O.BUS_HALF_YEAR
   WHEN MATCHED AND NOT N.CURR_BUS_HALF_YEAR_FG IS NOT DISTINCT FROM O.CURR_BUS_HALF_YEAR_FG
   OR NOT N.BUS_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_OFFSET
   OR NOT N.BUS_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_HALF_YEAR_OFFSET THEN UPDATE SET
    CURR_BUS_HALF_YEAR_FG = O.CURR_BUS_HALF_YEAR_FG, 
    BUS_YEAR_OFFSET = O.BUS_YEAR_OFFSET, 
    BUS_HALF_YEAR_OFFSET = O.BUS_HALF_YEAR_OFFSET, 
    DWH_UPDATED_TMSP = current_timestamp(), 
    DWH_LOAD_ID = cast('LOAD_ID'  as BIGNUMERIC), 
    DWH_NODE_CD = 'MANUAL'
;
-- Calendar_2 Year Quarter
MERGE INTO ldl_data_production_core_dim.t_dim_calendar_year_quarter_2 AS N USING (
  SELECT
      B.CAL_YEAR_QTR,
      CASE
        WHEN B.CAL_YEAR_QTR = C.CAL_YEAR_QTR THEN true
        ELSE false
      END AS CURR_CAL_YEAR_QTR_FG,
      dense_rank() OVER (ORDER BY if(B.CAL_YEAR IS NULL, 0, 1) DESC, B.CAL_YEAR) - C.OFFSET_YEAR AS CAL_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_HALF_YEAR IS NULL, 0, 1) DESC, B.CAL_HALF_YEAR) - C.OFFSET_HALF_YEAR AS CAL_HALF_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_YEAR_QTR IS NULL, 0, 1) DESC, B.CAL_YEAR_QTR) - C.OFFSET_YEAR_QTR AS CAL_YEAR_QTR_OFFSET
    FROM
      ldl_data_production_core_dim.t_dim_calendar_year_quarter_2 AS B
      CROSS JOIN (
        SELECT
            subselect.CAL_YEAR_QTR,
            subselect.OFFSET_YEAR_QTR,
            subselect.OFFSET_HALF_YEAR,
            subselect.OFFSET_YEAR
          FROM
            (
              SELECT
                  CAL_YEAR_QTR,
                  CAL_YEAR_QTR_BEGIN_DT,
                  CAL_YEAR_QTR_END_DT,
                  dense_rank() OVER (ORDER BY if(CAL_YEAR_QTR IS NULL, 0, 1) DESC, CAL_YEAR_QTR) AS OFFSET_YEAR_QTR,
                  dense_rank() OVER (ORDER BY if(CAL_HALF_YEAR IS NULL, 0, 1) DESC, CAL_HALF_YEAR) AS OFFSET_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(CAL_YEAR IS NULL, 0, 1) DESC, CAL_YEAR) AS OFFSET_YEAR
                FROM
                  ldl_data_production_core_dim.t_dim_calendar_year_quarter_2
                WHERE CAL_YEAR_QTR <> -NUMERIC '1'
            ) AS subselect
          WHERE current_date() BETWEEN subselect.CAL_YEAR_QTR_BEGIN_DT AND subselect.CAL_YEAR_QTR_END_DT
      ) AS C
    WHERE B.CAL_YEAR_QTR <> -NUMERIC '1'
) AS O
ON N.CAL_YEAR_QTR = O.CAL_YEAR_QTR
   WHEN MATCHED AND NOT N.CURR_CAL_YEAR_QTR_FG IS NOT DISTINCT FROM O.CURR_CAL_YEAR_QTR_FG
   OR NOT N.CAL_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_YEAR_OFFSET
   OR NOT N.CAL_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_HALF_YEAR_OFFSET
   OR NOT N.CAL_YEAR_QTR_OFFSET IS NOT DISTINCT FROM O.CAL_YEAR_QTR_OFFSET THEN UPDATE SET
    CURR_CAL_YEAR_QTR_FG = O.CURR_CAL_YEAR_QTR_FG, 
    CAL_YEAR_OFFSET = O.CAL_YEAR_OFFSET, 
    CAL_HALF_YEAR_OFFSET = O.CAL_HALF_YEAR_OFFSET, 
    CAL_YEAR_QTR_OFFSET = O.CAL_YEAR_QTR_OFFSET, 
    DWH_UPDATED_TMSP = current_timestamp(), 
    DWH_LOAD_ID = cast('LOAD_ID'  as BIGNUMERIC), 
    DWH_NODE_CD = 'MANUAL'
;
-- Business Year Quarter
MERGE INTO ldl_data_production_core_dim.t_dim_business_year_quarter_2 AS N USING (
  SELECT
      B.BUS_YEAR_QTR,
      CASE
        WHEN B.BUS_YEAR_QTR = C.BUS_YEAR_QTR THEN true
        ELSE false
      END AS CURR_BUS_YEAR_QTR_FG,
      dense_rank() OVER (ORDER BY if(B.BUS_YEAR IS NULL, 0, 1) DESC, B.BUS_YEAR) - C.OFFSET_YEAR AS BUS_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_HALF_YEAR IS NULL, 0, 1) DESC, B.BUS_HALF_YEAR) - C.OFFSET_HALF_YEAR AS BUS_HALF_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_YEAR_QTR IS NULL, 0, 1) DESC, B.BUS_YEAR_QTR) - C.OFFSET_YEAR_QTR AS BUS_YEAR_QTR_OFFSET
    FROM
      ldl_data_production_core_dim.t_dim_business_year_quarter_2 AS B
      CROSS JOIN (
        SELECT
            subselect.BUS_YEAR_QTR,
            subselect.OFFSET_YEAR,
            subselect.OFFSET_HALF_YEAR,
            subselect.OFFSET_YEAR_QTR
          FROM
            (
              SELECT
                  BUS_YEAR_QTR,
                  BUS_YEAR_QTR_BEGIN_DT,
                  BUS_YEAR_QTR_END_DT,
                  dense_rank() OVER (ORDER BY if(BUS_YEAR_QTR IS NULL, 0, 1) DESC, BUS_YEAR_QTR) AS OFFSET_YEAR_QTR,
                  dense_rank() OVER (ORDER BY if(BUS_HALF_YEAR IS NULL, 0, 1) DESC, BUS_HALF_YEAR) AS OFFSET_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(BUS_YEAR IS NULL, 0, 1) DESC, BUS_YEAR) AS OFFSET_YEAR
                FROM
                  ldl_data_production_core_dim.t_dim_business_year_quarter_2
                WHERE BUS_YEAR_QTR <> -NUMERIC '1'
            ) AS subselect
          WHERE current_date() BETWEEN subselect.BUS_YEAR_QTR_BEGIN_DT AND subselect.BUS_YEAR_QTR_END_DT
      ) AS C
    WHERE B.BUS_YEAR_QTR <> -NUMERIC '1'
) AS O
ON N.BUS_YEAR_QTR = O.BUS_YEAR_QTR
   WHEN MATCHED AND NOT N.CURR_BUS_YEAR_QTR_FG IS NOT DISTINCT FROM O.CURR_BUS_YEAR_QTR_FG
   OR NOT N.BUS_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_OFFSET
   OR NOT N.BUS_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_HALF_YEAR_OFFSET
   OR NOT N.BUS_YEAR_QTR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_QTR_OFFSET THEN UPDATE SET
    CURR_BUS_YEAR_QTR_FG = O.CURR_BUS_YEAR_QTR_FG, 
    BUS_YEAR_OFFSET = O.BUS_YEAR_OFFSET, 
    BUS_HALF_YEAR_OFFSET = O.BUS_HALF_YEAR_OFFSET, 
    BUS_YEAR_QTR_OFFSET = O.BUS_YEAR_QTR_OFFSET, 
    DWH_UPDATED_TMSP = current_timestamp(), 
    DWH_LOAD_ID = cast('LOAD_ID'  as BIGNUMERIC), 
    DWH_NODE_CD = 'MANUAL'
;
-- Calendar_2 Month
MERGE INTO ldl_data_production_core_dim.t_dim_calendar_month_2 AS N USING (
  SELECT
      B.CAL_MONTH,
      CASE
        WHEN B.CAL_MONTH = C.CAL_MONTH THEN true
        ELSE false
      END AS CURR_CAL_MONTH_FG,
      dense_rank() OVER (ORDER BY if(B.CAL_YEAR IS NULL, 0, 1) DESC, B.CAL_YEAR) - C.OFFSET_CAL_YEAR AS CAL_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_HALF_YEAR IS NULL, 0, 1) DESC, B.CAL_HALF_YEAR) - C.OFFSET_CAL_HALF_YEAR AS CAL_HALF_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_YEAR_QTR IS NULL, 0, 1) DESC, B.CAL_YEAR_QTR) - C.OFFSET_CAL_YEAR_QTR AS CAL_YEAR_QTR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_YEAR IS NULL, 0, 1) DESC, B.BUS_YEAR) - C.OFFSET_BUS_YEAR AS BUS_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_HALF_YEAR IS NULL, 0, 1) DESC, B.BUS_HALF_YEAR) - C.OFFSET_BUS_HALF_YEAR AS BUS_HALF_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_YEAR_QTR IS NULL, 0, 1) DESC, B.BUS_YEAR_QTR) - C.OFFSET_BUS_YEAR_QTR AS BUS_YEAR_QTR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_MONTH IS NULL, 0, 1) DESC, B.CAL_MONTH) - C.OFFSET_CAL_MONTH AS CAL_MONTH_OFFSET
    FROM
      ldl_data_production_core_dim.t_dim_calendar_month_2 AS B
      CROSS JOIN (
        SELECT
            subselect.CAL_MONTH,
            subselect.OFFSET_CAL_MONTH,
            subselect.OFFSET_CAL_YEAR,
            subselect.OFFSET_BUS_YEAR,
            subselect.OFFSET_CAL_HALF_YEAR,
            subselect.OFFSET_BUS_HALF_YEAR,
            subselect.OFFSET_CAL_YEAR_QTR,
            subselect.OFFSET_BUS_YEAR_QTR
          FROM
            (
              SELECT
                  CAL_MONTH,
                  CAL_MONTH_BEGIN_DT,
                  CAL_MONTH_END_DT,
                  dense_rank() OVER (ORDER BY if(CAL_MONTH IS NULL, 0, 1) DESC, CAL_MONTH) AS OFFSET_CAL_MONTH,
                  dense_rank() OVER (ORDER BY if(CAL_YEAR IS NULL, 0, 1) DESC, CAL_YEAR) AS OFFSET_CAL_YEAR,
                  dense_rank() OVER (ORDER BY if(BUS_YEAR IS NULL, 0, 1) DESC, BUS_YEAR) AS OFFSET_BUS_YEAR,
                  dense_rank() OVER (ORDER BY if(CAL_HALF_YEAR IS NULL, 0, 1) DESC, CAL_HALF_YEAR) AS OFFSET_CAL_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(BUS_HALF_YEAR IS NULL, 0, 1) DESC, BUS_HALF_YEAR) AS OFFSET_BUS_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(CAL_YEAR_QTR IS NULL, 0, 1) DESC, CAL_YEAR_QTR) AS OFFSET_CAL_YEAR_QTR,
                  dense_rank() OVER (ORDER BY if(BUS_YEAR_QTR IS NULL, 0, 1) DESC, BUS_YEAR_QTR) AS OFFSET_BUS_YEAR_QTR
                FROM
                  ldl_data_production_core_dim.t_dim_calendar_month_2
                WHERE CAL_MONTH <> -NUMERIC '1'
            ) AS subselect
          WHERE current_date() BETWEEN subselect.CAL_MONTH_BEGIN_DT AND subselect.CAL_MONTH_END_DT
      ) AS C
    WHERE B.CAL_MONTH <> -NUMERIC '1'
) AS O
ON N.CAL_MONTH = O.CAL_MONTH
   WHEN MATCHED AND NOT N.CURR_CAL_MONTH_FG IS NOT DISTINCT FROM O.CURR_CAL_MONTH_FG
   OR NOT N.CAL_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_YEAR_OFFSET
   OR NOT N.CAL_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_HALF_YEAR_OFFSET
   OR NOT N.CAL_YEAR_QTR_OFFSET IS NOT DISTINCT FROM O.CAL_YEAR_QTR_OFFSET
   OR NOT N.CAL_MONTH_OFFSET IS NOT DISTINCT FROM O.CAL_MONTH_OFFSET
   OR NOT N.BUS_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_OFFSET
   OR NOT N.BUS_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_HALF_YEAR_OFFSET
   OR NOT N.BUS_YEAR_QTR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_QTR_OFFSET THEN UPDATE SET
    CURR_CAL_MONTH_FG = O.CURR_CAL_MONTH_FG, 
    CAL_YEAR_OFFSET = O.CAL_YEAR_OFFSET, 
    CAL_HALF_YEAR_OFFSET = O.CAL_HALF_YEAR_OFFSET, 
    CAL_YEAR_QTR_OFFSET = O.CAL_YEAR_QTR_OFFSET, 
    CAL_MONTH_OFFSET = O.CAL_MONTH_OFFSET, 
    BUS_YEAR_OFFSET = O.BUS_YEAR_OFFSET, 
    BUS_HALF_YEAR_OFFSET = O.BUS_HALF_YEAR_OFFSET, 
    BUS_YEAR_QTR_OFFSET = O.BUS_YEAR_QTR_OFFSET, 
    DWH_UPDATED_TMSP = current_timestamp(), 
    DWH_LOAD_ID = cast('LOAD_ID'  as BIGNUMERIC), 
    DWH_NODE_CD = 'MANUAL'
;
-- Calendar_2 Week
MERGE INTO ldl_data_production_core_dim.t_dim_calendar_week_2 AS N USING (
  SELECT
      B.CAL_WEEK,
      CASE
        WHEN B.CAL_WEEK = C.CAL_WEEK THEN true
        ELSE false
      END AS CURR_CAL_WEEK_FG,
      dense_rank() OVER (ORDER BY if(B.CAL_WEEK IS NULL, 0, 1) DESC, B.CAL_WEEK) - C.OFFSET_CAL_WEEK AS CAL_WEEK_OFFSET
    FROM
      ldl_data_production_core_dim.t_dim_calendar_week_2 AS B
      CROSS JOIN (
        SELECT
            subselect.CAL_WEEK,
            subselect.OFFSET_CAL_WEEK
          FROM
            (
              SELECT
                  CAL_WEEK,
                  CAL_WEEK_BEGIN_DT,
                  CAL_WEEK_END_DT,
                  dense_rank() OVER (ORDER BY if(CAL_WEEK IS NULL, 0, 1) DESC, CAL_WEEK) AS OFFSET_CAL_WEEK
                FROM
                  ldl_data_production_core_dim.t_dim_calendar_week_2
                WHERE CAL_WEEK <> -NUMERIC '1'
            ) AS subselect
          WHERE current_date() BETWEEN subselect.CAL_WEEK_BEGIN_DT AND subselect.CAL_WEEK_END_DT
      ) AS C
    WHERE B.CAL_WEEK <> -NUMERIC '1'
) AS O
ON N.CAL_WEEK = O.CAL_WEEK
   WHEN MATCHED AND NOT N.CURR_CAL_WEEK_FG IS NOT DISTINCT FROM O.CURR_CAL_WEEK_FG
   OR NOT N.CAL_WEEK_OFFSET IS NOT DISTINCT FROM O.CAL_WEEK_OFFSET THEN UPDATE SET
    CURR_CAL_WEEK_FG = O.CURR_CAL_WEEK_FG, 
    CAL_WEEK_OFFSET = O.CAL_WEEK_OFFSET, 
    DWH_UPDATED_TMSP = current_timestamp(), 
    DWH_LOAD_ID = cast('LOAD_ID'  as BIGNUMERIC), 
    DWH_NODE_CD = 'MANUAL'
;
-- Calendar_2 Partial Week
MERGE INTO ldl_data_production_core_dim.t_dim_calendar_partial_week_2 AS N USING (
  SELECT
      B.PART_WEEK,
      CASE
        WHEN B.PART_WEEK = C.PART_WEEK THEN true
        ELSE false
      END AS CURR_PART_WEEK_FG,
      dense_rank() OVER (ORDER BY if(B.CAL_YEAR IS NULL, 0, 1) DESC, B.CAL_YEAR) - C.OFFSET_CAL_YEAR AS CAL_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_HALF_YEAR IS NULL, 0, 1) DESC, B.CAL_HALF_YEAR) - C.OFFSET_CAL_HALF_YEAR AS CAL_HALF_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_YEAR_QTR IS NULL, 0, 1) DESC, B.CAL_YEAR_QTR) - C.OFFSET_CAL_YEAR_QTR AS CAL_YEAR_QTR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_YEAR IS NULL, 0, 1) DESC, B.BUS_YEAR) - C.OFFSET_BUS_YEAR AS BUS_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_HALF_YEAR IS NULL, 0, 1) DESC, B.BUS_HALF_YEAR) - C.OFFSET_BUS_HALF_YEAR AS BUS_HALF_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_YEAR_QTR IS NULL, 0, 1) DESC, B.BUS_YEAR_QTR) - C.OFFSET_BUS_YEAR_QTR AS BUS_YEAR_QTR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_MONTH IS NULL, 0, 1) DESC, B.CAL_MONTH) - C.OFFSET_CAL_MONTH AS CAL_MONTH_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_WEEK IS NULL, 0, 1) DESC, B.CAL_WEEK) - C.OFFSET_CAL_WEEK AS CAL_WEEK_OFFSET,
      dense_rank() OVER (ORDER BY if(B.PART_WEEK IS NULL, 0, 1) DESC, B.PART_WEEK) - C.OFFSET_PART_WEEK AS PART_WEEK_OFFSET
    FROM
      ldl_data_production_core_dim.t_dim_calendar_partial_week_2 AS B
      CROSS JOIN (
        SELECT
            subselect.PART_WEEK,
            subselect.OFFSET_CAL_MONTH,
            subselect.OFFSET_CAL_YEAR,
            subselect.OFFSET_BUS_YEAR,
            subselect.OFFSET_CAL_HALF_YEAR,
            subselect.OFFSET_BUS_HALF_YEAR,
            subselect.OFFSET_CAL_YEAR_QTR,
            subselect.OFFSET_BUS_YEAR_QTR,
            subselect.OFFSET_CAL_WEEK,
            subselect.OFFSET_PART_WEEK
          FROM
            (
              SELECT
                  PART_WEEK,
                  PART_WEEK_BEGIN_DT,
                  PART_WEEK_END_DT,
                  dense_rank() OVER (ORDER BY if(CAL_MONTH IS NULL, 0, 1) DESC, CAL_MONTH) AS OFFSET_CAL_MONTH,
                  dense_rank() OVER (ORDER BY if(CAL_YEAR IS NULL, 0, 1) DESC, CAL_YEAR) AS OFFSET_CAL_YEAR,
                  dense_rank() OVER (ORDER BY if(BUS_YEAR IS NULL, 0, 1) DESC, BUS_YEAR) AS OFFSET_BUS_YEAR,
                  dense_rank() OVER (ORDER BY if(CAL_HALF_YEAR IS NULL, 0, 1) DESC, CAL_HALF_YEAR) AS OFFSET_CAL_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(BUS_HALF_YEAR IS NULL, 0, 1) DESC, BUS_HALF_YEAR) AS OFFSET_BUS_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(CAL_YEAR_QTR IS NULL, 0, 1) DESC, CAL_YEAR_QTR) AS OFFSET_CAL_YEAR_QTR,
                  dense_rank() OVER (ORDER BY if(BUS_YEAR_QTR IS NULL, 0, 1) DESC, BUS_YEAR_QTR) AS OFFSET_BUS_YEAR_QTR,
                  dense_rank() OVER (ORDER BY if(CAL_WEEK IS NULL, 0, 1) DESC, CAL_WEEK) AS OFFSET_CAL_WEEK,
                  dense_rank() OVER (ORDER BY if(PART_WEEK IS NULL, 0, 1) DESC, PART_WEEK) AS OFFSET_PART_WEEK
                FROM
                  ldl_data_production_core_dim.t_dim_calendar_partial_week_2
                WHERE PART_WEEK <> -NUMERIC '1'
            ) AS subselect
          WHERE current_date() BETWEEN subselect.PART_WEEK_BEGIN_DT AND subselect.PART_WEEK_END_DT
      ) AS C
    WHERE B.PART_WEEK <> -NUMERIC '1'
) AS O
ON N.PART_WEEK = O.PART_WEEK
   WHEN MATCHED AND NOT N.CURR_PART_WEEK_FG IS NOT DISTINCT FROM O.CURR_PART_WEEK_FG
   OR NOT N.CAL_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_YEAR_OFFSET
   OR NOT N.CAL_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_HALF_YEAR_OFFSET
   OR NOT N.CAL_YEAR_QTR_OFFSET IS NOT DISTINCT FROM O.CAL_YEAR_QTR_OFFSET
   OR NOT N.CAL_MONTH_OFFSET IS NOT DISTINCT FROM O.CAL_MONTH_OFFSET
   OR NOT N.BUS_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_OFFSET
   OR NOT N.BUS_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_HALF_YEAR_OFFSET
   OR NOT N.BUS_YEAR_QTR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_QTR_OFFSET
   OR NOT N.CAL_WEEK_OFFSET IS NOT DISTINCT FROM O.CAL_WEEK_OFFSET
   OR NOT N.PART_WEEK_OFFSET IS NOT DISTINCT FROM O.PART_WEEK_OFFSET THEN UPDATE SET
    CURR_PART_WEEK_FG = O.CURR_PART_WEEK_FG, 
    CAL_YEAR_OFFSET = O.CAL_YEAR_OFFSET, 
    CAL_HALF_YEAR_OFFSET = O.CAL_HALF_YEAR_OFFSET, 
    CAL_YEAR_QTR_OFFSET = O.CAL_YEAR_QTR_OFFSET, 
    CAL_MONTH_OFFSET = O.CAL_MONTH_OFFSET, 
    BUS_YEAR_OFFSET = O.BUS_YEAR_OFFSET, 
    BUS_HALF_YEAR_OFFSET = O.BUS_HALF_YEAR_OFFSET, 
    BUS_YEAR_QTR_OFFSET = O.BUS_YEAR_QTR_OFFSET, 
    CAL_WEEK_OFFSET = O.CAL_WEEK_OFFSET, 
    PART_WEEK_OFFSET = O.PART_WEEK_OFFSET, 
    DWH_UPDATED_TMSP = current_timestamp(), 
    DWH_LOAD_ID = cast('LOAD_ID'  as BIGNUMERIC), 
    DWH_NODE_CD = 'MANUAL'
;
-- Calendar_2 Date
MERGE INTO ldl_data_production_core_dim.t_dim_calendar_date_2 AS N USING (
  SELECT
      B.CAL_DT,
      CASE
        WHEN B.CAL_DT = C.CAL_DT THEN true
        ELSE false
      END AS CURR_CAL_DT_FG,
      dense_rank() OVER (ORDER BY if(B.CAL_YEAR IS NULL, 0, 1) DESC, B.CAL_YEAR) - C.OFFSET_CAL_YEAR AS CAL_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_HALF_YEAR IS NULL, 0, 1) DESC, B.CAL_HALF_YEAR) - C.OFFSET_CAL_HALF_YEAR AS CAL_HALF_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_YEAR_QTR IS NULL, 0, 1) DESC, B.CAL_YEAR_QTR) - C.OFFSET_CAL_YEAR_QTR AS CAL_YEAR_QTR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_YEAR IS NULL, 0, 1) DESC, B.BUS_YEAR) - C.OFFSET_BUS_YEAR AS BUS_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_HALF_YEAR IS NULL, 0, 1) DESC, B.BUS_HALF_YEAR) - C.OFFSET_BUS_HALF_YEAR AS BUS_HALF_YEAR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.BUS_YEAR_QTR IS NULL, 0, 1) DESC, B.BUS_YEAR_QTR) - C.OFFSET_BUS_YEAR_QTR AS BUS_YEAR_QTR_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_MONTH IS NULL, 0, 1) DESC, B.CAL_MONTH) - C.OFFSET_CAL_MONTH AS CAL_MONTH_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_WEEK IS NULL, 0, 1) DESC, B.CAL_WEEK) - C.OFFSET_CAL_WEEK AS CAL_WEEK_OFFSET,
      dense_rank() OVER (ORDER BY if(B.PART_WEEK IS NULL, 0, 1) DESC, B.PART_WEEK) - C.OFFSET_PART_WEEK AS PART_WEEK_OFFSET,
      dense_rank() OVER (ORDER BY if(B.CAL_DT IS NULL, 0, 1) DESC, B.CAL_DT) - C.OFFSET_CAL_DT AS CAL_DT_OFFSET
    FROM
      ldl_data_production_core_dim.t_dim_calendar_date_2 AS B
      CROSS JOIN (
        SELECT
            subselect.CAL_DT,
            subselect.OFFSET_CAL_MONTH,
            subselect.OFFSET_CAL_YEAR,
            subselect.OFFSET_BUS_YEAR,
            subselect.OFFSET_CAL_HALF_YEAR,
            subselect.OFFSET_BUS_HALF_YEAR,
            subselect.OFFSET_CAL_YEAR_QTR,
            subselect.OFFSET_BUS_YEAR_QTR,
            subselect.OFFSET_CAL_WEEK,
            subselect.OFFSET_PART_WEEK,
            subselect.OFFSET_CAL_DT
          FROM
            (
              SELECT
                  CAL_DT,
                  dense_rank() OVER (ORDER BY if(CAL_MONTH IS NULL, 0, 1) DESC, CAL_MONTH) AS OFFSET_CAL_MONTH,
                  dense_rank() OVER (ORDER BY if(CAL_YEAR IS NULL, 0, 1) DESC, CAL_YEAR) AS OFFSET_CAL_YEAR,
                  dense_rank() OVER (ORDER BY if(BUS_YEAR IS NULL, 0, 1) DESC, BUS_YEAR) AS OFFSET_BUS_YEAR,
                  dense_rank() OVER (ORDER BY if(CAL_HALF_YEAR IS NULL, 0, 1) DESC, CAL_HALF_YEAR) AS OFFSET_CAL_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(BUS_HALF_YEAR IS NULL, 0, 1) DESC, BUS_HALF_YEAR) AS OFFSET_BUS_HALF_YEAR,
                  dense_rank() OVER (ORDER BY if(CAL_YEAR_QTR IS NULL, 0, 1) DESC, CAL_YEAR_QTR) AS OFFSET_CAL_YEAR_QTR,
                  dense_rank() OVER (ORDER BY if(BUS_YEAR_QTR IS NULL, 0, 1) DESC, BUS_YEAR_QTR) AS OFFSET_BUS_YEAR_QTR,
                  dense_rank() OVER (ORDER BY if(CAL_WEEK IS NULL, 0, 1) DESC, CAL_WEEK) AS OFFSET_CAL_WEEK,
                  dense_rank() OVER (ORDER BY if(PART_WEEK IS NULL, 0, 1) DESC, PART_WEEK) AS OFFSET_PART_WEEK,
                  dense_rank() OVER (ORDER BY if(CAL_DT IS NULL, 0, 1) DESC, CAL_DT) AS OFFSET_CAL_DT
                FROM
                  ldl_data_production_core_dim.t_dim_calendar_date_2
                WHERE CAL_DT <> '0001-01-01'
            ) AS subselect
          WHERE current_date() = subselect.CAL_DT
      ) AS C
    WHERE B.CAL_DT <> '0001-01-01'
) AS O
ON N.CAL_DT = O.CAL_DT
   WHEN MATCHED AND NOT N.CURR_CAL_DT_FG IS NOT DISTINCT FROM O.CURR_CAL_DT_FG
   OR NOT N.CAL_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_YEAR_OFFSET
   OR NOT N.CAL_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.CAL_HALF_YEAR_OFFSET
   OR NOT N.CAL_YEAR_QTR_OFFSET IS NOT DISTINCT FROM O.CAL_YEAR_QTR_OFFSET
   OR NOT N.CAL_MONTH_OFFSET IS NOT DISTINCT FROM O.CAL_MONTH_OFFSET
   OR NOT N.BUS_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_OFFSET
   OR NOT N.BUS_HALF_YEAR_OFFSET IS NOT DISTINCT FROM O.BUS_HALF_YEAR_OFFSET
   OR NOT N.BUS_YEAR_QTR_OFFSET IS NOT DISTINCT FROM O.BUS_YEAR_QTR_OFFSET
   OR NOT N.CAL_WEEK_OFFSET IS NOT DISTINCT FROM O.CAL_WEEK_OFFSET
   OR NOT N.PART_WEEK_OFFSET IS NOT DISTINCT FROM O.PART_WEEK_OFFSET
   OR NOT N.CAL_DT_OFFSET IS NOT DISTINCT FROM O.CAL_DT_OFFSET THEN UPDATE SET
    CURR_CAL_DT_FG = O.CURR_CAL_DT_FG, 
    CAL_YEAR_OFFSET = O.CAL_YEAR_OFFSET, 
    CAL_HALF_YEAR_OFFSET = O.CAL_HALF_YEAR_OFFSET, 
    CAL_YEAR_QTR_OFFSET = O.CAL_YEAR_QTR_OFFSET, 
    CAL_MONTH_OFFSET = O.CAL_MONTH_OFFSET, 
    BUS_YEAR_OFFSET = O.BUS_YEAR_OFFSET, 
    BUS_HALF_YEAR_OFFSET = O.BUS_HALF_YEAR_OFFSET, 
    BUS_YEAR_QTR_OFFSET = O.BUS_YEAR_QTR_OFFSET, 
    CAL_WEEK_OFFSET = O.CAL_WEEK_OFFSET, 
    PART_WEEK_OFFSET = O.PART_WEEK_OFFSET, 
    CAL_DT_OFFSET = O.CAL_DT_OFFSET, 
    DWH_UPDATED_TMSP = current_timestamp(), 
    DWH_LOAD_ID = cast('${LOAD_ID}'  as BIGNUMERIC), 
    DWH_NODE_CD = 'MANUAL'
;
