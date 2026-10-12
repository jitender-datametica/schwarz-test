CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_sales_package_position_shipment AS SELECT IFNULL(SPS.wshop_cd
  , '-1') AS wshop_cd,
 SPS.dist_channel_cd,
 IFNULL(SPS.pack_sid, - 1) AS pack_sid,
  CASE
  WHEN SPS.pack_tracking_nr = ''
  THEN '-1'
  ELSE SPS.pack_tracking_nr
  END AS pack_tracking_nr,
 SPS.ewm_pack_nr,
 SPS.pack_tracking_url,
 SPS.pack_order_nr,
 SPS.delivery_order_nr,
 SPS.cust_delivery_tgt_dt,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_tgt_create_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS pack_order_tgt_create_tmsp,
 DATE(SPS.pack_order_tgt_create_tmsp) AS pack_order_tgt_create_date,
  CASE
  WHEN SPS.delivery_order_nr LIKE '6%'
  THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
     'Europe/Berlin')) AS DATETIME)
  WHEN SPS.delivery_order_nr LIKE '8%'
  THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_orig_create_tmsp AS TIMESTAMP),
     'Europe/Berlin')) AS DATETIME)
  ELSE CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
     'Europe/Berlin')) AS DATETIME)
  END AS pack_order_original_create_tmsp,
 DATE(CASE
   WHEN SPS.delivery_order_nr LIKE '6%'
   THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME)
   WHEN SPS.delivery_order_nr LIKE '8%'
   THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_orig_create_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME)
   ELSE CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME)
   END) AS pack_order_original_create_date,
 TIME(CASE
   WHEN SPS.delivery_order_nr LIKE '6%'
   THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME)
   WHEN SPS.delivery_order_nr LIKE '8%'
   THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_orig_create_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME)
   ELSE CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
      'Europe/Berlin')) AS DATETIME)
   END) AS pack_order_original_create_tm,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS pack_order_actual_create_tmsp,
 DATE(SPS.pack_order_actual_create_tmsp) AS pack_order_actual_create_date,
 TIME(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
     'Europe/Berlin')) AS DATETIME)) AS pack_order_actual_create_tm,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.cust_delivery_tgt_hauler_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS cust_delivery_tgt_hauler_tmsp,
 DATE(SPS.cust_delivery_tgt_hauler_tmsp) AS cust_delivery_tgt_hauler_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.wh_leave_tgt_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS wh_leave_tgt_tmsp,
 DATE(SPS.wh_leave_tgt_tmsp) AS wh_leave_tgt_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.wh_leave_actual_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS wh_leave_actual_tmsp,
 DATE(SPS.wh_leave_actual_tmsp) AS wh_leave_actual_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.first_hub_scan_actual_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS first_hub_scan_actual_tmsp,
 DATE(SPS.first_hub_scan_actual_tmsp) AS first_hub_scan_actual_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.first_hub_scan_tgt_tmsp AS TIMESTAMP), 'Europe/Berlin')
   ) AS DATETIME) AS first_hub_scan_tgt_tmsp,
 DATE(SPS.first_hub_scan_tgt_tmsp) AS first_hub_scan_tgt_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.first_attempt_delivery_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS first_attempt_delivery_tmsp,
 DATE(SPS.first_attempt_delivery_tmsp) AS first_attempt_delivery_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.cust_delivery_actual_tmsp AS TIMESTAMP), 'Europe/Berlin'
    )) AS DATETIME) AS cust_delivery_actual_tmsp,
 DATE(SPS.cust_delivery_actual_tmsp) AS cust_delivery_actual_date,
 IFNULL(SPS.wh_sid, - 1) AS wh_sid,
 SPS.is_damaged_fg,
  CASE
  WHEN SPS.pack_size_type_cd = ''
  THEN '-1'
  ELSE IFNULL(SPS.pack_size_type_cd, '-1')
  END AS pack_size_type_cd,
  CASE
  WHEN SPS.delivery_type_cd = ''
  THEN '-1'
  ELSE IFNULL(SPS.delivery_type_cd, '-1')
  END AS delivery_type_cd,
 IFNULL(SPS.delivery_addr_sid, - 1) AS delivery_addr_sid,
  CASE
  WHEN SPS.delivery_zip_short_cd = ''
  THEN '-1'
  ELSE CAST(IFNULL(SPS.delivery_zip_short_cd, '-1') AS STRING)
  END AS delivery_zip_short_cd,
 IFNULL(SPS.hauler_sid, - 1) AS hauler_sid,
 SPS.hauler_name,
 IF(SPS.hauler_name = 'PL_DPD', SPS.pack_length_meas * SPS.pack_width_meas * SPS.pack_height_meas / 0.006, NULL) AS
 pack_volumetric_weight_gross,
 SPS.pack_height_meas,
 LEFT(CAST(SPS.pack_height_meas AS STRING) || ' ' || UOM_PACK_HEIGHT.uom_cd, 20) AS pack_height_str,
  SPS.pack_height_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_height_meas_standard,
 IFNULL(UOM_PACK_HEIGHT.uom_standard_cd, '-1') AS pack_height_meas_standard_uom_cd,
 SPS.pack_width_meas,
 LEFT(CAST(SPS.pack_width_meas AS STRING) || ' ' || UOM_PACK_WIDTH.uom_cd, 20) AS pack_width_str,
  SPS.pack_width_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_width_meas_standard,
 IFNULL(UOM_PACK_WIDTH.uom_standard_cd, '-1') AS pack_width_meas_standard_uom_cd,
 SPS.pack_length_meas,
 SPS.pack_mean_length_meas,
 SPS.pack_shortest_length_meas,
 SPS.pack_longest_length_meas,
 LEFT(CAST(SPS.pack_length_meas AS STRING) || ' ' || UOM_PACK_LENGTH.uom_cd, 20) AS pack_length_str,
  SPS.pack_length_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_length_meas_standard,
 LEFT(CAST(SPS.pack_mean_length_meas AS STRING) || ' ' || UOM_PACK_LENGTH.uom_cd, 20) AS pack_mean_length_str,
  SPS.pack_mean_length_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_mean_length_meas_standard,
 LEFT(CAST(SPS.pack_shortest_length_meas AS STRING) || ' ' || UOM_PACK_LENGTH.uom_cd, 20) AS pack_shortest_length_str,
  SPS.pack_shortest_length_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_shortest_length_meas_standard,
 LEFT(CAST(SPS.pack_longest_length_meas AS STRING) || ' ' || UOM_PACK_LENGTH.uom_cd, 20) AS pack_longest_length_str,
  SPS.pack_longest_length_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_longest_length_meas_standard,
 IFNULL(UOM_PACK_LENGTH.uom_standard_cd, '-1') AS pack_length_meas_standard_uom_cd,
 SPS.pack_girth_west_meas,
 SPS.pack_girth_east_meas,
 LEFT(CAST(SPS.pack_girth_west_meas AS STRING) || ' ' || UOM_PACK_GIRTH.uom_cd, 20) AS pack_girth_west_str,
  SPS.pack_girth_west_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_girth_west_meas_standard,
 LEFT(CAST(SPS.pack_girth_east_meas AS STRING) || ' ' || UOM_PACK_GIRTH.uom_cd, 20) AS pack_girth_east_str,
  SPS.pack_girth_east_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_girth_east_meas_standard,
 IFNULL(UOM_PACK_GIRTH.uom_standard_cd, '-1') AS pack_girth_meas_standard_uom_cd,
 SPS.pack_weight_meas,
 LEFT(CAST(SPS.pack_weight_meas AS STRING) || ' ' || UOM_PACK_WEIGHT.uom_cd, 20) AS pack_weight_str,
  SPS.pack_weight_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_weight_meas_standard,
 IFNULL(UOM_PACK_WEIGHT.uom_standard_cd, '-1') AS pack_weight_meas_standard_uom_cd,
 SPS.pack_volume_meas,
 LEFT(CAST(SPS.pack_volume_meas AS STRING) || ' ' || UOM_PACK_VOLUME.uom_cd, 20) AS pack_volume_str,
  SPS.pack_volume_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_volume_meas_standard,
 IFNULL(UOM_PACK_VOLUME.uom_standard_cd, '-1') AS pack_volume_meas_standard_uom_cd,
  CASE
  WHEN SPS.weight_class_cd = ''
  THEN '-1'
  ELSE IFNULL(SPS.weight_class_cd, '-1')
  END AS weight_class_cd,
  CASE
  WHEN SPS.volume_class_cd = ''
  THEN '-1'
  ELSE IFNULL(SPS.volume_class_cd, '-1')
  END AS volume_class_cd,
 IFNULL(SPS.delivery_order_sid, - 1) AS delivery_order_sid,
 SPS.pack_material_nr,
 SPS.wh_punctuality_cd AS warehouse_punctuality,
 SPS.hauler_punctuality_cd AS service_provider_punctuality,
 SPS.cust_ship_punctuality_cd AS customer_punctuality_shipment_level,
 SPS.pack_order_create_punctuality_cd AS ewm_order_punctuality,
  CASE
  WHEN SPS.pack_order_create_punctuality_cd = 'zu spät' AND DATE(CASE
      WHEN SPS.delivery_order_nr LIKE '6%'
      THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
         'Europe/Berlin')) AS DATETIME)
      WHEN SPS.delivery_order_nr LIKE '8%'
      THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_orig_create_tmsp AS TIMESTAMP),
         'Europe/Berlin')) AS DATETIME)
      ELSE CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
         'Europe/Berlin')) AS DATETIME)
      END) = DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.wh_leave_tgt_tmsp AS TIMESTAMP),
        'Europe/Berlin')) AS DATETIME))
  THEN 'T0'
  WHEN SPS.pack_order_create_punctuality_cd = 'zu spät' AND DATE(CASE
      WHEN SPS.delivery_order_nr LIKE '6%'
      THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
         'Europe/Berlin')) AS DATETIME)
      WHEN SPS.delivery_order_nr LIKE '8%'
      THEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_orig_create_tmsp AS TIMESTAMP),
         'Europe/Berlin')) AS DATETIME)
      ELSE CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_order_actual_create_tmsp AS TIMESTAMP),
         'Europe/Berlin')) AS DATETIME)
      END) > DATE(CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.wh_leave_tgt_tmsp AS TIMESTAMP),
        'Europe/Berlin')) AS DATETIME))
  THEN 'T1'
  ELSE '-1'
  END AS ewm_order_delay_status,
 SPS.wh_delay_hr AS warehouse_delay_in_hours,
 CEIL(SPS.wh_delay_hr / 24) AS warehouse_delay_in_days,
 SPS.hauler_delay_hr AS service_provider_delay_in_hours,
 CEIL(SPS.hauler_delay_hr / 24) AS service_provider_delay_in_days,
 SPS.cust_ship_delay_day AS customer_shipment_level_delay_in_days,
 SPS.vehicle_internal_nr,
 SPS.vehicle_license_plate_nr,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.vehicle_departure_tmsp AS TIMESTAMP), 'Europe/Berlin'))
  AS DATETIME) AS vehicle_departure_tmsp,
 DATE(SPS.vehicle_departure_tmsp) AS vehicle_departure_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.vehicle_loading_start_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS vehicle_loading_start_tmsp,
 DATE(SPS.vehicle_loading_start_tmsp) AS vehicle_loading_start_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.vehicle_loading_end_tmsp AS TIMESTAMP), 'Europe/Berlin'
    )) AS DATETIME) AS vehicle_loading_end_tmsp,
 DATE(SPS.vehicle_loading_end_tmsp) AS vehicle_loading_end_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.vehicle_hub_loading_start_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS truck_unloading_start_at_hub_tmsp,
 DATE(SPS.vehicle_hub_loading_start_tmsp) AS truck_unloading_start_at_hub_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.vehicle_hub_loading_end_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS truck_unloading_stop_at_hub_tmsp,
 DATE(SPS.vehicle_hub_loading_end_tmsp) AS truck_unloading_stop_at_hub_date,
 SPS.vehicle_hub_loading_dur_hr AS duration_of_unloading_at_hub_in_h,
 SPS.vehicle_hub_loading_pct AS truck_unloading_stop_at_hub_tmsp_percentrank_selected_group,
 SPS.is_ghost_pack_fg,
 SPS.is_ghost_pack_return_fg,
 SPS.is_lost_pack_fg,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(SPS.pack_return_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS
  DATETIME) AS pack_return_tmsp,
 DATE(SPS.pack_return_tmsp) AS pack_return_date,
 SPS.ghost_pack_return_duration_days_cnt,
 SPS.first_hub_loc_descr,
 SPS.second_hub_loc_descr,
 REL_OP.pack_pos_nr,
 REL_OP.prod_variant_sid,
 COALESCE(REL_OP.cust_order_nr, '-1') AS cust_order_nr,
 REL_OP.cust_order_pos_nr,
 COALESCE(REL_OP.ic_order_nr, '-1') AS ic_order_nr,
 REL_OP.ic_order_pos_nr,
 REL_OP.delivery_label_for_recycling_fg,
 REL_OP.delivery_to_point_of_use_fg,
 REL_OP.delivery_pick_up_for_recycling_fg,
 REL_OP.deliv_prod_qty,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_COL.cust_order_create_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS cust_order_create_tmsp,
 DATE(FACT_COL.cust_order_create_tmsp) AS cust_order_create_date,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_ICOL.ic_order_create_tmsp AS TIMESTAMP),
    'Europe/Berlin')) AS DATETIME) AS ic_order_create_tmsp,
 DATE(FACT_ICOL.ic_order_create_tmsp) AS ic_order_create_date,
 FACT_COL.cust_order_dt,
 FACT_ICOL.ic_order_dt,
 COALESCE(FACT_COL.cust_order_type_cd, FACT_ICOL.cust_order_type_cd) AS cust_order_type_cd,
 COALESCE(FACT_COL.cust_paym_method_cd, '-1') AS cust_paym_method_cd
