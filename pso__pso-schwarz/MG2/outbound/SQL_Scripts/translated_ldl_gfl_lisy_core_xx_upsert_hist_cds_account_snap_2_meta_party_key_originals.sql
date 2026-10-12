BEGIN TRANSACTION;


DELETE FROM ldl_data_production_meta.t_party_key  -- PREVENT ANY CONCURRENT ACCESS TO THIS KEYSPACE
WHERE 1 = 2;
-- CREATE NEW SK ENTRIES FOR EVERY NEW NK/TYPE/VALID_FROM_TMSP COMBINATION

INSERT INTO ldl_data_production_meta.t_party_key (party_sid, party_key_type_cd, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
 dwh_valid_fg, party_nat_key_nr, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
(SELECT MAX_SEQ.max_seq + (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) AS party_sid,
  'STORE' AS int_org_key_type_cd,
  CAST(T1.sinkmodifiedon AS TIMESTAMP) AS sinkmodifiedon,
  CAST('9999-12-31 23:59:59' AS TIMESTAMP),
  TRUE,
  T1.int_org_natural_key AS natural_key,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CAST('${LOAD_ID}' AS BIGNUMERIC) AS load_id,
  UPPER(T1.dwh_node_cd) AS t1_dwh_node_cd
 FROM (SELECT LOWER(dwh_node_cd) AS dwh_node_cd,
    'STORE' AS int_org_key_type_cd,
      UPPER(SUBSTR(igl_number, 1, 2)) || '|' || CAST(ROUND(CAST(SUBSTR(igl_number, 3, 5) AS BIGNUMERIC), 0) AS STRING)
    AS int_org_natural_key,
    sinkmodifiedon
   FROM ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap AS t1
   WHERE igl_accounttypecode IN (285540000, 285540009)    -- REAL ESTATE ASSOCIATED WITH STORES AND SPECIAL SALE STORES
    AND (igl_neodate IS NOT NULL OR igl_closingdate IS NOT NULL)  -- ONLY OBJECTS WITH ASSIGNED OBJECT NUMBER SHOULD BE KEPT -- IF A BUILDING SHOULD BE COUNTED AS A STORE, IT MUST HAVE AT LEAST ONE OF THESE DATES
    AND igl_substituteforid IS NULL
    AND accountid NOT IN (SELECT igl_replacementid
      FROM ldl_data_production_etl_process.t_tcache_lisy_cds_account_snap
      WHERE igl_replacementid IS NOT NULL -- "ROOT"( "INIT") STORES ONLY - THESE STORES ARE NOT DESCENDANTS OF ANY OTHER STORE.
      )
    AND igl_number IS NOT NULL
   GROUP BY t1.dwh_node_cd,
    int_org_key_type_cd,
    int_org_natural_key,
    sinkmodifiedon) AS T1
  INNER JOIN (SELECT COALESCE(MAX(party_sid), 0) AS max_seq
   FROM ldl_data_production_meta.t_party_key) AS MAX_SEQ ON TRUE
 WHERE NOT EXISTS (SELECT 1
   FROM ldl_data_production_meta.t_party_key AS t2
   WHERE UPPER(party_key_type_cd) = UPPER(T1.int_org_key_type_cd)
    AND CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp
    AND party_nat_key_nr = UPPER(T1.int_org_natural_key))-- ACCOMODATES HISTORIZED SID ASSOCIATION (FULL CAPABILITY NOT IMPLEMENTED IN INITIAL RELEASE)
  AND T1.int_org_natural_key IS NOT NULL);

COMMIT;