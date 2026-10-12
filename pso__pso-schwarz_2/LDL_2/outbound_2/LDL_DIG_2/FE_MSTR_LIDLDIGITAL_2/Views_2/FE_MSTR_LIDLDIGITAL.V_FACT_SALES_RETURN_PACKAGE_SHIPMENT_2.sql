
CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_sales_return_package_shipment_2 AS WITH RET_ODR AS (SELECT
   cust_order_sid,
   cust_order_pos_nr,
   wshop_cd,
   MIN(cust_order_return_create_tmsp) AS return_wh_tmsp,
   MAX(return_paym_to_cust_tmsp) AS return_paym_to_cust_tmsp
  FROM ldl_dig_lec_share.v_fact_customer_return_line_2
  GROUP BY wshop_cd,
   cust_order_sid,
   cust_order_pos_nr) (SELECT IFNULL(PCK_SHP.return_pack_sid, -1) AS return_pack_sid,
   IFNULL(PCK_SHP.prod_variant_sid, -1) AS prod_variant_sid,
   IFNULL(PCK_SHP.return_request_nr, '-1') AS return_request_nr,
   IFNULL(PCK_SHP.return_pack_tracking_nr, '-1') AS return_pack_tracking_nr,
   IFNULL(PCK_SHP.return_pack_tracking_url, '-1') AS return_pack_tracking_url,
   IFNULL(PCK_SHP.sale_order_sid, -1) AS sale_order_sid,
   IFNULL(PCK_SHP.sale_order_nr, '-1') AS sale_order_nr,
   IFNULL(PCK_SHP.sale_order_pos_nr, -1) AS sale_order_pos_nr,
   IFNULL(PCK_SHP.hauler_sid, -1) AS hauler_sid,
   IFNULL(PCK_SHP.origin_country_cd, '-1') AS origin_country_cd,
   IFNULL(PCK_SHP.return_wh_sid, -1) AS return_wh_sid,
   IFNULL(PCK_SHP.return_option_cd, '-1') AS return_option_cd,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(PCK_SHP.return_request_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
   AS return_request_tmsp,
   PCK_SHP.return_request_dt,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(PCK_SHP.handover_to_carrier_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS handover_to_carrier_tmsp,
   PCK_SHP.handover_to_carrier_dt,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(PCK_SHP.first_intake_scan_hub_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME) AS first_intake_scan_hub_tmsp,
   PCK_SHP.first_intake_scan_hub_dt,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(PCK_SHP.return_hub_tmsp AS TIMESTAMP), 'Europe/Berlin'))
    AS DATETIME) AS return_hub_tmsp,
   PCK_SHP.return_hub_dt,
   PCK_SHP.prod_qty,
   PCK_SHP.request_to_carrier_dur_day,
   PCK_SHP.request_to_carrier_dur_hr,
   PCK_SHP.carrier_to_hub_dur_day,
   PCK_SHP.carrier_to_hub_dur_hr,
   PCK_SHP.hub_to_wh_dur_day,
   PCK_SHP.hub_to_wh_dur_hr,
   PCK_SHP.return_ship_cost_net_eur_val,
   IFNULL(PCK_SHP.dist_channel_cd, '-1') AS dist_channel_cd,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(t2.return_wh_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS
    DATETIME) AS return_wh_tmsp,
   DATE(t2.return_wh_tmsp) AS return_wh_dt,
   CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(t2.return_paym_to_cust_tmsp AS TIMESTAMP), 'Europe/Berlin'
      )) AS DATETIME) AS return_paym_to_cust_tmsp,
   CAST(FLOOR((DATE_DIFF(CAST(t2.return_paym_to_cust_tmsp AS DATETIME), CAST(t2.return_wh_tmsp AS DATETIME), SECOND) - CAST(ldl_dig_fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(t2.wshop_cd, DATE(t2.return_wh_tmsp), DATE(t2.return_paym_to_cust_tmsp)) AS FLOAT64)
         * 86400) / 3600) AS INTEGER) AS return_wh_to_paym_dur_hr,
   CAST(FLOOR((DATE_DIFF(CAST(t2.return_paym_to_cust_tmsp AS DATETIME), CAST(t2.return_wh_tmsp AS DATETIME), SECOND) - CAST(fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(t2.wshop_cd, DATE(t2.return_wh_tmsp), DATE(t2.return_paym_to_cust_tmsp)) AS FLOAT64)
          * 86400) / 3600 / 24) AS INTEGER) AS return_wh_to_paym_dur_day,
   CAST(FLOOR((DATE_DIFF(CAST(t2.return_wh_tmsp AS DATETIME), CAST(PCK_SHP.handover_to_carrier_tmsp AS DATETIME), SECOND)
        - CAST(fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(PCK_SHP.origin_country_cd, DATE(PCK_SHP.handover_to_carrier_tmsp), DATE(t2.return_wh_tmsp)) AS FLOAT64)
         * 86400) / 3600) AS INTEGER) AS carrier_to_wh_dur_hr,
    CASE
    WHEN DATE(PCK_SHP.handover_to_carrier_tmsp) = DATE(t2.return_wh_tmsp)
    THEN 0
    ELSE CAST(FLOOR((DATE_DIFF(CAST(t2.return_wh_tmsp AS DATETIME), CAST(PCK_SHP.handover_to_carrier_tmsp AS DATETIME),
           SECOND) - CAST(fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(PCK_SHP.origin_country_cd, DATE(PCK_SHP.handover_to_carrier_tmsp), Date(t2.return_wh_tmsp)) AS FLOAT64)
           * 86400) / 3600 / 24) AS INTEGER)
    END AS carrier_to_wh_dur_day,
   CAST(FLOOR((DATE_DIFF(CAST(t2.return_paym_to_cust_tmsp AS DATETIME), CAST(PCK_SHP.handover_to_carrier_tmsp AS DATETIME)
         ,SECOND) - CAST(fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(t2.wshop_cd, date(PCK_SHP.handover_to_carrier_tmsp), DATE(t2.return_paym_to_cust_tmsp)) AS FLOAT64)
         * 86400) / 3600) AS INTEGER) AS carrier_to_paym_dur_hr,
   CAST(FLOOR((DATE_DIFF(CAST(t2.return_paym_to_cust_tmsp AS DATETIME), CAST(PCK_SHP.handover_to_carrier_tmsp AS DATETIME)
          ,SECOND) - CAST(fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(t2.wshop_cd, DATE(PCK_SHP.handover_to_carrier_tmsp), DATE(t2.return_paym_to_cust_tmsp)) AS FLOAT64)
          * 86400) / 3600 / 24) AS INTEGER) AS carrier_to_paym_dur_day,
   CAST(FLOOR((DATE_DIFF(CAST(t2.return_paym_to_cust_tmsp AS DATETIME), CAST(PCK_SHP.return_request_tmsp AS DATETIME),
         SECOND) - CAST(fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(t2.wshop_cd, DATE(PCK_SHP.return_request_tmsp), DATE(t2.return_paym_to_cust_tmsp)) AS FLOAT64)
         * 86400) / 3600) AS INTEGER) AS request_to_paym_dur_hr,
   CAST(FLOOR((DATE_DIFF(CAST(t2.return_paym_to_cust_tmsp AS DATETIME), CAST(PCK_SHP.return_request_tmsp AS DATETIME),
          SECOND) - CAST(fe_mstr_lidldigital.f_count_holidays_and_sundays_and_saturdays(t2.wshop_cd, DATE(PCK_SHP.return_request_tmsp), DATE(t2.return_paym_to_cust_tmsp)) AS FLOAT64)
          * 86400) / 3600 / 24) AS INTEGER) AS request_to_paym_dur_day
  FROM ldl_dig_lec_share.v_fact_sales_return_package_shipment_2 AS PCK_SHP
   LEFT JOIN RET_ODR AS t2 ON PCK_SHP.sale_order_sid = t2.cust_order_sid AND PCK_SHP.sale_order_pos_nr = t2.cust_order_pos_nr
     );