FROM ldl_dig_lec_share.v_rel_order_packaging AS REL_OP
 LEFT JOIN ldl_dig_lec_share.v_fact_sales_package_shipment AS SPS ON REL_OP.pack_sid = SPS.pack_sid
 LEFT JOIN ldl_dig_lec_share.v_fact_customer_order_line AS FACT_COL ON REL_OP.cust_order_sid = FACT_COL.cust_order_sid
  AND REL_OP.cust_order_pos_nr = FACT_COL.cust_order_pos_nr
 LEFT JOIN ldl_dig_lec_share.v_fact_intercompany_order_line AS FACT_ICOL ON REL_OP.ic_order_sid = FACT_ICOL.ic_order_sid
    AND REL_OP.ic_order_pos_nr = FACT_ICOL.ic_order_pos_nr
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_PACK_HEIGHT ON UOM_PACK_HEIGHT.uom_sid = IFNULL(SPS
   .pack_height_uom_sid, -1)
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_PACK_WIDTH ON UOM_PACK_WIDTH.uom_sid = IFNULL(SPS
   .pack_width_uom_sid, -1)
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_PACK_LENGTH ON UOM_PACK_LENGTH.uom_sid = IFNULL(SPS
   .pack_length_uom_sid, -1)
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_PACK_GIRTH ON UOM_PACK_GIRTH.uom_sid = IFNULL(SPS
   .pack_girth_uom_sid, -1)
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_PACK_WEIGHT ON UOM_PACK_WEIGHT.uom_sid = IFNULL(SPS
   .pack_weight_uom_sid, -1)
 INNER JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement AS UOM_PACK_VOLUME ON UOM_PACK_VOLUME.uom_sid = IFNULL(SPS
   .pack_volume_uom_sid, -1);