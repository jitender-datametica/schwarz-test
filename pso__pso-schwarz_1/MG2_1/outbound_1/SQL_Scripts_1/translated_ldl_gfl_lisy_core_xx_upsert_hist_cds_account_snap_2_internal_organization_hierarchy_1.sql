-- if we get information for the store for this type of relationship from lisy
-- delete relationships of type 'DELIVCMP_STORE' from non-lisy sources
DELETE FROM core_rel.t_internal_organization_hierarchy_1
WHERE NUMERIC '1' = NUMERIC '1'
  AND UPPER(t_internal_organization_hierarchy.dwh_node_cd) <> 'LISY'
  AND t_internal_organization_hierarchy.int_org_hierarchy_type_cd = 'DELIVCMP_STORE'
  AND t_internal_organization_hierarchy.int_org_sid IN (
    SELECT
        -- get the SID only if LISY sends us information to which company the CURRENT building of the store is related
        curr_store.party_sid
      FROM
        meta.t_party_key_1 AS curr_store
        INNER JOIN (
          SELECT
              ac.igl_number,
              rh.*
            FROM
              etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_1 AS rh
              INNER JOIN etl_process.t_tcache_lisy_cds_account_snap_1 AS ac
                ON rh.igl_accountid = ac.accountid
            WHERE NUMERIC '1' = NUMERIC '1'
              AND rh.igl_companytypecode = NUMERIC '285540000'
              AND rh.statecode = NUMERIC '0'
              AND rh.igl_regionid IS NOT NULL
            QUALIFY ROW_NUMBER() OVER (
              PARTITION BY rh.igl_accountid,
                           rh.igl_regionid,
                           rh.igl_companytypecode,
                           rh.igl_validfromdate
              ORDER BY IF(rh.sinkmodifiedon IS NULL, 0, 1),
                       rh.sinkmodifiedon DESC
            ) = NUMERIC '1'
        ) AS src
          ON CONCAT(
               UPPER(SUBSTR(src.igl_number, 1, 2)),
               CAST(ROUND(CAST(SUBSTR(src.igl_number, 3, LENGTH(src.igl_number)) AS bignumeric), 0) AS string)
             ) =
             CONCAT(
               UPPER(SUBSTR(curr_store.party_nat_key_nr, 1, 2)),
               SUBSTR(curr_store.party_nat_key_nr, 4, LENGTH(curr_store.party_nat_key_nr))
             )
    WHERE NUMERIC '1' = NUMERIC '1'
      AND curr_store.dwh_valid_fg = TRUE
      AND curr_store.party_key_type_cd = 'STORE'
);

-- if we get information for the store for this type of relationship from lisy
-- delete relationships of type EXPCMP_STORE from non-lisy sources
DELETE FROM core_rel.t_internal_organization_hierarchy_1
WHERE NUMERIC '1' = NUMERIC '1'
  AND UPPER(t_internal_organization_hierarchy.dwh_node_cd) <> 'LISY'
  AND t_internal_organization_hierarchy.int_org_hierarchy_type_cd = 'EXPCMP_STORE'
  AND t_internal_organization_hierarchy.int_org_sid IN (
    SELECT
        curr_store.party_sid
      FROM
        meta.t_party_key_1 AS curr_store
        INNER JOIN (
          SELECT
              ac.igl_number,
              rh.*
            FROM
              etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_1 AS rh
              INNER JOIN etl_process.t_tcache_lisy_cds_account_snap_1 AS ac
                ON rh.igl_accountid = ac.accountid
            WHERE NUMERIC '1' = NUMERIC '1'
              AND rh.igl_companytypecode = NUMERIC '285540003'
              AND rh.statecode = NUMERIC '0'
              AND rh.igl_regionid IS NOT NULL
            QUALIFY ROW_NUMBER() OVER (
              PARTITION BY rh.igl_accountid,
                           rh.igl_regionid,
                           rh.igl_companytypecode,
                           rh.igl_validfromdate
              ORDER BY IF(rh.sinkmodifiedon IS NULL, 0, 1),
                       rh.sinkmodifiedon DESC
            ) = NUMERIC '1'
        ) AS src
          ON CONCAT(
               UPPER(SUBSTR(src.igl_number, 1, 2)),
               CAST(ROUND(CAST(SUBSTR(src.igl_number, 3, LENGTH(src.igl_number)) AS bignumeric), 0) AS string)
             ) =
             CONCAT(
               UPPER(SUBSTR(curr_store.party_nat_key_nr, 1, 2)),
               SUBSTR(curr_store.party_nat_key_nr, 4, LENGTH(curr_store.party_nat_key_nr))
             )
    WHERE NUMERIC '1' = NUMERIC '1'
      AND curr_store.dwh_valid_fg = TRUE
      AND curr_store.party_key_type_cd = 'STORE'
);

