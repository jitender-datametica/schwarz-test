-- STEP 1. CREATE A TEMPORARY TABLE CONTAINING ONE ROW PER COMPANY WITH FLAGS FOR EACH ROLE AS PER LATEST EXTRACT
CREATE OR REPLACE TEMPORARY TABLE t_tmp_lisy_comp AS
WITH last_comp_role_extract AS (
  SELECT
      -- one row per company role
      t_tcache_lisy_cds_company_snap.id,
      t_tcache_lisy_cds_company_snap.igl_legalname,
      t_tcache_lisy_cds_company_snap.igl_name,
      t_tcache_lisy_cds_company_snap.igl_companytypecode,
      t_tcache_lisy_cds_company_snap.igl_isocode2,
      CONCAT(
        SUBSTR(t_tcache_lisy_cds_company_snap.igl_associationnumber, 1, 2),
        CAST(ROUND(CAST(REGEXP_REPLACE(t_tcache_lisy_cds_company_snap.igl_associationnumber, '[^0-9]', '') AS bignumeric), 0) AS string)
      ) AS int_org_nr,
      CONCAT(
        SUBSTR(t_tcache_lisy_cds_company_snap.igl_associationnumber, 1, 2),
        '|',
        CAST(ROUND(CAST(REGEXP_REPLACE(t_tcache_lisy_cds_company_snap.igl_associationnumber, '[^0-9]', '') AS bignumeric), 0) AS string)
      ) AS party_nat_key_nr,
      comp_nr_len AS comp_nr_len,
      CASE
        WHEN REGEXP_CONTAINS(
               SUBSTR(t_tcache_lisy_cds_company_snap.igl_associationnumber, CAST(comp_nr_len - numeric '2' AS int64), 1),
               r'^(?:[0-9])$'
             ) -- if 3rd char from the back is digit
             THEN SUBSTR(t_tcache_lisy_cds_company_snap.igl_associationnumber, CAST(comp_nr_len - numeric '1' AS int64), 2)
              -- get last 2 chars
        ELSE SUBSTR(t_tcache_lisy_cds_company_snap.igl_associationnumber, CAST(comp_nr_len - numeric '2' AS int64), 3)
      END  AS int_org_short_name, -- get last 3 chars
      t_tcache_lisy_cds_company_snap.statecode,
      t_tcache_lisy_cds_company_snap.sinkmodifiedon
    FROM
      etl_process.t_tcache_lisy_cds_company_snap_1
      CROSS JOIN UNNEST(ARRAY[
        CAST(LENGTH(t_tcache_lisy_cds_company_snap.igl_associationnumber) AS bignumeric)
      ]) AS comp_nr_len
    WHERE REGEXP_CONTAINS(
            t_tcache_lisy_cds_company_snap.igl_associationnumber,
            r'^(?:^[A-Z]{2}.*)$'
          )
)
SELECT
    last_comp_role_extract.int_org_nr,
    last_comp_role_extract.party_nat_key_nr,
    last_comp_role_extract.igl_isocode2,
    MAX(last_comp_role_extract.sinkmodifiedon) AS mapping_tmsp,
    MIN_BY(last_comp_role_extract.igl_legalname, last_comp_role_extract.igl_legalname)  AS legal_name, -- we want to have the same legal name in all rows that are for the same company
    MIN_BY(
      REGEXP_REPLACE(last_comp_role_extract.igl_name, r'\([A-Z]{2,3}\)', ''),
      last_comp_role_extract.igl_legalname
    )  AS int_org_name,-- we want to have same name in all rows that are for the same company
    MIN_BY(last_comp_role_extract.int_org_short_name, last_comp_role_extract.igl_legalname) AS int_org_short_name,
    -- country_org_cd is populated only when the company has an active role of a country_1 organization
    CASE
      WHEN SUM(
             IF(
               last_comp_role_extract.igl_companytypecode = '285540001'
               AND last_comp_role_extract.statecode = numeric '0',
               numeric '1',
               numeric '0'
             )
           ) > numeric '0' THEN last_comp_role_extract.igl_isocode2
      ELSE NULL
    END AS country_org_cd,
    -- flags are True if we have a record with this role for the company and its state is active
    SUM(
      IF(
        last_comp_role_extract.igl_companytypecode = '285540002'
        AND last_comp_role_extract.statecode = numeric '0',
        numeric '1',
        numeric '0'
      )
    ) > numeric '0' AS is_sales_company_fg,
    SUM(
      IF(
        last_comp_role_extract.igl_companytypecode = '285540000'
        AND last_comp_role_extract.statecode = numeric '0',
        numeric '1',
        numeric '0'
      )
    ) > numeric '0' AS is_deliv_company_fg,
    SUM(
      IF(
        last_comp_role_extract.igl_companytypecode = '285540003'
        AND last_comp_role_extract.statecode = numeric '0',
        numeric '1',
        numeric '0'
      )
    ) > numeric '0' AS is_expansion_company_fg,
    SUM(
      IF(
        last_comp_role_extract.igl_companytypecode = '285540006'
        AND last_comp_role_extract.statecode = numeric '0',
        numeric '1',
        numeric '0'
      )
    ) > numeric '0' AS is_bal_sheet_company_fg,
    SUM(
      IF(
        last_comp_role_extract.igl_companytypecode = '285540005'
        AND last_comp_role_extract.statecode = numeric '0',
        numeric '1',
        numeric '0'
      )
    ) > numeric '0' AS is_owner_company_fg,
    SUM(
      IF(
        last_comp_role_extract.igl_companytypecode = '285540001'
        AND last_comp_role_extract.statecode = numeric '0',
        numeric '1',
        numeric '0'
      )
    ) > numeric '0' AS is_country_org_fg
  FROM
    last_comp_role_extract
  GROUP BY 1, 2, 3
