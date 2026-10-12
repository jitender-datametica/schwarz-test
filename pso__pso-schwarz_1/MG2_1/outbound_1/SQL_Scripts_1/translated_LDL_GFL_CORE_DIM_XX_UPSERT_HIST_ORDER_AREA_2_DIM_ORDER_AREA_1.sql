INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (dwh_node_cd, tf_error_fg, dwh_load_id, record_id,
 filename, order_area_nr, order_area_descr_de, country_org_sid, country_org_cd, order_area_descr_en, order_area_descr,
 error_descr)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
  CAST(record_id AS STRING) AS record_id,
  filename,
  order_area_nr,
  order_area_descr_de,
  country_org_sid,
  country_org_cd,
  order_area_descr_en,
  order_area_descr,
  error_descr
 FROM (SELECT oa.order_area_nr,
     oa.int_org_sid AS country_org_sid,
     intorg.country_org_cd,
     MAX(CASE
       WHEN oa.lang_cd = 'DE'
       THEN oa.order_area_descr
       ELSE ''
       END) AS order_area_descr,
     MAX(CASE
       WHEN oa.lang_cd = 'EN'
       THEN oa.order_area_descr
       ELSE ''
       END) AS order_area_descr_en,
     MAX(CASE
       WHEN oa.lang_cd = 'DE'
       THEN oa.order_area_descr
       ELSE ''
       END) AS order_area_descr_de,
     CAST(${LOAD_ID} AS INTEGER) AS dwh_load_id,
     oa.dwh_node_cd,
     0 AS tf_error_fg,
     '' AS error_descr,
     0 AS record_id,
     'core_rel.t_order_area_1' AS filename
    FROM ldl_data_production_core_rel.t_order_area_1 AS oa
     INNER JOIN ldl_data_production_core_rel.t_internal_organization_1 AS intorg ON oa.int_org_sid = intorg.int_org_sid
      AND intorg.dwh_valid_fg
    GROUP BY oa.order_area_nr,
     oa.int_org_sid,
     intorg.country_org_cd,
     oa.dwh_node_cd
    UNION ALL
    SELECT -- select all order_area numbers from product which are missing in the core_rel.t_order_area_1 table
 d.order_area_nr
     ,
     d.int_org_sid AS country_org_sid,
     p0.country_org_cd,
     'unbekannt' AS order_area_descr,
     'unknown' AS order_area_descr_en,
     'unbekannt' AS order_area_descr_de,
     CAST(${LOAD_ID} AS INTEGER) AS dwh_load_id,
     'WAWI' AS dwh_node_cd,
     0 AS tf_error_fg,
     '' AS error_descr,
     0 AS record_id,
     'core_rel.t_product_order_area_1' AS filename
    FROM (SELECT p.order_area_nr,
       p.int_org_sid
      FROM ldl_data_production_core_rel.t_product_order_area_1 AS p
       LEFT JOIN ldl_data_production_core_rel.t_order_area_1 AS oa ON p.order_area_nr = oa.order_area_nr AND p.int_org_sid
          = oa.int_org_sid
      WHERE p.dwh_valid_fg
       AND oa.order_area_nr IS NULL
      GROUP BY p.int_org_sid,
       p.order_area_nr) AS d
     LEFT JOIN ldl_data_production_core_rel.t_internal_organization_1 AS p0 ON d.int_org_sid = p0.int_org_sid
    WHERE p0.dwh_valid_fg
     AND p0.int_org_type_cd = 'COMPANY'
    UNION ALL
    SELECT -- insert generell dummy_1
 '@' AS order_area_nr,
     - 1 AS country_org_sid,
     '@' AS country_org_cd,
     '@' AS order_area_descr,
     '@' AS order_area_descr_en,
     '@' AS order_area_descr_de,
     - 1 AS dwh_load_id,
     'DUMMY_1' AS dwh_node_cd,
     0 AS tf_error_fg,
     '' AS error_descr,
     0 AS record_id,
     'DUMMY_1' AS filename) AS t9);


INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (dwh_node_cd, tf_error_fg, dwh_load_id, record_id,
 filename, order_area_nr, order_area_descr_de, country_org_sid, country_org_cd, order_area_descr_en, order_area_descr,
 error_descr)
(SELECT 'DUMMY_1' AS dwh_node_cd,
  0 AS tf_error_fg,
  ${LOAD_ID} AS dwh_load_id,
  CAST(0 AS STRING) AS record_id,
  'DUMMY_1' AS filename,
  -- insert dummys for each country_1
 a.order_area_nr,
  '@' AS order_area_descr_de,
  a.country_org_sid,
  p0.country_org_cd,
  '@' AS order_area_descr_en,
  '@' AS order_area_descr,
  '' AS error_descr
 FROM (SELECT DISTINCT p.order_area_nr,
    p.country_org_sid
   FROM ldl_data_production_core_dim.t_dim_local_product_1 AS p
    LEFT JOIN ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} AS pg ON p.order_area_nr = pg.order_area_nr AND p
      .country_org_sid = pg.country_org_sid
   WHERE pg.order_area_nr IS NULL) AS a
  LEFT JOIN ldl_data_production_core_rel.t_internal_organization_1 AS p0 ON a.country_org_sid = p0.int_org_sid
 WHERE p0.dwh_valid_fg
  AND p0.int_org_type_cd = 'COMPANY');