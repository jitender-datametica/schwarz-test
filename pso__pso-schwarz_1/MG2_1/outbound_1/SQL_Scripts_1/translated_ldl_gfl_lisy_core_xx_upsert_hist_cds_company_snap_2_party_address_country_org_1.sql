INSERT INTO etl.${src2tgt_temp_table1}_${src_context_area} (
  party_key_type_cd,
  party_natural_key,
  addr_key_type_cd,
  addr_natural_key,
  addr_usg_type_cd,
  party_type_cd,
  addr_type_cd,
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
WITH ranked_addr AS (
  SELECT
      SUBSTR(src.igl_associationnumber, 1, 2) AS party_natural_key,
      company_natural_key AS company_natural_key,
      CONCAT(
        COALESCE(src.igl_isocode2, ''),
        '|',
        COALESCE(src.igl_city, ''),
        '|',
        COALESCE(src.igl_postalcode, ''),
        '|',
        COALESCE(src.igl_street, ''),
        '|',
        COALESCE(src.igl_housenumber, '')
      ) AS addr_natural_key,
      CASE
         src.igl_companytypecode
        WHEN NUMERIC '285540000' THEN NUMERIC '1' -- (delivery company)
        WHEN NUMERIC '285540002' THEN NUMERIC '2' -- (sales_1 company)
        WHEN NUMERIC '285540001' THEN NUMERIC '3' -- (head office)
        WHEN NUMERIC '285540003' THEN NUMERIC '4' -- (expansion company)
        ELSE NUMERIC '99'
      END AS ranking,
      -- (lowest ranking)
      SUM(
        CASE src.igl_companytypecode
          WHEN NUMERIC '285540001' THEN NUMERIC '1'
          ELSE NUMERIC '0'
        END
      ) OVER (PARTITION BY company_natural_key) AS is_country_org,
      src.*
    FROM
      etl_process.t_${src_input_table} AS src
      CROSS JOIN UNNEST(ARRAY[
        CONCAT(
          SUBSTR(src.igl_associationnumber, 1, 2),
          '|',
          CAST(
            ROUND(
              CAST(REGEXP_REPLACE(src.igl_associationnumber, '[^0-9]', '') AS bignumeric),
              0
            ) AS STRING
          )
        )
      ]) AS company_natural_key
    WHERE src.igl_companytypecode IS NOT NULL
     AND src.igl_companytypecode IN(
        NUMERIC '285540000',
        NUMERIC '285540001',
        NUMERIC '285540002',
        NUMERIC '285540003',
        NUMERIC '285540005',
        NUMERIC '285540006'
     )
     AND src.igl_associationnumber IS NOT NULL
     AND REGEXP_CONTAINS(src.igl_associationnumber, r'^(?:^[A-Z]{2}.*)$')
     AND src.igl_isocode2 IS NOT NULL
     AND src.deleted <> 'x'
)
SELECT
    -- make sure we are working with Head offices
    'COUNTRY_1' AS party_key_type_cd,
    ranked_addr.party_natural_key AS party_natural_key,
    'STAD' AS addr_key_type_cd,
    ranked_addr.addr_natural_key AS addr_natural_key,
    'SA_MN' AS addr_usg_type_cd,
    'INT_ORG' AS party_type_cd,
    'STAD' AS addr_type_cd,
    'LISY' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    ranked_addr.sinkmodifiedon AS dwh_mapping_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS deleted_fg,
    NUMERIC '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'LISY' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
  FROM
    ranked_addr
  WHERE ranked_addr.is_country_org = NUMERIC '1'
    -- even if these companies come with a flag that they are country_1 orgs, we ignore them
    -- we expect the country_1 orgs for these countries to be other companies and there can be only one country_1 org
    -- FR|99, CZ|1, SI|1
     AND ranked_addr.company_natural_key NOT IN(
      'FR|1', 'FR|2', 'CZ|2', 'SI|5', 'DE|10', 'DE|79'
    )
  QUALIFY
    ROW_NUMBER() OVER (
      PARTITION BY ranked_addr.company_natural_key
      ORDER BY IF(ranked_addr.ranking IS NULL, 0, 1) DESC, ranked_addr.ranking
    ) = NUMERIC '1'
;
