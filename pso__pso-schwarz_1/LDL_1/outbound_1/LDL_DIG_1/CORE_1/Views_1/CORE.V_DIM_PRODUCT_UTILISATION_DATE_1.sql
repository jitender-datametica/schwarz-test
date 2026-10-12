CREATE OR REPLACE VIEW ldl_dig_core.v_dim_product_utilisation_date_1 AS WITH CTE_PU AS (SELECT prod_sid,
   util_action_cd,
   exception_util_dt
  FROM ldl_dig_core.t_fact_product_utilisation_1
  WHERE dwh_valid_fg), MAX_LT AS (SELECT prod_sid,
   MAX(tgt_prod_receive_cy_week) AS tgt_prod_receive_cy_week_max
  FROM ldl_dig_core.t_dim_sales_promotion_1
  WHERE dwh_valid_fg
   AND LOWER(sale_promo_status_cd) <> 'canceled'
   AND NOT is_repeated_fg
  GROUP BY prod_sid), MAX_BATCH AS (SELECT T2.prod_sid,
   MAX(T2.amc_ian_nr) AS amc_ian_nr,
   MAX(T2.assortment_plan_period_nr) AS assortment_plan_period_nr,
   MIN(C2.cal_dt) AS min_delivery_dt_batch,
   MAX(C1.cal_dt) AS max_delivery_dt_batch,
   MAX(T2.promo_dur_week_cnt) AS promo_dur_week_cnt_batch
  FROM ldl_dig_core.t_dim_sales_promotion_1 AS T2
   INNER JOIN ldl_dig_core.t_dim_cal_day_1 AS C1 ON T2.tgt_prod_receive_cy_week = C1.cy_week AND C1.day_of_week = 5
   INNER JOIN ldl_dig_core.t_dim_cal_day_1 AS C2 ON T2.first_delivery_cy_week = C2.cy_week AND C2.day_of_week = 5
   LEFT JOIN MAX_LT AS T3 ON T2.prod_sid = T3.prod_sid
  WHERE LOWER(T2.sale_promo_status_cd) <> 'canceled'
   AND T2.dwh_valid_fg
   AND T3.tgt_prod_receive_cy_week_max = T2.tgt_prod_receive_cy_week
   AND NOT T2.is_repeated_fg
  GROUP BY T2.prod_sid), MAX_IAN AS (SELECT T1.prod_sid,
   MAX(T1.amc_ian_nr) AS amc_ian_nr,
   MAX(T1.assortment_plan_period_nr) AS assortment_plan_period_nr,
   MIN(C2.cal_dt) AS min_delivery_dt_ian,
   MAX(C1.cal_dt) AS max_delivery_dt_ian,
   MAX(T1.promo_dur_week_cnt) AS promo_dur_week_cnt_ian
  FROM ldl_dig_core.t_dim_sales_promotion_1 AS T1_1
   INNER JOIN ldl_dig_core.t_dim_cal_day_1 AS C1 ON T1.tgt_prod_receive_cy_week = C1.cy_week AND C1.day_of_week = 5
   INNER JOIN ldl_dig_core.t_dim_cal_day_1 AS C2 ON T1.first_delivery_cy_week = C2.cy_week AND C2.day_of_week = 5
   LEFT JOIN MAX_LT AS T2 ON T1.prod_sid = T2.prod_sid
  WHERE LOWER(T1.sale_promo_status_cd) <> 'canceled'
   AND T1.dwh_valid_fg
   AND T2.tgt_prod_receive_cy_week_max = T1.tgt_prod_receive_cy_week
   AND NOT T1.is_repeated_fg
  GROUP BY T1.prod_sid
  HAVING T1.prod_sid NOT IN (SELECT T2.prod_sid
    FROM ldl_dig_core.t_dim_sales_promotion_1 AS T2
     INNER JOIN ldl_dig_core.t_dim_cal_day_1 AS C10 ON T2.tgt_prod_receive_cy_week = C10.cy_week AND C10.day_of_week = 5
     INNER JOIN ldl_dig_core.t_dim_cal_day_1 AS C20 ON T2.first_delivery_cy_week = C20.cy_week AND C20.day_of_week = 5
     LEFT JOIN MAX_LT AS T3 ON T2.prod_sid = T3.prod_sid
      WHERE LOWER(T2.sale_promo_status_cd) <> 'canceled'
     AND T2.dwh_valid_fg
     AND T3.tgt_prod_receive_cy_week_max = T2.tgt_prod_receive_cy_week
     AND NOT T2.is_repeated_fg
    GROUP BY T2.prod_sid)), SALES_PROMOTION_TEMP AS (SELECT DIM_SP.prod_sid,
    DIM_SP.is_catalog_prod_fg,
    DIM_SP.assortment_plan_period_nr,
    DIM_SP.amc_ian_nr,
    CAL_W.cy_week_begin_dt AS tgt_prod_receive_cy_week_dt,
    'BATCH' AS source
   FROM ldl_dig_core.t_dim_sales_promotion_1 AS DIM_SP
    INNER JOIN ldl_dig_core.t_dim_cal_week_1 AS CAL_W ON DIM_SP.tgt_prod_receive_cy_week = CAL_W.cy_week
    INNER JOIN MAX_BATCH AS BATCH ON DIM_SP.prod_sid = BATCH.prod_sid
   WHERE DIM_SP.dwh_valid_fg
    AND LOWER(DIM_SP.sale_promo_status_cd) <> 'canceled'
    AND NOT DIM_SP.is_repeated_fg
   UNION DISTINCT
   SELECT t25.prod_sid ,
    is_catalog_prod_fg,
    assortment_plan_period_nr,
    amc_ian_nr,
    cy_week_begin_dt AS tgt_prod_receive_cy_week_dt,
    'IAN' AS source
   FROM (SELECT dim_sp.prod_sid
        ,is_catalog_prod_fg
        ,dim_sp.assortment_plan_period_nr
        ,dim_sp.amc_ian_nr
        ,cal_w.cy_week_begin_dt 
        ,'ian' as source,dwh_valid_fg,sale_promo_status_cd,is_repeated_fg
     FROM ldl_dig_core.t_dim_sales_promotion_1 AS DIM_SP
      INNER JOIN ldl_dig_core.t_dim_cal_week_1 AS CAL_W ON DIM_SP.tgt_prod_receive_cy_week = CAL_W.cy_week
      INNER JOIN MAX_IAN AS IAN ON TRUE
     WHERE DIM_SP.prod_sid = IAN.prod_sid) AS t25
   WHERE t25.dwh_valid_fg
    AND LOWER(t25.sale_promo_status_cd) <> 'canceled'
    AND NOT t25.is_repeated_fg), SALES_PROMOTION AS (SELECT prod_sid,
   source,
   is_catalog_prod_fg,
   assortment_plan_period_nr,
   amc_ian_nr,
   MAX(tgt_prod_receive_cy_week_dt) OVER (PARTITION BY prod_sid RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS tgt_prod_receive_cy_week_dt
  FROM SALES_PROMOTION_TEMP
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY prod_sid )) = 1) (-- total stock count per PROD_SID

  -- use only promotions which are not in the future. use the promotion with the largets AMC_IAN_NR for each product

  -- use the (prefiltered) promotion with the largest date

  -- only show products which currently have a stock greater than 0
 SELECT DIM_P.prod_sid,
   DIM_P.prod_nr,
   SP.is_catalog_prod_fg,
   SP.assortment_plan_period_nr,
    CASE
    WHEN SP.assortment_plan_period_nr IS NOT NULL
    THEN BATCH.min_delivery_dt_batch
    ELSE IAN.min_delivery_dt_ian
    END AS min_delivery_date,
    CASE
    WHEN SP.assortment_plan_period_nr IS NOT NULL
    THEN BATCH.max_delivery_dt_batch
    ELSE IAN.max_delivery_dt_ian
    END AS max_delivery_date,
    CASE
    WHEN SP.assortment_plan_period_nr IS NOT NULL
    THEN BATCH.promo_dur_week_cnt_batch
    ELSE IAN.promo_dur_week_cnt_ian
    END AS promo_dur_week_cnt,
   CAST(CASE
     WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
     THEN 'bereits in Verwertung'
     WHEN CASE
      WHEN SP.assortment_plan_period_nr IS NOT NULL
      THEN BATCH.max_delivery_dt_batch
      ELSE IAN.max_delivery_dt_ian
      END IS NULL
     THEN 'kein LT'
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END < DATE('2022-09-16')
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END, INTERVAL 16 MONTH))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END < DATE('2022-09-16')
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END, INTERVAL 26 WEEK))
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END, INTERVAL 16 MONTH))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END, INTERVAL 26 WEEK))
     WHEN CASE
       WHEN SP.assortment_plan_period_nr IS NOT NULL
       THEN BATCH.promo_dur_week_cnt_batch
       ELSE IAN.promo_dur_week_cnt_ian
       END IS NULL OR CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END = 0
     THEN 'Sortiment, keine Verwertung'
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 12
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END, INTERVAL 15 WEEK))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 12
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END, INTERVAL 15 WEEK))
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END > 12 AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 26
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END, INTERVAL 29 WEEK))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END > 12 AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 26
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END, INTERVAL 29 WEEK))
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END > 26
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END, INTERVAL 55 WEEK))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END > 26
     THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END, INTERVAL 55 WEEK))
     ELSE 'kein LT'
     END AS STRING) AS calculated_utilisation,
   CAST(CASE
     WHEN UPPER(FACT_PU.util_action_cd) = 'AUSLISTUNG NACHDISPO'
     THEN FORMAT_DATE('%d.%m.%Y', FACT_PU.exception_util_dt)
     WHEN UPPER(FACT_PU.util_action_cd) = 'AUSNAHME_1 VWK'
     THEN FORMAT_DATE('%d.%m.%Y', FACT_PU.exception_util_dt)
     WHEN CAST(SAFE.PARSE_DATE('%F', SUBSTR(CAST(FACT_PU.exception_util_dt AS STRING), 1, 20)) AS STRING) > CAST(CASE
        WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
        THEN 'bereits in Verwertung'
        WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.max_delivery_dt_batch
         ELSE IAN.max_delivery_dt_ian
         END IS NULL
        THEN 'kein LT'
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END < DATE('2022-09-16')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 16 MONTH))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END < DATE('2022-09-16')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 26 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 16 MONTH))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 26 WEEK))
        WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END IS NULL OR CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END = 0
        THEN 'Sortiment, keine Verwertung'
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 12
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 15 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 12
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 15 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 29 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 29 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 55 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 55 WEEK))
        ELSE 'kein LT'
        END AS STRING)
     THEN FORMAT_DATE('%d.%m.%Y', FACT_PU.exception_util_dt)
     ELSE CAST(CASE
       WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
       THEN 'bereits in Verwertung'
       WHEN CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END IS NULL
       THEN 'kein LT'
       WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.min_delivery_dt_batch
          ELSE IAN.min_delivery_dt_ian
          END < DATE('2022-09-16')
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.min_delivery_dt_batch
          ELSE IAN.min_delivery_dt_ian
          END, INTERVAL 16 MONTH))
       WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.max_delivery_dt_batch
          ELSE IAN.max_delivery_dt_ian
          END < DATE('2022-09-16')
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.max_delivery_dt_batch
          ELSE IAN.max_delivery_dt_ian
          END, INTERVAL 26 WEEK))
       WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.min_delivery_dt_batch
          ELSE IAN.min_delivery_dt_ian
          END, INTERVAL 16 MONTH))
       WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.max_delivery_dt_batch
          ELSE IAN.max_delivery_dt_ian
          END, INTERVAL 26 WEEK))
       WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END IS NULL OR CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END = 0
       THEN 'Sortiment, keine Verwertung'
       WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END <= 12
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.min_delivery_dt_batch
          ELSE IAN.min_delivery_dt_ian
          END, INTERVAL 15 WEEK))
       WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END <= 12
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.max_delivery_dt_batch
          ELSE IAN.max_delivery_dt_ian
          END, INTERVAL 15 WEEK))
       WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 12 AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END <= 26
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.min_delivery_dt_batch
          ELSE IAN.min_delivery_dt_ian
          END, INTERVAL 29 WEEK))
       WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 12 AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END <= 26
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.max_delivery_dt_batch
          ELSE IAN.max_delivery_dt_ian
          END, INTERVAL 29 WEEK))
       WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END > 26
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.min_delivery_dt_batch
          ELSE IAN.min_delivery_dt_ian
          END, INTERVAL 55 WEEK))
       WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END > 26
       THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.max_delivery_dt_batch
          ELSE IAN.max_delivery_dt_ian
          END, INTERVAL 55 WEEK))
       ELSE 'kein LT'
       END AS STRING)
     END AS STRING) AS correct_utilisation,
   DATE(CAST(CASE
      WHEN UPPER(FACT_PU.util_action_cd) = 'AUSLISTUNG NACHDISPO'
      THEN FORMAT_DATE('%d.%m.%Y', FACT_PU.exception_util_dt)
      WHEN UPPER(FACT_PU.util_action_cd) = 'AUSNAHME_1 VWK'
      THEN FORMAT_DATE('%d.%m.%Y', FACT_PU.exception_util_dt)
      WHEN CAST(SAFE.PARSE_DATE('%F', SUBSTR(CAST(FACT_PU.exception_util_dt AS STRING), 1, 20)) AS STRING) > CAST(CASE
         WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
         THEN 'bereits in Verwertung'
         WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.max_delivery_dt_batch
          ELSE IAN.max_delivery_dt_ian
          END IS NULL
         THEN 'kein LT'
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END < DATE('2022-09-16')
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 16 MONTH))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END < DATE('2022-09-16')
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 26 WEEK))
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 16 MONTH))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 26 WEEK))
         WHEN CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END IS NULL OR CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END = 0
         THEN 'Sortiment, keine Verwertung'
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END <= 12
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 15 WEEK))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END <= 12
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 15 WEEK))
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END > 12 AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END <= 26
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 29 WEEK))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END > 12 AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END <= 26
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 29 WEEK))
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 26
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 55 WEEK))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 26
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 55 WEEK))
         ELSE 'kein LT'
         END AS STRING)
      THEN FORMAT_DATE('%d.%m.%Y', FACT_PU.exception_util_dt)
      ELSE CAST(CASE
        WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
        THEN 'bereits in Verwertung'
        WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.max_delivery_dt_batch
         ELSE IAN.max_delivery_dt_ian
         END IS NULL
        THEN 'kein LT'
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END < DATE('2022-09-16')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 16 MONTH))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END < DATE('2022-09-16')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 26 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 16 MONTH))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 26 WEEK))
        WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END IS NULL OR CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END = 0
        THEN 'Sortiment, keine Verwertung'
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 12
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 15 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 12
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 15 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 29 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 29 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 55 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 55 WEEK))
        ELSE 'kein LT'
        END AS STRING)
      END AS STRING)) AS correct_utilisation_date_only,
   DCW.cy_week_name AS correct_utilisation_week,
   CAST(FLOOR(DATE_DIFF(DATE(CAST(CASE
          WHEN UPPER(FACT_PU.util_action_cd) = 'AUSLISTUNG NACHDISPO'
          THEN FORMAT_DATE('%d.%m.%Y',FACT_PU.exception_util_dt)
          WHEN UPPER(FACT_PU.util_action_cd) = 'AUSNAHME_1 VWK'
          THEN FORMAT_DATE('%d.%m.%Y',FACT_PU.exception_util_dt)
          WHEN CAST(SAFE.PARSE_DATE('%Y%m%d',CAST(FACT_PU.exception_util_dt AS STRING)) AS STRING) > CAST(CASE
             WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
             THEN 'bereits in Verwertung'
             WHEN CASE
              WHEN SP.assortment_plan_period_nr IS NOT NULL
              THEN BATCH.max_delivery_dt_batch
              ELSE IAN.max_delivery_dt_ian
              END IS NULL
             THEN 'kein LT'
             WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.min_delivery_dt_batch
                ELSE IAN.min_delivery_dt_ian
                END < DATE('2022-09-16')
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.min_delivery_dt_batch
                ELSE IAN.min_delivery_dt_ian
                END, INTERVAL 16 MONTH))
             WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.max_delivery_dt_batch
                ELSE IAN.max_delivery_dt_ian
                END < DATE('2022-09-16')
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.max_delivery_dt_batch
                ELSE IAN.max_delivery_dt_ian
                END, INTERVAL 26 WEEK))
             WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.min_delivery_dt_batch
                ELSE IAN.min_delivery_dt_ian
                END, INTERVAL 16 MONTH))
             WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.max_delivery_dt_batch
                ELSE IAN.max_delivery_dt_ian
                END, INTERVAL 26 WEEK))
             WHEN CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.promo_dur_week_cnt_batch
               ELSE IAN.promo_dur_week_cnt_ian
               END IS NULL OR CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.promo_dur_week_cnt_batch
                ELSE IAN.promo_dur_week_cnt_ian
                END = 0
             THEN 'Sortiment, keine Verwertung'
             WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.promo_dur_week_cnt_batch
                ELSE IAN.promo_dur_week_cnt_ian
                END <= 12
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.min_delivery_dt_batch
                ELSE IAN.min_delivery_dt_ian
                END, INTERVAL 15 WEEK))
             WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.promo_dur_week_cnt_batch
                ELSE IAN.promo_dur_week_cnt_ian
                END <= 12
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.max_delivery_dt_batch
                ELSE IAN.max_delivery_dt_ian
                END, INTERVAL 15 WEEK))
             WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
                 WHEN SP.assortment_plan_period_nr IS NOT NULL
                 THEN BATCH.promo_dur_week_cnt_batch
                 ELSE IAN.promo_dur_week_cnt_ian
                 END > 12 AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.promo_dur_week_cnt_batch
                ELSE IAN.promo_dur_week_cnt_ian
                END <= 26
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.min_delivery_dt_batch
                ELSE IAN.min_delivery_dt_ian
                END, INTERVAL 29 WEEK))
             WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
                 WHEN SP.assortment_plan_period_nr IS NOT NULL
                 THEN BATCH.promo_dur_week_cnt_batch
                 ELSE IAN.promo_dur_week_cnt_ian
                 END > 12 AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.promo_dur_week_cnt_batch
                ELSE IAN.promo_dur_week_cnt_ian
                END <= 26
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.max_delivery_dt_batch
                ELSE IAN.max_delivery_dt_ian
                END, INTERVAL 29 WEEK))
             WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.promo_dur_week_cnt_batch
                ELSE IAN.promo_dur_week_cnt_ian
                END > 26
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.min_delivery_dt_batch
                ELSE IAN.min_delivery_dt_ian
                END, INTERVAL 55 WEEK))
             WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.promo_dur_week_cnt_batch
                ELSE IAN.promo_dur_week_cnt_ian
                END > 26
             THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.max_delivery_dt_batch
                ELSE IAN.max_delivery_dt_ian
                END, INTERVAL 55 WEEK))
             ELSE 'kein LT'
             END AS STRING)
          THEN FORMAT_DATE('%d.%m.%Y',FACT_PU.exception_util_dt)
          ELSE CAST(CASE
            WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
            THEN 'bereits in Verwertung'
            WHEN CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.max_delivery_dt_batch
             ELSE IAN.max_delivery_dt_ian
             END IS NULL
            THEN 'kein LT'
            WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.min_delivery_dt_batch
               ELSE IAN.min_delivery_dt_ian
               END < DATE('2022-09-16')
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.min_delivery_dt_batch
               ELSE IAN.min_delivery_dt_ian
               END, INTERVAL 16 MONTH))
            WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.max_delivery_dt_batch
               ELSE IAN.max_delivery_dt_ian
               END < DATE('2022-09-16')
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.max_delivery_dt_batch
               ELSE IAN.max_delivery_dt_ian
               END, INTERVAL 26 WEEK))
            WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.min_delivery_dt_batch
               ELSE IAN.min_delivery_dt_ian
               END, INTERVAL 16 MONTH))
            WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.max_delivery_dt_batch
               ELSE IAN.max_delivery_dt_ian
               END, INTERVAL 26 WEEK))
            WHEN CASE
              WHEN SP.assortment_plan_period_nr IS NOT NULL
              THEN BATCH.promo_dur_week_cnt_batch
              ELSE IAN.promo_dur_week_cnt_ian
              END IS NULL OR CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.promo_dur_week_cnt_batch
               ELSE IAN.promo_dur_week_cnt_ian
               END = 0
            THEN 'Sortiment, keine Verwertung'
            WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.promo_dur_week_cnt_batch
               ELSE IAN.promo_dur_week_cnt_ian
               END <= 12
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.min_delivery_dt_batch
               ELSE IAN.min_delivery_dt_ian
               END, INTERVAL 15 WEEK))
            WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.promo_dur_week_cnt_batch
               ELSE IAN.promo_dur_week_cnt_ian
               END <= 12
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.max_delivery_dt_batch
               ELSE IAN.max_delivery_dt_ian
               END, INTERVAL 15 WEEK))
            WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.promo_dur_week_cnt_batch
                ELSE IAN.promo_dur_week_cnt_ian
                END > 12 AND CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.promo_dur_week_cnt_batch
               ELSE IAN.promo_dur_week_cnt_ian
               END <= 26
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.min_delivery_dt_batch
               ELSE IAN.min_delivery_dt_ian
               END, INTERVAL 29 WEEK))
            WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
                WHEN SP.assortment_plan_period_nr IS NOT NULL
                THEN BATCH.promo_dur_week_cnt_batch
                ELSE IAN.promo_dur_week_cnt_ian
                END > 12 AND CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.promo_dur_week_cnt_batch
               ELSE IAN.promo_dur_week_cnt_ian
               END <= 26
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.max_delivery_dt_batch
               ELSE IAN.max_delivery_dt_ian
               END, INTERVAL 29 WEEK))
            WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.promo_dur_week_cnt_batch
               ELSE IAN.promo_dur_week_cnt_ian
               END > 26
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.min_delivery_dt_batch
               ELSE IAN.min_delivery_dt_ian
               END, INTERVAL 55 WEEK))
            WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.promo_dur_week_cnt_batch
               ELSE IAN.promo_dur_week_cnt_ian
               END > 26
            THEN FORMAT_DATE('%d.%m.%Y',DATE_ADD(CASE
               WHEN SP.assortment_plan_period_nr IS NOT NULL
               THEN BATCH.max_delivery_dt_batch
               ELSE IAN.max_delivery_dt_ian
               END, INTERVAL 55 WEEK))
            ELSE 'kein LT'
            END AS STRING)
          END AS STRING)), CURRENT_DATE, DAY) / 7) AS INTEGER) AS weeks_until_utilisation,
   CAST(CASE
     WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
     THEN 'bereits in Verwertung'
     WHEN CASE
      WHEN SP.assortment_plan_period_nr IS NOT NULL
      THEN BATCH.max_delivery_dt_batch
      ELSE IAN.max_delivery_dt_ian
      END IS NULL
     THEN 'kein LT'
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END < DATE '2022-09-16'
     THEN 'Altes Konzept Festlistung'
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END < DATE '2022-09-16'
     THEN 'Altes Konzept Aktion_1'
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
     THEN 'Altes Konzept Festlistung'
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
     THEN 'Altes Konzept Aktion_1'
     WHEN CASE
       WHEN SP.assortment_plan_period_nr IS NOT NULL
       THEN BATCH.promo_dur_week_cnt_batch
       ELSE IAN.promo_dur_week_cnt_ian
       END IS NULL OR CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END = 0
     THEN 'Sortiment, keine Verwertung'
     WHEN CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 12 AND DIM_P.prod_promo_class_cd = 'FS'
     THEN 'Neues Konzept Festlistung 12 Wochen'
     WHEN CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 12 AND DIM_P.prod_promo_class_cd <> 'FS'
     THEN 'Neues Konzept Aktion_1 12 Wochen'
     WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END > 12 AND CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END <= 26 AND DIM_P.prod_promo_class_cd = 'FS'
     THEN 'Neues Konzept Festlistung 26 Wochen'
     WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END > 12 AND CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END <= 26 AND DIM_P.prod_promo_class_cd <> 'FS'
     THEN 'Neues Konzept Aktion_1 26 Wochen'
     WHEN CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END > 26 AND DIM_P.prod_promo_class_cd = 'FS'
     THEN 'Neues Konzept Festlistung 52 Wochen'
     WHEN CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END > 26 AND DIM_P.prod_promo_class_cd <> 'FS'
     THEN 'Neues Konzept Aktion_1 52 Wochen'
     ELSE 'kein LT'
     END AS STRING) AS calculated_information_concept,
    CASE
    WHEN UPPER(FACT_PU.util_action_cd) = 'AUSLISTUNG NACHDISPO'
    THEN 'Ausnahme_1 ohne Auslistung'
    WHEN UPPER(FACT_PU.util_action_cd) = 'AUSNAHME_1 VWK'
    THEN 'Ausnahme_1 ohne Auslistung'
    WHEN LENGTH(CAST(CASE
        WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
        THEN 'bereits in Verwertung'
        WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.max_delivery_dt_batch
         ELSE IAN.max_delivery_dt_ian
         END IS NULL
        THEN 'kein LT'
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END < DATE('2022-09-16')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 16 MONTH))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END < DATE('2022-09-16')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 26 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 16 MONTH))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 26 WEEK))
        WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END IS NULL OR CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END = 0
        THEN 'Sortiment, keine Verwertung'
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 12
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 15 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 12
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 15 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 29 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 29 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 55 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 55 WEEK))
        ELSE 'kein LT'
        END AS STRING)) = 10
    THEN CASE
     WHEN CAST(FACT_PU.exception_util_dt AS STRING) > CAST(CASE
        WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
        THEN 'bereits in Verwertung'
        WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.max_delivery_dt_batch
         ELSE IAN.max_delivery_dt_ian
         END IS NULL
        THEN 'kein LT'
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END < DATE('2022-09-16')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 16 MONTH))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END < DATE('2022-09-16')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 26 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 16 MONTH))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 26 WEEK))
        WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END IS NULL OR CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END = 0
        THEN 'Sortiment, keine Verwertung'
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 12
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 15 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 12
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 15 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 29 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 29 WEEK))
        WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.min_delivery_dt_batch
           ELSE IAN.min_delivery_dt_ian
           END, INTERVAL 55 WEEK))
        WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 26
        THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END, INTERVAL 55 WEEK))
        ELSE 'kein LT'
        END AS STRING)
     THEN 'Ausnahme_1 ohne Auslistung'
     ELSE CAST(CASE
       WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
       THEN 'bereits in Verwertung'
       WHEN CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END IS NULL
       THEN 'kein LT'
       WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.min_delivery_dt_batch
          ELSE IAN.min_delivery_dt_ian
          END < DATE '2022-09-16'
       THEN 'Altes Konzept Festlistung'
       WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.max_delivery_dt_batch
          ELSE IAN.max_delivery_dt_ian
          END < DATE '2022-09-16'
       THEN 'Altes Konzept Aktion_1'
       WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
       THEN 'Altes Konzept Festlistung'
       WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
       THEN 'Altes Konzept Aktion_1'
       WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END IS NULL OR CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END = 0
       THEN 'Sortiment, keine Verwertung'
       WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END <= 12 AND DIM_P.prod_promo_class_cd = 'FS'
       THEN 'Neues Konzept Festlistung 12 Wochen'
       WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END <= 12 AND DIM_P.prod_promo_class_cd <> 'FS'
       THEN 'Neues Konzept Aktion_1 12 Wochen'
       WHEN CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26 AND DIM_P.prod_promo_class_cd = 'FS'
       THEN 'Neues Konzept Festlistung 26 Wochen'
       WHEN CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END > 12 AND CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END <= 26 AND DIM_P.prod_promo_class_cd <> 'FS'
       THEN 'Neues Konzept Aktion_1 26 Wochen'
       WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END > 26 AND DIM_P.prod_promo_class_cd = 'FS'
       THEN 'Neues Konzept Festlistung 52 Wochen'
       WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END > 26 AND DIM_P.prod_promo_class_cd <> 'FS'
       THEN 'Neues Konzept Aktion_1 52 Wochen'
       ELSE 'kein LT'
       END AS STRING)
     END
    ELSE CAST(CASE
      WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
      THEN 'bereits in Verwertung'
      WHEN CASE
       WHEN SP.assortment_plan_period_nr IS NOT NULL
       THEN BATCH.max_delivery_dt_batch
       ELSE IAN.max_delivery_dt_ian
       END IS NULL
      THEN 'kein LT'
      WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.min_delivery_dt_batch
         ELSE IAN.min_delivery_dt_ian
         END < DATE '2022-09-16'
      THEN 'Altes Konzept Festlistung'
      WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.max_delivery_dt_batch
         ELSE IAN.max_delivery_dt_ian
         END < DATE '2022-09-16'
      THEN 'Altes Konzept Aktion_1'
      WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
      THEN 'Altes Konzept Festlistung'
      WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
      THEN 'Altes Konzept Aktion_1'
      WHEN CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END IS NULL OR CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END = 0
      THEN 'Sortiment, keine Verwertung'
      WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END <= 12 AND DIM_P.prod_promo_class_cd = 'FS'
      THEN 'Neues Konzept Festlistung 12 Wochen'
      WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END <= 12 AND DIM_P.prod_promo_class_cd <> 'FS'
      THEN 'Neues Konzept Aktion_1 12 Wochen'
      WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END > 12 AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END <= 26 AND DIM_P.prod_promo_class_cd = 'FS'
      THEN 'Neues Konzept Festlistung 26 Wochen'
      WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END > 12 AND CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.promo_dur_week_cnt_batch
          ELSE IAN.promo_dur_week_cnt_ian
          END <= 26 AND DIM_P.prod_promo_class_cd <> 'FS'
      THEN 'Neues Konzept Aktion_1 26 Wochen'
      WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END > 26 AND DIM_P.prod_promo_class_cd = 'FS'
      THEN 'Neues Konzept Festlistung 52 Wochen'
      WHEN CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END > 26 AND DIM_P.prod_promo_class_cd <> 'FS'
      THEN 'Neues Konzept Aktion_1 52 Wochen'
      ELSE 'kein LT'
      END AS STRING)
    END AS correct_information_concept,
   CAST(CASE
     WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
     THEN 'bereits in Verwertung'
     WHEN CASE
      WHEN SP.assortment_plan_period_nr IS NOT NULL
      THEN BATCH.max_delivery_dt_batch
      ELSE IAN.max_delivery_dt_ian
      END IS NULL
     THEN 'kein LT'
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END < DATE('2022-09-16')
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END < DATE('2022-09-16')
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END))
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END))
     WHEN CASE
       WHEN SP.assortment_plan_period_nr IS NOT NULL
       THEN BATCH.promo_dur_week_cnt_batch
       ELSE IAN.promo_dur_week_cnt_ian
       END IS NULL OR CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END = 0
     THEN 'Sortiment, keine Verwertung'
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 12
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 12
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END))
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END > 12 AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 26
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
         WHEN SP.assortment_plan_period_nr IS NOT NULL
         THEN BATCH.promo_dur_week_cnt_batch
         ELSE IAN.promo_dur_week_cnt_ian
         END > 12 AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END <= 26
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END))
     WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END > 26
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.min_delivery_dt_batch
        ELSE IAN.min_delivery_dt_ian
        END))
     WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.promo_dur_week_cnt_batch
        ELSE IAN.promo_dur_week_cnt_ian
        END > 26
     THEN CONCAT(EXTRACT(YEAR FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END), ' KW ', EXTRACT(ISOWEEK FROM CASE
        WHEN SP.assortment_plan_period_nr IS NOT NULL
        THEN BATCH.max_delivery_dt_batch
        ELSE IAN.max_delivery_dt_ian
        END))
     ELSE 'kein LT'
     END AS STRING) AS used_delivery_utilisation_date
  FROM ldl_dig_core.t_dim_product_1 AS DIM_P
   LEFT JOIN CTE_PU AS FACT_PU ON DIM_P.prod_sid = FACT_PU.prod_sid
   LEFT JOIN SALES_PROMOTION AS SP ON DIM_P.prod_sid = SP.prod_sid
   LEFT JOIN MAX_IAN AS IAN ON DIM_P.prod_sid = IAN.prod_sid
   LEFT JOIN MAX_BATCH AS BATCH ON DIM_P.prod_sid = BATCH.prod_sid
   LEFT JOIN ldl_dig_core.t_dim_cal_day_1 AS DCD ON DATE(CAST(CASE
       WHEN UPPER(FACT_PU.util_action_cd) = 'AUSLISTUNG NACHDISPO'
       THEN FORMAT_DATE('%d.%m.%Y', FACT_PU.exception_util_dt)
       WHEN UPPER(FACT_PU.util_action_cd) = 'AUSNAHME_1 VWK'
       THEN FORMAT_DATE('%d.%m.%Y', FACT_PU.exception_util_dt)
       WHEN CAST(SAFE.PARSE_DATE('%F', SUBSTR(CAST(FACT_PU.exception_util_dt AS STRING), 1, 20)) AS STRING) > CAST(CASE
          WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
          THEN 'bereits in Verwertung'
          WHEN CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.max_delivery_dt_batch
           ELSE IAN.max_delivery_dt_ian
           END IS NULL
          THEN 'kein LT'
          WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.min_delivery_dt_batch
             ELSE IAN.min_delivery_dt_ian
             END < DATE('2022-09-16')
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.min_delivery_dt_batch
             ELSE IAN.min_delivery_dt_ian
             END, INTERVAL 16 MONTH))
          WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.max_delivery_dt_batch
             ELSE IAN.max_delivery_dt_ian
             END < DATE('2022-09-16')
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.max_delivery_dt_batch
             ELSE IAN.max_delivery_dt_ian
             END, INTERVAL 26 WEEK))
          WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.min_delivery_dt_batch
             ELSE IAN.min_delivery_dt_ian
             END, INTERVAL 16 MONTH))
          WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.max_delivery_dt_batch
             ELSE IAN.max_delivery_dt_ian
             END, INTERVAL 26 WEEK))
          WHEN CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END IS NULL OR CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END = 0
          THEN 'Sortiment, keine Verwertung'
          WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END <= 12
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.min_delivery_dt_batch
             ELSE IAN.min_delivery_dt_ian
             END, INTERVAL 15 WEEK))
          WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END <= 12
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.max_delivery_dt_batch
             ELSE IAN.max_delivery_dt_ian
             END, INTERVAL 15 WEEK))
          WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
              WHEN SP.assortment_plan_period_nr IS NOT NULL
              THEN BATCH.promo_dur_week_cnt_batch
              ELSE IAN.promo_dur_week_cnt_ian
              END > 12 AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END <= 26
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.min_delivery_dt_batch
             ELSE IAN.min_delivery_dt_ian
             END, INTERVAL 29 WEEK))
          WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
              WHEN SP.assortment_plan_period_nr IS NOT NULL
              THEN BATCH.promo_dur_week_cnt_batch
              ELSE IAN.promo_dur_week_cnt_ian
              END > 12 AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END <= 26
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.max_delivery_dt_batch
             ELSE IAN.max_delivery_dt_ian
             END, INTERVAL 29 WEEK))
          WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END > 26
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.min_delivery_dt_batch
             ELSE IAN.min_delivery_dt_ian
             END, INTERVAL 55 WEEK))
          WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END > 26
          THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.max_delivery_dt_batch
             ELSE IAN.max_delivery_dt_ian
             END, INTERVAL 55 WEEK))
          ELSE 'kein LT'
          END AS STRING)
       THEN FORMAT_DATE('%d.%m.%Y', FACT_PU.exception_util_dt)
       ELSE CAST(CASE
         WHEN UPPER(FACT_PU.util_action_cd) = 'VERWERTUNG'
         THEN 'bereits in Verwertung'
         WHEN CASE
          WHEN SP.assortment_plan_period_nr IS NOT NULL
          THEN BATCH.max_delivery_dt_batch
          ELSE IAN.max_delivery_dt_ian
          END IS NULL
         THEN 'kein LT'
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END < DATE('2022-09-16')
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 16 MONTH))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END < DATE('2022-09-16')
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 26 WEEK))
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 16 MONTH))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND SP.assortment_plan_period_nr IN ('2110', '2107', '2104', '2101', '2010', '2007', '2004', '2001', '1910', '1907', '1904', '1901')
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 26 WEEK))
         WHEN CASE
           WHEN SP.assortment_plan_period_nr IS NOT NULL
           THEN BATCH.promo_dur_week_cnt_batch
           ELSE IAN.promo_dur_week_cnt_ian
           END IS NULL OR CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END = 0
         THEN 'Sortiment, keine Verwertung'
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END <= 12
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 15 WEEK))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END <= 12
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 15 WEEK))
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END > 12 AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END <= 26
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 29 WEEK))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
             WHEN SP.assortment_plan_period_nr IS NOT NULL
             THEN BATCH.promo_dur_week_cnt_batch
             ELSE IAN.promo_dur_week_cnt_ian
             END > 12 AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END <= 26
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 29 WEEK))
         WHEN DIM_P.prod_promo_class_cd = 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 26
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.min_delivery_dt_batch
            ELSE IAN.min_delivery_dt_ian
            END, INTERVAL 55 WEEK))
         WHEN DIM_P.prod_promo_class_cd <> 'FS' AND CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.promo_dur_week_cnt_batch
            ELSE IAN.promo_dur_week_cnt_ian
            END > 26
         THEN FORMAT_DATE('%d.%m.%Y', DATE_ADD(CASE
            WHEN SP.assortment_plan_period_nr IS NOT NULL
            THEN BATCH.max_delivery_dt_batch
            ELSE IAN.max_delivery_dt_ian
            END, INTERVAL 55 WEEK))
         ELSE 'kein LT'
         END AS STRING)
       END AS STRING)) = DCD.cal_dt
   LEFT JOIN ldl_dig_core.t_dim_cal_week_1 AS DCW ON DCD.cy_week = DCW.cy_week
  WHERE DIM_P.dwh_valid_fg
   AND DIM_P.prod_sid IN (SELECT t48.prod_sid
     FROM (SELECT DIM_PV.prod_sid,
        SUM(SWD.total_stock_cnt) AS total_stock_cnt
       FROM ldl_dig_core.t_fact_stock_warehouse_daily_1 AS SWD
        INNER JOIN ldl_dig_core.t_dim_product_variant_1 AS DIM_PV ON SWD.prod_variant_sid = DIM_PV.prod_variant_sid AND
         DIM_PV.dwh_valid_fg
       WHERE SWD.active_fg
       GROUP BY DIM_PV.prod_sid
       HAVING total_stock_cnt > 0) AS t48));

