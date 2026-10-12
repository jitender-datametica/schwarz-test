INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (sup_sid, sup_name, legal_name, vat_nr, sup_status_cd, sup_status_descr, iso_country_cd, country_name, city_name, district_name, zip, street_name, house_nr, lon, lat, dwh_valid_fg, dwh_mapping_tmsp, dwh_load_id, dwh_node_cd, tf_error_fg, error_descr, record_id, filename, deleted_fg)
  SELECT
      s.sup_sid,
      COALESCE(org.org_name, 'Unbekannt') AS sup_name,
      COALESCE(org.legal_name, 'Unbekannt') AS legal_name,
      COALESCE(org.vat_nr, '-1') AS vat_nr,
      '@' AS sup_status_cd,
      'Unbekannt' AS sup_status_descr,
      COALESCE(c.iso_country_cd, '@') AS iso_country_cd,
      COALESCE(c.country_name, 'unbekannt') AS country_name,
      'Unbekannt' AS city_name,
      'Unbekannt' AS district_name,
      NUMERIC '1' AS zip,
      'Unbekannt' AS street_name,
      NULL AS house_nr,
      NULL AS lon,
      NULL AS lat,
      s.dwh_valid_fg,
      s.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
      ${load_id} AS dwh_load_id,
      s.dwh_node_cd,
      NUMERIC '0' AS tf_error_fg,
      '' AS error_descr,
      NUMERIC '0' AS record_id,
      't_product_supplier' AS filename,
      NUMERIC '0' AS deleted_fg
    FROM
      ldl_data_production.core_rel.t_product_supplier AS s
      LEFT OUTER JOIN ldl_data_production.core_rel.t_organization AS org ON s.sup_sid = org.org_sid
       AND org.dwh_valid_fg = NUMERIC '1'
       AND org.is_sup_fg = NUMERIC '1'
       AND org.org_type_cd = 'COMPANY'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_country AS c ON s.int_org_sid = c.country_sid
       AND c.dwh_valid_fg = NUMERIC '1'
    WHERE s.dwh_valid_fg = NUMERIC '1'
    QUALIFY ROW_NUMBER() OVER (PARTITION BY s.sup_sid ORDER BY IF(dwh_mapping_tmsp IS NULL, 0, 1) DESC, dwh_mapping_tmsp) = zip
;