-- if we get information for the store for this type of relationship from lisy
-- delete relationships of type OWNERCMP_STORE from non-lisy sources
DELETE FROM core_rel.t_internal_organization_hierarchy_1
WHERE NUMERIC '1' = NUMERIC '1'
  AND UPPER(t_internal_organization_hierarchy.dwh_node_cd) <> 'LISY'
  AND t_internal_organization_hierarchy.int_org_hierarchy_type_cd = 'OWNERCMP_STORE'
  AND t_internal_organization_hierarchy.int_org_sid IN (
    SELECT
        curr_store.party_sid
      FROM
        meta.t_party_key_1 AS curr_store
        INNER JOIN (
          SELECT
              ac.igl_number,
              rh.*
            FROM
              etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_1 AS rh
              INNER JOIN etl_process.t_tcache_lisy_cds_account_snap_1 AS ac
                ON rh.igl_accountid = ac.accountid
            WHERE NUMERIC '1' = NUMERIC '1'
              AND rh.igl_companytypecode = NUMERIC '285540005'
              AND rh.statecode = NUMERIC '0'
              AND rh.igl_regionid IS NOT NULL
            QUALIFY ROW_NUMBER() OVER (
              PARTITION BY rh.igl_accountid,
                           rh.igl_regionid,
                           rh.igl_companytypecode,
                           rh.igl_validfromdate
              ORDER BY IF(rh.sinkmodifiedon IS NULL, 0, 1),
                       rh.sinkmodifiedon DESC
            ) = NUMERIC '1'
        ) AS src
          ON CONCAT(
               UPPER(SUBSTR(src.igl_number, 1, 2)),
               CAST(ROUND(CAST(SUBSTR(src.igl_number, 3, LENGTH(src.igl_number)) AS bignumeric), 0) AS string)
             ) =
             CONCAT(
               UPPER(SUBSTR(curr_store.party_nat_key_nr, 1, 2)),
               SUBSTR(curr_store.party_nat_key_nr, 4, LENGTH(curr_store.party_nat_key_nr))
             )
    WHERE NUMERIC '1' = NUMERIC '1'
      AND curr_store.dwh_valid_fg = TRUE
      AND curr_store.party_key_type_cd = 'STORE'
);

-- if we get information for the store for this type of relationship from lisy
-- delete relationships of type BALSHCMP_STORE from non-lisy sources
DELETE FROM core_rel.t_internal_organization_hierarchy_1
WHERE NUMERIC '1' = NUMERIC '1'
  AND UPPER(t_internal_organization_hierarchy.dwh_node_cd) <> 'LISY'
  AND t_internal_organization_hierarchy.int_org_hierarchy_type_cd = 'BALSHCMP_STORE'
  AND t_internal_organization_hierarchy.int_org_sid IN (
    SELECT
        curr_store.party_sid
      FROM
        meta.t_party_key_1 AS curr_store
        INNER JOIN (
          SELECT
              ac.igl_number,
              rh.*
            FROM
              etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_1 AS rh
              INNER JOIN etl_process.t_tcache_lisy_cds_account_snap_1 AS ac
                ON rh.igl_accountid = ac.accountid
            WHERE NUMERIC '1' = NUMERIC '1'
              AND rh.igl_companytypecode = NUMERIC '285540006'
              AND rh.statecode = NUMERIC '0'
              AND rh.igl_regionid IS NOT NULL
            QUALIFY ROW_NUMBER() OVER (
              PARTITION BY rh.igl_accountid,
                           rh.igl_regionid,
                           rh.igl_companytypecode,
                           rh.igl_validfromdate
              ORDER BY IF(rh.sinkmodifiedon IS NULL, 0, 1),
                       rh.sinkmodifiedon DESC
            ) = NUMERIC '1'
        ) AS src
          ON CONCAT(
               UPPER(SUBSTR(src.igl_number, 1, 2)),
               CAST(ROUND(CAST(SUBSTR(src.igl_number, 3, LENGTH(src.igl_number)) AS bignumeric), 0) AS string)
             ) =
             CONCAT(
               UPPER(SUBSTR(curr_store.party_nat_key_nr, 1, 2)),
               SUBSTR(curr_store.party_nat_key_nr, 4, LENGTH(curr_store.party_nat_key_nr))
             )
    WHERE NUMERIC '1' = NUMERIC '1'
      AND curr_store.dwh_valid_fg = TRUE
      AND curr_store.party_key_type_cd = 'STORE'
);

