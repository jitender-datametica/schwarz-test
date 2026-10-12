
CREATE OR REPLACE TEMPORARY TABLE ${t_wawi_instanz_kzl_map_load_id} AS
SELECT t0.int_org_ctr_cd AS wawi_instanz_kzl_tgt,
 t0.party_nat_key_nr AS wawi_instanz_kzl_src,
 ROW_NUMBER() OVER (PARTITION BY CAST(t0.party_sid AS STRING) ORDER BY CASE
     WHEN t0.party_nat_key_nr = t0.int_org_ctr_cd
     THEN 0
     ELSE 1
     END IS NULL, CASE
     WHEN t0.party_nat_key_nr = t0.int_org_ctr_cd
     THEN 0
     ELSE 1
     END, t0.party_nat_key_nr IS NULL, t0.party_nat_key_nr) AS wawi_instanz_kzl_rank
FROM (SELECT DISTINCT pk.party_sid,
   pk.party_nat_key_nr,
   LEFT(io.int_org_nr, 2) AS int_org_ctr_cd
  FROM ldl_data_production_meta.t_party_key_2 AS pk
   INNER JOIN ldl_data_production_core_rel.t_internal_organization_2 AS io ON pk.party_sid = io.int_org_sid AND pk.dwh_valid_fg
       AND io.dwh_valid_fg AND pk.party_key_type_cd = 'COUNTRY_2') AS t0;


-- TBC


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, party_nat_key_nr, party_sid, party_key_type_cd)
WITH selected_src AS (SELECT t1.party_sid,
    t1.wawi_instanz_kzl_src,
    t1.wawi_instanz_kzl_tgt,
    t1.krednr0 AS krednr,
    t1.extraction_tmsp
   FROM (SELECT party_sid0.party_sid,
      c.wawi_instanz_kzl_src,
      c.wawi_instanz_kzl_tgt,
      ROUND(CAST(k.krednr AS BIGNUMERIC), 0) AS krednr0,
      k.extraction_tmsp,
      k.krednr,
      c.wawi_instanz_kzl_rank
     FROM hqwawiadm.kreditor_2 AS k
      INNER JOIN ${t_wawi_instanz_kzl_map_load_id} AS c ON LEFT(k.wawi_instanz_kzl, 2) = c.wawi_instanz_kzl_src
      INNER JOIN ldl_data_production_meta.t_party_key_2 AS party_sid0 ON party_sid0.dwh_valid_fg AND UPPER(party_sid0.party_key_type_cd
          ) = 'SUPPLIER_2' AND UPPER(party_sid0.party_nat_key_nr) = UPPER(c.wawi_instanz_kzl_tgt) || '|' || CAST(ROUND(CAST(k.krednr AS BIGNUMERIC)
           , 0) AS STRING)
     WHERE k.delete_fg IS NULL
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY c.wawi_instanz_kzl_tgt, CAST(krednr0 AS STRING) ORDER BY c.wawi_instanz_kzl_rank
           IS NULL, c.wawi_instanz_kzl_rank)) > 1) AS t1_2) (SELECT 'WAWI_HQ' AS dwh_node_cd,
    0 AS tf_error_fg,
    '${LOAD_ID}' AS dwh_load_id,
    CAST(0 AS BOOL) AS deleted_fg,
    CAST(0 AS STRING) AS record_id,
    '${T_SRC_INPUT_TABLE}' AS filename,
    'WAWI_HQ' AS source_system,
    CURRENT_DATE AS extraction_dt,
    CAST(extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
    UPPER(wawi_instanz_kzl_src || '|' || CAST(krednr AS STRING)) AS party_nat_key_nr,
    party_sid,
    'SUPPLIER_2' AS party_key_type_cd
   FROM selected_src);