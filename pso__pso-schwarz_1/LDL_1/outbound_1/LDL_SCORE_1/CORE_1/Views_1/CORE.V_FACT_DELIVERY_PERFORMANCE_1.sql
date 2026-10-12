CREATE OR REPLACE VIEW ldl_score_core.v_fact_delivery_performance_1 AS SELECT T.dispo_week,
 T.order_dt,
 T.inbound_dispo_order_sid,
 T.inbound_dispo_order_pos_sid,
 T.logistic_temp_cd,
 T.dispo_nr,
 T.dispo_descr,
 T.route_descr,
 T.bus_country_cd AS tgt_country_cd,
 T.order_reference_nr,
 T.purchase_order_nr,
 T.product_variant_sid,
 T.prod_variant_nan_nr AS nan,
 T.prod_variant_ian_nr AS ian,
 T.gtin_nr,
 T.prod_name,
 T.pallet_type_cd,
 T.double_deck_fg,
 T.storage_space_qty,
 T.pallet_cnt,
  CASE
  WHEN T.pallet_type_cd = 'DD'
  THEN T.pallet_cnt / 2
  ELSE T.pallet_cnt
  END AS ep_pallet_cnt,
 SUP.supplier_nr,
 SUP.supplier_name,
 SS.site_sid,
 SS.site_nr AS supplier_location_nr,
 SS.city_name AS supplier_location_name,
 T.vl_departure_site_sid,
 T.vl_transport_service_type_cd,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN FM.site_nr
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN MM1.site_nr
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN MM2.site_nr
  ELSE NULL
  END AS xdock_place_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN FM.city_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN MM1.city_name
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN MM2.city_name
  ELSE NULL
  END AS xdock_place_first_mile_name,
 SOP_FM.site_operator_nr AS xdock_operator_id_first_mile,
 SOP_FM.site_operator_name AS xdock_operator_name_first_mile,
 HFM.hauler_sid AS fmm_hauler_sid,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN HFM.hauler_nr
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN HMM1.hauler_nr
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN HMM2.hauler_nr
  ELSE NULL
  END AS first_mile_hauler_nr,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN HFM.hauler_short_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN HMM1.hauler_short_name
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN HMM2.hauler_short_name
  ELSE NULL
  END AS first_mile_hauler_short_name,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN HFM.hauler_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN HMM1.hauler_name
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN HMM2.hauler_name
  ELSE NULL
  END AS first_mile_hauler_name,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_hauler_price_per_vehicle_val
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_hauler_price_per_vehicle_val
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_per_vehicle_val
  ELSE NULL
  END AS net_rate_per_truck_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_hauler_price_per_pallet_val
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_hauler_price_per_pallet_val
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_per_pallet_val
  ELSE NULL
  END AS net_rate_per_pal_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_hauler_price_validity_period_from_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_hauler_price_validity_period_from_tmsp
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_validity_period_from_tmsp
  ELSE NULL
  END AS rate_validity_from_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_hauler_price_validity_period_to_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_hauler_price_validity_period_to_tmsp
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_validity_period_to_tmsp
  ELSE NULL
  END AS rate_validity_to_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_hauler_price_per_pallet_val
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_hauler_price_per_pallet_val
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_per_pallet_val
  ELSE NULL
  END AS billing_unit_price_rate_net_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_hauler_price_per_vehicle_val
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_hauler_price_per_vehicle_val
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_per_vehicle_val
  ELSE NULL
  END AS gros_rate_per_pal_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_supplier_curr_cd
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_supplier_curr_cd
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_supplier_curr_cd
  ELSE NULL
  END AS gros_rate_currency_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_supplier_price_validity_period_from_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_supplier_price_validity_period_from_tmsp
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_supplier_price_validity_period_from_tmsp
  ELSE NULL
  END AS gros_rate_validity_from_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_supplier_price_validity_period_to_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_supplier_price_validity_period_to_tmsp
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_supplier_price_validity_period_to_tmsp
  ELSE NULL
  END AS gros_rate_validity_to_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_distance_km_meas
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_distance_km_meas
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_distance_km_meas
  ELSE NULL
  END AS distance_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_agmt_co2_emission_kg_meas
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_agmt_co2_emission_kg_meas
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_agmt_co2_emission_kg_meas
  ELSE NULL
  END AS co2_emission_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN SUBSTR(T.vl_hauler_delivery_reference_nr, 0, 7)
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN SUBSTR(T.zl1_hauler_delivery_reference_nr, 0, 7)
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN SUBSTR(T.zl2_hauler_delivery_reference_nr, 0, 7)
  ELSE NULL
  END AS wetourid_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_inbound_logistics_partner_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_inbound_logistics_partner_name
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_inbound_logistics_partner_name
  ELSE NULL
  END AS we_hauler_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN SUBSTR(T.vl_hauler_delivery_reference_nr, 9, 7)
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN SUBSTR(T.zl1_hauler_delivery_reference_nr, 9, 7)
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN SUBSTR(T.zl2_hauler_delivery_reference_nr, 9, 7)
  ELSE NULL
  END AS watourid_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_logistics_partner_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_logistics_partner_name
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_logistics_partner_name
  ELSE NULL
  END AS wa_hauler_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_tgt_departure_dt
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_tgt_departure_dt
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_tgt_departure_dt
  ELSE NULL
  END AS target_delivery_date_first_mile_from,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_tgt_delivery_dt
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_tgt_delivery_dt
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_tgt_delivery_dt
  ELSE NULL
  END AS target_delivery_date_first_mile_to,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_dept_departure_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_dept_departure_tmsp
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_dept_departure_tmsp
  ELSE NULL
  END AS actual_time_dept_xdock_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_dest_arrival_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_dest_arrival_tmsp
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_dest_arrival_tmsp
  ELSE NULL
  END AS actual_time_dest_xdock_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_delivered_pallet_cnt
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_delivered_pallet_cnt
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_delivered_pallet_cnt
  ELSE NULL
  END AS amount_pal_loaded_per_truck_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_hauler_missing_pallet_cnt
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_hauler_missing_pallet_cnt
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_missing_pallet_cnt
  ELSE NULL
  END AS missing_pallets_first_mile,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.vl_delivery_progress_pct
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl1_delivery_progress_pct
  WHEN T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_delivery_progress_pct
  ELSE NULL
  END AS first_mile_delivered_progress,
 T.zl1_departure_site_sid,
 T.zl1_transport_service_type_cd,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN MM1.site_nr
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN MM2.site_nr
  ELSE NULL
  END AS xdock_place_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN MM1.city_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN MM2.city_name
  ELSE NULL
  END AS xdock_place_middle_mile1_name,
 SOP_MM1.site_operator_nr AS xdock_operator_id_middle_mile1,
 SOP_MM1.site_operator_name AS xdock_operator_middle_mile1_name,
 HMM1.hauler_sid AS hmm1_hauler_sid,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN HMM1.hauler_nr
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN HMM2.hauler_nr
  ELSE NULL
  END AS middle_mile1_hauler_nr,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN HMM1.hauler_short_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN HMM2.hauler_short_name
  ELSE NULL
  END AS middle_mile1_hauler_short_name,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN HMM1.hauler_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN HMM2.hauler_name
  ELSE NULL
  END AS middle_mile1_hauler_name,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_hauler_price_per_vehicle_val
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_per_vehicle_val
  ELSE NULL
  END AS net_rate_per_truck_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_hauler_price_per_pallet_val
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_per_pallet_val
  ELSE NULL
  END AS net_rate_per_pal_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_hauler_price_validity_period_from_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_validity_period_from_tmsp
  ELSE NULL
  END AS rate_validity_from_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_hauler_price_validity_period_to_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_validity_period_to_tmsp
  ELSE NULL
  END AS rate_validity_to_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_hauler_price_per_pallet_val
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_per_pallet_val
  ELSE NULL
  END AS billing_unit_price_rate_net_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_hauler_price_per_vehicle_val
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_price_per_vehicle_val
  ELSE NULL
  END AS gros_rate_per_pal_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_supplier_curr_cd
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_supplier_curr_cd
  ELSE NULL
  END AS gros_rate_currency_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_supplier_price_validity_period_from_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_supplier_price_validity_period_from_tmsp
  ELSE NULL
  END AS gros_rate_validity_from_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_supplier_price_validity_period_to_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_supplier_price_validity_period_to_tmsp
  ELSE NULL
  END AS gros_rate_validity_to_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_distance_km_meas
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_distance_km_meas
  ELSE NULL
  END AS distance_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_agmt_co2_emission_kg_meas
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_agmt_co2_emission_kg_meas
  ELSE NULL
  END AS co2_emission_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN SUBSTR(T.zl1_hauler_delivery_reference_nr, 0, 7)
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN SUBSTR(T.zl2_hauler_delivery_reference_nr, 0, 7)
  ELSE NULL
  END AS wetourid_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_inbound_logistics_partner_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_inbound_logistics_partner_name
  ELSE NULL
  END AS we_hauler_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN SUBSTR(T.zl1_hauler_delivery_reference_nr, 9, 7)
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN SUBSTR(T.zl2_hauler_delivery_reference_nr, 9, 7)
  ELSE NULL
  END AS watourid_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_logistics_partner_name
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_logistics_partner_name
  ELSE NULL
  END AS wa_hauler_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_tgt_departure_dt
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_tgt_departure_dt
  ELSE NULL
  END AS target_delivery_date_middle_mile1_from,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_tgt_delivery_dt
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_tgt_delivery_dt
  ELSE NULL
  END AS target_delivery_date_middle_mile1_to,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_dept_departure_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_dept_departure_tmsp
  ELSE NULL
  END AS actual_time_dept_xdock_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_dest_arrival_tmsp
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_dest_arrival_tmsp
  ELSE NULL
  END AS actual_time_dest_xdock_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_delivered_pallet_cnt
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_delivered_pallet_cnt
  ELSE NULL
  END AS amount_pal_loaded_per_truck_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_hauler_missing_pallet_cnt
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_hauler_missing_pallet_cnt
  ELSE NULL
  END AS missing_pallets_middle_mile1,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_delivery_progress_pct
  WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
  THEN T.zl2_delivery_progress_pct
  ELSE NULL
  END AS middle_mile1_delivered_progress,
 T.zl2_departure_site_sid,
 T.zl2_transport_service_type_cd,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN MM2.site_nr
  ELSE NULL
  END AS xdock_place_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN MM2.city_name
  ELSE NULL
  END AS xdock_place_middle_mile2_name,
 SOP_MM2.site_operator_nr AS xdock_operator_id_middle_mile2,
 SOP_MM2.site_operator_name AS xdock_operator_middle_mile2_name,
 HMM2.hauler_sid AS mm2_hauler_sid,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN HMM2.hauler_nr
  ELSE NULL
  END AS middle_mile2_hauler_nr,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN HMM2.hauler_short_name
  ELSE NULL
  END AS middle_mile2_hauler_short_name,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN HMM2.hauler_name
  ELSE NULL
  END AS middle_mile2_hauler_name,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_hauler_price_per_vehicle_val
  ELSE NULL
  END AS net_rate_per_truck_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_hauler_price_per_pallet_val
  ELSE NULL
  END AS net_rate_per_pal_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_hauler_price_validity_period_from_tmsp
  ELSE NULL
  END AS rate_validity_from_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_hauler_price_validity_period_to_tmsp
  ELSE NULL
  END AS rate_validity_to_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_hauler_price_per_pallet_val
  ELSE NULL
  END AS billing_unit_price_rate_net_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl1_hauler_price_per_vehicle_val
  ELSE NULL
  END AS gros_rate_per_pal_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_supplier_curr_cd
  ELSE NULL
  END AS gros_rate_currency_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_supplier_price_validity_period_from_tmsp
  ELSE NULL
  END AS gros_rate_validity_from_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_supplier_price_validity_period_to_tmsp
  ELSE NULL
  END AS gros_rate_validity_to_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_distance_km_meas
  ELSE NULL
  END AS distance_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_agmt_co2_emission_kg_meas
  ELSE NULL
  END AS co2_emission_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN SUBSTR(T.zl2_hauler_delivery_reference_nr, 0, 7)
  ELSE NULL
  END AS wetourid_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_inbound_logistics_partner_name
  ELSE NULL
  END AS we_hauler_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN SUBSTR(T.zl2_hauler_delivery_reference_nr, 9, 7)
  ELSE NULL
  END AS watourid_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_logistics_partner_name
  ELSE NULL
  END AS wa_hauler_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_tgt_departure_dt
  ELSE NULL
  END AS target_delivery_date_middle_mile2_from,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_tgt_delivery_dt
  ELSE NULL
  END AS target_delivery_date_middle_mile2_to,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_dept_departure_tmsp
  ELSE NULL
  END AS actual_time_dept_xdock_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_dest_arrival_tmsp
  ELSE NULL
  END AS actual_time_dest_xdock_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_delivered_pallet_cnt
  ELSE NULL
  END AS amount_pal_loaded_per_truck_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_hauler_missing_pallet_cnt
  ELSE NULL
  END AS missing_pallets_middle_mile2,
  CASE
  WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
   IS NOT NULL
  THEN T.zl2_delivery_progress_pct
  ELSE NULL
  END AS middle_mile2_delivered_progress,
 T.dp_departure_site_sid,
 LM.site_nr AS xdock_place_last_mile,
 LM.city_name AS xdock_place_last_mile_name,
 SOP_LM.site_operator_nr AS xdock_operator_id_last_mile,
 SOP_LM.site_operator_name AS xdock_operator_last_mile_name,
 LMH.hauler_nr AS last_mile_hauler_nr,
 LMH.hauler_short_name AS last_mile_hauler_short_name,
 LMH.hauler_name AS last_mile_hauler_name,
 T.dp_hauler_price_per_vehicle_val AS net_rate_per_truck_last_mile,
 T.dp_hauler_price_per_pallet_val AS net_rate_per_pal_last_mile,
 T.dp_hauler_price_validity_period_from_tmsp AS rate_validity_from_last_mile,
 T.dp_hauler_price_validity_period_to_tmsp AS rate_validity_to_last_mile,
 T.dp_supplier_price_per_vehicle_val AS gros_rate_per_truck_last_mile,
 T.dp_supplier_price_per_pallet_val AS gros_rate_per_pal_last_mile,
 T.dp_supplier_curr_cd AS gros_rate_currency_last_mile,
 T.dp_supplier_price_validity_period_from_tmsp AS gros_rate_validity_from_last_mile,
 T.dp_supplier_price_validity_period_to_tmsp AS gros_rate_validity_to_last_mile,
 T.dp_distance_km_meas AS distance_last_mile,
 T.dp_agmt_co2_emission_kg_meas AS co2_emission_last_mile,
 SUBSTR(T.dp_hauler_delivery_reference_nr, 0, 7) AS wetourid_last_mile,
 T.dp_inbound_logistics_partner_name AS we_hauler_last_mile,
 SUBSTR(T.dp_hauler_delivery_reference_nr, 9, 7) AS watourid_last_mile,
 T.dp_logistics_partner_name AS wa_hauler_last_mile,
 T.dp_tgt_departure_dt AS target_delivery_date_last_mile_from,
 T.dp_tgt_delivery_dt AS target_delivery_date_last_mile_to,
 T.dp_dept_departure_tmsp AS actual_time_dept_xdock_last_mile,
 T.dp_dest_arrival_tmsp AS actual_time_dest_xdock_last_mile,
 T.dp_delivered_pallet_cnt AS amount_pal_loaded_per_truck_last_mile,
 T.dp_rdc_delivery_dt AS wedatum,
 T.dp_rdc_punctuality_cd AS last_mile_punctuality,
 T.dp_rdc_punctuality_pct AS last_mile_punctuality_per_ref,
 T.dp_hauler_missing_pallet_cnt AS missing_pallets_last_mile,
 T.dp_delivery_progress_pct AS delivered_progress,
 T.dp_destination_site_sid,
 RDC.site_nr AS destination_rdc_nr,
 RDC.site_name AS destination_rdc_short,
 RDC.city_name AS destination_rdc_name,
 T.dp_tgt_departure_dt AS target_time_dep_xdock_last_mile,
 T.dp_tgt_delivery_dt AS target_delivery_rdc_day,
 T.dp_inbound_logistics_partner_name,
 T.dp_logistics_partner_name,
 T.dp_ready_for_collection_dt AS readyforcollection,
 T.dp_latest_delivery_dt AS latestdelivery,
 T.dp_latest_loading_release_dt AS latestloadingrelease,
 T.dp_advised_for_collection_dt AS advisedforcollection,
 T.dp_collected_dt AS collected,
 T.dp_unloaded_at_wh_dt AS unloadedatwarehouse,
  CASE
  WHEN T.dp_ready_for_collection_dt IS NULL
  THEN NULL
  ELSE T.dp_order_availability_status_cd
  END AS offen_bereitstellung,
  CASE
  WHEN T.dp_ready_for_collection_dt IS NULL
  THEN NULL
  ELSE T.dp_order_availability_punctuality_cd
  END AS bereitstellungspuenktlichkeit,
  CASE
  WHEN T.dp_ready_for_collection_dt IS NULL
  THEN NULL
  ELSE T.dp_pickup_notification_status_cd
  END AS avisierungsstatus,
  CASE
  WHEN T.dp_ready_for_collection_dt IS NULL
  THEN NULL
  ELSE T.dp_pickup_punctuality_cd
  END AS abholpuenktlichkeit,
  CASE
  WHEN T.dp_ready_for_collection_dt IS NULL
  THEN NULL
  ELSE T.dp_hauler_delivery_punctuality_cd
  END AS anlieferpuenktlichkeit_hauler,
  CASE
  WHEN T.dp_ready_for_collection_dt IS NULL
  THEN NULL
  ELSE T.dp_delivery_punctuality_cd
  END AS anlieferpuenktlichkeit,
  CASE
  WHEN T.dp_ready_for_collection_dt IS NULL
  THEN NULL
  ELSE T.dp_preparation_punctuality_status_cd
  END AS preparationpunctuality,
 T.dp_is_empty_stock_fg AS stock_0,
 COALESCE(FM.site_nr, MM1.site_nr, MM2.site_nr, LM.site_nr) AS first_delivery_site_nr,
 COALESCE(FM.city_name, MM1.city_name, MM2.city_name, LM.city_name) AS first_delivery_site_name,
 COALESCE(T.vl_tgt_departure_dt, T.zl1_tgt_departure_dt, T.zl2_tgt_departure_dt, T.dp_tgt_departure_dt) AS
 first_delivery_site_tgt_delivery_dt,
 COALESCE(T.vl_dept_departure_tmsp, T.zl1_dept_departure_tmsp, T.zl2_dept_departure_tmsp, T.dp_dept_departure_tmsp) AS
 first_delivery_site_actual_delivery_tmsp