;

-- reduce the dataset to 1 row per company

-- STEP 2. CREATE A TEMPORARY TABLE WITH THE VALIDITY_1 DATES OF ALL COMPANY ROLE - STORE RELATIONS
CREATE OR REPLACE TEMPORARY TABLE t_tmp_lisy_comp_rel AS
WITH last_rel_extract AS (
  SELECT
      rdg.igl_regionid AS comp_role_id,
      CONCAT(
        SUBSTR(c.igl_associationnumber, 1, 2),
        CAST(ROUND(CAST(REGEXP_REPLACE(c.igl_associationnumber, '[^0-9]', '') AS bignumeric), 0) AS string)
      ) AS int_org_nr,
      rdg.igl_companytypecode AS comp_role_type_cd,
      DATE(rdg.igl_validfromdate) AS val_from,
      COALESCE(CAST(DATE(rdg.igl_validtodate) AS string), '9999-12-31') AS val_to -- default for open interval 
    FROM
      etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_1 AS rdg
      INNER JOIN etl_process.t_tcache_lisy_cds_company_snap_1 AS c
        ON c.id = rdg.igl_regionid
       AND c.igl_companytypecode = rdg.igl_companytypecode
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY comp_role_id, comp_role_type_cd, rdg.igl_validfromdate
      ORDER BY IF(rdg.sinkmodifiedon IS NULL, 0, 1), rdg.sinkmodifiedon DESC
    ) = numeric '1'
), rel_dates AS (
  SELECT
      last_rel_extract.int_org_nr,
      last_rel_extract.comp_role_type_cd,
      last_rel_extract.val_from,
      last_rel_extract.val_to,
      MAX(last_rel_extract.val_to) OVER (
        PARTITION BY last_rel_extract.int_org_nr, last_rel_extract.comp_role_type_cd
        ORDER BY last_rel_extract.val_from NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
      ) AS prev_max_val_to,
      CASE
        WHEN MAX(last_rel_extract.val_to) OVER (
               PARTITION BY last_rel_extract.int_org_nr, last_rel_extract.comp_role_type_cd
               ORDER BY last_rel_extract.val_from NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
             ) IS NULL THEN numeric '0'
        WHEN last_rel_extract.val_from > CAST(
               MAX(last_rel_extract.val_to) OVER (
                 PARTITION BY last_rel_extract.int_org_nr, last_rel_extract.comp_role_type_cd
                 ORDER BY last_rel_extract.val_from NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
               ) AS bignumeric
             ) + numeric '1' THEN numeric '1'
        ELSE numeric '0'
      END AS has_gap_fg
    FROM
      last_rel_extract
), rel_dates_with_groups AS (
  SELECT
      rd.*,
      SUM(rd.has_gap_fg) OVER (
        PARTITION BY rd.int_org_nr, rd.comp_role_type_cd
        ORDER BY rd.val_from NULLS LAST, rd.has_gap_fg DESC NULLS FIRST ROWS UNBOUNDED PRECEDING
      ) AS time_group_id
    FROM
      rel_dates AS rd
)
SELECT
    rel_dates_with_groups.int_org_nr,
    rel_dates_with_groups.comp_role_type_cd,
    rel_dates_with_groups.time_group_id,
    MIN(rel_dates_with_groups.val_from) AS val_from,
    MAX(rel_dates_with_groups.val_to) AS val_to
  FROM
    rel_dates_with_groups
  GROUP BY 1, 2, 3
