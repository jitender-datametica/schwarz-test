
-- WAWI_HQ country_1 deduplication mapping table



CREATE TEMPORARY TABLE IF NOT EXISTS t_ctrcode_map_1 AS
SELECT LEFT(com.party_nat_key_nr, 2) AS ctrcode_tgt,
 ctr.party_nat_key_nr AS ctrcode_src,
 ROW_NUMBER() OVER (PARTITION BY CAST(ctr.party_sid AS STRING) ORDER BY CASE
     WHEN ctr.party_nat_key_nr = LEFT(com.party_nat_key_nr, 2)
     THEN 0
     ELSE 1
     END IS NULL, CASE
     WHEN ctr.party_nat_key_nr = LEFT(com.party_nat_key_nr, 2)
     THEN 0
     ELSE 1
     END, ctr.party_nat_key_nr IS NULL, ctr.party_nat_key_nr) AS ctrcode_rank
FROM ldl_data_production_meta.t_party_key_1 AS ctr
 INNER JOIN ldl_data_production_meta.t_party_key_1 AS com ON ctr.party_key_type_cd = 'COUNTRY_1' AND ctr.party_sid = com.party_sid
     AND com.party_key_type_cd = 'COMPANY';


-- Extraction/Filter Logic:


-- for retrieving the int_org_sid


--<--- added in subquery


--<--- added


/* By NF/CBX product prefer the WAWI item_1 with matching number */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt, prod_nr, dwh_mapping_tmsp,
 prod_key_type_cd, int_org_key_type_cd, ctrcode, local_prod_variant_nr, local_prod_variant_name, local_prod_nr)
(SELECT DISTINCT pv.p_dwh_node_cd AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  pv.prod_variant_key_type_cd,
  'CBX' AS source_system,
  CURRENT_DATE AS extraction_dt,
  p.prod_nr,
  CAST(iit.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  'CBX' AS prod_key_type_cd,
  'COUNTRY_1' AS int_org_key_type_cd,
  iit.ctrcode,
  pv.prod_variant_nr AS local_prod_variant_nr,
  pv.prod_variant_name AS local_prod_variant_name,
  p.prod_nr AS local_prod_nr
 FROM (SELECT t_product_variant.prod_variant_sid,
    t_product_variant.dwh_valid_from_tmsp,
    t_product_variant.dwh_valid_to_tmsp,
    t_product_variant.dwh_valid_fg,
    t_product_variant.prod_sid,
    t_product_variant.prod_variant_nr,
    t_product_variant.gtin,
    t_product_variant.prod_variant_name,
    t_product_variant.prod_variant_type_cd,
    t_product_variant.weight_based_fg,
    t_product_variant.logistic_variant_type_cd,
    t_product_variant.case_size_cnt,
    t_product_variant.sales_variant_type_cd,
    t_product_variant.sales_variant_content_meas,
    t_product_variant.unit_cnt,
    t_product_variant.unit_content_meas,
    t_product_variant.content_uom_cd,
    t_product_variant.non_food_variant_type_cd,
    t_product_variant.size_name,
    t_product_variant.style_name,
    t_product_variant.kind_name,
    t_product_variant.fruits_and_vegetables_class_cd,
    t_product_variant.min_caliber_meas,
    t_product_variant.max_caliber_meas,
    t_product_variant.caliber_uom_cd,
    t_product_variant.country_of_origin_sid,
    t_product_variant.dwh_created_tmsp,
    t_product_variant.dwh_updated_tmsp,
    t_product_variant.dwh_load_id,
    t_product_variant.dwh_node_cd,
    t_product_variant_key.prod_variant_sid AS prod_variant_sid0,
    t_product_variant_key.prod_variant_key_type_cd,
    t_product_variant_key.dwh_valid_from_tmsp AS dwh_valid_from_tmsp0,
    t_product_variant_key.dwh_valid_to_tmsp AS dwh_valid_to_tmsp0,
    t_product_variant_key.dwh_valid_fg AS dwh_valid_fg0,
    t_product_variant_key.prod_variant_nat_key_nr,
    t_product_variant_key.dwh_created_tmsp AS dwh_created_tmsp0,
    t_product_variant_key.dwh_updated_tmsp AS dwh_updated_tmsp0,
    t_product_variant_key.dwh_load_id AS dwh_load_id0,
    t_product_variant_key.dwh_node_cd AS dwh_node_cd0,
    t_product_variant.dwh_node_cd AS p_dwh_node_cd
   FROM ldl_data_production_core_rel.t_product_variant_1
    INNER JOIN ldl_data_production_meta.t_product_variant_key_1 ON t_product_variant.prod_variant_sid =
      t_product_variant_key.prod_variant_sid AND t_product_variant_key.prod_variant_key_type_cd IN ('CBX_SLS',
       'CBX_SLS_UNK', 'CBX_LOG')
   WHERE t_product_variant.dwh_valid_fg) AS pv
  INNER JOIN ldl_data_production_core_rel.t_product_1 AS p ON pv.prod_sid = p.prod_sid AND p.dwh_valid_fg
  INNER JOIN (SELECT iit.ctrcode,
    iit.extraction_tmsp,
    iit.itemnr,
    iit.c215_int_itemnr
   FROM (SELECT DISTINCT ctrcode,
      extraction_tmsp,
      ROUND(CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
      ROUND(CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS c215_int_itemnr
     FROM ldl_data_production_etl.t_wawi_precore_t215_int_itemnr_1
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY ctrcode, CAST(c215_int_itemnr AS STRING) ORDER BY CASE
            WHEN c215_int_itemnr = itemnr
            THEN 0
            ELSE 1
            END IS NULL, CASE
            WHEN c215_int_itemnr = itemnr
            THEN 0
            ELSE 1
            END, itemnr IS NULL, itemnr)) = 1) AS iit
    INNER JOIN t_ctrcode_map_1 AS cm ON iit.ctrcode = cm.ctrcode_src
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(iit.c215_int_itemnr AS STRING), cm.ctrcode_tgt ORDER BY cm.ctrcode_rank
         IS NULL, cm.ctrcode_rank)) = 1) AS iit ON ROUND(SAFE_CAST(p.prod_nr AS BIGNUMERIC), 0) = iit.c215_int_itemnr);