INSERT INTO etl.${src2tgt_temp_table1}_${src_context_area} (
  int_org_sid,
  int_org_hierarchy_type_cd,
  parent_int_org_sid,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  dwh_ending_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
WITH relhist_dedup AS (
  SELECT
      t_tcache_lisy_cds_regionrelationhistory_snap.*
    FROM
      etl_process.t_tcache_lisy_cds_regionrelationhistory_snap_1
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY igl_accountid,
                   igl_regionid,
                   igl_companytypecode,
                   igl_validfromdate
      ORDER BY IF(sinkmodifiedon IS NULL, 0, 1),
               sinkmodifiedon DESC
    ) = NUMERIC '1'
), src AS (
  SELECT
      act.igl_number,
      act.igl_neodate,
      act.igl_closingdate,
      rh.igl_validfromdate,
      DATETIME_SUB(DATETIME_ADD(rh.igl_validtodate, INTERVAL 1 DAY), INTERVAL 1 MILLISECOND) AS valid_to_tmsp,
      comp.igl_associationnumber,
      rh.igl_companytypecode,
      DATE(GREATEST(act.igl_neodate, rh.igl_validfromdate)) AS dwh_valid_from_dt,
      DATE(rh.igl_validtodate) AS dwh_valid_to_dt
    FROM
      relhist_dedup AS rh
      INNER JOIN etl_process.t_tcache_lisy_cds_account_snap_1 AS act
        ON rh.igl_accountid = act.accountid
      INNER JOIN etl_process.t_tcache_lisy_cds_company_snap_1 AS comp
        ON comp.id = rh.igl_regionid
    WHERE NUMERIC '1' = NUMERIC '1'
      AND act.igl_accounttypecode IN(
        NUMERIC '285540000', NUMERIC '285540009'
      )
      AND act.igl_number IS NOT NULL
      AND rh.igl_companytypecode IN(
        NUMERIC '285540000', NUMERIC '285540003', NUMERIC '285540005', NUMERIC '285540006'
      )
      AND rh.igl_validfromdate < rh.igl_validtodate
      AND (
        act.igl_neodate BETWEEN rh.igl_validfromdate AND rh.igl_validtodate
        OR act.igl_closingdate BETWEEN rh.igl_validfromdate AND rh.igl_validtodate
        OR (
          act.igl_closingdate IS NULL
          AND rh.igl_validtodate >= act.igl_neodate
        )
        OR (
          rh.igl_validfromdate > act.igl_neodate
          AND rh.igl_validtodate < act.igl_closingdate
        )
      )
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY act.igl_number,
                   rh.igl_companytypecode,
                   rh.igl_validfromdate
      ORDER BY IF(rh.igl_validfromdate IS NULL, 0, 1),
               rh.igl_validfromdate DESC
    ) = NUMERIC '1'
), src_with_sid AS (
  SELECT
      src.igl_companytypecode,
      store_key.party_sid AS store_sid,
      src.igl_validfromdate AS rel_valid_from,
      src.dwh_valid_from_dt,
      src.valid_to_tmsp,
      comp_key.party_sid AS company_sid
    FROM
      src
      INNER JOIN meta.t_party_key_1 AS store_key
        ON CONCAT(
             UPPER(SUBSTR(src.igl_number, 1, 2)), '|',
             CAST(ROUND(CAST(SUBSTR(src.igl_number, 3, LENGTH(src.igl_number)) AS bignumeric), 0) AS string)
           ) = store_key.party_nat_key_nr
      INNER JOIN meta.t_party_key_1 AS comp_key
        ON comp_key.party_nat_key_nr = CONCAT(
             SUBSTR(src.igl_associationnumber, 1, 2), '|',
             CAST(ROUND(CAST(REGEXP_REPLACE(src.igl_associationnumber, '[^0-9]', '') AS bignumeric), 0) AS string)
           )
       AND comp_key.party_key_type_cd = 'COMPANY'
    WHERE store_key.party_key_type_cd = 'STORE'
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY store_sid,
                   src.igl_companytypecode,
                   src.dwh_valid_from_dt
      ORDER BY IF(rel_valid_from IS NULL, 0, 1),
               rel_valid_from DESC
    ) = NUMERIC '1'
), src_track_changes AS (
  SELECT
      s.igl_companytypecode,
      s.store_sid,
      s.dwh_valid_from_dt,
      LEAST(
        CAST(s.valid_to_tmsp AS STRING),
        COALESCE(
          CAST(DATE_SUB(LEAD(s.dwh_valid_from_dt, 1) OVER (
            PARTITION BY s.store_sid, s.igl_companytypecode
            ORDER BY IF(s.dwh_valid_from_dt IS NULL, 0, 1) DESC, s.dwh_valid_from_dt
          ), INTERVAL 1 MILLISECOND) AS STRING),
          '9999-12-31 23:23:59.999999999'
        )
      ) AS dwh_valid_to_tmsp,
      s.company_sid
    FROM
      src_with_sid AS s
), final_sel AS (
  SELECT
      st.igl_companytypecode,
      st.store_sid AS int_org_sid,
      CAST(CAST(MIN(st.dwh_valid_from_dt) AS STRING) AS DATETIME) AS dwh_valid_from_tmsp,
      MAX(st.dwh_valid_to_tmsp) AS dwh_valid_to_tmsp,
      st.company_sid AS parent_int_org_sid
    FROM
      src_track_changes AS st
    GROUP BY
      st.igl_companytypecode,
      st.store_sid,
      st.company_sid
)
SELECT
    fs.int_org_sid AS store_sid,
    'DELIVCMP_STORE' AS int_org_hierarchy_type_cd,
    fs.parent_int_org_sid AS parent_int_org_sid,
    'LISY' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    COALESCE(CAST(fs.dwh_valid_from_tmsp AS STRING), '1900-01-01') AS dwh_mapping_tmsp,
    fs.dwh_valid_to_tmsp AS dwh_ending_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS deleted_fg,
    NUMERIC '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'LISY' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
  FROM final_sel AS fs
 WHERE fs.igl_companytypecode = NUMERIC '285540000'

