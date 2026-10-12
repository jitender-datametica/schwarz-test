INSERT INTO ldl_data_production_core_dim.t_dim_real_estate_2 (
  real_estate_sid,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  real_estate_nr,
  real_estate_name,
  real_estate_type_cd,
  real_estate_type_descr,
  real_estate_status_cd,
  real_estate_status_descr,
  int_org_sid,
  curr_int_org_nr,
  int_org_name,
  int_org_type_cd,
  int_org_type_descr,
  ownership_type_cd,
  ownership_type_descr,
  ownership_ratio_type_cd,
  ownership_ratio_type_descr,
  own_acquisition_fg,
  real_estate_usg_type_cd,
  real_estate_usg_type_descr,
  replacement_real_estate_sid,
  replacement_real_estate_nr,
  replacement_real_estate_name,
  real_estate_replacement_type_cd,
  real_estate_replacement_type_descr,
  wh_building_type_cd,
  wh_building_type_descr,
  wh_purpose_cd,
  wh_purpose_descr,
  shared_usg_fg,
  iso_country_cd,
  country_name,
  city_name,
  district_name,
  zip,
  street_name,
  house_nr,
  lon,
  lat,
  po_box_nr,
  phone_nr,
  fax_nr,
  email_addr_txt,
  reporting_country_cd,
  reporting_country_name,
  sales_area_meas,
  storage_area_meas,
  total_sublet_area_meas,
  rented_sublet_area_meas,
  uom_cd,
  sales_area_m2_meas,
  storage_area_m2_meas,
  total_sublet_area_m2_meas,
  rented_sublet_area_m2_meas,
  total_parking_space_cnt,
  own_parking_space_cnt,
  underground_parking_space_cnt,
  rental_cost_val,
  rental_income_val,
  curr_cd,
  rental_cost_eur_val,
  rental_income_eur_val,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
)
WITH validity_listing AS (
  SELECT
    t_real_estate.real_estate_sid,
    t_real_estate.dwh_valid_from_tmsp AS dwh_mapping_tmsp
  FROM
    ldl_data_production_core_rel.t_real_estate_2
  UNION DISTINCT
  SELECT
    t_real_estate.real_estate_sid,
    CASE
      WHEN t_real_estate.dwh_valid_to_tmsp = TIMESTAMP '9999‑12‑31 23:59:59.999999'
        THEN t_real_estate.dwh_valid_to_tmsp
      ELSE
        TIMESTAMP_ADD(t_real_estate.dwh_valid_to_tmsp, INTERVAL 1 MICROSECOND)
    END AS dwh_mapping_tmsp
  FROM
    ldl_data_production_core_rel.t_real_estate_2
  UNION DISTINCT
  SELECT
    t_real_estate.real_estate_sid,
    CAST('1900‑01‑01' AS TIMESTAMP) AS dwh_mapping_tmsp
  FROM
    ldl_data_production_core_rel.t_real_estate_2
  UNION DISTINCT
  SELECT
    t_real_estate_status.real_estate_sid,
    t_real_estate_status.dwh_valid_from_tmsp AS dwh_mapping_tmsp
  FROM
    ldl_data_production_core_rel.t_real_estate_status_2
  UNION DISTINCT
  SELECT
    t_real_estate_status.real_estate_sid,
    CASE
      WHEN t_real_estate_status.dwh_valid_to_tmsp = TIMESTAMP '9999‑12‑31 23:59:59.999999'
        THEN t_real_estate_status.dwh_valid_to_tmsp
      ELSE
        TIMESTAMP_ADD(t_real_estate_status.dwh_valid_to_tmsp, INTERVAL 1 MICROSECOND)
    END AS dwh_mapping_tmsp
  FROM
    ldl_data_production_core_rel.t_real_estate_status_2
  UNION DISTINCT
  SELECT
    t_r2d_resource_item_cost.real_estate_sid,
    t_r2d_resource_item_cost.dwh_valid_from_tmsp AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_resource_item_cost_2
  UNION DISTINCT
  SELECT
    t_r2d_resource_item_cost.real_estate_sid,
    CASE
      WHEN t_r2d_resource_item_cost.dwh_valid_to_tmsp = TIMESTAMP '9999‑12‑31 23:59:59.999999'
        THEN t_r2d_resource_item_cost.dwh_valid_to_tmsp
      ELSE
        TIMESTAMP_ADD(t_r2d_resource_item_cost.dwh_valid_to_tmsp, INTERVAL 1 MICROSECOND)
    END AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_resource_item_cost_2
  UNION DISTINCT
  SELECT
    t_r2d_real_estate_replacement.real_estate_sid,
    t_r2d_real_estate_replacement.dwh_valid_from_tmsp AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_real_estate_replacement_2
  UNION DISTINCT
  SELECT
    t_r2d_real_estate_replacement.real_estate_sid,
    CASE
      WHEN t_r2d_real_estate_replacement.dwh_valid_to_tmsp = TIMESTAMP '9999‑12‑31 23:59:59.999999'
        THEN t_r2d_real_estate_replacement.dwh_valid_to_tmsp
      ELSE
        TIMESTAMP_ADD(t_r2d_real_estate_replacement.dwh_valid_to_tmsp, INTERVAL 1 MICROSECOND)
    END AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_real_estate_replacement_2
  UNION DISTINCT
  SELECT
    t_r2d_real_estate_street_address.real_estate_sid,
    t_r2d_real_estate_street_address.dwh_valid_from_tmsp AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_real_estate_street_address_2
  UNION DISTINCT
  SELECT
    t_r2d_real_estate_street_address.real_estate_sid,
    CASE
      WHEN t_r2d_real_estate_street_address.dwh_valid_to_tmsp = TIMESTAMP '9999‑12‑31 23:59:59.999999'
        THEN t_r2d_real_estate_street_address.dwh_valid_to_tmsp
      ELSE
        TIMESTAMP_ADD(t_r2d_real_estate_street_address.dwh_valid_to_tmsp, INTERVAL 1 MICROSECOND)
    END AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_real_estate_street_address_2
  UNION DISTINCT
  SELECT
    t_r2d_real_estate_phone.real_estate_sid,
    t_r2d_real_estate_phone.dwh_valid_from_tmsp AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_real_estate_phone_2
  UNION DISTINCT
  SELECT
    t_r2d_real_estate_phone.real_estate_sid,
    CASE
      WHEN t_r2d_real_estate_phone.dwh_valid_to_tmsp = TIMESTAMP '9999‑12‑31 23:59:59.999999'
        THEN t_r2d_real_estate_phone.dwh_valid_to_tmsp
      ELSE
        TIMESTAMP_ADD(t_r2d_real_estate_phone.dwh_valid_to_tmsp, INTERVAL 1 MICROSECOND)
    END AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_real_estate_phone_2
  UNION DISTINCT
  SELECT
    t_r2d_real_estate_internal_organization.real_estate_sid,
    t_r2d_real_estate_internal_organization.dwh_valid_from_tmsp AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_real_estate_internal_organization_2
  UNION DISTINCT
  SELECT
    t_r2d_real_estate_internal_organization.real_estate_sid,
    CASE
      WHEN t_r2d_real_estate_internal_organization.dwh_valid_to_tmsp = TIMESTAMP '9999‑12‑31 23:59:59.999999'
        THEN t_r2d_real_estate_internal_organization.dwh_valid_to_tmsp
      ELSE
        TIMESTAMP_ADD(t_r2d_real_estate_internal_organization.dwh_valid_to_tmsp, INTERVAL 1 MICROSECOND)
    END AS dwh_mapping_tmsp
  FROM
    ldl_data_production_etl.t_r2d_real_estate_internal_organization_2
)
SELECT 
  vl.real_estate_sid,
  vl.dwh_mapping_tmsp AS val_from,
  COALESCE(
    TIMESTAMP_SUB(
      LEAD(vl.dwh_mapping_tmsp)
        OVER (PARTITION BY vl.real_estate_sid ORDER BY vl.dwh_mapping_tmsp ASC),
      INTERVAL 1 MICROSECOND
    ),
    TIMESTAMP '9999‑12‑31 23:59:59.999999'
  ) AS val_to,
  CURRENT_TIMESTAMP() BETWEEN vl.dwh_mapping_tmsp 
    AND COALESCE(
          TIMESTAMP_SUB(
            LEAD(vl.dwh_mapping_tmsp)
              OVER (PARTITION BY vl.real_estate_sid ORDER BY vl.dwh_mapping_tmsp ASC),
            INTERVAL 1 MICROSECOND
          ),
          TIMESTAMP '9999‑12‑31 23:59:59.999999'
        ) AS dwh_valid_fg,
  re.real_estate_nr,
  IFNULL(re.real_estate_name, 'Unbekannt') AS real_estate_name,
  IFNULL(re.real_estate_type_cd, '@') AS real_estate_type_cd,
  IFNULL(ret.real_estate_type_descr, 'Unbekannt') AS real_estate_type_descr,
  IFNULL(res.real_estate_status_cd, '@') AS real_estate_status_cd,
  IFNULL(rest.real_estate_status_descr, 'Unbekannt') AS real_estate_status_descr,
  IFNULL(reio.int_org_sid, -1) AS int_org_sid,
  IFNULL(reio.curr_int_org_nr, '@') AS curr_int_org_nr,
  IFNULL(reio.int_org_name, 'Unbekannt') AS int_org_name,
  IFNULL(reio.int_org_type_cd, '@') AS int_org_type_cd,
  IFNULL(reio.int_org_type_descr, 'Unbekannt') AS int_org_type_descr,
  IFNULL(re.ownership_type_cd, '@') AS ownership_type_cd,
  IFNULL(ot.ownership_type_descr, 'Unbekannt') AS ownership_type_descr,
  IFNULL(re.ownership_ratio_type_cd, '@') AS ownership_ratio_type_cd,
  IFNULL(ort.ownership_ratio_type_descr, 'Unbekannt') AS ownership_ratio_type_descr,
  IFNULL(re.own_acquisition_fg, FALSE) AS own_acquisition_fg,
  IFNULL(re.real_estate_usg_type_cd, '@') AS real_estate_usg_type_cd,
  IFNULL(reut.real_estate_usg_type_descr, 'Unbekannt') AS real_estate_usg_type_descr,
  IFNULL(re_repl.replacement_real_estate_sid, -1) AS replacement_real_estate_sid,
  re_repl.replacement_real_estate_nr,
  IFNULL(re_repl.replacement_real_estate_name, 'Unbekannt') AS replacement_real_estate_name,
  IFNULL(re_repl.real_estate_replacement_type_cd, '@') AS real_estate_replacement_type_cd,
  IFNULL(re_repl.real_estate_replacement_type_descr, 'Unbekannt') AS real_estate_replacement_type_descr,
  IFNULL(re.wh_building_type_cd, '@') AS wh_building_type_cd,
  IFNULL(wbt.wh_building_type_descr, 'Unbekannt') AS wh_building_type_descr,
  IFNULL(re.wh_purpose_cd, '@') AS wh_purpose_cd,
  IFNULL(wp.wh_purpose_descr, 'Unbekannt') AS wh_purpose_descr,
  IFNULL(re.shared_usg_fg, FALSE) AS shared_usg_fg,
  IFNULL(re_addr.iso_country_cd, '@') AS iso_country_cd,
  IFNULL(re_addr.country_name, 'Unbekannt') AS country_name,
  re_addr.city_name,
  re_addr.district_name,
  re_addr.zip,
  re_addr.street_name,
  re_addr.house_nr,
  CAST(re_addr.lon AS NUMERIC),
  CAST(re_addr.lat AS NUMERIC),
  CAST(NULL AS STRING) AS po_box_nr,
  re_tel.phone_nr,
  CAST(NULL AS STRING) AS fax_nr,
  'Unbekannt' AS email_addr_txt,
  IFNULL(re_addr.reporting_country_cd, '@') AS reporting_country_cd,
  IFNULL(re_addr.reporting_country_name, 'Unbekannt') AS reporting_country_name,
  re.sales_area_meas,
  re.storage_area_meas,
  re.total_sublet_area_meas,
  re.rented_sublet_area_meas,
  IFNULL(re.uom_cd, '@') AS uom_cd,
  CASE 
    WHEN re.uom_cd = 'SQFT' THEN re.sales_area_meas / 10.76391042 
    ELSE re.sales_area_meas 
  END AS sales_area_m2_meas,
  CASE 
    WHEN re.uom_cd = 'SQFT' THEN re.storage_area_meas / 10.76391042 
    ELSE re.storage_area_meas 
  END AS storage_area_m2_meas,
  CASE 
    WHEN re.uom_cd = 'SQFT' THEN re.total_sublet_area_meas / 10.76391042 
    ELSE re.total_sublet_area_meas 
  END AS total_sublet_area_m2_meas,
  CASE 
    WHEN re.uom_cd = 'SQFT' THEN re.rented_sublet_area_meas / 10.76391042 
    ELSE re.rented_sublet_area_meas 
  END AS rented_sublet_area_m2_meas,
  re.total_parking_space_cnt,
  re.own_parking_space_cnt,
  re.underground_parking_space_cnt,
  c_lo.cost_val AS rental_cost_val,
  c_li.cost_val AS rental_income_val,
  COALESCE(c_lo.curr_cd, c_li.curr_cd, '@') AS curr_cd,
  c_lo.cost_eur_val AS rental_cost_eur_val,
  c_li.cost_eur_val AS rental_income_eur_val,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
  -1 AS dwh_load_id,
  'CORE_REL' AS dwh_node_cd
