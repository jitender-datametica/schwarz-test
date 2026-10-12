CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_frontend_id40_wb AS SELECT WBV.mandant_id,
 SC.land_id,
 WBV.year_id,
 WBV.week_id,
 WBV.kjwo,
 WBV.aktion_id,
 SC.aktion_dat_von,
 SC.vk_aktion_brutto,
 SC.currency,
 SC.promo_stores,
 WBV.wup_id,
 REGEXP_REPLACE(SC.wup_name, 'Kaufland ', '') AS wup_name,
 SC.wup_cluster,
 COALESCE(CAST(SC.wup_region AS STRING), 'Missing') AS wup_region,
 WBV.sku_id,
 WBV.kl_art_id,
 SC.art_name AS sku_name,
 SC.hwg_bez,
 SC.owg_bez,
 SC.wg_bez,
 SC.wug_bez,
 SC.stock_initial,
 SC.sales_promo_week,
 SC.sell_ratio_promo_week,
 SC.sales_total,
 SC.sell_ratio_current,
 SC.remaining_stock,
 SC.current_discount,
 SC.current_week,
 SC.remaining_weeks,
 SC.md_price_opt AS src_md_price_opt,
 WBV.sap_transfer_date,
 WBV.previous_submitted_valid_from,
 WBV.submitted_date,
  SC.vk_aktion_brutto * SC.remaining_stock AS art_warenwert,
  CASE
  WHEN CAST(WBV.valid_from AS DATE) < DATE_ADD(SC.aktion_dat_von, INTERVAL CAST(PRMS.no_touch_time AS INTEGER) DAY)
     OR SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns >=
    PRMS.discount_count
  THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
  WHEN SC.md_price_opt >= ROUND(WBV.previous_submitted_price * (1 - PRMS.discount_steps / 100), 2) OR SC.md_price_opt
      IS NULL AND WBV.previous_submitted_price IS NOT NULL OR WBV.previous_submitted_price <= ROUND(SC.vk_aktion_brutto
       * (1 - PRMS.max_discount / 100), 2) OR WBV.previous_submitted_price >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount
           / 100), 2) AND SC.md_price_opt >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100), 2)
  THEN CAST(WBV.previous_submitted_price AS FLOAT64)
  WHEN SC.md_price_opt IS NULL OR SC.md_price_opt > SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
  THEN CAST(SC.vk_aktion_brutto AS FLOAT64)
  WHEN SC.md_price_opt <= SC.vk_aktion_brutto * (1 - CASE
        WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
        THEN PRMS.max_discount_for_max_price
        ELSE PRMS.max_discount
        END / 100)
  THEN CAST(SC.vk_aktion_brutto * (1 - CASE
        WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
        THEN PRMS.max_discount_for_max_price
        ELSE PRMS.max_discount
        END / 100) AS FLOAT64)
  ELSE SC.md_price_opt
  END AS helper_md_price,
  CASE
  WHEN SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns >=
    PRMS.discount_count
  THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
  WHEN WBV.last_manual_price IS NOT NULL AND WBV.last_manual_price <= COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto
     )
  THEN CAST(WBV.last_manual_price AS FLOAT64)
  ELSE CASE
   WHEN CAST(WBV.valid_from AS DATE) < DATE_ADD(SC.aktion_dat_von, INTERVAL CAST(PRMS.no_touch_time AS INTEGER) DAY)
      OR SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns >=
     PRMS.discount_count
   THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
   WHEN SC.md_price_opt >= ROUND(WBV.previous_submitted_price * (1 - PRMS.discount_steps / 100), 2) OR SC.md_price_opt
       IS NULL AND WBV.previous_submitted_price IS NOT NULL OR WBV.previous_submitted_price <= ROUND(SC.vk_aktion_brutto
         * (1 - PRMS.max_discount / 100), 2) OR WBV.previous_submitted_price >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount
            / 100), 2) AND SC.md_price_opt >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100), 2)
   THEN CAST(WBV.previous_submitted_price AS FLOAT64)
   WHEN SC.md_price_opt IS NULL OR SC.md_price_opt > SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
   THEN CAST(SC.vk_aktion_brutto AS FLOAT64)
   WHEN SC.md_price_opt <= SC.vk_aktion_brutto * (1 - CASE
         WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
         THEN PRMS.max_discount_for_max_price
         ELSE PRMS.max_discount
         END / 100)
   THEN CAST(SC.vk_aktion_brutto * (1 - CASE
         WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
         THEN PRMS.max_discount_for_max_price
         ELSE PRMS.max_discount
         END / 100) AS FLOAT64)
   ELSE SC.md_price_opt
   END
  END AS helper_manual_price,
  CASE
  WHEN SC.vk_aktion_brutto > 0
  THEN ROUND(1 - CASE
      WHEN CAST(WBV.valid_from AS DATE) < DATE_ADD(SC.aktion_dat_von, INTERVAL CAST(PRMS.no_touch_time AS INTEGER)
           DAY) OR SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns
         >= PRMS.discount_count
      THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
      WHEN SC.md_price_opt >= ROUND(WBV.previous_submitted_price * (1 - PRMS.discount_steps / 100), 2) OR SC.md_price_opt
          IS NULL AND WBV.previous_submitted_price IS NOT NULL OR WBV.previous_submitted_price <= ROUND(SC.vk_aktion_brutto
            * (1 - PRMS.max_discount / 100), 2) OR WBV.previous_submitted_price >= ROUND(SC.vk_aktion_brutto * (1 - PRMS
              .min_discount / 100), 2) AND SC.md_price_opt >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
          , 2)
      THEN CAST(WBV.previous_submitted_price AS FLOAT64)
      WHEN SC.md_price_opt IS NULL OR SC.md_price_opt > SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
      THEN CAST(SC.vk_aktion_brutto AS FLOAT64)
      WHEN SC.md_price_opt <= SC.vk_aktion_brutto * (1 - CASE
            WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
            THEN PRMS.max_discount_for_max_price
            ELSE PRMS.max_discount
            END / 100)
      THEN CAST(SC.vk_aktion_brutto * (1 - CASE
            WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
            THEN PRMS.max_discount_for_max_price
            ELSE PRMS.max_discount
            END / 100) AS FLOAT64)
      ELSE SC.md_price_opt
      END / SC.vk_aktion_brutto, 4)
  ELSE NULL
  END AS md_discount_opt,
 ROUND(CASE
   WHEN CAST(WBV.valid_from AS DATE) < DATE_ADD(SC.aktion_dat_von, INTERVAL CAST(PRMS.no_touch_time AS INTEGER) DAY)
      OR SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns >=
     PRMS.discount_count
   THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
   WHEN SC.md_price_opt >= ROUND(WBV.previous_submitted_price * (1 - PRMS.discount_steps / 100), 2) OR SC.md_price_opt
       IS NULL AND WBV.previous_submitted_price IS NOT NULL OR WBV.previous_submitted_price <= ROUND(SC.vk_aktion_brutto
         * (1 - PRMS.max_discount / 100), 2) OR WBV.previous_submitted_price >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount
            / 100), 2) AND SC.md_price_opt >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100), 2)
   THEN CAST(WBV.previous_submitted_price AS FLOAT64)
   WHEN SC.md_price_opt IS NULL OR SC.md_price_opt > SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
   THEN CAST(SC.vk_aktion_brutto AS FLOAT64)
   WHEN SC.md_price_opt <= SC.vk_aktion_brutto * (1 - CASE
         WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
         THEN PRMS.max_discount_for_max_price
         ELSE PRMS.max_discount
         END / 100)
   THEN CAST(SC.vk_aktion_brutto * (1 - CASE
         WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
         THEN PRMS.max_discount_for_max_price
         ELSE PRMS.max_discount
         END / 100) AS FLOAT64)
   ELSE SC.md_price_opt
   END, CASE
   WHEN SC.vk_aktion_brutto >= PRMS.price_ending_threshold AND SC.vk_aktion_brutto <> CAST(ROUND(CASE
        WHEN CAST(WBV.valid_from AS DATE) < DATE_ADD(SC.aktion_dat_von, INTERVAL CAST(PRMS.no_touch_time AS INTEGER)
             DAY) OR SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns
           >= PRMS.discount_count
        THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
        WHEN SC.md_price_opt >= ROUND(WBV.previous_submitted_price * (1 - PRMS.discount_steps / 100), 2) OR SC.md_price_opt
            IS NULL AND WBV.previous_submitted_price IS NOT NULL OR WBV.previous_submitted_price <= ROUND(SC.vk_aktion_brutto
              * (1 - PRMS.max_discount / 100), 2) OR WBV.previous_submitted_price >= ROUND(SC.vk_aktion_brutto * (1 -
                PRMS.min_discount / 100), 2) AND SC.md_price_opt >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount /
                100), 2)
        THEN CAST(WBV.previous_submitted_price AS FLOAT64)
        WHEN SC.md_price_opt IS NULL OR SC.md_price_opt > SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
        THEN CAST(SC.vk_aktion_brutto AS FLOAT64)
        WHEN SC.md_price_opt <= SC.vk_aktion_brutto * (1 - CASE
              WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
              THEN PRMS.max_discount_for_max_price
              ELSE PRMS.max_discount
              END / 100)
        THEN CAST(SC.vk_aktion_brutto * (1 - CASE
              WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
              THEN PRMS.max_discount_for_max_price
              ELSE PRMS.max_discount
              END / 100) AS FLOAT64)
        ELSE SC.md_price_opt
        END, 0) AS INTEGER)
   THEN 0
   ELSE 2
   END) AS md_price_opt,
 SC.md_confidence,
 SC.model_date,
 SC.model_id,
 SC.parameter_config,
 SC.cluster_config,
  CASE
  WHEN SC.vk_aktion_brutto > 0
  THEN ROUND(1 - CASE
      WHEN SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns
        >= PRMS.discount_count
      THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
      WHEN WBV.last_manual_price IS NOT NULL AND WBV.last_manual_price <= COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto
         )
      THEN CAST(WBV.last_manual_price AS FLOAT64)
      ELSE CASE
       WHEN CAST(WBV.valid_from AS DATE) < DATE_ADD(SC.aktion_dat_von, INTERVAL CAST(PRMS.no_touch_time AS INTEGER)
            DAY) OR SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns
          >= PRMS.discount_count
       THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
       WHEN SC.md_price_opt >= ROUND(WBV.previous_submitted_price * (1 - PRMS.discount_steps / 100), 2) OR SC.md_price_opt
           IS NULL AND WBV.previous_submitted_price IS NOT NULL OR WBV.previous_submitted_price <= ROUND(SC.vk_aktion_brutto
             * (1 - PRMS.max_discount / 100), 2) OR WBV.previous_submitted_price >= ROUND(SC.vk_aktion_brutto * (1 -
               PRMS.min_discount / 100), 2) AND SC.md_price_opt >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount /
               100), 2)
       THEN CAST(WBV.previous_submitted_price AS FLOAT64)
       WHEN SC.md_price_opt IS NULL OR SC.md_price_opt > SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
       THEN CAST(SC.vk_aktion_brutto AS FLOAT64)
       WHEN SC.md_price_opt <= SC.vk_aktion_brutto * (1 - CASE
             WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
             THEN PRMS.max_discount_for_max_price
             ELSE PRMS.max_discount
             END / 100)
       THEN CAST(SC.vk_aktion_brutto * (1 - CASE
             WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
             THEN PRMS.max_discount_for_max_price
             ELSE PRMS.max_discount
             END / 100) AS FLOAT64)
       ELSE SC.md_price_opt
       END
      END / SC.vk_aktion_brutto, 2)
  ELSE NULL
  END AS manual_markdown_percentage,
 ROUND(CASE
   WHEN SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns >=
     PRMS.discount_count
   THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
   WHEN WBV.last_manual_price IS NOT NULL AND WBV.last_manual_price <= COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto
      )
   THEN CAST(WBV.last_manual_price AS FLOAT64)
   ELSE CASE
    WHEN CAST(WBV.valid_from AS DATE) < DATE_ADD(SC.aktion_dat_von, INTERVAL CAST(PRMS.no_touch_time AS INTEGER) DAY)
         OR SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns
      >= PRMS.discount_count
    THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
    WHEN SC.md_price_opt >= ROUND(WBV.previous_submitted_price * (1 - PRMS.discount_steps / 100), 2) OR SC.md_price_opt
        IS NULL AND WBV.previous_submitted_price IS NOT NULL OR WBV.previous_submitted_price <= ROUND(SC.vk_aktion_brutto
          * (1 - PRMS.max_discount / 100), 2) OR WBV.previous_submitted_price >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount
             / 100), 2) AND SC.md_price_opt >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100), 2)
    THEN CAST(WBV.previous_submitted_price AS FLOAT64)
    WHEN SC.md_price_opt IS NULL OR SC.md_price_opt > SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
    THEN CAST(SC.vk_aktion_brutto AS FLOAT64)
    WHEN SC.md_price_opt <= SC.vk_aktion_brutto * (1 - CASE
          WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
          THEN PRMS.max_discount_for_max_price
          ELSE PRMS.max_discount
          END / 100)
    THEN CAST(SC.vk_aktion_brutto * (1 - CASE
          WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
          THEN PRMS.max_discount_for_max_price
          ELSE PRMS.max_discount
          END / 100) AS FLOAT64)
    ELSE SC.md_price_opt
    END
   END, CASE
   WHEN SC.vk_aktion_brutto >= PRMS.price_ending_threshold AND SC.vk_aktion_brutto > CAST(ROUND(CASE
        WHEN SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns >= PRMS.discount_count
        THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
        WHEN WBV.last_manual_price IS NOT NULL AND WBV.last_manual_price <= COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto
           )
        THEN CAST(WBV.last_manual_price AS FLOAT64)
        ELSE CASE
         WHEN CAST(WBV.valid_from AS DATE) < DATE_ADD(SC.aktion_dat_von, INTERVAL CAST(PRMS.no_touch_time AS INTEGER)
              DAY) OR SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns
            >= PRMS.discount_count
         THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
         WHEN SC.md_price_opt >= ROUND(WBV.previous_submitted_price * (1 - PRMS.discount_steps / 100), 2) OR SC.md_price_opt
             IS NULL AND WBV.previous_submitted_price IS NOT NULL OR WBV.previous_submitted_price <= ROUND(SC.vk_aktion_brutto
               * (1 - PRMS.max_discount / 100), 2) OR WBV.previous_submitted_price >= ROUND(SC.vk_aktion_brutto * (1 -
                 PRMS.min_discount / 100), 2) AND SC.md_price_opt >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount
                 / 100), 2)
         THEN CAST(WBV.previous_submitted_price AS FLOAT64)
         WHEN SC.md_price_opt IS NULL OR SC.md_price_opt > SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
         THEN CAST(SC.vk_aktion_brutto AS FLOAT64)
         WHEN SC.md_price_opt <= SC.vk_aktion_brutto * (1 - CASE
               WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
               THEN PRMS.max_discount_for_max_price
               ELSE PRMS.max_discount
               END / 100)
         THEN CAST(SC.vk_aktion_brutto * (1 - CASE
               WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
               THEN PRMS.max_discount_for_max_price
               ELSE PRMS.max_discount
               END / 100) AS FLOAT64)
         ELSE SC.md_price_opt
         END
        END, 0) AS INTEGER)
   THEN 0
   ELSE 2
   END) AS manual_markdown_price,
 WBV.valid_from,
 WBV.manual_comment,
 WBV.jf_submitted,
 WBV.id40_submitted_price,
 WBV.purchasing_price,
 WBV.rohertrag,
 WBV.previous_submitted_price,
 WBV.nb_of_markdowns AS nb_of_markdown,
 WBV.first_day_of_cw,
 WBV.promotion_week_x_weeks_ago,
 WBV.region,
 WBV.werbemutter,
 SC.wg_id AS warengruppe_id,
 SC.sales_last_week,
 SC.current_revenue,
 CAST(CURRENT_TIMESTAMP() AS DATETIME) AS model_run_time,
  CASE
  WHEN WBV.last_manual_price IS NULL
  THEN 'Model Recommendation'
  ELSE 'Manual Input'
  END AS manual_input_indicator,
  CASE
  WHEN CASE
    WHEN SC.vk_aktion_brutto > 0
    THEN ROUND(1 - CASE
        WHEN SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns
           >= PRMS.discount_count
        THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
        WHEN WBV.last_manual_price IS NOT NULL AND WBV.last_manual_price <= COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto
           )
        THEN CAST(WBV.last_manual_price AS FLOAT64)
        ELSE CASE
         WHEN CAST(WBV.valid_from AS DATE) < DATE_ADD(SC.aktion_dat_von, INTERVAL CAST(PRMS.no_touch_time AS INTEGER)
              DAY) OR SC.vk_aktion_brutto * SC.remaining_stock <= PRMS.min_value OR SC.remaining_stock = 0 OR WBV.nb_of_markdowns
            >= PRMS.discount_count
         THEN CAST(COALESCE(WBV.previous_submitted_price, SC.vk_aktion_brutto) AS FLOAT64)
         WHEN SC.md_price_opt >= ROUND(WBV.previous_submitted_price * (1 - PRMS.discount_steps / 100), 2) OR SC.md_price_opt
             IS NULL AND WBV.previous_submitted_price IS NOT NULL OR WBV.previous_submitted_price <= ROUND(SC.vk_aktion_brutto
               * (1 - PRMS.max_discount / 100), 2) OR WBV.previous_submitted_price >= ROUND(SC.vk_aktion_brutto * (1 -
                 PRMS.min_discount / 100), 2) AND SC.md_price_opt >= ROUND(SC.vk_aktion_brutto * (1 - PRMS.min_discount
                 / 100), 2)
         THEN CAST(WBV.previous_submitted_price AS FLOAT64)
         WHEN SC.md_price_opt IS NULL OR SC.md_price_opt > SC.vk_aktion_brutto * (1 - PRMS.min_discount / 100)
         THEN CAST(SC.vk_aktion_brutto AS FLOAT64)
         WHEN SC.md_price_opt <= SC.vk_aktion_brutto * (1 - CASE
               WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
               THEN PRMS.max_discount_for_max_price
               ELSE PRMS.max_discount
               END / 100)
         THEN CAST(SC.vk_aktion_brutto * (1 - CASE
               WHEN SC.vk_aktion_brutto >= PRMS.price_threshold_for_max_discount
               THEN PRMS.max_discount_for_max_price
               ELSE PRMS.max_discount
               END / 100) AS FLOAT64)
         ELSE SC.md_price_opt
         END
        END / SC.vk_aktion_brutto, 2)
    ELSE NULL
    END > 0
  THEN CAST(COUNT(SC.wup_id) OVER (PARTITION BY SC.land_id, SC.calendar_year, SC.calendar_week, SC.aktion_id, CAST(SC.art_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS INTEGER)
  ELSE 0
  END AS stores_with_discounts,
 WBV.last_manual_updated_date,
 WBV.article_cluster,
 PRMS.discount_ending
FROM kfl_nfmd_fe_mstr_nfmd.mv_latest_fe_wb AS WBV
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_hadoop_parameters AS PRMS ON WBV.mandant_id = PRMS.mandant_id
 INNER JOIN kfl_nfmd_core.src_hdp_frontend_screen_scorecard AS SC ON WBV.mandant_id = SC.mandant_id AND CAST(SC.calendar_year AS FLOAT64)
       = WBV.year_id AND CAST(SC.calendar_week AS FLOAT64) = WBV.week_id AND WBV.aktion_id = SC.aktion_id AND WBV.sku_id
     = SC.art_id AND WBV.wup_id = SC.wup_id
WHERE SC.wup_id IN (1360, 1430, 1480, 1493, 1500, 1530, 1580, 1600, 1633, 1863, 2160, 2170, 2370, 2440, 2590, 2640, 2700
   , 2900, 3040, 3080, 3280, 3470, 3520, 3560, 3690, 4200, 4250, 4350, 4370, 4410, 4550, 4620, 5050, 5380, 5590, 5620,
   6000, 6580, 8610);