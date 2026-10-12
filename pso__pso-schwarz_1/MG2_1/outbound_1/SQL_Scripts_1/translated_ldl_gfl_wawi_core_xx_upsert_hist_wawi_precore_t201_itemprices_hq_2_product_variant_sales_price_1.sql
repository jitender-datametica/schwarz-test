 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, 
-- FRAMEWORK AND TECHNICAL COLUMNS
dwh_mapping_tmsp, filename
 , prod_variant_sid, curr_cd, dwh_ending_tmsp, price_reason_cd, price_grp_sid, sales_gross_price)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI' AS source_system,
  CAST(p.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(p.c201_datefrom AS TIMESTAMP) AS dwh_mapping_tmsp,
  'wawi_precore_t201_itemprices_hq' AS filename,
  kv.prod_variant_sid,
  org.curr_cd,
  CAST(p.c201_dateto AS TIMESTAMP) AS dwh_ending_tmsp,
  CAST(p.c201_reason_id AS STRING) AS price_reason_cd,
  pgk.price_grp_sid,
  p.c201_price AS sales_gross_price
 FROM ldl_data_production_etl.t_wawi_precore_t201_itemprices_hq_1 AS p
  INNER JOIN ldl_data_production_meta.t_party_key_1 AS k ON k.party_key_type_cd = 'COUNTRY_1' AND p.ctrcode = k.party_nat_key_nr
      AND k.dwh_valid_fg
  INNER JOIN ldl_data_production_core_rel.t_internal_organization_1 AS org ON k.party_sid = org.int_org_sid AND org.dwh_valid_fg
   
  INNER JOIN ldl_data_production_meta.t_product_variant_key_1 AS kv ON kv.prod_variant_key_type_cd = 'LOG' AND kv.prod_variant_nat_key_nr
      = p.ctrcode || '|' || CAST(ROUND(CAST(SUBSTR(p.c201_itemno, 1, LENGTH(p.c201_itemno) - 4) AS BIGNUMERIC), 0) AS
         STRING) || '|' || CAST(ROUND(CAST(RIGHT(CAST(p.c201_itemno AS STRING), 4) AS BIGNUMERIC), 0) AS STRING) AND kv
   .dwh_valid_fg
  INNER JOIN ldl_data_production_meta.t_price_group_key_1 AS pgk ON pgk.price_grp_key_type_cd = 'WAWI' AND pgk.price_grp_nat_key_nr
      = p.ctrcode || '|' || CAST(ROUND(CAST(p.c201_groupnr AS BIGNUMERIC), 0) AS STRING) AND k.dwh_valid_fg
 WHERE p.c201_lastedited >= CAST('${SRC_START_DATE}' AS DATETIME)
  AND p.c201_dateto > p.c201_datefrom -- to address_1 dq issues

  AND p.c201_price IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY kv.prod_variant_sid, CAST(p.c201_groupnr AS STRING), p.c201_datefrom ORDER BY
       ROUND(ROUND(CAST(RIGHT(CAST(p.c201_itemno AS STRING), 4) AS BIGNUMERIC), 0), 0) IS NULL DESC, ROUND(ROUND(CAST(RIGHT(CAST(p.c201_itemno AS STRING)
           , 4) AS BIGNUMERIC), 0), 0) DESC)) = 1);