;

-- STEP 3. HISTORIZE ROLE CHANGES FOR EACH COMPANY
CREATE OR REPLACE TABLE etl.t_tmp_lisy_comp_rel_tf_1 AS
WITH cal_dt_flags AS (
  SELECT
      c.int_org_nr,
      cd.cal_dt,
      c.party_nat_key_nr,
      c.int_org_name,
      c.legal_name,
      c.int_org_short_name,
      CASE
        WHEN cd.cal_dt < CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND co.val_from IS NOT NULL
         OR cd.cal_dt >= CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND c.is_country_org_fg = TRUE
         OR c.int_org_nr = 'MT99' THEN c.country_org_cd
        ELSE NULL
      END AS country_org_cd,
      CASE
        WHEN cd.cal_dt < CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND dc.val_from IS NOT NULL
         OR cd.cal_dt >= CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND c.is_deliv_company_fg = TRUE THEN TRUE
        ELSE FALSE
      END AS is_deliv_company_fg,
      CASE
        WHEN cd.cal_dt < CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND sc.val_from IS NOT NULL
         OR cd.cal_dt >= CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND c.is_sales_company_fg = TRUE THEN TRUE
        ELSE FALSE
      END AS is_sales_company_fg,
      CASE
        WHEN cd.cal_dt < CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND ec.val_from IS NOT NULL
         OR cd.cal_dt >= CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND c.is_expansion_company_fg = TRUE THEN TRUE
        ELSE FALSE
      END AS is_expansion_company_fg,
      CASE
        WHEN cd.cal_dt < CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND oc.val_from IS NOT NULL
         OR cd.cal_dt >= CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND c.is_owner_company_fg = TRUE THEN TRUE
        ELSE FALSE
      END AS is_owner_company_fg,
      CASE
        WHEN cd.cal_dt < CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND bc.val_from IS NOT NULL
         OR cd.cal_dt >= CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND c.is_bal_sheet_company_fg = TRUE THEN TRUE
        ELSE FALSE
      END AS is_bal_sheet_company_fg,
      CASE
        WHEN cd.cal_dt < CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND co.val_from IS NOT NULL
         OR cd.cal_dt >= CAST(CAST(c.mapping_tmsp AS string) AS DATE)
         AND c.is_country_org_fg = TRUE
         OR c.int_org_nr = 'MT99' THEN TRUE
        ELSE FALSE
      END AS is_country_org_fg
    FROM
      t_tmp_lisy_comp AS c
      CROSS JOIN core_dim.t_dim_calendar_date_1 AS cd
      LEFT OUTER JOIN t_tmp_lisy_comp_rel AS dc
        ON c.int_org_nr = dc.int_org_nr
       AND cd.cal_dt BETWEEN dc.val_from AND dc.val_to
       AND dc.comp_role_type_cd = '285540000'
      LEFT OUTER JOIN t_tmp_lisy_comp_rel AS co
        ON c.int_org_nr = co.int_org_nr
       AND cd.cal_dt BETWEEN co.val_from AND co.val_to
       AND co.comp_role_type_cd = '285540001'
      LEFT OUTER JOIN t_tmp_lisy_comp_rel AS sc
        ON c.int_org_nr = sc.int_org_nr
       AND cd.cal_dt BETWEEN sc.val_from AND sc.val_to
       AND sc.comp_role_type_cd = '285540002'
      LEFT OUTER JOIN t_tmp_lisy_comp_rel AS ec
        ON c.int_org_nr = ec.int_org_nr
       AND cd.cal_dt BETWEEN ec.val_from AND ec.val_to
       AND ec.comp_role_type_cd = '285540003'
      LEFT OUTER JOIN t_tmp_lisy_comp_rel AS oc
        ON c.int_org_nr = oc.int_org_nr
       AND cd.cal_dt BETWEEN oc.val_from AND oc.val_to
       AND oc.comp_role_type_cd = '285540005'
      LEFT OUTER JOIN t_tmp_lisy_comp_rel AS bc
        ON c.int_org_nr = bc.int_org_nr
       AND cd.cal_dt BETWEEN bc.val_from AND bc.val_to
       AND bc.comp_role_type_cd = '285540006'
    WHERE numeric '1' = numeric '1'
      AND cd.cal_dt BETWEEN '1900-01-01' AND CURRENT_DATE() -- current_date will always be >= extraction date from the latest company export
), flag_changes AS (
  SELECT
    *,
    TO_HEX(SHA256(
      CONCAT(
        '#' || CAST(is_deliv_company_fg AS STRING),
        '#' || CAST(is_country_org_fg AS STRING),
        '#' || CAST(is_sales_company_fg AS STRING),
        '#' || CAST(is_expansion_company_fg AS STRING),
        '#' || CAST(is_owner_company_fg AS STRING),
        '#' || CAST(is_bal_sheet_company_fg AS STRING)
      )
    )) AS hash_value,
    CASE
      WHEN TO_HEX(SHA256(
             CONCAT(
               '#' || CAST(is_deliv_company_fg AS STRING),
               '#' || CAST(is_country_org_fg AS STRING),
               '#' || CAST(is_sales_company_fg AS STRING),
               '#' || CAST(is_expansion_company_fg AS STRING),
               '#' || CAST(is_owner_company_fg AS STRING),
               '#' || CAST(is_bal_sheet_company_fg AS STRING)
             )
           ))
           != LAG(TO_HEX(SHA256(
               CONCAT(
                 '#' || CAST(is_deliv_company_fg AS STRING),
                 '#' || CAST(is_country_org_fg AS STRING),
                 '#' || CAST(is_sales_company_fg AS STRING),
                 '#' || CAST(is_expansion_company_fg AS STRING),
                 '#' || CAST(is_owner_company_fg AS STRING),
                 '#' || CAST(is_bal_sheet_company_fg AS STRING)
               )
             )), 1, '-') OVER (PARTITION BY int_org_nr ORDER BY cal_dt)
      THEN 1
      ELSE 0
    END AS change_fg
FROM cal_dt_flags
), flag_change_groups AS (
  SELECT
      flag_changes.*,
      SUM(flag_changes.change_fg) OVER (PARTITION BY flag_changes.int_org_nr ORDER BY IF(flag_changes.cal_dt IS NULL, 0, 1) DESC, flag_changes.cal_dt) AS group_id
    FROM
      flag_changes
)
SELECT
    fcg.int_org_nr,
    fcg.party_nat_key_nr,
    CAST(CAST(MIN(fcg.cal_dt) AS string) AS datetime) AS dwh_valid_from,
    CASE
      WHEN MAX(fcg.cal_dt) >= CURRENT_DATE() THEN CAST('9999-12-31 23:59:59.99999999999' AS datetime)
      ELSE datetime_sub(datetime_add(CAST(CAST(MAX(fcg.cal_dt) AS string) AS datetime), INTERVAL 1 DAY), INTERVAL 1 nanosecond)
    END AS dwh_valid_to,
    fcg.int_org_name,
    fcg.legal_name,
    fcg.int_org_short_name,
    CASE
      WHEN fcg.is_country_org_fg = TRUE
       AND fcg.country_org_cd = 'NI' THEN 'GBP' -- NI data from LISY is for Northern Ireland, and not NIcaragua.
      WHEN fcg.is_country_org_fg = TRUE
       AND fcg.party_nat_key_nr NOT IN(
        'FR|1', 'FR|2', 'SI|5', 'CZ|2', 'DE|10', 'DE|79'
      ) THEN cntr.curr_cd
      ELSE NULL
    END AS curr_cd,
    CASE
      WHEN fcg.party_nat_key_nr IN(
        'FR|1', 'FR|2', 'SI|5', 'CZ|2', 'DE|10', 'DE|79'
      ) THEN NULL
      ELSE fcg.country_org_cd
    END AS country_org_cd,
    CASE
      WHEN fcg.country_org_cd = 'NI' THEN 'Nordirland'
      ELSE cntr.country_name
    END AS country_org_name,
    fcg.is_sales_company_fg,
    fcg.is_deliv_company_fg,
    fcg.is_expansion_company_fg,
    fcg.is_bal_sheet_company_fg,
    fcg.is_owner_company_fg,
    CASE
      WHEN fcg.party_nat_key_nr IN(
        'FR|1', 'FR|2', 'SI|5', 'CZ|2', 'DE|10', 'DE|79'
      ) THEN FALSE
      ELSE fcg.is_country_org_fg
    END AS is_country_org_fg
