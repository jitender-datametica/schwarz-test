CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_real_estate_street_address_consistent_2 (real_estate_sid,
dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, real_estate_nr, real_estate_name, real_estate_type_cd,
real_estate_type_descr, real_estate_status_cd, real_estate_status_descr, int_org_sid, curr_int_org_nr, int_org_name,
int_org_type_cd, int_org_type_descr, ownership_type_cd, ownership_type_descr, ownership_ratio_type_cd,
ownership_ratio_type_descr, own_acquisition_fg, real_estate_usg_type_cd, real_estate_usg_type_descr,
replacement_real_estate_sid, replacement_real_estate_nr, replacement_real_estate_name, real_estate_replacement_type_cd,
real_estate_replacement_type_descr, wh_building_type_cd, wh_building_type_descr, wh_purpose_cd, wh_purpose_descr,
shared_usg_fg, iso_country_cd, country_name, city_name, district_name, zip, street_name, house_nr, lon, lat, po_box_nr,
phone_nr, fax_nr, email_addr_txt, reporting_country_cd, reporting_country_name, sales_area_meas, storage_area_meas,
total_sublet_area_meas, rented_sublet_area_meas, uom_cd, sales_area_m2_meas, storage_area_m2_meas,
total_sublet_area_m2_meas, rented_sublet_area_m2_meas, total_parking_space_cnt, own_parking_space_cnt,
underground_parking_space_cnt, rental_cost_val, rental_income_val, curr_cd, rental_cost_eur_val, rental_income_eur_val,
dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd, real_estate_address_real_estate_sid,
real_estate_address_addr_sid, street_address_street_addr_sid, street_address_country_name, street_address_city_name,
street_address_district_name, street_address_zip, street_address_street_name, street_address_house_nr,
street_address_lon, street_address_lat, failed_country_name_consistent, failed_city_name_consistent,
failed_district_name_consistent, failed_zip_consistent, failed_street_name_consistent, failed_house_nr_consistent,
failed_lon_consistent, failed_lat_consistent, total)
OPTIONS(DESCRIPTION = `CHECK CONSISTENCY BETWEEN THE ADDRESS_2 FIELDS IN CORE_DIM.T_DIM_REAL_ESTATE_2 AND CORE_REL.T_STREET_ADDRESS_2\\NINPUT DATASETS:\\NCORE_DIM.T_DIM_REAL_ESTATE_2\\NCORE_REL.T_REAL_ESTATE_ADDRESS_2\\NCORE_REL.T_STREET_ADDRESS_2`)
AS SELECT real_estate.real_estate_sid,
 real_estate.dwh_valid_from_tmsp,
 real_estate.dwh_valid_to_tmsp,
 real_estate.dwh_valid_fg,
 real_estate.real_estate_nr,
 real_estate.real_estate_name,
 real_estate.real_estate_type_cd,
 real_estate.real_estate_type_descr,
 real_estate.real_estate_status_cd,
 real_estate.real_estate_status_descr,
 real_estate.int_org_sid,
 real_estate.curr_int_org_nr,
 real_estate.int_org_name,
 real_estate.int_org_type_cd,
 real_estate.int_org_type_descr,
 real_estate.ownership_type_cd,
 real_estate.ownership_type_descr,
 real_estate.ownership_ratio_type_cd,
 real_estate.ownership_ratio_type_descr,
 real_estate.own_acquisition_fg,
 real_estate.real_estate_usg_type_cd,
 real_estate.real_estate_usg_type_descr,
 real_estate.replacement_real_estate_sid,
 real_estate.replacement_real_estate_nr,
 real_estate.replacement_real_estate_name,
 real_estate.real_estate_replacement_type_cd,
 real_estate.real_estate_replacement_type_descr,
 real_estate.wh_building_type_cd,
 real_estate.wh_building_type_descr,
 real_estate.wh_purpose_cd,
 real_estate.wh_purpose_descr,
 real_estate.shared_usg_fg,
 real_estate.iso_country_cd,
 real_estate.country_name,
 real_estate.city_name,
 real_estate.district_name,
 real_estate.zip,
 real_estate.street_name,
 real_estate.house_nr,
 real_estate.lon,
 real_estate.lat,
 real_estate.po_box_nr,
 real_estate.phone_nr,
 real_estate.fax_nr,
 real_estate.email_addr_txt,
 real_estate.reporting_country_cd,
 real_estate.reporting_country_name,
 real_estate.sales_area_meas,
 real_estate.storage_area_meas,
 real_estate.total_sublet_area_meas,
 real_estate.rented_sublet_area_meas,
 real_estate.uom_cd,
 real_estate.sales_area_m2_meas,
 real_estate.storage_area_m2_meas,
 real_estate.total_sublet_area_m2_meas,
 real_estate.rented_sublet_area_m2_meas,
 real_estate.total_parking_space_cnt,
 real_estate.own_parking_space_cnt,
 real_estate.underground_parking_space_cnt,
 real_estate.rental_cost_val,
 real_estate.rental_income_val,
 real_estate.curr_cd,
 real_estate.rental_cost_eur_val,
 real_estate.rental_income_eur_val,
 real_estate.dwh_created_tmsp,
 real_estate.dwh_updated_tmsp,
 real_estate.dwh_load_id,
 real_estate.dwh_node_cd,
 real_estate_address.real_estate_sid AS real_estate_address_real_estate_sid,
 real_estate_address.addr_sid AS real_estate_address_addr_sid,
 street_address.street_addr_sid AS street_address_street_addr_sid,
 street_address.country_name AS street_address_country_name,
 street_address.city_name AS street_address_city_name,
 street_address.district_name AS street_address_district_name,
 street_address.zip AS street_address_zip,
 street_address.street_name AS street_address_street_name,
 street_address.house_nr AS street_address_house_nr,
 street_address.lon AS street_address_lon,
 street_address.lat AS street_address_lat,
  CASE
  WHEN real_estate.country_name <> street_address.country_name
  THEN 1
  ELSE 0
  END AS failed_country_name_consistent,
  CASE
  WHEN real_estate.city_name <> street_address.city_name
  THEN 1
  ELSE 0
  END AS failed_city_name_consistent,
  CASE
  WHEN real_estate.district_name <> street_address.district_name
  THEN 1
  ELSE 0
  END AS failed_district_name_consistent,
  CASE
  WHEN real_estate.zip <> street_address.zip
  THEN 1
  ELSE 0
  END AS failed_zip_consistent,
  CASE
  WHEN real_estate.street_name <> street_address.street_name
  THEN 1
  ELSE 0
  END AS failed_street_name_consistent,
  CASE
  WHEN real_estate.house_nr <> street_address.house_nr
  THEN 1
  ELSE 0
  END AS failed_house_nr_consistent,
  CASE
  WHEN real_estate.lon <> street_address.lon
  THEN 1
  ELSE 0
  END AS failed_lon_consistent,
  CASE
  WHEN real_estate.lat <> street_address.lat
  THEN 1
  ELSE 0
  END AS failed_lat_consistent,
 1 AS total
FROM ldl_data_production_core_dim.t_dim_real_estate_2 AS real_estate
 LEFT JOIN (SELECT real_estate_sid,
   addr_sid
  FROM ldl_data_production_core_rel.t_real_estate_address_2
  WHERE addr_type_cd = 'STAD'
   AND dwh_valid_fg) AS real_estate_address ON real_estate.real_estate_sid = real_estate_address.real_estate_sid
 LEFT JOIN (SELECT street_addr_sid,
   country_name,
   city_name,
   district_name,
   zip,
   street_name,
   house_nr,
   lon,
   lat
  FROM ldl_data_production_core_rel.t_street_address_2
  WHERE dwh_valid_fg) AS street_address ON real_estate_address.addr_sid = street_address.street_addr_sid
WHERE real_estate.dwh_valid_fg;