FROM validity_listing vl
LEFT JOIN ldl_data_production_core_rel.t_real_estate_2 re_2
  ON re.real_estate_sid = vl.real_estate_sid
    AND vl.dwh_mapping_tmsp BETWEEN re.dwh_valid_from_tmsp AND re.dwh_valid_to_tmsp
LEFT JOIN ldl_data_production_core_rel.t_real_estate_status_2 res
  ON res.real_estate_sid = vl.real_estate_sid
    AND res.real_estate_status_categ_cd = 'BS'
    AND vl.dwh_mapping_tmsp BETWEEN res.dwh_valid_from_tmsp AND res.dwh_valid_to_tmsp
LEFT JOIN ldl_data_production_etl.t_r2d_real_estate_internal_organization_2 reio
  ON reio.real_estate_sid = vl.real_estate_sid
    AND vl.dwh_mapping_tmsp BETWEEN reio.dwh_valid_from_tmsp AND reio.dwh_valid_to_tmsp
LEFT JOIN ldl_data_production_etl.t_r2d_real_estate_replacement_2 re_repl
  ON re_repl.real_estate_sid = vl.real_estate_sid
    AND vl.dwh_mapping_tmsp BETWEEN re_repl.dwh_valid_from_tmsp AND re_repl.dwh_valid_to_tmsp