FROM
  flag_change_groups AS fcg
  LEFT OUTER JOIN core_rel.t_country_1 AS cntr
    ON fcg.country_org_cd = cntr.iso_country_cd
   AND cntr.dwh_valid_fg = TRUE
GROUP BY 1, 2, 5, 6, 7, 8, fcg.country_org_cd, 10, 11, 12, 13, 14, 15, fcg.is_country_org_fg, fcg.group_id
;

-- STEP 4 - NKC Additions
INSERT INTO meta.t_party_key_1 (
  party_sid,
  party_key_type_cd,
  party_nat_key_nr,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  dwh_node_cd,
  dwh_load_id
)
SELECT
    max_seq.max_seq + ROW_NUMBER() OVER (ORDER BY IF(numeric '1' IS NULL, 0, 1) DESC, numeric '1') AS party_sid,
    t1.int_org_key_type_cd,
    t1.int_org_natural_key AS natural_key,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP(),
    '9999-12-31 23:59:59.999999999',
    TRUE,
    t1.dwh_node_cd,
    '${load_id}'
  FROM (
    SELECT
        t1_0.dwh_node_cd,
        t1_0.int_org_key_type_cd,
        t1_0.int_org_natural_key
      FROM (
        SELECT
            'LISY' AS dwh_node_cd,
            'COMPANY' AS int_org_key_type_cd,
            UPPER(t1_1.party_nat_key_nr) AS int_org_natural_key
          FROM
            etl.t_tmp_lisy_comp_rel_tf_1 AS t1_1
      ) AS t1_0
    GROUP BY 1, 2, 3
) AS t1_1
CROSS JOIN (
  SELECT
      COALESCE(MAX(t_party_key.party_sid), numeric '0') AS max_seq
    FROM
      meta.t_party_key_1
) AS max_seq
WHERE t1.int_org_natural_key IS NOT NULL
  AND NOT EXISTS (
    SELECT numeric '1'
      FROM meta.t_party_key_1 AS t2
     WHERE UPPER(t2.party_key_type_cd) = t1.int_org_key_type_cd
       AND CURRENT_TIMESTAMP() BETWEEN t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp
       AND UPPER(t2.party_nat_key_nr) = t1.int_org_natural_key
);

