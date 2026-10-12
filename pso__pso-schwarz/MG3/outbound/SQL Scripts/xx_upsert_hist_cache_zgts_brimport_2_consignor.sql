INSERT INTO szd_producton.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  consignor_name,
  party_id,
  party_key_type_cd,
  dwh_src_file_name,
  consignor_stream_cd,
  importer_party_id,
  importer_party_key_type_cd,
  dwh_src_1_tmsp,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
SELECT
  src.*
FROM (
  SELECT
    TRIM(upper(t_cache_zgts_brimport.parno_consignor_name1), ' ') AS consignor_name,
    TRIM(upper(t_cache_zgts_brimport.parno_consignor_name1), ' ') AS party_id,
    'CONSIGNOR' AS party_key_type_cd,
    t_cache_zgts_brimport.dwh_src_file_name,
    'EXTERNAL' AS consignor_stream_cd,
    '-1' AS importer_party_id,
    'IMPORTER' AS importer_party_key_type_cd,
    t_cache_zgts_brimport.dwh_src_1_tmsp,
    coalesce(t_cache_zgts_brimport.etats, t_cache_zgts_brimport.etd) AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    t_cache_zgts_brimport.dwh_src_file_name AS filename
  FROM szd_production.etl.t_cache_zgts_brimport
  WHERE
    upper(RTRIM(t_cache_zgts_brimport.parno_consignor_name1, ' ')) <> 'NULL'
) AS src
LEFT OUTER JOIN szd_production.meta.t_party_key AS p
  ON RTRIM(src.party_id, ' ') = RTRIM(p.party_nat_key_nr, ' ')
LEFT OUTER JOIN szd_production.core_rel.t_consignor AS c
  ON p.party_sid = c.party_sid
WHERE
  c.party_sid IS NULL
QUALIFY
  row_number() OVER (PARTITION BY src.party_id, src.dwh_mapping_tmsp ORDER BY src.dwh_src_file_name) = 1;