LEFT JOIN ldl_data_production_etl.t_r2d_real_estate_street_address_2 re_addr
  ON re_addr.real_estate_sid = vl.real_estate_sid
    AND vl.dwh_mapping_tmsp BETWEEN re_addr.dwh_valid_from_tmsp AND re_addr.dwh_valid_to_tmsp
LEFT JOIN ldl_data_production_etl.t_r2d_real_estate_phone_2 re_tel
  ON re_tel.real_estate_sid = vl.real_estate_sid
    AND vl.dwh_mapping_tmsp BETWEEN re_tel.dwh_valid_from_tmsp AND re_tel.dwh_valid_to_tmsp
LEFT JOIN ldl_data_production_etl.t_r2d_resource_item_cost_2 c_lo
  ON c_lo.real_estate_sid = vl.real_estate_sid
    AND c_lo.cost_type_cd = 'LO'
    AND c_lo.resource_item_type_cd = 'RE_2'
    AND vl.dwh_mapping_tmsp BETWEEN c_lo.dwh_valid_from_tmsp AND c_lo.dwh_valid_to_tmsp
LEFT JOIN ldl_data_production_etl.t_r2d_resource_item_cost_2 c_li
  ON c_li.real_estate_sid = vl.real_estate_sid
    AND c_li.cost_type_cd = 'LI'
    AND c_li.resource_item_type_cd = 'RE_2'
    AND vl.dwh_mapping_tmsp BETWEEN c_li.dwh_valid_from_tmsp AND c_li.dwh_valid_to_tmsp
