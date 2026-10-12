/* Create records for those stores that have never been replaced */
INSERT INTO etl.${src2tgt_temp_table1}_${src_context_area} (
  int_org_sid,
  int_org_type_cd,
  int_org_nr,
  int_org_name,
  country_org_name,
  open_dt,
  planned_open_dt,
  close_dt,
  curr_cd,
  holiday_store_fg,
  legal_name,
  vat_nr,
  country_org_cd,
  comment_txt,
  is_sales_company_fg,
  is_deliv_company_fg,
  is_country_org_fg,
  is_expansion_company_fg,
  is_bal_sheet_company_fg,
  is_owner_company_fg,
  is_trust_fg,
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
WITH src_sel AS (
  SELECT
      -- Source is deduplicated data from LISY_CDS_ACCOUNT, filtered to contain only buildings related to stores. And the building must have OPEN_DT. We also check it we already have existing records from LISY to decide if validity_2 date (DWH_VALID_FROM_TMSP) should be OPEN_DT  (for the first records) or "now" (the date of change for the any following records)
      *
    FROM
      etl_process.t_${src_input_table}
    WHERE numeric '1' = numeric '1'
      AND t_${src_input_table}.igl_accounttypecode IN (
        numeric '285540000', numeric '285540009'
      ) -- real estate associated with stores and special sale stores
      AND t_${src_input_table}.igl_number IS NOT NULL -- only objects with assigned object number should be considered
      AND (
           t_${src_input_table}.igl_neodate IS NOT NULL
        OR t_${src_input_table}.igl_closingdate IS NOT NULL
      ) -- if a building should be counted as a Store, it must have at least one of these dates
), src_with_sid AS (
  SELECT
      -- the first two parts of the mapping are responsible for generating SIDs in the META schema
      -- so we can use inner join with the KEY table - the NKs are already there and mapped to SIDs
      st_k.party_sid AS store_sid,
      src_sel.*
    FROM
      src_sel
      INNER JOIN meta.t_party_key_2 AS st_k
        ON st_k.party_nat_key_nr = CONCAT(
             UPPER(SUBSTR(igl_number, 1, 2)), '|',
             CAST(ROUND(CAST(SUBSTR(igl_number, 3, 5) AS bignumeric), 0) AS string)
           )
    WHERE st_k.party_key_type_cd = 'STORE'
      AND st_k.dwh_valid_fg = TRUE
    -- we will not update the information for the store based on the info for older buildings
    -- if source provides info for two buildings that represent the same store,
    -- we want to take only the information for the most recent building
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY store_sid
      ORDER BY IF(igl_neodate IS NULL, 0, 1), igl_neodate DESC
    ) = numeric '1'
), lisy_hist_exists AS (
  SELECT DISTINCT
      t_internal_organization.int_org_sid AS store_sid
    FROM
      core_rel.t_internal_organization_2
    WHERE UPPER(t_internal_organization.dwh_node_cd) = 'LISY'
      AND t_internal_organization.int_org_type_cd = 'STORE'
)
SELECT
    src.store_sid AS int_org_sid,
    'STORE' AS int_org_type_cd,
    CONCAT(
      UPPER(SUBSTR(igl_number, 1, 2)),
      CAST(ROUND(CAST(SUBSTR(igl_number, 3, 5) AS bignumeric), 0) AS string)
    ) AS int_org_nr,
    SUBSTR(src.name, 11) AS int_org_name,
    CASE
      WHEN igl_isocode2 = 'LU' THEN 'Belgien'
      WHEN igl_isocode2 = 'NI' THEN 'Nordirland'
      ELSE ctry.country_name
    END AS country_org_name,
    MIN(DATE(igl_neodate)) OVER (
      PARTITION BY CONCAT(
                     LOWER(SUBSTR(igl_number, 1, 2)), '|',
                     CAST(ROUND(CAST(SUBSTR(igl_number, 3, 5) AS bignumeric), 0) AS string)
                   )
    ) AS open_dt,
    MIN(DATE(igl_expectedopeningdate)) OVER (
      PARTITION BY CONCAT(
                     LOWER(SUBSTR(igl_number, 1, 2)), '|',
                     CAST(ROUND(CAST(SUBSTR(igl_number, 3, 5) AS bignumeric), 0) AS string)
                   )
    ) AS planned_open_dt,
    LAST_VALUE(DATE(igl_closingdate)) OVER (
      PARTITION BY CONCAT(
                     LOWER(SUBSTR(igl_number, 1, 2)), '|',
                     CAST(ROUND(CAST(SUBSTR(igl_number, 3, 5) AS bignumeric), 0) AS string)
                   )
      ORDER BY igl_closingdate NULLS LAST
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS close_dt,
    NULL AS curr_cd,
    NULL AS holiday_store_fg,
    NULL AS legal_name,
    NULL AS vat_nr,
    CASE
      WHEN igl_isocode2 = 'LU' THEN 'BE'
      ELSE igl_isocode2
    END AS country_org_cd,
    NULL AS comment_txt,
    NULL AS is_sales_company_fg,
    NULL AS is_deliv_company_fg,
    NULL AS is_country_org_fg,
    NULL AS is_expansion_company_fg,
    NULL AS is_bal_sheet_company_fg,
    NULL AS is_owner_company_fg,
    NULL AS is_trust_fg,
    'LISY' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    CASE
      WHEN lhe.store_sid IS NULL
       AND src.igl_neodate <= CURRENT_DATE() THEN src.igl_neodate
      WHEN lhe.store_sid IS NULL
       AND src.igl_neodate > CURRENT_DATE() THEN src.sinkmodifiedon
      WHEN lhe.store_sid IS NOT NULL
       AND src.igl_closingdate < src.sinkmodifiedon THEN COALESCE(src.igl_neodate, src.igl_contractdate)
      ELSE src.sinkmodifiedon
    END AS dwh_valid_from_tmsp,
    -- there are some records from LISY, so if there is a change in some attribute and it is valid from this moment
    numeric '0' AS tf_error_fg,
    numeric '0' AS deleted_fg,
    numeric '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'LISY' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM
  src_with_sid AS src
  -- check if we already have LISY history in the hierarchy_2
  LEFT OUTER JOIN lisy_hist_exists AS lhe
    ON lhe.store_sid = src.store_sid
  LEFT OUTER JOIN core_rel.t_country_2 AS ctry
    ON src.igl_isocode2 = ctry.iso_country_cd
   AND ctry.dwh_valid_fg = TRUE
;
