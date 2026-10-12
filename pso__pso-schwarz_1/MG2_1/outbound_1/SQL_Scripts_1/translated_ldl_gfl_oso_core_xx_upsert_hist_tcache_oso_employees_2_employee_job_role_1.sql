/*  This step is executed in order to remove records loaded from P_LEW_CORE for which we now have OSO data because we 
    want to avoid a situation where we have multiple EMP_SIDs representing the same person (one generated from P_LEW_CORE 
    based on firstname || lastname, and one generated from OSO based on the e-mail) for the same job_role_sid.
*/
DELETE FROM core_rel.t_employee_job_role_1
WHERE emp_sid IN (
  SELECT
      party_sid
    FROM
      meta.t_party_key_1
    WHERE
      party_key_type_cd = 'PERSON'
      -- and dwh_node_cd = 'P_LEW_CORE'
      AND TRANSLATE(party_nat_key_nr, ' 0123456789()|-', '') IN (
        SELECT
            TRANSLATE(UPPER(CONCAT(first_name, '|', family_name)), ' 0123456789()|-', '')
          FROM
            core_rel.t_person_1
          WHERE
            dwh_node_cd = 'OSO'
      )
);

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  emp_nat_key_nr,
  emp_key_type_cd,
  job_role_nat_key_nr,
  job_role_key_type_cd,
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
WITH 
-- deduplicating all stores coming from OSO
stores_dedup AS (
  SELECT
      *
    FROM
      etl.t_tcache_oso_orgaunits_1
    WHERE
      type0 = 'STORE'
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY orgaunitid
      ORDER BY IF(extraction_timestamp IS NULL, 0, 1) DESC,
               extraction_timestamp DESC
    ) = 1
),
src_with_sid AS (
  SELECT
      CONCAT(store.countrycode, store.organumber) AS store_nr,
      LOWER(smd.mail) AS sm_emp_nat_key_nr,
      LOWER(amd.mail) AS am_emp_nat_key_nr,
      --    , lower(cmd.mail) as cm_emp_nat_key_nr
      sales_manager_name AS sales_manager_name,
      account_manager_name AS account_manager_name,
      sales_company_nr AS sales_company_nr,
      CONCAT(sales_manager_name, ' (', COALESCE(account_manager_name, CONCAT('VL ', lisycomp.igl_name)), ' (', sales_company_nr, '))') AS sales_manager_nat_key_nr,
      CONCAT(COALESCE(account_manager_name, CONCAT('VL ', lisycomp.igl_name)), ' (', sales_company_nr, ')') AS account_manager_nat_key_nr,
      smd.extraction_timestamp AS sm_extraction_tmsp,
      amd.extraction_timestamp AS am_extraction_tmsp,
      CONCAT(SUBSTR(lisycomp.igl_associationnumber, 1, 2), '|', CAST(ROUND(CAST(REGEXP_REPLACE(lisycomp.igl_associationnumber, '[^0-9]', '') AS BIGNUMERIC), 0) AS STRING)) AS sales_comp_nat_key_nr,
      lisycomp.extraction_ts AS sales_comp_extraction_tmsp,
      amd.parent_id,
      store.parentorgaunitid
    FROM
      stores_dedup AS store
      INNER JOIN etl.t_tcache_oso_employees_1 AS smd   -- joining stores with sales_1 managers (OSO)
        ON store.employeeid = smd.id
       AND smd.orgaunitid = store.parentorgaunitid  -- take only the sales_1 managers associated with the parentorgaunit of the respective store (one sales_1 manager can be associated with more than one company)
      INNER JOIN etl.t_tcache_oso_employees_1 AS amd  -- joining sales_1 managers with account_1 managers (OSO)
        ON smd.parent_id = amd.id
       AND amd.orgaunitid = store.parentorgaunitid  -- take only the account_1 managers associated with the parentorgaunit of the respective store (one account_1 manager can be associated with more than one company)
--        join etl.t_tcache_oso_employees_1 cmd --- joining account_1 managers with company managers (the manager of the given sales_1 company) (OSO)
--            on amd.parent_id = cmd.id
--            and cmd.orgaunitid = store.parentorgaunitid -- take only the company managers associated with the parentorgaunit of the respective store (one company manager can be associated with more than one company)
      INNER JOIN etl_process.t_tcache_lisy_cds_account_snap_1 AS lisystore  --joining OSO stores with LISY store data
        ON CONCAT(store.countrycode, store.organumber) = CONCAT(UPPER(SUBSTR(lisystore.igl_number, 1, 2)), CAST(ROUND(CAST(SUBSTR(lisystore.igl_number, 3, 5) AS BIGNUMERIC), 0) AS STRING))
      INNER JOIN etl_process.t_tcache_lisy_cds_company_snap_1 AS lisycomp
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
),
-- get all relations between store - sales_1 manager - account_1 manager - company manager & sales_1 company
src_with_sid_cm AS (
  SELECT
      store.*,
      LOWER(cmd.mail) AS cm_emp_nat_key_nr
    FROM
      src_with_sid AS store
      INNER JOIN etl.t_tcache_oso_employees_1 AS cmd   -- joining account_1 managers with company managers (the manager of the given sales_1 company) (OSO)
        ON store.parent_id = cmd.id
       AND store.parentorgaunitid = cmd.orgaunitid  -- take only the company managers associated with the parentorgaunit of the respective store (one company manager can be associated with more than one company)
)
-- sales_1 manager job role
SELECT
    src.sm_emp_nat_key_nr       AS emp_nat_key_nr,  -- look up EMP_SID in t_party_key_1 where party_key_type_cd = 'PERSON'
    'PERSON'                    AS emp_key_type_cd,
    TRANSLATE(UPPER(src.sales_manager_nat_key_nr), sc.country_from_special_char_list, sc.country_to_special_char_list) AS job_role_nat_key_nr, -- look up job_role_sid in meta.t_job_role_key_1 where job_role_key_type_cd = 'COMPANY_MANAGER'
    'SALES_MANAGER'             AS job_role_key_type_cd,
    'OSO'                       AS source_system,
    CURRENT_DATE()              AS extraction_dt,
    src.sales_comp_extraction_tmsp AS dwh_mapping_tmsp,
    NUMERIC '0'                 AS tf_error_fg,
    NUMERIC '0'                 AS deleted_fg,
    NUMERIC '0'                 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'OSO'                       AS dwh_node_cd,
    '${LOAD_ID}'           AS dwh_load_id
  FROM
    src_with_sid AS src
    CROSS JOIN etl_process.t_country_special_char_1 AS sc
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY emp_nat_key_nr, job_role_nat_key_nr
    ORDER BY IF(dwh_mapping_tmsp IS NULL, 0, 1) DESC,
             dwh_mapping_tmsp DESC
  ) = 1

