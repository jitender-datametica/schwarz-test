
-- COALESCE(p1.party_sid, -1) importer_party_sid,
 -- h.clearance_date clearance_tmsp,
 -- entry_date entry_tmsp,

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, importer_party_sid,
 consignor_name, movement_ref_number, broker_declarant_party_sid, customs_declaration_type_cd, consignor_party_sid,
 authority_country_location_sid, clearance_dt, transport_country_location_sid, dispatch_country_location_sid,
 customs_val, import_location_sid, trader_reference, first_deferment, transport_route_type_cd, transport_type_cd,
 vat_adjustment_val, air_transport_adjust_cost_curr_cd, entry_dt, invoice_auth_country_val, invoice_trust_val,
 total_excise_val, invoice_trust_curr_cd, total_cap_val, transport_adjust_cost_val, entry_tmsp, clearance_tmsp,
 total_duty_val, total_vat_paid_val, declaration_ucr, acceptance_dt, total_vat_val, total_packages_cnt,
 paying_agent_number, vat_adjustment_curr_cd, air_transport_adjust_cost_val, transport_adjust_cost_curr_cd,
 invoice_auth_country_curr_cd, second_deferment, importer_declarant_party_sid)
(SELECT COALESCE(h.dwh_src_file_name, 'na') AS dwh_src_file_name,
  0 AS tf_error_fg,
  COALESCE(h.dwh_src_1_tmsp, CURRENT_TIMESTAMP()) AS dwh_src_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(1 AS BOOL) AS dwh_valid_fg,
  CAST(0 AS STRING) AS record_id,
  COALESCE(h.dwh_src_1_tmsp, CURRENT_TIMESTAMP()) AS dwh_mapping_tmsp,
  COALESCE(h.dwh_src_file_name, 'na') AS filename,
  COALESCE(NULLIF(con.importer_party_sid, - 1), p4.party_sid, - 1) AS importer_party_sid,
  i.consignor AS consignor_name,
  h.entry_identifier AS movement_ref_number,
  COALESCE(p3.party_sid, - 1) AS broker_declarant_party_sid,
  COALESCE(h.declaration_category, '-1') AS customs_declaration_type_cd,
  COALESCE(pk.party_sid, - 1) AS consignor_party_sid,
  gb_loc.location_sid AS authority_country_location_sid,
  DATE(SUBSTR(h.clearance_date, 1, 10)) AS clearance_dt,
  COALESCE(lc.location_sid, - 1) AS transport_country_location_sid,
  COALESCE(l1.location_sid, - 1) AS dispatch_country_location_sid,
  ROUND(SAFE_CAST(h.customs_value AS BIGNUMERIC), 5) AS customs_val,
  COALESCE(l2.location_sid, - 1) AS import_location_sid,
  COALESCE(NULLIF(h.declarant_reference, 'NULL'), NULLIF(br.trader_reference, 'NULL')) AS trader_reference,
  CAST(ROUND(SAFE_CAST(h.deferment_1 AS BIGNUMERIC), 0) AS STRING) AS first_deferment,
  COALESCE(tt.transport_route_type_cd, 'BEFORE_IMPORT') AS transport_route_type_cd,
  COALESCE(tt.transport_type_cd, 'UNKNOWN') AS transport_type_cd,
  ROUND(SAFE_CAST(h.vat_value_adjustment AS BIGNUMERIC), 5) AS vat_adjustment_val,
  COALESCE(CASE
    WHEN h.air_transport_cost_adjustment_currency = 'NULL'
    THEN NULL
    ELSE h.air_transport_cost_adjustment_currency
    END, '-1') AS air_transport_adjust_cost_curr_cd,
  DATE(SUBSTR(h.entry_date, 1, 10)),
  ROUND(SAFE_CAST(h.invoice_total_gbp AS BIGNUMERIC), 5) AS invoice_auth_country_val,
  ROUND(SAFE_CAST(h.invoice_total AS BIGNUMERIC), 5) AS invoice_trust_val,
  ROUND(SAFE_CAST(h.total_excise AS BIGNUMERIC), 5) AS total_excise_val,
  COALESCE(NULLIF(h.invoice_currency, 'NULL'), '-1') AS invoice_trust_curr_cd,
  ROUND(SAFE_CAST(h.total_cap AS BIGNUMERIC), 5) AS total_cap_val,
  ROUND(SAFE_CAST(h.transport_cost_adjustment AS BIGNUMERIC), 5) AS transport_adjust_cost_val,
  CAST(CASE
    WHEN LENGTH(h.entry_date) = 10 AND SUBSTR(TRIM(h.entry_date), 3, 1) = '/'
    THEN PARSE_DATETIME('%d/%m/%Y %H:%M:%S', SUBSTR(h.entry_date, 1, 10) || ' 00:00:00')
    WHEN LENGTH(h.entry_date) = 10 AND SUBSTR(TRIM(h.entry_date), 5, 1) = '-'
    THEN PARSE_DATETIME('%F %H:%M:%S', SUBSTR(h.entry_date, 1, 10) || ' 00:00:00')
    WHEN SUBSTR(TRIM(h.entry_date), 3, 1) = '/'
    THEN PARSE_DATETIME('%d/%m/%Y %H:%M:%S', SUBSTR(h.entry_date, 1, 19))
    WHEN SUBSTR(TRIM(h.entry_date), 5, 1) = '-'
    THEN PARSE_DATETIME('%F %H:%M:%S', SUBSTR(h.entry_date, 1, 19))
    ELSE NULL
    END AS TIMESTAMP) AS entry_tmsp,
  CAST(CASE
    WHEN LENGTH(h.clearance_date) = 10 AND SUBSTR(TRIM(h.clearance_date), 3, 1) = '/'
    THEN PARSE_DATETIME('%d/%m/%Y %H:%M:%S', SUBSTR(h.clearance_date, 1, 10) || ' 00:00:00')
    WHEN LENGTH(h.clearance_date) = 10 AND SUBSTR(TRIM(h.clearance_date), 5, 1) = '-'
    THEN PARSE_DATETIME('%F %H:%M:%S', SUBSTR(h.clearance_date, 1, 10) || ' 00:00:00')
    WHEN SUBSTR(TRIM(h.clearance_date), 3, 1) = '/'
    THEN PARSE_DATETIME('%d/%m/%Y %H:%M:%S', SUBSTR(h.clearance_date, 1, 19))
    WHEN SUBSTR(TRIM(h.clearance_date), 5, 1) = '-'
    THEN PARSE_DATETIME('%F %H:%M:%S', SUBSTR(h.clearance_date, 1, 19))
    ELSE NULL
    END AS TIMESTAMP) AS clearance_tmsp,
  ROUND(SAFE_CAST(h.total_duty AS BIGNUMERIC), 5) AS total_duty_val,
  ROUND(SAFE_CAST(h.total_vat_paid AS BIGNUMERIC), 5) AS total_vat_paid_val,
  h.ducr AS declaration_ucr,
  DATE(CASE
    WHEN COALESCE(NULLIF(h.acceptance_date, 'NULL'), '1900-12-31') = '1900-12-31'
    THEN '1900-12-31'
    ELSE CAST(DATE(SUBSTR(h.acceptance_date, 1, 10)) AS STRING)
    END) AS acceptance_dt,
  ROUND(SAFE_CAST(h.total_vat_value AS BIGNUMERIC), 5) AS total_vat_val,
  COALESCE(ROUND(SAFE_CAST(h.total_packages AS BIGNUMERIC), 5), 0) AS total_packages_cnt,
  NULLIF(h.paying_agent_eori, 'NULL') AS paying_agent_number,
  COALESCE(NULLIF(h.vat_adjustment_currency, 'NULL'), '-1') AS vat_adjustment_curr_cd,
  ROUND(SAFE_CAST(h.air_transport_cost_adjustment AS BIGNUMERIC), 5) AS air_transport_adjust_cost_val,
  COALESCE(NULLIF(h.transport_cost_adjustment_currency, 'NULL'), '-1') AS transport_adjust_cost_curr_cd,
  'GBP' AS invoice_auth_country_curr_cd,
  ROUND(SAFE_CAST(i.deferment_2 AS BIGNUMERIC), 0) AS second_deferment,
  COALESCE(p2.party_sid, - 1) AS importer_declarant_party_sid
 FROM szd_production_etl.t_cache_cds_header AS h
  LEFT JOIN (SELECT DISTINCT entry_identifier,
    DATE(SUBSTR(clearance_date, 1, 10)) AS clearance_date,
     CASE
     WHEN country_of_dispatch = 'NULL'
     THEN NULL
     ELSE country_of_dispatch
     END AS country_of_dispatch,
     CASE
     WHEN location_of_goods = 'NULL'
     THEN NULL
     ELSE location_of_goods
     END AS location_of_goods,
     CASE
     WHEN consignor = 'NULL'
     THEN NULL
     ELSE consignor
     END AS consignor,
     CASE
     WHEN deferment_2 = 'NULL'
     THEN NULL
     ELSE deferment_2
     END AS deferment_2
   FROM szd_production_etl.t_cache_cds_item) AS i ON h.entry_identifier = i.entry_identifier AND DATE(SUBSTR(h.clearance_date
      , 1, 10)) = i.clearance_date
  INNER JOIN (SELECT *
   FROM szd_production_meta.t_location_key
   WHERE location_key_type_cd = 'COUNTRY'
    AND location_nat_key_nr = 'GB') AS gb_loc ON TRUE
  LEFT JOIN szd_production_meta.t_party_key AS p1 ON p1.party_key_type_cd = 'CONSIGNOR' AND p1.party_nat_key_nr = NULLIF(UPPER(i
      .consignor), 'NULL')
  LEFT JOIN szd_production_core_rel.t_consignor AS con ON p1.party_sid = con.party_sid
  LEFT JOIN szd_production_meta.t_party_key AS p4 ON p4.party_key_type_cd = 'IMPORTER' AND p4.party_nat_key_nr = NULLIF(h
     .importer_eori, 'NULL')
  LEFT JOIN szd_production_meta.t_party_key AS p2 ON p2.party_key_type_cd = 'IMPORTER' AND p2.party_nat_key_nr = NULLIF(h
     .declarant_eori, 'NULL')
  LEFT JOIN szd_production_meta.t_party_key AS p3 ON p3.party_key_type_cd = 'BROKER' AND p3.party_nat_key_nr = NULLIF(h
     .declarant_eori, 'NULL')
  LEFT JOIN szd_production_meta.t_location_key AS l1 ON l1.location_key_type_cd = 'COUNTRY' AND i.country_of_dispatch =
    l1.location_nat_key_nr
  LEFT JOIN szd_production_meta.t_location_key AS l2 ON l2.location_key_type_cd = 'TRANSHIPMENT' AND l2.location_nat_key_nr
     = 'GB|' || i.location_of_goods
  LEFT JOIN szd_production_core_rel.t_transport_type AS tt ON h.transport_mode = tt.foreigntrade_id
  LEFT JOIN szd_production_meta.t_location_key AS lc ON lc.location_key_type_cd = 'COUNTRY' AND h.transport_country = lc
    .location_nat_key_nr
  LEFT JOIN szd_production_meta.t_party_key AS pk ON pk.party_nat_key_nr = UPPER(TRIM(i.consignor)) AND pk.party_key_type_cd
     = 'CONSIGNOR'
  LEFT JOIN (SELECT DISTINCT movement_ref_number,
    trader_reference
   FROM szd_production_core_rel.t_broker_report) AS br ON h.entry_identifier = br.movement_ref_number AND NULLIF(h.declarant_reference
    , 'NULL') IS NULL
 WHERE h.declaration_category IN ('IMA', 'IMD', 'IMY')
  AND COALESCE(NULLIF(h.declarant_reference, 'NULL'), NULLIF(br.trader_reference, 'NULL')) IS NOT NULL);