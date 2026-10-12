INSERT INTO etl.${src2tgt_temp_table1}_${src_context_area} (
  real_estate_key_type_cd,
  real_estate_nk,
  real_estate_status_categ_cd,
  real_estate_status_cd,
  real_estate_status_reason_cd,
  comment_txt,
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
WITH src_sel AS (
  SELECT
      *
    FROM
      etl_process.t_tcache_lisy_cds_account_snap_2
    WHERE t_tcache_lisy_cds_account_snap.igl_accounttypecode IN (
      NUMERIC '285540000', NUMERIC '285540009'
    )
      AND t_tcache_lisy_cds_account_snap.igl_number IS NOT NULL -- (only objects with assigned object number should be kept)
      AND t_tcache_lisy_cds_account_snap.igl_statusobjektcode NOT IN (
        NUMERIC '285540000', NUMERIC '285540001'
      ) -- we are only interested in statuses after there has been a contract for the store - the event that marks the beginning of the lifecycle of the real estate object and provides it with a number"
      AND t_tcache_lisy_cds_account_snap.deleted <> 'x' -- real estate associated with stores and special sale stores,a
), src AS (
  SELECT
      -- UC
      src_sel.igl_number,
      src_sel.igl_isocode2,
      'UC' AS real_estate_status_cd,
      NULL AS real_estate_status_reason_cd,
      LEAST_IGNORE_NULLS(src_sel.igl_contractdate, src_sel.igl_precontractdate) AS status_start_tmsp,
      NUMERIC '10' AS lifecycle_order_nr
    FROM
      src_sel
  UNION ALL
  SELECT
      -- OP
      t_tcache_lisy_cds_account_snap.igl_number,
      t_tcache_lisy_cds_account_snap.igl_isocode2,
      'OP' AS real_estate_status_cd,
      NULL AS real_estate_status_reason_cd,
      t_tcache_lisy_cds_account_snap.igl_neodate AS status_start_tmsp,
      NUMERIC '20' AS lifecycle_order_nr
    FROM
      etl_process.t_tcache_lisy_cds_account_snap_2
  UNION ALL
  SELECT
      -- CL
      t_tcache_lisy_cds_account_snap.igl_number,
      t_tcache_lisy_cds_account_snap.igl_isocode2,
      'CL' AS real_estate_status_cd,
      CASE
         t_tcache_lisy_cds_account_snap.igl_closingreasoncode
        WHEN NUMERIC '285540000' THEN 'BS_CL_NEP'
        WHEN NUMERIC '285540001' THEN 'BS_CL_DNC'
        WHEN NUMERIC '285540002' THEN 'BS_CL_CAI'
        WHEN NUMERIC '285540003' THEN 'BS_CL_LEO'
        WHEN NUMERIC '285540004' THEN 'BS_CL_LRE'
        WHEN NUMERIC '285540005' THEN 'BS_CL_TFP'
        WHEN NUMERIC '285540006' THEN 'BS_CL_BLC'
        WHEN NUMERIC '285540007' THEN 'BS_CL_BDS'
        WHEN NUMERIC '285540008' THEN 'BS_CL_RPL'
        WHEN NUMERIC '285540009' THEN 'BS_CL_MST'
        WHEN NUMERIC '285540010' THEN 'BS_CL_OTH'
      END AS real_estate_status_reason_cd,
      t_tcache_lisy_cds_account_snap.igl_closingdate AS status_start_tmsp,
      NUMERIC '30' AS lifecycle_order_nr
    FROM
      etl_process.t_tcache_lisy_cds_account_snap_2
  UNION ALL
  SELECT
      -- TE
      t_tcache_lisy_cds_account_snap.igl_number,
      t_tcache_lisy_cds_account_snap.igl_isocode2,
      'TE' AS real_estate_status_cd,
      NULL AS real_estate_status_reason_cd,
      t_tcache_lisy_cds_account_snap.igl_finalsettlementdate AS status_start_tmsp,
      NUMERIC '40' AS lifecycle_order_nr
    FROM
      etl_process.t_tcache_lisy_cds_account_snap_2
  UNION ALL
  SELECT
      -- CN
      t_tcache_lisy_cds_account_snap.igl_number,
      t_tcache_lisy_cds_account_snap.igl_isocode2,
      'CN' AS real_estate_status_cd,
      CASE
         t_tcache_lisy_cds_account_snap.igl_noimplementationreasoncode
        WHEN NUMERIC '285540000' THEN 'BS_CN_NBP'
        WHEN NUMERIC '285540001' THEN 'BS_CN_UCO'
        WHEN NUMERIC '285540002' THEN 'BS_CN_ULO'
        WHEN NUMERIC '285540003' THEN 'BS_CN_OTL'
        WHEN NUMERIC '285540004' THEN 'BS_CN_NCA'
        WHEN NUMERIC '285540005' THEN 'BS_CN_NAP'
        WHEN NUMERIC '285540006' THEN 'BS_CN_CDO'
      END AS real_estate_status_reason_cd,
      t_tcache_lisy_cds_account_snap.igl_noimplementationdate AS status_start_tmsp,
      NUMERIC '11' AS lifecycle_order_nr  -- after Under contract, but before Open - > makes no sense to have Cancelled Implementation if it is already opened 
    FROM
      etl_process.t_tcache_lisy_cds_account_snap_2
), src_eliminate_same_dates AS (
  SELECT
      src.*
    FROM
      src
    -- for some buildings two statuses could be set on the same date  - Closed and Termniated for example
    -- we keep the Status_2 which comes later in the lifecycle of a building  - Termninated in this case.
    -- Store was closed and immediatelly terminated, so it spend 0 days in stasus ""Closed""
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY src.igl_number,
                   src.status_start_tmsp
      ORDER BY IF(src.lifecycle_order_nr IS NULL, 0, 1),
               src.lifecycle_order_nr DESC
    ) = NUMERIC '1'
), transformed AS (
  SELECT
      src_eliminate_same_dates.igl_number,
      src_eliminate_same_dates.igl_isocode2,
      src_eliminate_same_dates.real_estate_status_cd,
      src_eliminate_same_dates.real_estate_status_reason_cd,
      src_eliminate_same_dates.status_start_tmsp,
      LEAD(
        datetime_sub(src_eliminate_same_dates.status_start_tmsp, INTERVAL 1 NANOSECOND),
        NUMERIC '1',
        '9999-12-31 23:59:59.999999999 '
      ) OVER (
        PARTITION BY src_eliminate_same_dates.igl_number
        ORDER BY IF(src_eliminate_same_dates.status_start_tmsp IS NULL, 0, 1) DESC,
                 src_eliminate_same_dates.status_start_tmsp
      ) AS status_end_tmsp
    FROM
      src_eliminate_same_dates
    WHERE src_eliminate_same_dates.status_start_tmsp IS NOT NULL
)
SELECT
    'RE_2' AS real_estate_key_type_cd,
    CONCAT(
      transformed.igl_isocode2,
      '|',
      LTRIM(SUBSTR(transformed.igl_number, 3, 7), '0#')
    ) AS real_estate_nk,
    'BS' AS real_estate_status_categ_cd,
    transformed.real_estate_status_cd,
    transformed.real_estate_status_reason_cd,
    NULL AS comment_txt,
    'LISY' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    transformed.status_start_tmsp AS dwh_mapping_tmsp,
    transformed.status_end_tmsp AS dwh_ending_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS deleted_fg,
    NUMERIC '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'LISY' AS dwh_node_cd,
    '${load_id}' AS dwh_load_id
FROM
  transformed
;
