INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  job_role_nat_key_nr,
  job_role_key_type_cd,
  job_role_type_cd,
  job_role_name,
  int_org_nat_key,
  int_org_key_type_cd,
  reports_to_job_role_nat_key_nr,
  reports_to_job_role_key_type_cd,
  --    FRAMEWORK AND TECHNICAL COLUMNS
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
WITH stores_dedup AS (
  SELECT
      -- deduplicating all stores coming from OSO
      *
    FROM
      etl.t_tcache_oso_orgaunits_2
    WHERE type0 = 'STORE'
    QUALIFY
      ROW_NUMBER() OVER (
        PARTITION BY orgaunitid
        ORDER BY IF(extraction_timestamp IS NULL, 0, 1), extraction_timestamp DESC
      ) = NUMERIC '1'
),
src_with_sid AS (
  SELECT
      -- get all relations between store - sales_2 manager - account_2 manager - company manager & sales_2 company
      sales_manager_name AS sales_manager_name,
      account_manager_name AS account_manager_name,
      sales_company_nr AS sales_company_nr,
      CONCAT(
        sales_manager_name,
        ' (',
        COALESCE(account_manager_name, CONCAT('VL ', lisycomp.igl_name)),
        ' (',
        sales_company_nr,
        '))'
      ) AS sales_manager_nat_key_nr,
      CONCAT(
        COALESCE(account_manager_name, CONCAT('VL ', lisycomp.igl_name)),
        ' (',
        sales_company_nr,
        ')'
      ) AS account_manager_nat_key_nr,
      store.extraction_timestamp AS extraction_tmsp,
      CONCAT(
        SUBSTR(lisycomp.igl_associationnumber, 1, 2),
        '|',
        CAST(ROUND(CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS BIGNUMERIC), 0) AS STRING)
      ) AS sales_comp_nat_key_nr,
      lisycomp.extraction_ts AS sales_comp_extraction_tmsp
    FROM
      stores_dedup AS store
      INNER JOIN etl.t_tcache_oso_employees_2 AS smd -- joining stores with sales_2 managers (OSO)
        ON store.employeeid = smd.id
       AND smd.orgaunitid = store.parentorgaunitid  -- take only the sales_2 managers associated with the parentorgaunit of the respective store (one sales_2 manager can be associated with more than one company)
      INNER JOIN etl.t_tcache_oso_employees_2 AS amd -- joining sales_2 managers with account_2 managers (OSO)
        ON smd.parent_id = amd.id
       AND amd.orgaunitid = store.parentorgaunitid  -- take only the account_2 managers associated with the parentorgaunit of the respective store (one account_2 manager can be associated with more than one company)
--    join etl.t_tcache_oso_employees_2 cmd --- joining account_2 managers with company managers (the manager of the given sales_2 company) (OSO)
--        on amd.parent_id = cmd.id
--        and cmd.orgaunitid = store.parentorgaunitid -- take only the company managers associated with the parentorgaunit of the respective store (one company manager can be associated with more than one company)
      INNER JOIN etl_process.t_tcache_lisy_cds_account_snap_2 AS lisystore  --joining OSO stores with LISY store data
        ON CONCAT(store.countrycode, store.organumber) = CONCAT(UPPER(SUBSTR(lisystore.igl_number, 1, 2)), CAST(ROUND(CAST(SUBSTR(lisystore.igl_number, 3, 5) AS BIGNUMERIC), 0) AS STRING))
      INNER JOIN etl_process.t_tcache_lisy_cds_company_snap_2 AS lisycomp  -- joining LISY sales_2 companies because OSO companies are unreliable, as they aren't always sales_2 companies
        ON lisystore.igl_salesassocid = lisycomp.id
      CROSS JOIN UNNEST(ARRAY[
        CONCAT(SUBSTR(lisycomp.igl_associationnumber, 1, 2), CAST(ROUND(CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS BIGNUMERIC), 0) AS STRING))
      ]) AS sales_company_nr
      CROSS JOIN UNNEST(ARRAY[
        CONCAT(amd.firstname, ' ', amd.lastname)
      ]) AS account_manager_name
      CROSS JOIN UNNEST(ARRAY[
        CONCAT(smd.firstname, ' ', smd.lastname)
      ]) AS sales_manager_name
)
SELECT
    -- sales_2 manager job role
    TRANSLATE(
      UPPER(src_with_sid.sales_manager_nat_key_nr),
      sc.country_from_special_char_list,
      sc.country_to_special_char_list
    ) AS job_role_nat_key_nr,  -- look up job_role_sid in meta.t_job_role_key_2 where job_role_key_type_cd = 'SALES_MANAGER'
    'SALES_MANAGER' AS job_role_key_type_cd,
    'SALES_MANAGER' AS job_role_type_cd,
    CONCAT('Verkaufsleiter ', src_with_sid.sales_manager_nat_key_nr) AS job_role_name,
    TRANSLATE(
      UPPER(src_with_sid.sales_manager_nat_key_nr),
      sc.country_from_special_char_list,
      sc.country_to_special_char_list
    ) AS int_org_nat_key,  -- look up party_sid in meta.t_party_key_2 where party_key_type_cd = 'SALES_MANAGER'
    'SALES_MANAGER' AS int_org_key_type_cd,
    TRANSLATE(
      UPPER(src_with_sid.account_manager_nat_key_nr),
      sc.country_from_special_char_list,
      sc.country_to_special_char_list
    ) AS reports_to_job_role_nat_key_nr,  -- look up job_role_sid in meta.t_job_role_key_2 where job_role_key_type_cd = 'ACCOUNT_MANAGER'
    'ACCOUNT_MANAGER' AS reports_to_job_role_key_type_cd,
    'OSO' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    src_with_sid.extraction_tmsp AS dwh_mapping_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS deleted_fg,
    NUMERIC '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'OSO' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
  FROM
    src_with_sid
    CROSS JOIN etl_process.t_country_special_char_2 AS sc
  QUALIFY
    ROW_NUMBER() OVER (
      PARTITION BY src_with_sid.sales_manager_nat_key_nr
      ORDER BY IF(dwh_mapping_tmsp IS NULL, 0, 1), dwh_mapping_tmsp DESC
    ) = NUMERIC '1'