UNION ALL

SELECT
    fs.int_org_sid,
    'EXPCMP_STORE',
    fs.parent_int_org_sid,
    'LISY',
    CURRENT_DATE(),
    COALESCE(CAST(fs.dwh_valid_from_tmsp AS STRING), '1900-01-01'),
    fs.dwh_valid_to_tmsp,
    NUMERIC '0',
    NUMERIC '0',
    NUMERIC '0',
    't_${SRC_INPUT_TABLE}',
    'LISY',
    '${LOAD_ID}'
  FROM final_sel AS fs
 WHERE fs.igl_companytypecode = NUMERIC '285540003'

UNION ALL

SELECT
    fs.int_org_sid,
    'OWNERCMP_STORE',
    fs.parent_int_org_sid,
    'LISY',
    CURRENT_DATE(),
    COALESCE(CAST(fs.dwh_valid_from_tmsp AS STRING), '1900-01-01'),
    fs.dwh_valid_to_tmsp,
    NUMERIC '0',
    NUMERIC '0',
    NUMERIC '0',
    't_${SRC_INPUT_TABLE}',
    'LISY',
    '${LOAD_ID}'
  FROM final_sel AS fs
 WHERE fs.igl_companytypecode = NUMERIC '285540005'

UNION ALL

SELECT
    fs.int_org_sid,
    'BALSHCMP_STORE',
    fs.parent_int_org_sid,
    'LISY',
    CURRENT_DATE(),
    COALESCE(CAST(fs.dwh_valid_from_tmsp AS STRING), '1900-01-01'),
    fs.dwh_valid_to_tmsp,
    NUMERIC '0',
    NUMERIC '0',
    NUMERIC '0',
    't_${SRC_INPUT_TABLE}',
    'LISY',
    '${LOAD_ID}'
  FROM final_sel AS fs
 WHERE fs.igl_companytypecode = NUMERIC '285540006';
