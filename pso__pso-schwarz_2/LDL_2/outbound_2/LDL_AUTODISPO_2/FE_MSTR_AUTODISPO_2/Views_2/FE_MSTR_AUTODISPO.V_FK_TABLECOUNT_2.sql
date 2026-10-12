CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_fk_tablecount_2 AS WITH BASE AS (SELECT C.country_2,
   v_dim_calendar_date.cal_dt,
   t.tabelle,
   t.threshold,
   t.src
  FROM ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_country_2 AS C
   INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_dim_calendar_date_2 ON TRUE
   INNER JOIN (SELECT 'FK_DELIVERY' AS tabelle,
      'Oracle' AS src,
      1 AS threshold
     UNION ALL
     SELECT 'FK_EXCLUDED' AS tabelle,
      'Oracle' AS src,
      0 AS threshold
     UNION ALL
     SELECT 'FK_FORECAST' AS tabelle,
      'Oracle' AS src,
      0.2 AS threshold
     UNION ALL
     SELECT 'FK_MIL' AS tabelle,
      'Oracle' AS src,
      1 AS threshold
     UNION ALL
     SELECT 'FK_MINMAX' AS tabelle,
      'Oracle' AS src,
      0 AS threshold
     UNION ALL
     SELECT 'FK_OPTIMIZATION' AS tabelle,
      'Oracle' AS src,
      0 AS threshold
     UNION ALL
     SELECT 'FK_ORDER' AS tabelle,
      'Oracle' AS src,
      0 AS threshold
     UNION ALL
     SELECT 'FK_REBUILDS' AS tabelle,
      'Oracle' AS src,
      10 AS threshold
     UNION ALL
     SELECT 'FK_SALES' AS tabelle,
      'Oracle' AS src,
      0.2 AS threshold
     UNION ALL
     SELECT 'FK_STOCK' AS tabelle,
      'Oracle' AS src,
      1 AS threshold
     UNION ALL
     SELECT 'FK_STORE_STOCK' AS tabelle,
      'Oracle' AS src,
      0.2 AS threshold
     UNION ALL
     SELECT 'FK_STORE_TREND_NEW' AS tabelle,
      'Oracle' AS src,
      0 AS threshold
     UNION ALL
     SELECT 'FK_SUPPLIER_FINAL_ORDER' AS tabelle,
      'Oracle' AS src,
      1 AS threshold
     UNION ALL
     SELECT 'FK_SUPPLIER_ORDER' AS tabelle,
      'Oracle' AS src,
      1 AS threshold
     UNION ALL
     SELECT 'FK_TO_COUNT' AS tabelle,
      'Oracle' AS src,
      1 AS threshold
     UNION ALL
     SELECT 'FK_WH_DELIVERY' AS tabelle,
      'Oracle' AS src,
      1 AS threshold
     UNION ALL
     SELECT 'FINAL_RESULTS_REDUCED' AS tabelle,
      'HIVE' AS src,
      0.1 AS threshold
     UNION ALL
     SELECT 'FORECAST_QUALITY_REDUCED' AS tabelle,
      'HIVE' AS src,
      0.2 AS threshold
     UNION ALL
     SELECT 'INTERNAL_FORECAST' AS tabelle,
      'AI' AS src,
      0.1 AS threshold) AS t ON TRUE
  WHERE v_dim_calendar_date.cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
   OR v_dim_calendar_date.cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 7
      DAY))), DATEN AS (((((((((((((((((((((((((((((((((((((SELECT country_2,
                                        DATE(snflk_update_tmsp) AS date_load,
                                        DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(del_time_id - 365.25 * 4712 - 2 AS INTEGER)
                                          DAY)) AS date,
                                        CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                        'FK_DELIVERY' AS tabelle,
                                        'Oracle' AS src,
                                        COUNT(*) AS rowcount,
                                        CAST(NULL AS BIGINT) AS rowcount_lastweek
                                       FROM ldl_autodispo_core.t_oracle_v_fk_delivery_2
                                       WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND
                                          (CURRENT_DATE)
                                       GROUP BY country_2,
                                        date_load,
                                        date
                                       UNION DISTINCT
                                       SELECT country_2,
                                        DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                                        DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(del_time_id - 365.25 * 4712 - 2 AS INTEGER)
                                          DAY)) AS date,
                                        CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                        'FK_DELIVERY' AS tabelle,
                                        'Oracle' AS src,
                                        CAST(NULL AS BIGINT) AS rowcount,
                                        COUNT(*) AS rowcount_lastweek
                                       FROM ldl_autodispo_core.t_oracle_v_fk_delivery_2
                                       WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND
                                          (DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY))
                                       GROUP BY country_2,
                                        date_load,
                                        date)
                                      UNION DISTINCT
                                      SELECT country_2,
                                       DATE(snflk_update_tmsp) AS date_load,
                                       DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(CAST(ex_from_time_id AS FLOAT64)
                                            - 365.25 * 4712 - 2 AS INTEGER) DAY)) AS date,
                                       CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                       'FK_EXCLUDED' AS tabelle,
                                       'Oracle' AS src,
                                       COUNT(*) AS rowcount,
                                       CAST(NULL AS BIGINT) AS rowcount_lastweek
                                      FROM ldl_autodispo_core.t_oracle_v_fk_excluded_2
                                      WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE
                                         )
                                      GROUP BY country_2,
                                       date_load,
                                       date)
                                     UNION DISTINCT
                                     SELECT country_2,
                                      DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                                      DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(CAST(ex_from_time_id AS FLOAT64)
                                           - 365.25 * 4712 - 2 AS INTEGER) DAY)) AS date,
                                      CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                      'FK_EXCLUDED' AS tabelle,
                                      'Oracle' AS src,
                                      CAST(NULL AS BIGINT) AS rowcount,
                                      COUNT(*) AS rowcount_lastweek
                                     FROM ldl_autodispo_core.t_oracle_v_fk_excluded_2
                                     WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                                         ,INTERVAL 7 DAY))
                                     GROUP BY country_2,
                                      date_load,
                                      date)
                                    UNION DISTINCT
                                    SELECT country_2,
                                     DATE(snflk_update_tmsp) AS date_load,
                                     DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
                                       DAY)) AS date,
                                     CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                     'FK_FORECAST' AS tabelle,
                                     'Oracle' AS src,
                                     COUNT(*) AS rowcount,
                                     CAST(NULL AS BIGINT) AS rowcount_lastweek
                                    FROM ldl_autodispo_core.t_oracle_v_fk_forecast_2
                                    WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE
                                       )
                                    GROUP BY country_2,
                                     date_load,
                                     date)
                                   UNION DISTINCT
                                   SELECT country_2,
                                    DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                                    DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(forc_time_id - 365.25 * 4712 - 2 AS INTEGER)
                                      DAY)) AS date,
                                    CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                    'FK_FORECAST' AS tabelle,
                                    'Oracle' AS src,
                                    CAST(NULL AS BIGINT) AS rowcount,
                                    COUNT(*) AS rowcount_lastweek
                                   FROM ldl_autodispo_core.t_oracle_v_fk_forecast_2
                                   WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                                       ,INTERVAL 7 DAY))
                                   GROUP BY country_2,
                                    date_load,
                                    date)
                                  UNION DISTINCT
                                  SELECT country_2,
                                   DATE(snflk_update_tmsp) AS date_load,
                                   DATE(entrydate) AS date,
                                   CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                   'FK_MIL' AS tabelle,
                                   'Oracle' AS src,
                                   COUNT(*) AS rowcount,
                                   CAST(NULL AS BIGINT) AS rowcount_lastweek
                                  FROM ldl_autodispo_core.t_oracle_v_fk_mil_2
                                  WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE
                                     )
                                  GROUP BY country_2,
                                   date_load,
                                   date)
                                 UNION DISTINCT
                                 SELECT country_2,
                                  DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                                  DATE(entrydate) AS date,
                                  CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                  'FK_MIL' AS tabelle,
                                  'Oracle' AS src,
                                  CAST(NULL AS BIGINT) AS rowcount,
                                  COUNT(*) AS rowcount_lastweek
                                 FROM ldl_autodispo_core.t_oracle_v_fk_mil_2
                                 WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                                     ,INTERVAL 7 DAY))
                                 GROUP BY country_2,
                                  date_load,
                                  date)
                                UNION DISTINCT
                                SELECT country_2,
                                 DATE(snflk_update_tmsp) AS date_load,
                                 DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(mm_gen_time_id - 365.25 * 4712 - 2 AS INTEGER)
                                   DAY)) AS date,
                                 CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                 'FK_MINMAX' AS tabelle,
                                 'Oracle' AS src,
                                 COUNT(*) AS rowcount,
                                 CAST(NULL AS BIGINT) AS rowcount_lastweek
                                FROM ldl_autodispo_core.t_oracle_v_fk_minmax_2
                                WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE
                                   )
                                GROUP BY country_2,
                                 date_load,
                                 date)
                               UNION DISTINCT
                               SELECT country_2,
                                DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                                DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(mm_gen_time_id - 365.25 * 4712 - 2 AS INTEGER)
                                  DAY)) AS date,
                                CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                                'FK_MINMAX' AS tabelle,
                                'Oracle' AS src,
                                CAST(NULL AS BIGINT) AS rowcount,
                                COUNT(*) AS rowcount_lastweek
                               FROM ldl_autodispo_core.t_oracle_v_fk_minmax_2
                               WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                                   ,INTERVAL 7 DAY))
                               GROUP BY country_2,
                                date_load,
                                date)
                              UNION DISTINCT
                              SELECT country_2,
                               DATE(snflk_update_tmsp) AS date_load,
                               DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(opt_time_id - 365.25 * 4712 - 2 AS INTEGER)
                                 DAY)) AS date,
                               CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                               'FK_OPTIMIZATION' AS tabelle,
                               'Oracle' AS src,
                               COUNT(*) AS rowcount,
                               CAST(NULL AS BIGINT) AS rowcount_lastweek
                              FROM ldl_autodispo_core.t_oracle_v_fk_optimization_2
                              WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE
                                 )
                              GROUP BY country_2,
                               date_load,
                               date)
                             UNION DISTINCT
                             SELECT country_2,
                              DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                              DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(opt_time_id - 365.25 * 4712 - 2 AS INTEGER)
                                DAY)) AS date,
                              CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                              'FK_OPTIMIZATION' AS tabelle,
                              'Oracle' AS src,
                              CAST(NULL AS BIGINT) AS rowcount,
                              COUNT(*) AS rowcount_lastweek
                             FROM ldl_autodispo_core.t_oracle_v_fk_optimization_2
                             WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                                 ,INTERVAL 7 DAY))
                             GROUP BY country_2,
                              date_load,
                              date)
                            UNION DISTINCT
                            SELECT country_2,
                             DATE(snflk_update_tmsp) AS date_load,
                             DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(ord_time_id - 365.25 * 4712 - 2 AS INTEGER)
                               DAY)) AS date,
                             CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                             'FK_ORDER' AS tabelle,
                             'Oracle' AS src,
                             COUNT(*) AS rowcount,
                             CAST(NULL AS BIGINT) AS rowcount_lastweek
                            FROM ldl_autodispo_core.t_oracle_v_fk_order_2
                            WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE
                               )
                            GROUP BY country_2,
                             date_load,
                             date)
                           UNION DISTINCT
                           SELECT country_2,
                            DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                            DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(ord_time_id - 365.25 * 4712 - 2 AS INTEGER)
                              DAY)) AS date,
                            CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                            'FK_ORDER' AS tabelle,
                            'Oracle' AS src,
                            CAST(NULL AS BIGINT) AS rowcount,
                            COUNT(*) AS rowcount_lastweek
                           FROM ldl_autodispo_core.t_oracle_v_fk_order_2
                           WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                               ,INTERVAL 7 DAY))
                           GROUP BY country_2,
                            date_load,
                            date)
                          UNION DISTINCT
                          SELECT country_2,
                           DATE(snflk_update_tmsp) AS date_load,
                           DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(rb_datefrom - 365.25 * 4712 - 2 AS INTEGER)
                             DAY)) AS date,
                           CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                           'FK_REBUILDS' AS tabelle,
                           'Oracle' AS src,
                           COUNT(*) AS rowcount,
                           CAST(NULL AS BIGINT) AS rowcount_lastweek
                          FROM ldl_autodispo_core.t_oracle_v_fk_rebuilds_2
                          WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE
                             )
                          GROUP BY country_2,
                           date_load,
                           date)
                         UNION DISTINCT
                         SELECT country_2,
                          DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                          DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(rb_datefrom - 365.25 * 4712 - 2 AS INTEGER)
                            DAY)) AS date,
                          CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                          'FK_REBUILDS' AS tabelle,
                          'Oracle' AS src,
                          CAST(NULL AS BIGINT) AS rowcount,
                          COUNT(*) AS rowcount_lastweek
                         FROM ldl_autodispo_core.t_oracle_v_fk_rebuilds_2
                         WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                             ,INTERVAL 7 DAY))
                         GROUP BY country_2,
                          date_load,
                          date)
                        UNION DISTINCT
                        SELECT country_2,
                         DATE(snflk_update_tmsp) AS date_load,
                         DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(sales_time_id - 365.25 * 4712 - 2 AS INTEGER)
                           DAY)) AS date,
                         CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                         'FK_SALES' AS tabelle,
                         'Oracle' AS src,
                         COUNT(*) AS rowcount,
                         CAST(NULL AS BIGINT) AS rowcount_lastweek
                        FROM ldl_autodispo_core.t_oracle_v_fk_sales_2
                        WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
                        GROUP BY country_2,
                         date_load,
                         date)
                       UNION DISTINCT
                       SELECT country_2,
                        DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                        DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(sales_time_id - 365.25 * 4712 - 2 AS INTEGER)
                          DAY)) AS date,
                        CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                        'FK_SALES' AS tabelle,
                        'Oracle' AS src,
                        CAST(NULL AS BIGINT) AS rowcount,
                        COUNT(*) AS rowcount_lastweek
                       FROM ldl_autodispo_core.t_oracle_v_fk_sales_2
                       WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                           ,INTERVAL 7 DAY))
                       GROUP BY country_2,
                        date_load,
                        date)
                      UNION DISTINCT
                      SELECT country_2,
                       DATE(snflk_update_tmsp) AS date_load,
                       DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(CAST(stock_time_id AS FLOAT64) - 365.25 *
                             4712 - 2 AS INTEGER) DAY)) AS date,
                       CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                       'FK_STOCK' AS tabelle,
                       'Oracle' AS src,
                       COUNT(*) AS rowcount,
                       CAST(NULL AS BIGINT) AS rowcount_lastweek
                      FROM ldl_autodispo_core.t_oracle_v_fk_stock_2
                      WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
                      GROUP BY country_2,
                       date_load,
                       date)
                     UNION DISTINCT
                     SELECT country_2,
                      DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                      DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(CAST(stock_time_id AS FLOAT64) - 365.25 *
                            4712 - 2 AS INTEGER) DAY)) AS date,
                      CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                      'FK_STOCK' AS tabelle,
                      'Oracle' AS src,
                      CAST(NULL AS BIGINT) AS rowcount,
                      COUNT(*) AS rowcount_lastweek
                     FROM ldl_autodispo_core.t_oracle_v_fk_stock_2
                     WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                         ,INTERVAL 7 DAY))
                     GROUP BY country_2,
                      date_load,
                      date)
                    UNION DISTINCT
                    SELECT country_2,
                     DATE(snflk_update_tmsp) AS date_load,
                     DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(fss_time_id - 365.25 * 4712 - 2 AS INTEGER)
                       DAY)) AS date,
                     CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                     'FK_STORE_STOCK' AS tabelle,
                     'Oracle' AS src,
                     COUNT(*) AS rowcount,
                     CAST(NULL AS BIGINT) AS rowcount_lastweek
                    FROM ldl_autodispo_core.t_oracle_v_fk_store_stock_2
                    WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
                    GROUP BY country_2,
                     date_load,
                     date)
                   UNION DISTINCT
                   SELECT country_2,
                    DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                    DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(fss_time_id - 365.25 * 4712 - 2 AS INTEGER)
                      DAY)) AS date,
                    CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                    'FK_STORE_STOCK' AS tabelle,
                    'Oracle' AS src,
                    CAST(NULL AS BIGINT) AS rowcount,
                    COUNT(*) AS rowcount_lastweek
                   FROM ldl_autodispo_core.t_oracle_v_fk_store_stock_2
                   WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                       ,INTERVAL 7 DAY))
                   GROUP BY country_2,
                    date_load,
                    date)
                  UNION DISTINCT
                  SELECT country_2,
                   DATE(snflk_update_tmsp) AS date_load,
                   DATE(snflk_update_tmsp) AS date,
                   CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                   'FK_STORE_TREND_NEW' AS tabelle,
                   'Oracle' AS src,
                   COUNT(*) AS rowcount,
                   CAST(NULL AS BIGINT) AS rowcount_lastweek
                  FROM ldl_autodispo_core.t_oracle_v_fk_store_trend_new_2
                  WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
                  GROUP BY country_2,
                   date_load,
                   date)
                 UNION DISTINCT
                 SELECT country_2,
                  DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                  DATE(snflk_update_tmsp) AS date,
                  CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                  'FK_STORE_TREND_NEW' AS tabelle,
                  'Oracle' AS src,
                  CAST(NULL AS BIGINT) AS rowcount,
                  COUNT(*) AS rowcount_lastweek
                 FROM ldl_autodispo_core.t_oracle_v_fk_store_trend_new_2
                 WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE
                     ,INTERVAL 7 DAY))
                 GROUP BY country_2,
                  date_load,
                  date)
                UNION DISTINCT
                SELECT country_2,
                 DATE(snflk_update_tmsp) AS date_load,
                 DATE(generation_date) AS date,
                 CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                 'FK_SUPPLIER_FINAL_ORDER' AS tabelle,
                 'Oracle' AS src,
                 COUNT(*) AS rowcount,
                 CAST(NULL AS BIGINT) AS rowcount_lastweek
                FROM ldl_autodispo_core.t_oracle_v_fk_supplier_final_order_2
                WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
                GROUP BY country_2,
                 date_load,
                 date)
               UNION DISTINCT
               SELECT country_2,
                DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
                DATE(generation_date) AS date,
                CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
                'FK_SUPPLIER_FINAL_ORDER' AS tabelle,
                'Oracle' AS src,
                CAST(NULL AS BIGINT) AS rowcount,
                COUNT(*) AS rowcount_lastweek
               FROM ldl_autodispo_core.t_oracle_v_fk_supplier_final_order_2
               WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE,
                   INTERVAL 7 DAY))
               GROUP BY country_2,
                date_load,
                date)
              UNION DISTINCT
              SELECT country_2,
               DATE(snflk_update_tmsp) AS date_load,
               order_sent_date AS date,
               CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
               'FK_SUPPLIER_ORDER' AS tabelle,
               'Oracle' AS src,
               COUNT(*) AS rowcount,
               CAST(NULL AS BIGINT) AS rowcount_lastweek
              FROM ldl_autodispo_core.t_oracle_v_fk_supplier_order_2
              WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
              GROUP BY country_2,
               date_load,
               date)
             UNION DISTINCT
             SELECT country_2,
              DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
              order_sent_date AS date,
              CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
              'FK_SUPPLIER_ORDER' AS tabelle,
              'Oracle' AS src,
              CAST(NULL AS BIGINT) AS rowcount,
              COUNT(*) AS rowcount_lastweek
             FROM ldl_autodispo_core.t_oracle_v_fk_supplier_order_2
             WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE,
                 INTERVAL 7 DAY))
             GROUP BY country_2,
              date_load,
              date)
            UNION DISTINCT
            SELECT country_2,
             DATE(snflk_update_tmsp) AS date_load,
             DATE(countingdate) AS date,
             CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
             'FK_TO_COUNT' AS tabelle,
             'Oracle' AS src,
             COUNT(*) AS rowcount,
             CAST(NULL AS BIGINT) AS rowcount_lastweek
            FROM ldl_autodispo_core.t_oracle_v_fk_to_count_2
            WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
            GROUP BY country_2,
             date_load,
             date)
           UNION DISTINCT
           SELECT country_2,
            DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
            DATE(countingdate) AS date,
            CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
            'FK_TO_COUNT' AS tabelle,
            'Oracle' AS src,
            CAST(NULL AS BIGINT) AS rowcount,
            COUNT(*) AS rowcount_lastweek
           FROM ldl_autodispo_core.t_oracle_v_fk_to_count_2
           WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE,
               INTERVAL 7 DAY))
           GROUP BY country_2,
            date_load,
            date)
          UNION DISTINCT
          SELECT country_2,
           DATE(snflk_update_tmsp) AS date_load,
           DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(CAST(wdel_time_id AS FLOAT64) - 365.25 * 4712 - 2 AS
              INTEGER) DAY)) AS date,
           CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
           'FK_WH_DELIVERY' AS tabelle,
           'Oracle' AS src,
           COUNT(*) AS rowcount,
           CAST(NULL AS BIGINT) AS rowcount_lastweek
          FROM ldl_autodispo_core.t_oracle_v_fk_wh_delivery_2
          WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
          GROUP BY country_2,
           date_load,
           date)
         UNION DISTINCT
         SELECT country_2,
          DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
          DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(CAST(wdel_time_id AS FLOAT64) - 365.25 * 4712 - 2 AS
             INTEGER) DAY)) AS date,
          CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
          'FK_WH_DELIVERY' AS tabelle,
          'Oracle' AS src,
          CAST(NULL AS BIGINT) AS rowcount,
          COUNT(*) AS rowcount_lastweek
         FROM ldl_autodispo_core.t_oracle_v_fk_wh_delivery_2
         WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE,
             INTERVAL 7 DAY))
         GROUP BY country_2,
          date_load,
          date)
        UNION DISTINCT
        SELECT country_2,
         DATE(snflk_update_tmsp) AS date_load,
         DATE(date_) AS date,
         CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
         'FINAL_RESULTS_REDUCED' AS tabelle,
         'HIVE' AS src,
         COUNT(*) AS rowcount,
         CAST(NULL AS BIGINT) AS rowcount_lastweek
        FROM ldl_autodispo_core.t_hive_final_results_reduced_2
        WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
        GROUP BY country_2,
         date_load,
         date)
       UNION DISTINCT
       SELECT country_2,
        DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
        DATE(date_) AS date,
        CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
        'FINAL_RESULTS_REDUCED' AS tabelle,
        'HIVE' AS src,
        CAST(NULL AS BIGINT) AS rowcount,
        COUNT(*) AS rowcount_lastweek
       FROM ldl_autodispo_core.t_hive_final_results_reduced_2
       WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL
           7 DAY))
       GROUP BY country_2,
        date_load,
        date)
      UNION DISTINCT
      SELECT country_2,
       DATE(snflk_update_tmsp) AS date_load,
       DATE(date_) AS date,
       CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
       'FORECAST_QUALITY_REDUCED' AS tabelle,
       'HIVE' AS src,
       COUNT(*) AS rowcount,
       CAST(NULL AS BIGINT) AS rowcount_lastweek
      FROM ldl_autodispo_core.t_hive_v_forecast_quality_reduced_2
      WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
      GROUP BY country_2,
       date_load,
       date)
     UNION DISTINCT
     SELECT country_2,
      DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
      DATE(date_) AS date,
      CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
      'FORECAST_QUALITY_REDUCED' AS tabelle,
      'HIVE' AS src,
      CAST(NULL AS BIGINT) AS rowcount,
      COUNT(*) AS rowcount_lastweek
     FROM ldl_autodispo_core.t_hive_v_forecast_quality_reduced_2
     WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 7
         DAY))
     GROUP BY country_2,
      date_load,
      date)
    UNION DISTINCT
    SELECT country_2,
     DATE(snflk_update_tmsp) AS date_load,
     DATE(date_) AS date,
     CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
     'INTERNAL_FORECAST' AS tabelle,
     'AI' AS src,
     COUNT(*) AS rowcount,
     CAST(NULL AS BIGINT) AS rowcount_lastweek
    FROM ldl_autodispo_core.t_internal_forecast_results_2
    WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND (CURRENT_DATE)
    GROUP BY country_2,
     date_load,
     date)
   UNION DISTINCT
   SELECT country_2,
    DATE_ADD(DATE(snflk_update_tmsp), INTERVAL 7 DAY) AS date_load,
    DATE(date_) AS date,
    CAST(MAX(snflk_update_tmsp) AS DATETIME) AS snflk_update_tmstp,
    'INTERNAL_FORECAST' AS tabelle,
    'AI' AS src,
    CAST(NULL AS BIGINT) AS rowcount,
    COUNT(*) AS rowcount_lastweek
   FROM ldl_autodispo_core.t_internal_forecast_results_2
   WHERE DATE(snflk_update_tmsp) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 7
       DAY))
   GROUP BY country_2,
    date_load,
    date) (SELECT b.country_2,
   b.cal_dt AS date_load,
   b.src,
   b.tabelle,
   b.threshold,
   t.date,
   MAX(t.snflk_update_tmstp) AS snflk_update_tmsp,
   SUM(t.rowcount) AS rowcount,
   SUM(t.rowcount_lastweek) AS rowcount_lastweek
  FROM BASE AS b
   LEFT JOIN DATEN AS t ON b.country_2 = t.country_2 AND b.cal_dt = t.date_load AND b.tabelle = t.tabelle AND b.src = t.src
  GROUP BY b.country_2,
   date_load,
   b.src,
   b.tabelle,
   b.threshold,
   t.date
  ORDER BY t.date DESC NULLS FIRST,
   b.tabelle NULLS LAST,
   b.country_2 NULLS LAST);