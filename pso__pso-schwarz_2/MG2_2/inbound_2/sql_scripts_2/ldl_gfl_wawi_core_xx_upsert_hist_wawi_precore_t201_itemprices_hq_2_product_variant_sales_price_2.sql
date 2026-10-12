INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
  prod_variant_sid,  
  price_grp_sid,
  sales_gross_price,
  curr_cd,
  price_reason_cd,
	
  -- FRAMEWORK AND TECHNICAL COLUMNS
  dwh_ending_tmsp,
  source_system, 
  extraction_dt, 
  dwh_mapping_tmsp,  
  tf_error_fg, 
  deleted_fg, 
  record_id, 
  filename,
  dwh_node_cd, 
  dwh_load_id)
SELECT  
  prod_variant_sid,
  price_grp_sid,
  p.c201_price AS sales_gross_price,
  org.curr_cd AS curr_cd,
  p.c201_reason_id AS price_reason_cd,

  p.c201_dateto AS dwh_ending_tmsp,
  'WAWI' AS source_system,
  p.extraction_tmsp AS extraction_dt,
  p.c201_datefrom AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  'wawi_precore_t201_itemprices_hq' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id 
FROM etl.t_wawi_precore_t201_itemprices_hq_2 p
JOIN meta.t_party_key_2 k ON party_key_type_cd='COUNTRY_2' AND party_nat_key_nr=p.ctrcode AND  k.dwh_valid_fg
JOIN core_rel.t_internal_organization_2 org ON int_org_sid=k.party_sid  AND  org.dwh_valid_fg
JOIN meta.t_product_variant_key_2 kv ON prod_variant_key_type_cd='LOG'
     AND prod_variant_nat_key_nr= p.ctrcode || '|' || CAST(SUBSTR(p.c201_itemno,1,LENGTH(p.c201_itemno)-4) AS INTEGER) || '|' ||  CAST(RIGHT(CAST (p.c201_itemno AS STRING),4) AS INTEGER)
     AND kv.dwh_valid_fg
JOIN meta.t_price_group_key_2 pgk  ON price_grp_key_type_cd ='WAWI' AND price_grp_nat_key_nr = p.ctrcode || '|' || CAST(p.c201_groupnr AS INTEGER) AND k.dwh_valid_fg
WHERE 
  p.c201_price IS NOT NULL 
  AND c201_lastedited >= '${SRC_START_DATE}'
  AND c201_dateto > c201_datefrom -- to address_2 dq issues
QUALIFY ROW_NUMBER() OVER (PARTITION BY prod_variant_sid,p.c201_groupnr,p.c201_datefrom ORDER BY CAST(RIGHT(CAST (p.c201_itemno as string),4) AS INTEGER) DESC) = 1
;