LEFT JOIN ldl_data_production_core_rel.t_real_estate_status_type_2 rest
  ON res.real_estate_status_categ_cd = rest.real_estate_status_categ_cd
    AND res.real_estate_status_cd = rest.real_estate_status_cd
    AND rest.lang_cd = 'DE'
    AND rest.real_estate_status_categ_cd = 'BS'
LEFT JOIN ldl_data_production_core_rel.t_real_estate_type_2 ret
  ON re.real_estate_type_cd = ret.real_estate_type_cd
    AND ret.lang_cd = 'DE'
LEFT JOIN ldl_data_production_core_rel.t_ownership_type_2 ot
  ON re.ownership_type_cd = ot.ownership_type_cd
    AND ot.lang_cd = 'DE'
LEFT JOIN ldl_data_production_core_rel.t_ownership_ratio_type_2 ort
  ON re.ownership_ratio_type_cd = ort.ownership_ratio_type_cd
    AND ort.lang_cd = 'DE'
LEFT JOIN ldl_data_production_core_rel.t_real_estate_usage_type_2 reut
  ON re.real_estate_usg_type_cd = reut.real_estate_usg_type_cd
    AND reut.lang_cd = 'DE'
LEFT JOIN ldl_data_production_core_rel.t_warehouse_building_type_2 wbt
  ON re.wh_building_type_cd = wbt.wh_building_type_cd
    AND wbt.lang_cd = 'DE'
LEFT JOIN ldl_data_production_core_rel.t_warehouse_purpose_2 wp
  ON re.wh_purpose_cd = wp.wh_purpose_cd
    AND wp.lang_cd = 'DE'
WHERE vl.dwh_mapping_tmsp < TIMESTAMP '9999‑12‑31 23:59:59.999999'
;
