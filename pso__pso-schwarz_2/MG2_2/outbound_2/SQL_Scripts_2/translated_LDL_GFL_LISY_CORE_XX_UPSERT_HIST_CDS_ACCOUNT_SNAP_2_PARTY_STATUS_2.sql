

-- real estate associated with stores and special sale stores


-- only objects with assigned object number 


-- meaningful only for PLAN status. The other statuses have their own date.


INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id
 , source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, party_sid, party_status_type_cd,
 party_type_cd)
WITH selected_set AS (SELECT *
   FROM ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap_2
   WHERE igl_accounttypecode IN (285540000, 285540009)
    AND (igl_expectedopeningdate IS NOT NULL OR igl_neodate IS NOT NULL OR igl_closingdate IS NOT NULL)
    AND deleted <> 'x'
    AND igl_number IS NOT NULL), src AS (SELECT k.party_sid,
    MIN(t1.igl_isocode2) AS igl_isocode2,
    MIN(t1.igl_expectedopeningdate) AS igl_expectedopeningdate,
    MIN(t1.sinkmodifiedon) AS status_date,
    MIN(t1.igl_neodate) AS igl_neodate,
    MAX(t1.igl_closingdate) AS igl_closingdate
   FROM selected_set AS t1_2
    INNER JOIN ldl_data_production_meta.t_party_key_2 AS k ON k.party_nat_key_nr = UPPER(SUBSTR(t1.igl_number, 1, 2)) ||
        '|' || CAST(ROUND(CAST(SUBSTR(t1.igl_number, 3, 5) AS BIGNUMERIC), 0) AS STRING) AND k.party_key_type_cd =
      'STORE'
   GROUP BY k.party_sid) (SELECT 'LISY' AS dwh_node_cd,
    0 AS tf_error_fg,
    '${LOAD_ID}' AS dwh_load_id,
    'LISY' AS source_system,
    CURRENT_DATE AS extraction_dt,
    CAST(0 AS BOOL) AS deleted_fg,
    CAST(0 AS STRING) AS record_id,
    CAST(CASE
      WHEN igl_neodate IS NULL AND igl_closingdate IS NULL AND igl_expectedopeningdate IS NOT NULL
      THEN status_date
      WHEN igl_closingdate IS NULL AND igl_neodate IS NOT NULL
      THEN igl_neodate
      WHEN igl_closingdate IS NOT NULL
      THEN igl_closingdate
      ELSE NULL
      END AS TIMESTAMP) AS dwh_mapping_tmsp,
    't_tcache_lisy_cds_account_snap_2' AS filename,
    party_sid,
     CASE
     WHEN igl_isocode2 IN ('AL', 'BA', 'ME', 'MK', 'XK')
     THEN 'PRE-PROCESS'
     WHEN igl_neodate IS NULL AND igl_closingdate IS NULL AND igl_expectedopeningdate IS NOT NULL
     THEN 'PLAN'
     WHEN (igl_closingdate IS NULL OR igl_closingdate > CAST(CURRENT_TIMESTAMP() AS DATETIME)) AND igl_neodate
      IS NOT NULL
     THEN 'ACTIVE'
     WHEN igl_closingdate < CAST(CURRENT_TIMESTAMP() AS DATETIME)
     THEN 'INACTIVE'
     ELSE NULL
     END AS party_status_type_cd,
    'INT_ORG' AS party_type_cd
   FROM src);