UNION ALL

-- account_1 manager job role
SELECT
    src.am_emp_nat_key_nr       AS emp_nat_key_nr,    -- look up EMP_SID in t_party_key_1 where party_key_type_cd = 'PERSON'
    'PERSON'                    AS emp_key_type_cd,
    TRANSLATE(UPPER(src.account_manager_nat_key_nr), sc.country_from_special_char_list, sc.country_to_special_char_list) AS job_role_nat_key_nr, -- look up job_role_sid in meta.t_job_role_key_1 where job_role_key_type_cd = 'COMPANY_MANAGER'
    'ACCOUNT_MANAGER'           AS job_role_key_type_cd,
    'OSO'                       AS source_system,
    CURRENT_DATE()              AS extraction_dt,
    src.sales_comp_extraction_tmsp AS dwh_mapping_tmsp,
    NUMERIC '0'                 AS tf_error_fg,
    NUMERIC '0'                 AS deleted_fg,
    NUMERIC '0'                 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'OSO'                       AS dwh_node_cd,
    '${LOAD_ID}'           AS dwh_load_id
  FROM
    src_with_sid AS src
    CROSS JOIN etl_process.t_country_special_char_1 AS sc
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY emp_nat_key_nr, job_role_nat_key_nr
    ORDER BY IF(dwh_mapping_tmsp IS NULL, 0, 1) DESC,
             dwh_mapping_tmsp DESC
  ) = 1

UNION ALL

-- company manager job role
SELECT
    src.cm_emp_nat_key_nr       AS emp_nat_key_nr,    -- look up EMP_SID in t_party_key_1 where party_key_type_cd = 'PERSON'
    'PERSON'                    AS emp_key_type_cd,
    TRANSLATE(UPPER(src.sales_comp_nat_key_nr), sc.country_from_special_char_list, sc.country_to_special_char_list) AS job_role_nat_key_nr, -- look up job_role_sid in meta.t_job_role_key_1 where job_role_key_type_cd = 'COMPANY_MANAGER'
    'COMPANY_MANAGER'           AS job_role_key_type_cd,
    'OSO'                       AS source_system,
    CURRENT_DATE()              AS extraction_dt,
    src.sm_extraction_tmsp      AS dwh_mapping_tmsp,
    NUMERIC '0'                 AS tf_error_fg,
    NUMERIC '0'                 AS deleted_fg,
    NUMERIC '0'                 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'OSO'                       AS dwh_node_cd,
    '${LOAD_ID}'           AS dwh_load_id
  FROM
    src_with_sid_cm AS src
    CROSS JOIN etl_process.t_country_special_char_1 AS sc
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY emp_nat_key_nr, job_role_nat_key_nr
    ORDER BY IF(src.sales_comp_extraction_tmsp IS NULL, 0, 1) DESC,
             src.sales_comp_extraction_tmsp DESC
  ) = 1
;
