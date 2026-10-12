CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_goods_package_shipment_1 AS SELECT FACT_GPS.pack_sid,
 FACT_GPS.pack_order_nr,
 FACT_GPS.pack_tracking_nr,
 FACT_GPS.pack_tracking_url,
 FACT_GPS.ewm_pack_nr,
 CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(FACT_GPS.pack_order_actual_create_tmsp AS TIMESTAMP), 'Europe/Berlin')) AS DATETIME)
 AS pack_order_actual_create_tmsp,
 FACT_GPS.pack_material_nr,
 IFNULL(FACT_GPS.pack_volume_uom_sid, -1) AS pack_volume_uom_sid,
 FACT_GPS.pack_volume_meas,
 LEFT(CAST(FACT_GPS.pack_volume_meas AS STRING) || ' ' || UOM_PACK_VOLUME.uom_cd, 20) AS pack_volume_str,
  FACT_GPS.pack_volume_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_volume_meas_standard,
 IFNULL(UOM_PACK_VOLUME.uom_standard_cd, '-1') AS pack_volume_meas_standard_uom_cd,
 IFNULL(FACT_GPS.pack_height_uom_sid, -1) AS pack_height_uom_sid,
 FACT_GPS.pack_height_meas,
 LEFT(CAST(FACT_GPS.pack_height_meas AS STRING) || ' ' || UOM_PACK_HEIGHT.uom_cd, 20) AS pack_height_str,
  FACT_GPS.pack_height_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_height_meas_standard,
 IFNULL(UOM_PACK_HEIGHT.uom_standard_cd, '-1') AS pack_height_meas_standard_uom_cd,
 IFNULL(FACT_GPS.pack_weight_uom_sid, -1) AS pack_weight_uom_sid,
 FACT_GPS.pack_weight_meas,
 LEFT(CAST(FACT_GPS.pack_weight_meas AS STRING) || ' ' || UOM_PACK_WEIGHT.uom_cd, 20) AS pack_weight_str,
  FACT_GPS.pack_weight_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_weight_meas_standard,
 IFNULL(UOM_PACK_WEIGHT.uom_standard_cd, '-1') AS pack_weight_meas_standard_uom_cd,
 IFNULL(FACT_GPS.pack_width_uom_sid, -1) AS pack_width_uom_sid,
 FACT_GPS.pack_width_meas,
 LEFT(CAST(FACT_GPS.pack_width_meas AS STRING) || ' ' || UOM_PACK_WIDTH.uom_cd, 20) AS pack_width_str,
  FACT_GPS.pack_width_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_width_meas_standard,
 IFNULL(UOM_PACK_WIDTH.uom_standard_cd, '-1') AS pack_width_meas_standard_uom_cd,
 FACT_GPS.pack_longest_length_meas,
 FACT_GPS.pack_shortest_length_meas,
 FACT_GPS.pack_mean_length_meas,
 IFNULL(FACT_GPS.pack_length_uom_sid, -1) AS pack_length_uom_sid,
 FACT_GPS.pack_length_meas,
 LEFT(CAST(FACT_GPS.pack_mean_length_meas AS STRING) || ' ' || UOM_PACK_LENGTH.uom_cd, 20) AS pack_mean_length_str,
  FACT_GPS.pack_mean_length_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_mean_length_meas_standard,
 LEFT(CAST(FACT_GPS.pack_shortest_length_meas AS STRING) || ' ' || UOM_PACK_LENGTH.uom_cd, 20) AS
 pack_shortest_length_str,
  FACT_GPS.pack_shortest_length_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_shortest_length_meas_standard,
 LEFT(CAST(FACT_GPS.pack_longest_length_meas AS STRING) || ' ' || UOM_PACK_LENGTH.uom_cd, 20) AS pack_longest_length_str
 ,
  FACT_GPS.pack_longest_length_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_longest_length_meas_standard,
 IFNULL(UOM_PACK_LENGTH.uom_standard_cd, '-1') AS pack_length_meas_standard_uom_cd,
 IFNULL(FACT_GPS.pack_girth_uom_sid, -1) AS pack_girth_uom_sid,
 FACT_GPS.pack_girth_east_meas,
 FACT_GPS.pack_girth_west_meas,
 LEFT(CAST(FACT_GPS.pack_girth_west_meas AS STRING) || ' ' || UOM_PACK_GIRTH.uom_cd, 20) AS pack_girth_west_str,
  FACT_GPS.pack_girth_west_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_girth_west_meas_standard,
 LEFT(CAST(FACT_GPS.pack_girth_east_meas AS STRING) || ' ' || UOM_PACK_GIRTH.uom_cd, 20) AS pack_girth_east_str,
  FACT_GPS.pack_girth_east_meas * UOM_PACK_WIDTH.uom_standard_multipl_meas AS pack_girth_east_meas_standard,
 IFNULL(UOM_PACK_GIRTH.uom_standard_cd, '-1') AS pack_girth_meas_standard_uom_cd,
 FACT_GPS.is_productsize_used_fg,
 IFNULL(FACT_GPS.delivery_order_sid, -1) AS delivery_order_sid
FROM ldl_dig_lec_share.v_fact_goods_package_shipment_1 AS FACT_GPS
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_HEIGHT ON UOM_PACK_HEIGHT.uom_sid = IFNULL(FACT_GPS
   .pack_height_uom_sid, -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_WIDTH ON UOM_PACK_WIDTH.uom_sid = IFNULL(FACT_GPS
   .pack_width_uom_sid, -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_LENGTH ON UOM_PACK_LENGTH.uom_sid = IFNULL(FACT_GPS
   .pack_length_uom_sid, -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_GIRTH ON UOM_PACK_GIRTH.uom_sid = IFNULL(FACT_GPS
   .pack_girth_uom_sid, -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_WEIGHT ON UOM_PACK_WEIGHT.uom_sid = IFNULL(FACT_GPS
   .pack_weight_uom_sid, -1)
 LEFT JOIN ldl_dig_fe_mstr_lidldigital.v_dim_unit_of_measurement_1 AS UOM_PACK_VOLUME ON UOM_PACK_VOLUME.uom_sid = IFNULL(FACT_GPS
   .pack_volume_uom_sid, -1);