FROM (SELECT IDO.inbound_dispo_order_sid,
   ITPTP_DP.inbound_dispo_order_pos_sid,
   ITPTP_DP.dispo_week,
   ITPTP_DP.dispo_descr,
   ITPTP_DP.order_reference_nr,
   ITPTP_DP.bus_country_cd,
   ITPTP_DP.logistic_temp_cd,
   ITPTP_DP.order_dt,
   ITPTP_DP.purchase_order_nr,
   ITPTP_DP.product_variant_sid,
   ITPTP_DP.prod_variant_nan_nr,
   PR.int_product_nr AS prod_variant_ian_nr,
   PR_V.int_product_name AS prod_name,
   PR_V.gtin_nr,
   ITPTP_DP.route_descr,
   ITPTP_DP.pallet_type_cd,
   ITPTP_DP.double_deck_fg,
   ITPTP_DP.storage_space_qty,
   ITPTP_DP.total_order_pallet_cnt,
   ITPTP_DP.missing_pallet_cnt,
   ITPTP_DP.total_order_missing_pallet_cnt,
   ITPTP_DP.supplier_sid,
   IDOP.delivering_site_sid AS supplier_location_sid,
   ITPTP_DP.dispo_nr,
   ITPTP_DP.logistic_type_cd,
   ITPTP_DP.departure_site_sid AS dp_departure_site_sid,
   ITPTP_DP.destination_site_sid AS dp_destination_site_sid,
   ITPTP_DP.tgt_departure_dt AS dp_tgt_departure_dt,
   ITPTP_DP.tgt_delivery_dt AS dp_tgt_delivery_dt,
   ITPTP_DP.dest_punctuality_pct AS dp_dest_punctuality_pct,
   ITPTP_DP.dest_punctuality_cd AS dp_dest_punctuality_cd,
   ITPTP_DP.hauler_sid AS dp_hauler_sid,
   ITPTP_DP.hauler_delivery_reference_nr AS dp_hauler_delivery_reference_nr,
   ITPTP_DP.inbound_logistics_partner_name AS dp_inbound_logistics_partner_name,
   ITPTP_DP.logistics_partner_name AS dp_logistics_partner_name,
   ITPTP_DP.transport_service_type_cd AS dp_transport_service_type_cd,
   ITPTP_DP.delivered_pallet_cnt AS dp_delivered_pallet_cnt,
   ITPTP_DP.ontime_pallet_cnt AS dp_ontime_pallet_cnt,
   ITPTP_DP.hauler_missing_pallet_cnt AS dp_hauler_missing_pallet_cnt,
   ITPTP_DP.dept_departure_tmsp AS dp_dept_departure_tmsp,
   ITPTP_DP.dest_arrival_tmsp AS dp_dest_arrival_tmsp,
   ITPTP_DP.dest_punctuality_cd AS dp_dest_punctuality_cd0,
   ITPTP_DP.dest_punctuality_pct AS dp_dest_punctuality_pct0,
   ITPTP_DP.dest_order_punctuality_pct AS dp_dest_order_punctuality_pct,
   ITPTP_DP.delivery_progress_pct AS dp_delivery_progress_pct,
   ITPTP_DP.rdc_delivery_dt AS dp_rdc_delivery_dt,
   ITPTP_DP.rdc_punctuality_pct AS dp_rdc_punctuality_pct,
   ITPTP_DP.rdc_punctuality_cd AS dp_rdc_punctuality_cd,
   ITPTP_DP.ready_for_collection_dt AS dp_ready_for_collection_dt,
   ITPTP_DP.latest_delivery_dt AS dp_latest_delivery_dt,
   ITPTP_DP.latest_loading_release_dt AS dp_latest_loading_release_dt,
   ITPTP_DP.advised_for_collection_dt AS dp_advised_for_collection_dt,
   ITPTP_DP.collected_dt AS dp_collected_dt,
   ITPTP_DP.unloaded_at_wh_dt AS dp_unloaded_at_wh_dt,
   ITPTP_DP.order_availability_status_cd AS dp_order_availability_status_cd,
   ITPTP_DP.order_availability_punctuality_cd AS dp_order_availability_punctuality_cd,
   ITPTP_DP.pickup_notification_status_cd AS dp_pickup_notification_status_cd,
   ITPTP_DP.pickup_punctuality_cd AS dp_pickup_punctuality_cd,
   ITPTP_DP.hauler_delivery_punctuality_cd AS dp_hauler_delivery_punctuality_cd,
   ITPTP_DP.delivery_punctuality_cd AS dp_delivery_punctuality_cd,
   ITPTP_DP.preparation_punctuality_status_cd AS dp_preparation_punctuality_status_cd,
   ITPTP_DP.preparation_punctuality_pct AS dp_preparation_punctuality_pct,
   ITPTP_DP.is_empty_stock_fg AS dp_is_empty_stock_fg,
   ITPTP_DP.distance_km_meas AS dp_distance_km_meas,
   ITPTP_DP.agmt_co2_emission_kg_meas AS dp_agmt_co2_emission_kg_meas,
   ITPTP_DP.supplier_price_validity_period_from_tmsp AS dp_supplier_price_validity_period_from_tmsp,
   ITPTP_DP.supplier_price_validity_period_to_tmsp AS dp_supplier_price_validity_period_to_tmsp,
   ITPTP_DP.supplier_curr_cd AS dp_supplier_curr_cd,
   ITPTP_DP.supplier_price_per_vehicle_val AS dp_supplier_price_per_vehicle_val,
   ITPTP_DP.supplier_price_per_pallet_val AS dp_supplier_price_per_pallet_val,
   ITPTP_DP.hauler_curr_cd AS dp_hauler_curr_cd,
   ITPTP_DP.hauler_price_validity_period_from_tmsp AS dp_hauler_price_validity_period_from_tmsp,
   ITPTP_DP.hauler_price_validity_period_to_tmsp AS dp_hauler_price_validity_period_to_tmsp,
   ITPTP_DP.hauler_price_per_vehicle_val AS dp_hauler_price_per_vehicle_val,
   ITPTP_DP.hauler_price_per_pallet_val AS dp_hauler_price_per_pallet_val,
   ITPTP_ZL2.departure_site_sid AS zl2_departure_site_sid,
   ITPTP_ZL2.destination_site_sid AS zl2_destination_site_sid,
   ITPTP_ZL2.tgt_departure_dt AS zl2_tgt_departure_dt,
   ITPTP_ZL2.tgt_delivery_dt AS zl2_tgt_delivery_dt,
   ITPTP_ZL2.dest_punctuality_pct AS zl2_dest_punctuality_pct,
   ITPTP_ZL2.dest_punctuality_cd AS zl2_dest_punctuality_cd,
   ITPTP_ZL2.hauler_sid AS zl2_hauler_sid,
   ITPTP_ZL2.hauler_delivery_reference_nr AS zl2_hauler_delivery_reference_nr,
   ITPTP_ZL2.inbound_logistics_partner_name AS zl2_inbound_logistics_partner_name,
   ITPTP_ZL2.logistics_partner_name AS zl2_logistics_partner_name,
   ITPTP_ZL2.transport_service_type_cd AS zl2_transport_service_type_cd,
   ITPTP_ZL2.delivered_pallet_cnt AS zl2_delivered_pallet_cnt,
   ITPTP_ZL2.ontime_pallet_cnt AS zl2_ontime_pallet_cnt,
   ITPTP_ZL2.hauler_missing_pallet_cnt AS zl2_hauler_missing_pallet_cnt,
   ITPTP_ZL2.dept_departure_tmsp AS zl2_dept_departure_tmsp,
   ITPTP_ZL2.dest_arrival_tmsp AS zl2_dest_arrival_tmsp,
   ITPTP_ZL2.dest_punctuality_cd AS zl2_dest_punctuality_cd0,
   ITPTP_ZL2.dest_punctuality_pct AS zl2_dest_punctuality_pct0,
   ITPTP_ZL2.dest_order_punctuality_pct AS zl2_dest_order_punctuality_pct,
   ITPTP_ZL2.delivery_progress_pct AS zl2_delivery_progress_pct,
   ITPTP_ZL2.distance_km_meas AS zl2_distance_km_meas,
   ITPTP_ZL2.agmt_co2_emission_kg_meas AS zl2_agmt_co2_emission_kg_meas,
   ITPTP_ZL2.supplier_price_validity_period_from_tmsp AS zl2_supplier_price_validity_period_from_tmsp,
   ITPTP_ZL2.supplier_price_validity_period_to_tmsp AS zl2_supplier_price_validity_period_to_tmsp,
   ITPTP_ZL2.supplier_curr_cd AS zl2_supplier_curr_cd,
   ITPTP_ZL2.supplier_price_per_vehicle_val AS zl2_supplier_price_per_vehicle_val,
   ITPTP_ZL2.supplier_price_per_pallet_val AS zl2_supplier_price_per_pallet_val,
   ITPTP_ZL2.hauler_curr_cd AS zl2_hauler_curr_cd,
   ITPTP_ZL2.hauler_price_validity_period_from_tmsp AS zl2_hauler_price_validity_period_from_tmsp,
   ITPTP_ZL2.hauler_price_validity_period_to_tmsp AS zl2_hauler_price_validity_period_to_tmsp,
   ITPTP_ZL2.hauler_price_per_vehicle_val AS zl2_hauler_price_per_vehicle_val,
   ITPTP_ZL2.hauler_price_per_pallet_val AS zl2_hauler_price_per_pallet_val,
   ITPTP_ZL1.departure_site_sid AS zl1_departure_site_sid,
   ITPTP_ZL1.destination_site_sid AS zl1_destination_site_sid,
   ITPTP_ZL1.tgt_departure_dt AS zl1_tgt_departure_dt,
   ITPTP_ZL1.tgt_delivery_dt AS zl1_tgt_delivery_dt,
   ITPTP_ZL1.dest_punctuality_pct AS zl1_dest_punctuality_pct,
   ITPTP_ZL1.dest_punctuality_cd AS zl1_dest_punctuality_cd,
   ITPTP_ZL1.hauler_sid AS zl1_hauler_sid,
   ITPTP_ZL1.hauler_delivery_reference_nr AS zl1_hauler_delivery_reference_nr,
   ITPTP_ZL1.inbound_logistics_partner_name AS zl1_inbound_logistics_partner_name,
   ITPTP_ZL1.logistics_partner_name AS zl1_logistics_partner_name,
   ITPTP_ZL1.transport_service_type_cd AS zl1_transport_service_type_cd,
   ITPTP_ZL1.delivered_pallet_cnt AS zl1_delivered_pallet_cnt,
   ITPTP_ZL1.ontime_pallet_cnt AS zl1_ontime_pallet_cnt,
   ITPTP_ZL1.hauler_missing_pallet_cnt AS zl1_hauler_missing_pallet_cnt,
   ITPTP_ZL1.dept_departure_tmsp AS zl1_dept_departure_tmsp,
   ITPTP_ZL1.dest_arrival_tmsp AS zl1_dest_arrival_tmsp,
   ITPTP_ZL1.dest_punctuality_cd AS zl1_dest_punctuality_cd0,
   ITPTP_ZL1.dest_punctuality_pct AS zl1_dest_punctuality_pct0,
   ITPTP_ZL1.dest_order_punctuality_pct AS zl1_dest_order_punctuality_pct,
   ITPTP_ZL1.delivery_progress_pct AS zl1_delivery_progress_pct,
   ITPTP_ZL1.distance_km_meas AS zl1_distance_km_meas,
   ITPTP_ZL1.agmt_co2_emission_kg_meas AS zl1_agmt_co2_emission_kg_meas,
   ITPTP_ZL1.supplier_price_validity_period_from_tmsp AS zl1_supplier_price_validity_period_from_tmsp,
   ITPTP_ZL1.supplier_price_validity_period_to_tmsp AS zl1_supplier_price_validity_period_to_tmsp,
   ITPTP_ZL1.supplier_curr_cd AS zl1_supplier_curr_cd,
   ITPTP_ZL1.supplier_price_per_vehicle_val AS zl1_supplier_price_per_vehicle_val,
   ITPTP_ZL1.supplier_price_per_pallet_val AS zl1_supplier_price_per_pallet_val,
   ITPTP_ZL1.hauler_curr_cd AS zl1_hauler_curr_cd,
   ITPTP_ZL1.hauler_price_validity_period_from_tmsp AS zl1_hauler_price_validity_period_from_tmsp,
   ITPTP_ZL1.hauler_price_validity_period_to_tmsp AS zl1_hauler_price_validity_period_to_tmsp,
   ITPTP_ZL1.hauler_price_per_vehicle_val AS zl1_hauler_price_per_vehicle_val,
   ITPTP_ZL1.hauler_price_per_pallet_val AS zl1_hauler_price_per_pallet_val,
   ITPTP_VL.departure_site_sid AS vl_departure_site_sid,
   ITPTP_VL.destination_site_sid AS vl_destination_site_sid,
   ITPTP_VL.tgt_departure_dt AS vl_tgt_departure_dt,
   ITPTP_VL.tgt_delivery_dt AS vl_tgt_delivery_dt,
   ITPTP_VL.dest_punctuality_pct AS vl_dest_punctuality_pct,
   ITPTP_VL.dest_punctuality_cd AS vl_dest_punctuality_cd,
   ITPTP_VL.hauler_sid AS vl_hauler_sid,
   ITPTP_VL.hauler_delivery_reference_nr AS vl_hauler_delivery_reference_nr,
   ITPTP_VL.inbound_logistics_partner_name AS vl_inbound_logistics_partner_name,
   ITPTP_VL.logistics_partner_name AS vl_logistics_partner_name,
   ITPTP_VL.transport_service_type_cd AS vl_transport_service_type_cd,
   ITPTP_VL.delivered_pallet_cnt AS vl_delivered_pallet_cnt,
   ITPTP_VL.ontime_pallet_cnt AS vl_ontime_pallet_cnt,
   ITPTP_VL.hauler_missing_pallet_cnt AS vl_hauler_missing_pallet_cnt,
   ITPTP_VL.dept_departure_tmsp AS vl_dept_departure_tmsp,
   ITPTP_VL.dest_arrival_tmsp AS vl_dest_arrival_tmsp,
   ITPTP_VL.dest_punctuality_cd AS vl_dest_punctuality_cd0,
   ITPTP_VL.dest_punctuality_pct AS vl_dest_punctuality_pct0,
   ITPTP_VL.dest_order_punctuality_pct AS vl_dest_order_punctuality_pct,
   ITPTP_VL.delivery_progress_pct AS vl_delivery_progress_pct,
   ITPTP_VL.distance_km_meas AS vl_distance_km_meas,
   ITPTP_VL.agmt_co2_emission_kg_meas AS vl_agmt_co2_emission_kg_meas,
   ITPTP_VL.supplier_price_validity_period_from_tmsp AS vl_supplier_price_validity_period_from_tmsp,
   ITPTP_VL.supplier_price_validity_period_to_tmsp AS vl_supplier_price_validity_period_to_tmsp,
   ITPTP_VL.supplier_curr_cd AS vl_supplier_curr_cd,
   ITPTP_VL.supplier_price_per_vehicle_val AS vl_supplier_price_per_vehicle_val,
   ITPTP_VL.supplier_price_per_pallet_val AS vl_supplier_price_per_pallet_val,
   ITPTP_VL.hauler_curr_cd AS vl_hauler_curr_cd,
   ITPTP_VL.hauler_price_validity_period_from_tmsp AS vl_hauler_price_validity_period_from_tmsp,
   ITPTP_VL.hauler_price_validity_period_to_tmsp AS vl_hauler_price_validity_period_to_tmsp,
   ITPTP_VL.hauler_price_per_vehicle_val AS vl_hauler_price_per_vehicle_val,
   ITPTP_VL.hauler_price_per_pallet_val AS vl_hauler_price_per_pallet_val,
   SUM(ITPTP_DP.missing_pallet_cnt) AS missing_pallet_cnt0,
   SUM(ITPTP_DP.pallet_cnt) AS pallet_cnt
  FROM ldl_score_core_rel.t_inbound_dispo_order_1 AS IDO
   INNER JOIN ldl_score_core_rel.t_inbound_dispo_order_position_1 AS IDOP ON IDO.inbound_dispo_order_sid = IDOP.inbound_dispo_order_sid
       AND CURRENT_TIMESTAMP() BETWEEN IDO.dwh_valid_from_tmsp AND IDO.dwh_valid_to_tmsp AND CURRENT_TIMESTAMP() BETWEEN
     IDOP.dwh_valid_from_tmsp AND IDOP.dwh_valid_to_tmsp
   INNER JOIN ldl_score_core.t_fact_delivery_performance_1 AS ITPTP_DP ON IDOP.inbound_dispo_order_pos_sid = ITPTP_DP.inbound_dispo_order_pos_sid
    
   LEFT JOIN ldl_score_core.t_fact_delivery_performance_1 AS ITPTP_ZL2 ON IDOP.inbound_dispo_order_pos_sid = ITPTP_ZL2.inbound_dispo_order_pos_sid
      AND ITPTP_DP.departure_site_sid = ITPTP_ZL2.destination_site_sid
   LEFT JOIN ldl_score_core.t_fact_delivery_performance_1 AS ITPTP_ZL1 ON IDOP.inbound_dispo_order_pos_sid = ITPTP_ZL1.inbound_dispo_order_pos_sid
      AND ITPTP_ZL2.departure_site_sid = ITPTP_ZL1.destination_site_sid
   LEFT JOIN ldl_score_core.t_fact_delivery_performance_1 AS ITPTP_VL ON IDOP.inbound_dispo_order_pos_sid = ITPTP_VL.inbound_dispo_order_pos_sid
      AND ITPTP_ZL1.departure_site_sid = ITPTP_VL.destination_site_sid
   INNER JOIN ldl_score_core_rel.t_product_1 AS PR ON IDOP.product_sid = PR.product_sid
   INNER JOIN ldl_score_core_rel.t_product_variant_1 AS PR_V ON ITPTP_DP.product_variant_sid = PR_V.product_variant_sid
  WHERE ITPTP_DP.transport_service_type_cd IN ('HL_1', 'DL')
  GROUP BY IDO.inbound_dispo_order_sid,
   ITPTP_DP.inbound_dispo_order_pos_sid,
   ITPTP_DP.dispo_week,
   ITPTP_DP.dispo_descr,
   ITPTP_DP.order_reference_nr,
   ITPTP_DP.bus_country_cd,
   ITPTP_DP.logistic_temp_cd,
   ITPTP_DP.order_dt,
   ITPTP_DP.purchase_order_nr,
   ITPTP_DP.product_variant_sid,
   ITPTP_DP.prod_variant_nan_nr,
   prod_variant_ian_nr,
   prod_name,
   PR_V.gtin_nr,
   ITPTP_DP.route_descr,
   ITPTP_DP.pallet_type_cd,
   ITPTP_DP.double_deck_fg,
   ITPTP_DP.storage_space_qty,
   ITPTP_DP.total_order_pallet_cnt,
   ITPTP_DP.missing_pallet_cnt,
   ITPTP_DP.total_order_missing_pallet_cnt,
   ITPTP_DP.supplier_sid,
   supplier_location_sid,
   ITPTP_DP.dispo_nr,
   ITPTP_DP.logistic_type_cd,
   dp_departure_site_sid,
   dp_destination_site_sid,
   dp_tgt_departure_dt,
   dp_tgt_delivery_dt,
   dp_dest_punctuality_pct,
   dp_dest_punctuality_cd,
   dp_hauler_sid,
   dp_hauler_delivery_reference_nr,
   dp_inbound_logistics_partner_name,
   dp_logistics_partner_name,
   dp_transport_service_type_cd,
   dp_delivered_pallet_cnt,
   dp_ontime_pallet_cnt,
   dp_hauler_missing_pallet_cnt,
   dp_dept_departure_tmsp,
   dp_dest_arrival_tmsp,
   dp_dest_order_punctuality_pct,
   dp_delivery_progress_pct,
   dp_rdc_delivery_dt,
   dp_rdc_punctuality_pct,
   dp_rdc_punctuality_cd,
   dp_ready_for_collection_dt,
   dp_latest_delivery_dt,
   dp_latest_loading_release_dt,
   dp_advised_for_collection_dt,
   dp_collected_dt,
   dp_unloaded_at_wh_dt,
   dp_order_availability_status_cd,
   dp_order_availability_punctuality_cd,
   dp_pickup_notification_status_cd,
   dp_pickup_punctuality_cd,
   dp_hauler_delivery_punctuality_cd,
   dp_delivery_punctuality_cd,
   dp_preparation_punctuality_status_cd,
   dp_preparation_punctuality_pct,
   dp_is_empty_stock_fg,
   dp_distance_km_meas,
   dp_agmt_co2_emission_kg_meas,
   dp_supplier_price_validity_period_from_tmsp,
   dp_supplier_price_validity_period_to_tmsp,
   dp_supplier_curr_cd,
   dp_supplier_price_per_vehicle_val,
   dp_supplier_price_per_pallet_val,
   dp_hauler_curr_cd,
   dp_hauler_price_validity_period_from_tmsp,
   dp_hauler_price_validity_period_to_tmsp,
   dp_hauler_price_per_vehicle_val,
   dp_hauler_price_per_pallet_val,
   zl2_departure_site_sid,
   zl2_destination_site_sid,
   zl2_tgt_departure_dt,
   zl2_tgt_delivery_dt,
   zl2_dest_punctuality_pct,
   zl2_dest_punctuality_cd,
   zl2_hauler_sid,
   zl2_hauler_delivery_reference_nr,
   zl2_inbound_logistics_partner_name,
   zl2_logistics_partner_name,
   zl2_transport_service_type_cd,
   zl2_delivered_pallet_cnt,
   zl2_ontime_pallet_cnt,
   zl2_hauler_missing_pallet_cnt,
   zl2_dept_departure_tmsp,
   zl2_dest_arrival_tmsp,
   zl2_dest_order_punctuality_pct,
   zl2_delivery_progress_pct,
   zl2_distance_km_meas,
   zl2_agmt_co2_emission_kg_meas,
   zl2_supplier_price_validity_period_from_tmsp,
   zl2_supplier_price_validity_period_to_tmsp,
   zl2_supplier_curr_cd,
   zl2_supplier_price_per_vehicle_val,
   zl2_supplier_price_per_pallet_val,
   zl2_hauler_curr_cd,
   zl2_hauler_price_validity_period_from_tmsp,
   zl2_hauler_price_validity_period_to_tmsp,
   zl2_hauler_price_per_vehicle_val,
   zl2_hauler_price_per_pallet_val,
   zl1_departure_site_sid,
   zl1_destination_site_sid,
   zl1_tgt_departure_dt,
   zl1_tgt_delivery_dt,
   zl1_dest_punctuality_pct,
   zl1_dest_punctuality_cd,
   zl1_hauler_sid,
   zl1_hauler_delivery_reference_nr,
   zl1_inbound_logistics_partner_name,
   zl1_logistics_partner_name,
   zl1_transport_service_type_cd,
   zl1_delivered_pallet_cnt,
   zl1_ontime_pallet_cnt,
   zl1_hauler_missing_pallet_cnt,
   zl1_dept_departure_tmsp,
   zl1_dest_arrival_tmsp,
   zl1_dest_order_punctuality_pct,
   zl1_delivery_progress_pct,
   zl1_distance_km_meas,
   zl1_agmt_co2_emission_kg_meas,
   zl1_supplier_price_validity_period_from_tmsp,
   zl1_supplier_price_validity_period_to_tmsp,
   zl1_supplier_curr_cd,
   zl1_supplier_price_per_vehicle_val,
   zl1_supplier_price_per_pallet_val,
   zl1_hauler_curr_cd,
   zl1_hauler_price_validity_period_from_tmsp,
   zl1_hauler_price_validity_period_to_tmsp,
   zl1_hauler_price_per_vehicle_val,
   zl1_hauler_price_per_pallet_val,
   vl_departure_site_sid,
   vl_destination_site_sid,
   vl_tgt_departure_dt,
   vl_tgt_delivery_dt,
   vl_dest_punctuality_pct,
   vl_dest_punctuality_cd,
   vl_hauler_sid,
   vl_hauler_delivery_reference_nr,
   vl_inbound_logistics_partner_name,
   vl_logistics_partner_name,
   vl_transport_service_type_cd,
   vl_delivered_pallet_cnt,
   vl_ontime_pallet_cnt,
   vl_hauler_missing_pallet_cnt,
   vl_dept_departure_tmsp,
   vl_dest_arrival_tmsp,
   vl_dest_order_punctuality_pct,
   vl_delivery_progress_pct,
   vl_distance_km_meas,
   vl_agmt_co2_emission_kg_meas,
   vl_supplier_price_validity_period_from_tmsp,
   vl_supplier_price_validity_period_to_tmsp,
   vl_supplier_curr_cd,
   vl_supplier_price_per_vehicle_val,
   vl_supplier_price_per_pallet_val,
   vl_hauler_curr_cd,
   vl_hauler_price_validity_period_from_tmsp,
   vl_hauler_price_validity_period_to_tmsp,
   vl_hauler_price_per_vehicle_val,
   vl_hauler_price_per_pallet_val) AS T
 LEFT JOIN ldl_score_core.t_dim_supplier_1 AS SUP ON T.supplier_sid = SUP.supplier_sid
 LEFT JOIN ldl_score_core.t_dim_site_1 AS FM ON T.vl_departure_site_sid = FM.site_sid AND FM.dwh_valid_fg
 LEFT JOIN ldl_score_core.t_dim_hauler_1 AS HFM ON T.vl_hauler_sid = HFM.hauler_sid
 LEFT JOIN ldl_score_core.t_dim_site_1 AS MM1 ON T.zl1_departure_site_sid = MM1.site_sid AND MM1.dwh_valid_fg
 LEFT JOIN ldl_score_core.t_dim_hauler_1 AS HMM1 ON T.zl1_hauler_sid = HMM1.hauler_sid
 LEFT JOIN ldl_score_core.t_dim_site_1 AS MM2 ON T.zl2_departure_site_sid = MM2.site_sid AND MM2.dwh_valid_fg
 LEFT JOIN ldl_score_core.t_dim_hauler_1 AS HMM2 ON T.zl2_hauler_sid = HMM2.hauler_sid
 LEFT JOIN ldl_score_core.t_dim_site_1 AS LM ON T.dp_departure_site_sid = LM.site_sid AND LM.dwh_valid_fg
 LEFT JOIN ldl_score_core.t_dim_hauler_1 AS LMH ON T.dp_hauler_sid = LMH.hauler_sid
 LEFT JOIN ldl_score_core.t_dim_site_1 AS RDC ON T.dp_destination_site_sid = RDC.site_sid AND LM.dwh_valid_fg
 LEFT JOIN ldl_score_core.t_dim_site_1 AS SS ON T.supplier_location_sid = SS.site_sid AND SS.dwh_valid_fg
 LEFT JOIN ldl_score_core.t_dim_site_operator_1 AS SOP_SS ON SS.site_operator_sid = SOP_SS.site_operator_sid AND SOP_SS.dwh_valid_fg
  
 LEFT JOIN ldl_score_core.t_dim_site_operator_1 AS SOP_FM ON CASE
    WHEN T.vl_departure_site_sid IS NOT NULL AND T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid
     IS NOT NULL
    THEN FM.site_operator_sid
    WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
    THEN MM1.site_operator_sid
    WHEN T.zl2_departure_site_sid IS NOT NULL
    THEN MM2.site_operator_sid
    ELSE NULL
    END = SOP_FM.site_operator_sid AND SOP_FM.dwh_valid_fg
 LEFT JOIN ldl_score_core.t_dim_site_operator_1 AS SOP_MM1 ON CASE
    WHEN T.zl1_departure_site_sid IS NOT NULL AND T.zl2_departure_site_sid IS NOT NULL
    THEN MM1.site_operator_sid
    WHEN T.zl2_departure_site_sid IS NOT NULL
    THEN MM2.site_operator_sid
    ELSE NULL
    END = SOP_MM1.site_operator_sid AND SOP_MM1.dwh_valid_fg
 LEFT JOIN ldl_score_core.t_dim_site_operator_1 AS SOP_MM2 ON CASE
    WHEN T.zl2_departure_site_sid IS NOT NULL
    THEN MM2.site_operator_sid
    ELSE NULL
    END = SOP_MM2.site_operator_sid AND SOP_MM2.dwh_valid_fg
 LEFT JOIN ldl_score_core.t_dim_site_operator_1 AS SOP_LM ON LM.site_operator_sid = SOP_LM.site_operator_sid AND SOP_LM.dwh_valid_fg;