DELETE FROM core_rel.t_internal_organization_1 AS io
 WHERE io.int_org_type_cd = 'COMPANY'
   AND io.int_org_sid IN (
    SELECT DISTINCT
        party_sid
      FROM
        meta.t_party_key_1 AS int_org_sid
      INNER JOIN etl.t_tmp_lisy_comp_rel_tf_1 AS tf
        ON int_org_sid.dwh_valid_fg = TRUE
       AND int_org_sid.party_key_type_cd = 'COMPANY'
       AND UPPER(int_org_sid.party_nat_key_nr) = UPPER(tf.party_nat_key_nr)
);

INSERT INTO core_rel.t_internal_organization_1 (
  int_org_sid,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  int_org_type_cd,
  int_org_nr,
  int_org_name,
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
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd,
  int_org_short_name,
  country_org_name
)
SELECT
    int_org_sid.party_sid,
    tf.dwh_valid_from,
    tf.dwh_valid_to,
    CASE
      WHEN CURRENT_TIMESTAMP() BETWEEN tf.dwh_valid_from AND tf.dwh_valid_to THEN TRUE
      ELSE FALSE
    END AS dwh_valid_fg,
    'COMPANY',
    tf.int_org_nr,
    COALESCE(tf.int_org_name, CONCAT('Unbekannt', ' (', tf.int_org_nr, ')')) AS int_org_name,
    NULL,
    NULL,
    NULL,
    tf.curr_cd,
    NULL,
    tf.legal_name,
    NULL,
    tf.country_org_cd,
    NULL,
    tf.is_sales_company_fg,
    tf.is_deliv_company_fg,
    tf.is_country_org_fg,
    tf.is_expansion_company_fg,
    tf.is_bal_sheet_company_fg,
    tf.is_owner_company_fg,
    FALSE AS is_trust_fg,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP(),
    '${load_id}',
    'LISY',
    tf.int_org_short_name,
    tf.country_org_name