UNION ALL

SELECT
    -- account_2 manager job role
    TRANSLATE(
      UPPER(src_with_sid.account_manager_nat_key_nr),
      sc.country_from_special_char_list,
      sc.country_to_special_char_list
    ) AS job_role_nat_key_nr,  -- look up job_role_sid in meta.t_job_role_key_2 where job_role_key_type_cd = 'ACCOUNT_MANAGER'
    'ACCOUNT_MANAGER' AS job_role_key_type_cd,
    'ACCOUNT_MANAGER' AS job_role_type_cd,
    CONCAT('Vertriebsleiter ', src_with_sid.account_manager_nat_key_nr) AS job_role_name,
    TRANSLATE(
      UPPER(src_with_sid.account_manager_nat_key_nr),
      sc.country_from_special_char_list,
      sc.country_to_special_char_list
    ) AS int_org_nat_key,  -- look up party_sid in meta.t_party_key_2 where party_key_type_cd = 'ACCOUNT_MANAGER'
    'ACCOUNT_MANAGER' AS int_org_key_type_cd,
    src_with_sid.sales_comp_nat_key_nr AS reports_to_job_role_nat_key_nr,  -- look up job_role_sid in meta.t_job_role_key_2 where job_role_key_type_cd = 'COMPANY_MANAGER'
    'COMPANY_MANAGER' AS reports_to_job_role_key_type_cd,
    'OSO' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    src_with_sid.extraction_tmsp AS dwh_mapping_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS deleted_fg,
    NUMERIC '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'OSO' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
  FROM
    src_with_sid
    CROSS JOIN etl_process.t_country_special_char_2 AS sc
  QUALIFY
    ROW_NUMBER() OVER (
      PARTITION BY src_with_sid.account_manager_nat_key_nr
      ORDER BY IF(dwh_mapping_tmsp IS NULL, 0, 1), dwh_mapping_tmsp DESC
    ) = NUMERIC '1'

UNION ALL

SELECT
    -- company manager job role
    src_with_sid.sales_comp_nat_key_nr AS job_role_nat_key_nr, -- look up job_role_sid in meta.t_job_role_key_2 where job_role_key_type_cd = 'COMPANY_MANAGER'
    'COMPANY_MANAGER' AS job_role_key_type_cd,
    'COMPANY_MANAGER' AS job_role_type_cd,
    CONCAT('Geschäftsführer ', src_with_sid.sales_company_nr) AS job_role_name,
    src_with_sid.sales_comp_nat_key_nr AS int_org_nat_key,  -- look up party_sid in meta.t_party_key_2 where party_key_type_cd = 'COMPANY'
    'COMPANY' AS int_org_key_type_cd,
    pk.party_nat_key_nr AS reports_to_job_role_nat_key_nr,  -- look up job_role_sid in meta.t_job_role_key_2 where job_role_key_type_cd = 'REGION_MANAGER'
    'REGION_MANAGER' AS reports_to_job_role_key_type_cd,
    'OSO' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    src_with_sid.sales_comp_extraction_tmsp AS dwh_mapping_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS deleted_fg,
    NUMERIC '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'OSO' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
  FROM
    src_with_sid  -- we need to take the SID of the parent region_2 of the given sales_2 company
    INNER JOIN meta.t_party_key_2 AS sck
      ON sck.party_nat_key_nr = src_with_sid.sales_comp_nat_key_nr
     AND sck.party_key_type_cd = 'COMPANY'
     AND sck.dwh_valid_fg
    INNER JOIN core_rel.t_internal_organization_hierarchy_2 AS ioh
      ON sck.party_sid = ioh.int_org_sid
     AND ioh.int_org_hierarchy_type_cd = 'REGION_COMPANY'
     AND src_with_sid.sales_comp_extraction_tmsp BETWEEN ioh.dwh_valid_from_tmsp AND ioh.dwh_valid_to_tmsp
    INNER JOIN meta.t_party_key_2 AS pk
      ON pk.party_sid = ioh.parent_int_org_sid
     AND pk.party_key_type_cd = 'REGION_2'
     AND pk.dwh_valid_fg
  QUALIFY
    ROW_NUMBER() OVER (
      PARTITION BY int_org_nat_key
      ORDER BY IF(src_with_sid.extraction_tmsp IS NULL, 0, 1), src_with_sid.extraction_tmsp DESC
    ) = NUMERIC '1'
;
