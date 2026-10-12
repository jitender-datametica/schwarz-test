
-- WAWI_HQ country deduplication mapping table (used by CBX, FV, EKS)



CREATE OR REPLACE TEMPORARY TABLE ${t_ctrcode_map_load_id} AS
SELECT t0.int_org_ctr_cd AS ctrcode_tgt,
 t0.party_nat_key_nr AS ctrcode_src,
 ROW_NUMBER() OVER (PARTITION BY CAST(t0.party_sid AS STRING) ORDER BY CASE
     WHEN t0.party_nat_key_nr = t0.int_org_ctr_cd
     THEN 0
     ELSE 1
     END IS NULL, CASE
     WHEN t0.party_nat_key_nr = t0.int_org_ctr_cd
     THEN 0
     ELSE 1
     END, t0.party_nat_key_nr IS NULL, t0.party_nat_key_nr) AS ctrcode_rank
FROM (SELECT DISTINCT pk.party_sid,
   pk.party_nat_key_nr,
   LEFT(io.int_org_nr, 2) AS int_org_ctr_cd
  FROM ldl_data_production_meta.t_party_key AS pk
   INNER JOIN ldl_data_production_core_rel.t_internal_organization AS io ON pk.party_sid = io.int_org_sid AND pk.dwh_valid_fg
       AND io.dwh_valid_fg AND pk.party_key_type_cd = 'COUNTRY') AS t0;


-- K.NAME1


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, legal_name, vat_nr, org_name, org_nat_key_nr,
 is_sup_fg, org_key_type_cd, org_type_cd)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${T_SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS source_system,
  CAST(extraction_tmsp AS DATE) AS extraction_dt,
  CAST(extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  name1 AS legal_name,
  tax_key AS vat_nr,
  suchname AS org_name,
    ctrcode_tgt || '|' || CAST(krednr AS STRING) AS org_nat_key_nr,
  TRUE AS is_sup_fg,
  'SUPPLIER' AS org_key_type_cd,
  'COMPANY' AS org_type_cd
 FROM (selected_src AS (SELECT t0.ctrcode_tgt,
     t0.krednr0 AS krednr,
     t0.suchname,
     t0.name1,
     t0.tax_key,
     t0.extraction_tmsp
    FROM (SELECT c.ctrcode_tgt,
       ROUND(CAST(k.krednr AS BIGNUMERIC), 0) AS krednr0,
       k.suchname,
       '' AS name1,
       k.tax_key,
       k.extraction_tmsp,
       k.krednr,
       c.ctrcode_rank
      FROM ldl_data_production_etl.t_wawi_precore_kreditor AS k
       INNER JOIN ${t_ctrcode_map_load_id} AS c ON k.ctrcode = c.ctrcode_src
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY c.ctrcode_tgt, CAST(krednr0 AS STRING) ORDER BY c.ctrcode_rank IS NULL, c
            .ctrcode_rank)) = 1) AS t0)));