FROM
  etl.t_tmp_lisy_comp_rel_tf_1 AS tf
  LEFT OUTER JOIN meta.t_party_key_1 AS int_org_sid
    ON int_org_sid.dwh_valid_fg = TRUE
   AND int_org_sid.party_key_type_cd = 'COMPANY'
   AND UPPER(int_org_sid.party_nat_key_nr) = UPPER(tf.party_nat_key_nr)
;

BEGIN TRANSACTION;
-- Note: any record for the previous country_1 organiation that started after the new organization become active should have its flag set to FALSE.
-- records for previous Country_1 Orgs that started before but end after the new organization becomes active should have their end-date adjusted and the gap should be filled with a record for the previous organization with flag FALSE (the insert in "M5")
MERGE INTO core_rel.t_internal_organization_1 AS trg
USING (
  WITH prev AS (
    SELECT
        t_internal_organization.*
      FROM
        core_rel.t_internal_organization_1
      WHERE t_internal_organization.is_country_org_fg = TRUE
       AND t_internal_organization.int_org_type_cd = 'COMPANY'
      QUALIFY numeric '1' = numeric '1'
       AND COUNT(DISTINCT int_org_sid) OVER (PARTITION BY country_org_cd) > numeric '1'
       AND RANK() OVER (PARTITION BY country_org_cd ORDER BY IF(dwh_load_id IS NULL, 0, 1), dwh_load_id DESC) > numeric '1'
  ), curr AS (
    SELECT
        t_internal_organization.*
      FROM
        core_rel.t_internal_organization_1
      WHERE t_internal_organization.is_country_org_fg = TRUE
       AND t_internal_organization.int_org_type_cd = 'COMPANY'
      QUALIFY numeric '1' = numeric '1'
       AND COUNT(DISTINCT int_org_sid) OVER (PARTITION BY country_org_cd) > numeric '1'
       AND RANK() OVER (PARTITION BY country_org_cd ORDER BY IF(dwh_load_id IS NULL, 0, 1), dwh_load_id DESC) = numeric '1'
  )
  SELECT
      prev.int_org_sid,
      prev.dwh_valid_from_tmsp AS prev_valid_from,
      prev.dwh_valid_to_tmsp AS prev_valid_to,
      CASE
        WHEN prev.dwh_valid_from_tmsp >= MIN(curr.dwh_valid_from_tmsp) THEN 'UPD FLAG'
        ELSE 'UPD TMSP'
      END AS action_type,
      MIN(curr.dwh_valid_from_tmsp) AS curr_valid_from,
      DATE_SUB(MIN(curr.dwh_valid_from_tmsp), INTERVAL 1 nanosecond) AS new_valid_to,
      prev.country_org_cd
    FROM
      prev
      INNER JOIN curr ON prev.country_org_cd = curr.country_org_cd
       AND prev.dwh_valid_to_tmsp > curr.dwh_valid_from_tmsp
    GROUP BY 1, 2, 3, 7
) AS src
ON trg.int_org_sid = src.int_org_sid
 AND trg.dwh_valid_from_tmsp = src.prev_valid_from
   WHEN MATCHED THEN UPDATE SET
    is_country_org_fg = CASE
       src.action_type
      WHEN 'UPD FLAG' THEN FALSE
      ELSE TRUE
    END,
    dwh_valid_to_tmsp = CASE
       src.action_type
      WHEN 'UPD TMSP' THEN src.new_valid_to
      ELSE src.prev_valid_to
    END,
    dwh_updated_tmsp = CURRENT_TIMESTAMP(),
    dwh_load_id = '${load_id}'
;
COMMIT TRANSACTION;
