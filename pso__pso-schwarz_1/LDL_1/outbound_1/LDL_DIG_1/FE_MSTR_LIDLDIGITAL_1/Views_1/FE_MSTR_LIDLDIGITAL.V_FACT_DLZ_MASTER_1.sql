
CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_dlz_master_1 AS WITH FACT_SPS_CTE AS (SELECT FACT_SPS.pack_sid,
   IFNULL(FACT_SPS.delivery_order_sid, - 1) AS delivery_order_sid,
   FACT_SPS.delivery_order_nr,
   IFNULL(FACT_SPS.wshop_cd, '-1') AS wshop_cd,
   FACT_SPS.dist_channel_cd,
   FACT_SPS.pack_tracking_nr,
   FACT_SPS.ewm_pack_nr,
   FACT_SPS.pack_tracking_url,
   FACT_SPS.pack_order_nr,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.pack_order_tgt_create_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
   AS pack_order_tgt_create_tmsp,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS pack_order_actual_create_tmsp,
   DATE(FACT_SPS.pack_order_actual_create_tmsp) AS pack_order_actual_create_date,
   TIME(FACT_SPS.pack_order_actual_create_tmsp) AS pack_order_actual_create_tm,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
      , 'Europe/Berlin')) AS DATETIME) AS pack_order_original_create_tmsp,
   DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
       , 'Europe/Berlin')) AS DATETIME)) AS pack_order_original_create_date,
   TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
       , 'Europe/Berlin')) AS DATETIME)) AS pack_order_original_create_tm,
   FACT_SPS.cust_delivery_tgt_dt,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS cust_delivery_tgt_hauler_tmsp,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS first_attempt_delivery_tmsp,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.cust_delivery_actual_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS cust_delivery_actual_tmsp,
   IFNULL(FACT_SPS.wh_sid, - 1) AS wh_sid,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.wh_leave_tgt_tmsp AS TIMESTAMP), 'Europe/Berlin'
      )) AS DATETIME) AS wh_leave_tgt_tmsp,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.wh_leave_actual_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS wh_leave_actual_tmsp,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.first_hub_scan_actual_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS first_hub_scan_actual_tmsp,
   NULL AS first_hub_scan_tgt_tmsp,
   FACT_SPS.is_damaged_fg,
    CASE
    WHEN FACT_SPS.pack_size_type_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_SPS.pack_size_type_cd, '-1')
    END AS pack_size_type_cd,
    CASE
    WHEN FACT_SPS.delivery_type_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_SPS.delivery_type_cd, '-1')
    END AS delivery_type_cd,
   IFNULL(FACT_SPS.delivery_addr_sid, - 1) AS delivery_addr_sid,
    CASE
    WHEN FACT_SPS.delivery_zip_short_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_SPS.delivery_zip_short_cd, '-1')
    END AS delivery_zip_short_cd,
   IFNULL(FACT_SPS.hauler_sid, - 1) AS hauler_sid,
   FACT_SPS.pack_height_meas,
   LEFT(CAST(FACT_SPS.pack_height_meas AS STRING) || ' ' || UOM_PACK_HEIGHT.uom_cd, 20) AS pack_height_str,
   IFNULL(UOM_PACK_HEIGHT.uom_standard_cd, '-1') AS pack_height_meas_standard_uom_cd,
   FACT_SPS.pack_width_meas,
   LEFT(CAST(FACT_SPS.pack_width_meas AS STRING) || ' ' || UOM_PACK_WIDTH.uom_cd, 20) AS pack_width_str,
   IFNULL(UOM_PACK_WIDTH.uom_standard_cd, '-1') AS pack_width_meas_standard_uom_cd,
   FACT_SPS.pack_length_meas,
   FACT_SPS.pack_longest_length_meas,
   LEFT(CAST(FACT_SPS.pack_length_meas AS STRING) || ' ' || UOM_PACK_LENGTH.uom_cd, 20) AS pack_length_str,
   LEFT(CAST(FACT_SPS.pack_longest_length_meas AS STRING) || ' ' || UOM_PACK_LENGTH.uom_cd, 20) AS
   pack_longest_length_str,
   IFNULL(UOM_PACK_LENGTH.uom_standard_cd, '-1') AS pack_length_meas_standard_uom_cd,
   FACT_SPS.pack_girth_west_meas,
   FACT_SPS.pack_girth_east_meas,
   LEFT(CAST(FACT_SPS.pack_girth_west_meas AS STRING) || ' ' || UOM_PACK_GIRTH.uom_cd, 20) AS pack_girth_west_str,
   LEFT(CAST(FACT_SPS.pack_girth_east_meas AS STRING) || ' ' || UOM_PACK_GIRTH.uom_cd, 20) AS pack_girth_east_str,
   FACT_SPS.pack_weight_meas,
   LEFT(CAST(FACT_SPS.pack_weight_meas AS STRING) || ' ' || UOM_PACK_WEIGHT.uom_cd, 20) AS pack_weight_str,
   IFNULL(UOM_PACK_WEIGHT.uom_standard_cd, '-1') AS pack_weight_meas_standard_uom_cd,
   FACT_SPS.pack_volume_meas,
   LEFT(CAST(FACT_SPS.pack_volume_meas AS STRING) || ' ' || UOM_PACK_VOLUME.uom_cd, 20) AS pack_volume_str,
   IFNULL(UOM_PACK_VOLUME.uom_standard_cd, '-1') AS pack_volume_meas_standard_uom_cd,
    CASE
    WHEN FACT_SPS.weight_class_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_SPS.weight_class_cd, '-1')
    END AS weight_class_cd,
    CASE
    WHEN FACT_SPS.volume_class_cd = ''
    THEN '-1'
    ELSE IFNULL(FACT_SPS.volume_class_cd, '-1')
    END AS volume_class_cd,
   FACT_SPS.pack_material_nr,
    CASE
    WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME),
      SECOND) <= 0
    THEN 'pünktlich'
    WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME),
      SECOND) > 0
    THEN 'zu spät'
    ELSE 'WA ausstehend'
    END AS warehouse_punctuality,
    CASE
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP))
        AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP))
        AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
       <= 0
    THEN 'pünktlich'
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP))
        AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP))
        AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
       > 0
    THEN 'zu spät'
    WHEN FACT_SPS.first_hub_scan_actual_tmsp IS NOT NULL AND FACT_SPS.first_attempt_delivery_tmsp IS NULL
    THEN 'Sendung offen'
    ELSE 'WE Scan ausstehend'
    END AS service_provider_punctuality,
    CASE
    WHEN DIST_CH.dist_country_cd = 'DE' AND TIME(FACT_SPS.first_hub_scan_actual_tmsp) <= '18:00:00' AND DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
          ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_hub_scan_actual_tmsp AS TIMESTAMP)
          ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.first_hub_scan_actual_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
        <= 1
    THEN 'pünktlich'
    WHEN DIST_CH.dist_country_cd = 'DE' AND TIME(FACT_SPS.first_hub_scan_actual_tmsp) > '18:00:00' AND DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
          ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_hub_scan_actual_tmsp AS TIMESTAMP)
          ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.first_hub_scan_actual_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
        <= 2
    THEN 'pünktlich'
    WHEN DIST_CH.dist_country_cd = 'DE' AND TIME(FACT_SPS.first_hub_scan_actual_tmsp) <= '18:00:00' AND DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
          ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_hub_scan_actual_tmsp AS TIMESTAMP)
          ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.first_hub_scan_actual_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
        > 1
    THEN 'zu spät'
    WHEN DIST_CH.dist_country_cd = 'DE' AND TIME(FACT_SPS.first_hub_scan_actual_tmsp) > '18:00:00' AND DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
          ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_hub_scan_actual_tmsp AS TIMESTAMP)
          ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.first_hub_scan_actual_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
        > 2
    THEN 'zu spät'
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP))
        AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP))
        AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
       <= 0
    THEN 'pünktlich'
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP))
        AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP))
        AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
       > 0
    THEN 'zu spät'
    WHEN FACT_SPS.first_hub_scan_actual_tmsp IS NOT NULL AND FACT_SPS.first_attempt_delivery_tmsp IS NULL
    THEN 'Sendung offen'
    ELSE 'WE Scan ausstehend'
    END AS service_provider_punctuality_legacy_de,
    CASE
    WHEN FACT_SPS.delivery_postponed_tgt_tmsp IS NOT NULL AND FACT_SPS.wshop_cd = 'DE' OR DATE_DIFF(CAST(FACT_SPS.first_attempt_delivery_tmsp AS DATE)
       ,FACT_SPS.cust_delivery_tgt_dt, DAY) <= 0
    THEN 'pünktlich'
    WHEN DATE_DIFF(CAST(FACT_SPS.first_attempt_delivery_tmsp AS DATE), FACT_SPS.cust_delivery_tgt_dt, DAY) > 0
    THEN 'zu spät'
    ELSE 'Zustellung nicht bestätigt'
    END AS customer_punctuality_shipment_level,
    CASE
    WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
           , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
           , 'Europe/Berlin')) AS DATETIME)) <= '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
          , 'Europe/Berlin')) AS DATETIME)) < DATE(FACT_SPS.wh_leave_tgt_tmsp)
    THEN 'pünktlich'
    WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
           , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
           , 'Europe/Berlin')) AS DATETIME)) > '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
          , 'Europe/Berlin')) AS DATETIME)) > DATE(FACT_SPS.wh_leave_tgt_tmsp)
    THEN 'zu spät'
    ELSE 'NA'
    END AS ewm_order_punctuality,
    CASE
    WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
      ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) <= 0
    THEN 'pünktlich'
    WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
      ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) > 0
    THEN 'zu spät'
    ELSE 'NA'
    END AS ewm_system_punctuality,
   DATE(FACT_SPS.wh_leave_tgt_tmsp) AS wh_leave_tgt_date,
   DATE(FACT_SPS.wh_leave_actual_tmsp) AS wh_leave_actual_date,
   DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp) AS cust_delivery_tgt_hauler_date,
   DATE(FACT_SPS.first_attempt_delivery_tmsp) AS first_attempt_delivery_date,
   DATE(FACT_SPS.cust_delivery_actual_tmsp) AS cust_delivery_actual_date,
    CASE
    WHEN CASE
      WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME)
        ,SECOND) <= 0
      THEN 'pünktlich'
      WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME)
        ,SECOND) > 0
      THEN 'zu spät'
      ELSE 'WA ausstehend'
      END = 'zu spät'
    THEN (DATETIME_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME),
        SECOND) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(FACT_SPS.wshop_cd, DATE(FACT_SPS.wh_leave_tgt_tmsp), DATE(FACT_SPS.wh_leave_actual_tmsp)) AS FLOAT64)
        * 86400) / 3600
    WHEN CASE
      WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME)
        ,SECOND) <= 0
      THEN 'pünktlich'
      WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME)
        ,SECOND) > 0
      THEN 'zu spät'
      ELSE 'WA ausstehend'
      END = 'pünktlich'
    THEN 0
    ELSE NULL
    END AS warehouse_delay_in_hours,
   CEIL(CASE
      WHEN CASE
        WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME)
          ,SECOND) <= 0
        THEN 'pünktlich'
        WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME)
          ,SECOND) > 0
        THEN 'zu spät'
        ELSE 'WA ausstehend'
        END = 'zu spät'
      THEN (DATETIME_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME)
          ,SECOND) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(FACT_SPS.wshop_cd, DATE(FACT_SPS.wh_leave_tgt_tmsp), DATE(FACT_SPS.wh_leave_actual_tmsp)) AS FLOAT64)
          * 86400) / 3600
      WHEN CASE
        WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME)
          ,SECOND) <= 0
        THEN 'pünktlich'
        WHEN TIMESTAMP_DIFF(CAST(FACT_SPS.wh_leave_actual_tmsp AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME)
          ,SECOND) > 0
        THEN 'zu spät'
        ELSE 'WA ausstehend'
        END = 'pünktlich'
      THEN 0
      ELSE NULL
      END / 24) AS warehouse_delay_in_days,
    CASE
    WHEN CASE
      WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
           ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP)
           ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
         <= 0
      THEN 'pünktlich'
      WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
           ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP)
           ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
         > 0
      THEN 'zu spät'
      WHEN FACT_SPS.first_hub_scan_actual_tmsp IS NOT NULL AND FACT_SPS.first_attempt_delivery_tmsp IS NULL
      THEN 'Sendung offen'
      ELSE 'WE Scan ausstehend'
      END = 'zu spät'
    THEN (DATETIME_DIFF(CAST(FACT_SPS.first_attempt_delivery_tmsp AS DATETIME), CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS DATETIME)
        ,SECOND) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
        * 86400) / 3600
    WHEN CASE
      WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
           ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP)
           ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
         <= 0
      THEN 'pünktlich'
      WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
           ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP)
           ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
         > 0
      THEN 'zu spät'
      WHEN FACT_SPS.first_hub_scan_actual_tmsp IS NOT NULL AND FACT_SPS.first_attempt_delivery_tmsp IS NULL
      THEN 'Sendung offen'
      ELSE 'WE Scan ausstehend'
      END = 'pünktlich'
    THEN 0
    ELSE NULL
    END AS service_provider_delay_in_hours,
   CEIL(CASE
      WHEN CASE
        WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
             ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP)
             ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
           <= 0
        THEN 'pünktlich'
        WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
             ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP)
             ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
           > 0
        THEN 'zu spät'
        WHEN FACT_SPS.first_hub_scan_actual_tmsp IS NOT NULL AND FACT_SPS.first_attempt_delivery_tmsp IS NULL
        THEN 'Sendung offen'
        ELSE 'WE Scan ausstehend'
        END = 'zu spät'
      THEN (DATETIME_DIFF(CAST(FACT_SPS.first_attempt_delivery_tmsp AS DATETIME), CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS DATETIME)
          ,SECOND) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
          * 86400) / 3600
      WHEN CASE
        WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
             ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP)
             ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
           <= 0
        THEN 'pünktlich'
        WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.first_attempt_delivery_tmsp AS TIMESTAMP)
             ) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(FACT_SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP)
             ) AS DATETIME), DAY) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(DIST_CH.dist_country_cd, DATE(FACT_SPS.cust_delivery_tgt_hauler_tmsp), DATE(FACT_SPS.first_attempt_delivery_tmsp)) AS FLOAT64)
           > 0
        THEN 'zu spät'
        WHEN FACT_SPS.first_hub_scan_actual_tmsp IS NOT NULL AND FACT_SPS.first_attempt_delivery_tmsp IS NULL
        THEN 'Sendung offen'
        ELSE 'WE Scan ausstehend'
        END = 'pünktlich'
      THEN 0
      ELSE NULL
      END / 24) AS service_provider_delay_in_days,
    CASE
    WHEN CASE
      WHEN FACT_SPS.delivery_postponed_tgt_tmsp IS NOT NULL AND FACT_SPS.wshop_cd = 'DE' OR DATE_DIFF(CAST(FACT_SPS.first_attempt_delivery_tmsp AS DATE)
         ,FACT_SPS.cust_delivery_tgt_dt, DAY) <= 0
      THEN 'pünktlich'
      WHEN DATE_DIFF(CAST(FACT_SPS.first_attempt_delivery_tmsp AS DATE), FACT_SPS.cust_delivery_tgt_dt, DAY) > 0
      THEN 'zu spät'
      ELSE 'Zustellung nicht bestätigt'
      END = 'zu spät'
    THEN DATE_DIFF(CAST(FACT_SPS.first_attempt_delivery_tmsp AS DATE), FACT_SPS.cust_delivery_tgt_dt, DAY)
    WHEN CASE
      WHEN FACT_SPS.delivery_postponed_tgt_tmsp IS NOT NULL AND FACT_SPS.wshop_cd = 'DE' OR DATE_DIFF(CAST(FACT_SPS.first_attempt_delivery_tmsp AS DATE)
         ,FACT_SPS.cust_delivery_tgt_dt, DAY) <= 0
      THEN 'pünktlich'
      WHEN DATE_DIFF(CAST(FACT_SPS.first_attempt_delivery_tmsp AS DATE), FACT_SPS.cust_delivery_tgt_dt, DAY) > 0
      THEN 'zu spät'
      ELSE 'Zustellung nicht bestätigt'
      END = 'pünktlich'
    THEN 0
    ELSE NULL
    END AS customer_shipment_level_delay_in_days,
    CASE
    WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
          , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
          , 'Europe/Berlin')) AS DATETIME)) > '02:00:00'
    THEN 0
    WHEN CASE
      WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME)) <= '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
            , 'Europe/Berlin')) AS DATETIME)) < DATE(FACT_SPS.wh_leave_tgt_tmsp)
      THEN 'pünktlich'
      WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME)) > '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
            , 'Europe/Berlin')) AS DATETIME)) > DATE(FACT_SPS.wh_leave_tgt_tmsp)
      THEN 'zu spät'
      ELSE 'NA'
      END = 'zu spät'
    THEN (DATETIME_DIFF(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
           , 'Europe/Berlin')) AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME), SECOND) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(FACT_SPS.wshop_cd, DATE(FACT_SPS.wh_leave_tgt_tmsp), DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS
                .pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP), 'Europe/Berlin'))
            AS DATETIME))) AS FLOAT64) * 86400) / 3600
    WHEN CASE
      WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME)) <= '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
            , 'Europe/Berlin')) AS DATETIME)) < DATE(FACT_SPS.wh_leave_tgt_tmsp)
      THEN 'pünktlich'
      WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME)) > '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
            , 'Europe/Berlin')) AS DATETIME)) > DATE(FACT_SPS.wh_leave_tgt_tmsp)
      THEN 'zu spät'
      ELSE 'NA'
      END = 'pünktlich'
    THEN 0
    ELSE NULL
    END AS ewm_order_delay_in_hours,
   CEIL(CASE
      WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
            , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
            , 'Europe/Berlin')) AS DATETIME)) > '02:00:00'
      THEN 0
      WHEN CASE
        WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
               , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
               , 'Europe/Berlin')) AS DATETIME)) <= '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
              , 'Europe/Berlin')) AS DATETIME)) < DATE(FACT_SPS.wh_leave_tgt_tmsp)
        THEN 'pünktlich'
        WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
               , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
               , 'Europe/Berlin')) AS DATETIME)) > '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
              , 'Europe/Berlin')) AS DATETIME)) > DATE(FACT_SPS.wh_leave_tgt_tmsp)
        THEN 'zu spät'
        ELSE 'NA'
        END = 'zu spät'
      THEN (DATETIME_DIFF(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME), CAST(FACT_SPS.wh_leave_tgt_tmsp AS DATETIME), SECOND) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(FACT_SPS.wshop_cd, DATE(FACT_SPS.wh_leave_tgt_tmsp), DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS
                  .pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP), 'Europe/Berlin')
               ) AS DATETIME))) AS FLOAT64) * 86400) / 3600
      WHEN CASE
        WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
               , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
               , 'Europe/Berlin')) AS DATETIME)) <= '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
              , 'Europe/Berlin')) AS DATETIME)) < DATE(FACT_SPS.wh_leave_tgt_tmsp)
        THEN 'pünktlich'
        WHEN DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
               , 'Europe/Berlin')) AS DATETIME)) = DATE(FACT_SPS.wh_leave_tgt_tmsp) AND TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
               , 'Europe/Berlin')) AS DATETIME)) > '02:00:00' OR DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
              , 'Europe/Berlin')) AS DATETIME)) > DATE(FACT_SPS.wh_leave_tgt_tmsp)
        THEN 'zu spät'
        ELSE 'NA'
        END = 'pünktlich'
      THEN 0
      ELSE NULL
      END / 24) AS ewm_order_delay_in_days,
    CASE
    WHEN CASE
      WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
        ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) <= 0
      THEN 'pünktlich'
      WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
        ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) > 0
      THEN 'zu spät'
      ELSE 'NA'
      END = 'zu spät'
    THEN (DATETIME_DIFF(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
           , 'Europe/Berlin')) AS DATETIME), CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(FACT_SPS.wshop_cd, DATE(FACT_SPS.pack_order_tgt_create_tmsp), DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z',
              CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
              , 'Europe/Berlin')) AS DATETIME))) AS FLOAT64) * 86400) / 3600
    WHEN CASE
      WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
        ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) <= 0
      THEN 'pünktlich'
      WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
        ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) > 0
      THEN 'zu spät'
      ELSE 'NA'
      END = 'pünktlich'
    THEN 0
    ELSE NULL
    END AS ewm_system_delay_in_hours,
   CEIL(CASE
      WHEN CASE
        WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
          ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) <= 0
        THEN 'pünktlich'
        WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
          ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) > 0
        THEN 'zu spät'
        ELSE 'NA'
        END = 'zu spät'
      THEN (DATETIME_DIFF(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
             , 'Europe/Berlin')) AS DATETIME), CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(FACT_SPS.wshop_cd, DATE(FACT_SPS.pack_order_tgt_create_tmsp), DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z'
                , CAST(COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp) AS TIMESTAMP)
                , 'Europe/Berlin')) AS DATETIME))) AS FLOAT64) * 86400) / 3600
      WHEN CASE
        WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
          ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) <= 0
        THEN 'pünktlich'
        WHEN TIMESTAMP_DIFF(CAST(DATETIME( COALESCE(FACT_SPS.pack_order_orig_create_tmsp, FACT_SPS.pack_order_actual_create_tmsp),'Europe/Berlin') AS DATETIME)
          ,CAST(FACT_SPS.pack_order_tgt_create_tmsp AS DATETIME), SECOND) > 0
        THEN 'zu spät'
        ELSE 'NA'
        END = 'pünktlich'
      THEN 0
      ELSE NULL
      END / 24) AS ewm_system_delay_in_days,
   FACT_SPS.vehicle_internal_nr,
   FACT_SPS.vehicle_license_plate_nr,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.vehicle_departure_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS vehicle_departure_tmsp,
   DATE(FACT_SPS.vehicle_departure_tmsp) AS vehicle_departure_dt,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.vehicle_loading_start_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS vehicle_loading_start_tmsp,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.vehicle_loading_end_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS vehicle_loading_end_tmsp,
   MIN(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_SPS.first_hub_scan_actual_tmsp AS TIMESTAMP),
       'Europe/Berlin')) AS DATETIME)) OVER (PARTITION BY FACT_SPS.vehicle_license_plate_nr, FACT_SPS.vehicle_departure_tmsp
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS truck_unloading_start_at_hub_tmsp,
   ROUND(CAST(IF(TRUNC((PERCENT_RANK() OVER (PARTITION BY FACT_SPS.vehicle_license_plate_nr, FACT_SPS.vehicle_departure_tmsp ORDER BY FACT_SPS.first_hub_scan_actual_tmsp)) * 100) < 95, 0, TRUNC((PERCENT_RANK() OVER (PARTITION BY FACT_SPS.vehicle_license_plate_nr, FACT_SPS.vehicle_departure_tmsp
          ORDER BY FACT_SPS.first_hub_scan_actual_tmsp)) * 100)) AS BIGNUMERIC), 0) AS
   truck_unloading_stop_at_hub_tmsp_percentrank_selected_group,
   FACT_SPS.is_ghost_pack_fg,
   FACT_SPS.is_ghost_pack_return_fg,
   FACT_SPS.pack_return_tmsp,
   FACT_SPS.ghost_pack_return_duration_days_cnt,
   FACT_SPS.first_hub_loc_descr,
   FACT_SPS.second_hub_loc_descr
  FROM ldl_dig_lec_share.v_fact_sales_package_shipment_1 AS FACT_SPS
   INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_cal_day_1 AS CALDAY ON FACT_SPS.cust_delivery_tgt_dt = CALDAY.cal_dt
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_HEIGHT ON UOM_PACK_HEIGHT.uom_sid =
    IFNULL(FACT_SPS.pack_height_uom_sid, -1)
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_WIDTH ON UOM_PACK_WIDTH.uom_sid = IFNULL(FACT_SPS
     .pack_width_uom_sid, -1)
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_LENGTH ON UOM_PACK_LENGTH.uom_sid =
    IFNULL(FACT_SPS.pack_length_uom_sid, -1)
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_GIRTH ON UOM_PACK_GIRTH.uom_sid = IFNULL(FACT_SPS
     .pack_girth_uom_sid, -1)
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_WEIGHT ON UOM_PACK_WEIGHT.uom_sid =
    IFNULL(FACT_SPS.pack_weight_uom_sid, -1)
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_VOLUME ON UOM_PACK_VOLUME.uom_sid =
    IFNULL(FACT_SPS.pack_volume_uom_sid, -1)
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_distribution_channel_1 AS DIST_CH ON FACT_SPS.dist_channel_cd = DIST_CH.dist_channel_cd
    
  WHERE CALDAY.cy_week_offset >= - 13), FACT_COL AS (SELECT COL_FACT.cust_order_sid,
   COL_FACT.cust_order_pos_nr,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(COL_FACT.cust_order_create_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS cust_order_create_tmsp,
   COL_FACT.cust_order_dt,
   IFNULL(COL_FACT.cust_order_nr, '-1') AS cust_order_nr,
   IFNULL(COL_FACT.cust_order_type_cd, '-1') AS cust_order_type_cd,
   IFNULL(COL_FACT.cust_paym_method_cd, '-1') AS cust_paym_method_cd,
   COL_FACT.wh_sid,
   COL_FACT.wh_cd,
   COL_FACT.wshop_cd,
   COL_FACT.delivery_addr_sid
  FROM ldl_dig_lec_share.v_fact_customer_order_line_1 AS COL_FACT
   INNER JOIN ldl_dig_lec_share.v_dim_cal_day_1 AS CAL_DIM ON COL_FACT.cust_order_dt = CAL_DIM.cal_dt
  WHERE CAL_DIM.bus_year_offset IN (0, -1, -2)), FACT_ICOL AS (SELECT ICOL_FACT.ic_order_sid,
   ICOL_FACT.ic_order_pos_nr,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(ICOL_FACT.ic_order_create_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS ic_order_create_tmsp,
   ICOL_FACT.dist_channel_cd,
   ICOL_FACT.wh_sid,
   ICOL_FACT.wh_cd,
   ICOL_FACT.ic_order_dt,
   ICOL_FACT.ic_order_nr,
   ICOL_FACT.delivery_addr_sid,
   ICOL_FACT.cust_order_type_cd
  FROM ldl_dig_lec_share.v_fact_intercompany_order_line_1 AS ICOL_FACT
   INNER JOIN ldl_dig_lec_share.v_dim_cal_day_1 AS CAL_DIM0 ON ICOL_FACT.ic_order_dt = CAL_DIM0.cal_dt
  WHERE CAL_DIM0.bus_year_offset IN (0, -1, -2)) (SELECT IFNULL(REL_OP.pack_sid, -1) AS pack_sid,
   IFNULL(REL_OP.pack_pos_nr, '-1') AS pack_pos_nr,
   COALESCE(REL_OP.delivery_order_sid, FACT_SPS.delivery_order_sid) AS delivery_order_sid,
   IFNULL(REL_OP.delivery_order_pos_nr, - 1) AS delivery_order_pos_nr,
   IFNULL(REL_OP.prod_variant_sid, -1) AS prod_variant_sid,
   CAST(COALESCE(REL_OP.delivery_order_nr, FACT_SPS.delivery_order_nr) AS STRING) AS delivery_order_nr,
   IFNULL(REL_OP.cust_order_sid, -1) AS cust_order_sid,
   IFNULL(REL_OP.cust_order_pos_nr, -1) AS cust_order_pos_nr,
   IFNULL(REL_OP.ic_order_sid, -1) AS ic_order_sid,
   IFNULL(REL_OP.ic_order_pos_nr, -1) AS ic_order_pos_nr,
   REL_OP.delivery_to_point_of_use_fg,
   REL_OP.delivery_pick_up_for_recycling_fg,
   REL_OP.delivery_label_for_recycling_fg,
   REL_OP.deliv_prod_qty,
   REL_OP.deliv_prod_price,
   REL_OP.deliv_prod_val,
   COALESCE(FACT_SPS.wshop_cd, t5.wshop_cd, '-1') AS wshop_cd,
   FACT_SPS.dist_channel_cd,
   FACT_SPS.pack_tracking_nr,
   FACT_SPS.ewm_pack_nr,
   FACT_SPS.pack_tracking_url,
   FACT_SPS.pack_order_nr,
   FACT_SPS.pack_order_tgt_create_tmsp,
   FACT_SPS.pack_order_actual_create_tmsp,
   FACT_SPS.pack_order_actual_create_date,
   FACT_SPS.pack_order_actual_create_tm,
   FACT_SPS.pack_order_original_create_tmsp,
   FACT_SPS.pack_order_original_create_date,
   FACT_SPS.pack_order_original_create_tm,
   FACT_SPS.cust_delivery_tgt_dt,
   FACT_SPS.cust_delivery_tgt_hauler_tmsp,
   FACT_SPS.first_attempt_delivery_tmsp,
   FACT_SPS.cust_delivery_actual_tmsp,
   COALESCE(FACT_SPS.wh_sid, t5.wh_sid, t8.wh_sid) AS wh_sid,
   FACT_SPS.wh_leave_tgt_tmsp,
   FACT_SPS.wh_leave_actual_tmsp,
   FACT_SPS.first_hub_scan_actual_tmsp,
   FACT_SPS.first_hub_scan_tgt_tmsp,
   FACT_SPS.is_damaged_fg,
   IFNULL(FACT_SPS.pack_size_type_cd, '-1') AS pack_size_type_cd,
   IFNULL(FACT_SPS.delivery_type_cd, '-1') AS delivery_type_cd,
   COALESCE(FACT_SPS.delivery_addr_sid, t5.delivery_addr_sid, t8.delivery_addr_sid) AS delivery_addr_sid,
   IFNULL(FACT_SPS.delivery_zip_short_cd, '-1') AS delivery_zip_short_cd,
   IFNULL(FACT_SPS.hauler_sid, -1) AS hauler_sid,
   FACT_SPS.pack_height_meas,
   FACT_SPS.pack_height_str,
   IFNULL(FACT_SPS.pack_height_meas_standard_uom_cd, '-1') AS pack_height_meas_standard_uom_cd,
   FACT_SPS.pack_width_meas,
   FACT_SPS.pack_width_str,
   IFNULL(FACT_SPS.pack_width_meas_standard_uom_cd, '-1') AS pack_width_meas_standard_uom_cd,
   FACT_SPS.pack_length_meas,
   FACT_SPS.pack_longest_length_meas,
   FACT_SPS.pack_length_str,
   FACT_SPS.pack_longest_length_str,
   IFNULL(FACT_SPS.pack_length_meas_standard_uom_cd, '-1') AS pack_length_meas_standard_uom_cd,
   FACT_SPS.pack_girth_west_meas,
   FACT_SPS.pack_girth_east_meas,
   FACT_SPS.pack_girth_west_str,
   FACT_SPS.pack_girth_east_str,
   FACT_SPS.pack_weight_meas,
   FACT_SPS.pack_weight_str,
   IFNULL(FACT_SPS.pack_weight_meas_standard_uom_cd, '-1') AS pack_weight_meas_standard_uom_cd,
   IF(DIM_HAU.hauler_name = 'PL_DPD', FACT_SPS.pack_length_meas * FACT_SPS.pack_width_meas * FACT_SPS.pack_height_meas /
     0.006, NULL) AS pack_volumetric_weight_gross,
   FACT_SPS.pack_volume_meas,
   FACT_SPS.pack_volume_str,
   IFNULL(FACT_SPS.pack_volume_meas_standard_uom_cd, '-1') AS pack_volume_meas_standard_uom_cd,
   IFNULL(FACT_SPS.weight_class_cd, '-1') AS weight_class_cd,
   IFNULL(FACT_SPS.volume_class_cd, '-1') AS volume_class_cd,
   IFNULL(FACT_SPS.pack_material_nr, '-1') AS pack_material_nr,
   FACT_SPS.warehouse_punctuality,
   FACT_SPS.service_provider_punctuality,
   FACT_SPS.service_provider_punctuality_legacy_de,
   FACT_SPS.customer_punctuality_shipment_level,
   FACT_SPS.ewm_order_punctuality,
   FACT_SPS.ewm_system_punctuality,
   FACT_SPS.wh_leave_tgt_date,
   FACT_SPS.wh_leave_actual_date,
   FACT_SPS.cust_delivery_tgt_hauler_date,
   FACT_SPS.first_attempt_delivery_date,
   FACT_SPS.cust_delivery_actual_date,
   FACT_SPS.warehouse_delay_in_hours,
   FACT_SPS.warehouse_delay_in_days,
   FACT_SPS.service_provider_delay_in_hours,
   FACT_SPS.service_provider_delay_in_days,
   FACT_SPS.customer_shipment_level_delay_in_days,
   FACT_SPS.ewm_order_delay_in_hours,
   FACT_SPS.ewm_order_delay_in_days,
   FACT_SPS.ewm_system_delay_in_hours,
   FACT_SPS.ewm_system_delay_in_days,
   t5.cust_order_create_tmsp,
   t5.cust_order_dt,
   COALESCE(t5.cust_order_nr, '-1') AS cust_order_nr,
   t8.ic_order_create_tmsp,
   t8.ic_order_dt,
   t8.ic_order_nr,
   COALESCE(t5.cust_paym_method_cd, '-1') AS cust_paym_method_cd,
   COALESCE(t5.cust_order_type_cd, t8.cust_order_type_cd, '-1') AS cust_order_type_cd,
   COALESCE(t5.wh_cd, t8.wh_cd, '-1') AS wh_cd,
   FACT_GM.stock_placement_cd,
   FACT_GM.stock_removal_cd,
   DATE(FACT_SPS.first_hub_scan_actual_tmsp) AS first_hub_scan_actual_date,
   FACT_SPS.vehicle_internal_nr,
   FACT_SPS.vehicle_license_plate_nr,
   FACT_SPS.vehicle_departure_tmsp,
   FACT_SPS.vehicle_departure_dt,
   FACT_SPS.vehicle_loading_start_tmsp,
   FACT_SPS.vehicle_loading_end_tmsp,
   FACT_SPS.truck_unloading_start_at_hub_tmsp,
   FACT_SPS.truck_unloading_stop_at_hub_tmsp,
   FACT_SPS.duration_of_unloading_at_hub_in_h,
   FACT_SPS.truck_unloading_stop_at_hub_tmsp_percentrank_selected_group,
   FACT_SPS.is_ghost_pack_fg,
   FACT_SPS.is_ghost_pack_return_fg,
   FACT_SPS.pack_return_tmsp,
   FACT_SPS.ghost_pack_return_duration_days_cnt,
   FACT_SPS.first_hub_loc_descr,
   FACT_SPS.second_hub_loc_descr
  FROM ldl_dig_fe_mstr_lidldigital.v_rel_order_packaging_1 AS REL_OP
   LEFT JOIN (SELECT pack_sid,
     delivery_order_sid,
     delivery_order_nr,
     wshop_cd,
     dist_channel_cd,
     pack_tracking_nr,
     ewm_pack_nr,
     pack_tracking_url,
     pack_order_nr,
     pack_order_tgt_create_tmsp,
     pack_order_actual_create_tmsp,
     pack_order_actual_create_date,
     pack_order_actual_create_tm,
     pack_order_original_create_tmsp,
     pack_order_original_create_date,
     pack_order_original_create_tm,
     cust_delivery_tgt_dt,
     cust_delivery_tgt_hauler_tmsp,
     first_attempt_delivery_tmsp,
     cust_delivery_actual_tmsp,
     wh_sid,
     wh_leave_tgt_tmsp,
     wh_leave_actual_tmsp,
     first_hub_scan_actual_tmsp,
     first_hub_scan_tgt_tmsp,
     is_damaged_fg,
     pack_size_type_cd,
     delivery_type_cd,
     delivery_addr_sid,
     delivery_zip_short_cd,
     hauler_sid,
     pack_height_meas,
     pack_height_str,
     pack_height_meas_standard_uom_cd,
     pack_width_meas,
     pack_width_str,
     pack_width_meas_standard_uom_cd,
     pack_length_meas,
     pack_longest_length_meas,
     pack_length_str,
     pack_longest_length_str,
     pack_length_meas_standard_uom_cd,
     pack_girth_west_meas,
     pack_girth_east_meas,
     pack_girth_west_str,
     pack_girth_east_str,
     pack_weight_meas,
     pack_weight_str,
     pack_weight_meas_standard_uom_cd,
     pack_volume_meas,
     pack_volume_str,
     pack_volume_meas_standard_uom_cd,
     weight_class_cd,
     volume_class_cd,
     pack_material_nr,
     warehouse_punctuality,
     service_provider_punctuality,
     service_provider_punctuality_legacy_de,
     customer_punctuality_shipment_level,
     ewm_order_punctuality,
     ewm_system_punctuality,
     wh_leave_tgt_date,
     wh_leave_actual_date,
     cust_delivery_tgt_hauler_date,
     first_attempt_delivery_date,
     cust_delivery_actual_date,
     warehouse_delay_in_hours,
     warehouse_delay_in_days,
     service_provider_delay_in_hours,
     service_provider_delay_in_days,
     customer_shipment_level_delay_in_days,
     ewm_order_delay_in_hours,
     ewm_order_delay_in_days,
     ewm_system_delay_in_hours,
     ewm_system_delay_in_days,
     vehicle_internal_nr,
     vehicle_license_plate_nr,
     vehicle_departure_tmsp,
     vehicle_departure_dt,
     vehicle_loading_start_tmsp,
     vehicle_loading_end_tmsp,
     truck_unloading_start_at_hub_tmsp,
     truck_unloading_stop_at_hub_tmsp_percentrank_selected_group,
     is_ghost_pack_fg,
     is_ghost_pack_return_fg,
     pack_return_tmsp,
     ghost_pack_return_duration_days_cnt,
     first_hub_loc_descr,
     second_hub_loc_descr,
     MIN(first_hub_scan_actual_tmsp) OVER (PARTITION BY vehicle_license_plate_nr, vehicle_departure_tmsp, CAST(truck_unloading_stop_at_hub_tmsp_percentrank_selected_group AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS truck_unloading_stop_at_hub_tmsp,
      DATETIME_DIFF((MIN(first_hub_scan_actual_tmsp) OVER (PARTITION BY vehicle_license_plate_nr, vehicle_departure_tmsp
           , CAST(truck_unloading_stop_at_hub_tmsp_percentrank_selected_group AS STRING) RANGE BETWEEN
         UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), truck_unloading_start_at_hub_tmsp, SECOND) / 3600 AS
     duration_of_unloading_at_hub_in_h
    FROM FACT_SPS_CTE AS t1_1) AS FACT_SPS ON REL_OP.pack_sid = FACT_SPS.pack_sid
   LEFT JOIN FACT_COL AS t5 ON REL_OP.cust_order_sid = t5.cust_order_sid AND REL_OP.cust_order_pos_nr = t5.cust_order_pos_nr
     
   LEFT JOIN FACT_ICOL AS t8 ON REL_OP.ic_order_sid = t8.ic_order_sid AND REL_OP.ic_order_pos_nr = t8.ic_order_pos_nr
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_fact_goods_movement_1 AS FACT_GM ON REL_OP.delivery_order_sid = FACT_GM.delivery_order_sid
      AND REL_OP.delivery_order_pos_nr = FACT_GM.delivery_order_pos_nr
   LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_hauler_1 AS DIM_HAU ON FACT_SPS.hauler_sid = DIM_HAU.hauler_sid);

