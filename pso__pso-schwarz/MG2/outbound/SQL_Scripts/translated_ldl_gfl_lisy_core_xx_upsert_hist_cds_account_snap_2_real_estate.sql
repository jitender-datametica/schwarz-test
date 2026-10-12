INSERT INTO etl.${src2tgt_temp_table1}_${src_context_area} (
  real_estate_key_type_cd,
  real_estate_nk,
  real_estate_nr,
  real_estate_name,
  real_estate_type_cd,
  ownership_type_cd,
  ownership_ratio_type_cd,
  own_acquisition_fg,
  real_estate_usg_type_cd,
  wh_building_type_cd,
  wh_purpose_cd,
  shared_usg_fg,
  contract_dt,
  precontract_dt,
  construction_start_dt,
  construction_end_dt,
  open_dt,
  planned_open_dt,
  close_dt,
  planned_close_dt,
  project_cancel_dt,
  project_term_dt,
  sales_area_meas,
  storage_area_meas,
  total_sublet_area_meas,
  rented_sublet_area_meas,
  uom_cd,
  total_parking_space_cnt,
  own_parking_space_cnt,
  underground_parking_space_cnt,
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
WITH proj_selected AS (
  SELECT
      *
    FROM
      etl_process.t_tcache_lisy_cds_projectmilestones_snap
    WHERE t_tcache_lisy_cds_projectmilestones_snap.deleted <> 'x'
      AND t_tcache_lisy_cds_projectmilestones_snap.igl_accountnumber IS NOT NULL
      AND t_tcache_lisy_cds_projectmilestones_snap.igl_projecttypecode = NUMERIC '285540000'
      AND t_tcache_lisy_cds_projectmilestones_snap.startofconstruction_act IS NOT NULL
      AND t_tcache_lisy_cds_projectmilestones_snap.endofproject_act IS NOT NULL
      AND t_tcache_lisy_cds_projectmilestones_snap.igl_projectstatuscode = NUMERIC '285540008' -- Completed projects only
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY t_tcache_lisy_cds_projectmilestones_snap.igl_accountnumber,
                   t_tcache_lisy_cds_projectmilestones_snap.startofconstruction_act
      ORDER BY IF(t_tcache_lisy_cds_projectmilestones_snap.endofconstruction_act IS NULL, 0, 1),
               t_tcache_lisy_cds_projectmilestones_snap.endofconstruction_act DESC,
               IF(t_tcache_lisy_cds_projectmilestones_snap.sinkmodifiedon IS NULL, 0, 1),
               t_tcache_lisy_cds_projectmilestones_snap.sinkmodifiedon DESC
    ) = NUMERIC '1'
), marketing_selected AS (
  SELECT
      *,
      SUM(t_tcache_lisy_cds_marketingarea_snap.igl_areaqm) OVER (
        PARTITION BY t_tcache_lisy_cds_marketingarea_snap.account_number
      )AS total_area_meas -- HERE, WE COMPUTE THE TOTAL AREA WITHIN THE STORE THAT CAN BE SUBLET REGARDLESS OF WHETHER OR NOT THIS IS ACTUALLY DONE AND REGARDLESS OF THE TYPE OF AREA 
    FROM
      etl_process.t_tcache_lisy_cds_marketingarea_snap
    WHERE t_tcache_lisy_cds_marketingarea_snap.igl_areatypecode = NUMERIC '285540005'
      AND t_tcache_lisy_cds_marketingarea_snap.igl_accounttypecode = NUMERIC '285540000' -- account type "Store"
      AND t_tcache_lisy_cds_marketingarea_snap.account_number IS NOT NULL -- type "Sublet area"
    QUALIFY ROW_NUMBER() OVER (
      PARTITION BY t_tcache_lisy_cds_marketingarea_snap.account_number,
                   t_tcache_lisy_cds_marketingarea_snap.igl_areaqm,
                   t_tcache_lisy_cds_marketingarea_snap.igl_industrycode,
                   t_tcache_lisy_cds_marketingarea_snap.igl_floorcode,
                   t_tcache_lisy_cds_marketingarea_snap.igl_rentalincomepa
      ORDER BY IF(t_tcache_lisy_cds_marketingarea_snap.sinkmodifiedon IS NULL, 0, 1),
               t_tcache_lisy_cds_marketingarea_snap.sinkmodifiedon DESC
    ) = NUMERIC '1' -- THIS ROW MAKES SURE WE GET RID OF DUPLICATES
), marketing_sum AS (
  SELECT
      -- THIS IS A NEW CTE WHERE WE TAKE JUST THE SUBLET AREA SO WE FILTER BY IGL_REALISEDBOOL = TRUE
      marketing_selected.account_number,
      marketing_selected.igl_realisedbool,
      marketing_selected.total_area_meas,
      SUM(marketing_selected.igl_areaqm) AS rented_area_meas -- TOTAL SUBLET AREA WITHIN THE STORE REGARDLESS OF ITS TYPE 
    FROM
      marketing_selected
    WHERE marketing_selected.igl_realisedbool = TRUE
    GROUP BY 1, 2, 3
)
SELECT
    'RE' AS real_estate_key_type_cd,
    CONCAT(
      src.igl_isocode2,
      '|',
      LTRIM(SUBSTR(src.igl_number, 3, LENGTH(src.igl_number)), '0#')
    ) AS real_estate_nk, -- Use for Keyspace Lookup
    src.igl_number AS real_estate_nr, -- Target table column
    src.address1_name AS real_estate_name,
    CASE
       src.igl_accounttypecode
      WHEN NUMERIC '285540000' THEN 'STORE'
      WHEN NUMERIC '285540009' THEN 'SPEC'
      ELSE '-1'
    END AS real_estate_type_cd,
    CASE
       src.igl_propertytypecode
      WHEN NUMERIC '285540000' THEN 'B'
      WHEN NUMERIC '285540001' THEN 'R'
      WHEN NUMERIC '285540002' THEN 'L'
      ELSE '-1'
    END AS ownership_type_cd,
    CASE
       src.igl_ownershipcode
      WHEN NUMERIC '285540000' THEN 'F'
      WHEN NUMERIC '285540001' THEN 'P'
    END AS ownership_ratio_type_cd,
    src.igl_ownacquisition AS own_acquisition_fg,
    CASE
      WHEN src.igl_totalareabuildingm2calc >= mrkt.total_area_meas
       AND mrkt.rented_area_meas > NUMERIC '0' THEN '3PTY'
      ELSE 'OWN'
    END AS real_estate_usg_type_cd,
    NULL AS wh_building_type_cd,
    NULL AS wh_purpose_cd,
    NULL AS shared_usg_fg,
    DATE(src.igl_contractdate) AS contract_dt,
    DATE(src.igl_precontractdate) AS precontract_dt,
    proj.startofconstruction_act AS construction_start_dt,
    proj.endofconstruction_act AS construction_end_dt,
    DATE(src.igl_neodate) AS open_dt,
    DATE(src.igl_expectedopeningdate) AS planned_open_dt,
    DATE(src.igl_closingdate) AS close_dt,
    DATE(src.igl_expectedclosingdate) AS planned_close_dt,
    DATE(src.igl_noimplementationdate) AS project_cancel_dt,
    src.igl_finalsettlementdate AS project_term_dt,
    src.igl_salesarea AS sales_area_meas,
    src.igl_lstoragearea AS storage_area_meas,
    CASE
      WHEN src.igl_totalareabuildingm2calc >= mrkt.total_area_meas THEN mrkt.total_area_meas
      ELSE NULL
    END AS total_sublet_area_meas,
    mrkt.rented_area_meas AS rented_sublet_area_meas,
    'SQMT' AS uom_cd,
    src.igl_parkingtotal AS total_parking_space_cnt,
    src.igl_parkinglidl AS own_parking_space_cnt,
    src.igl_parkingdeck AS underground_parking_space_cnt,
    'LISY' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    CASE
      WHEN re.real_estate_nr IS NOT NULL THEN src.sinkmodifiedon
      WHEN igl_expectedopeningdate > CURRENT_DATE()
       OR igl_neodate >= CURRENT_DATE() THEN src.sinkmodifiedon
      ELSE COALESCE(src.igl_neodate, src.sinkmodifiedon)
    END AS dwh_mapping_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS deleted_fg,
    NUMERIC '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'LISY' AS dwh_node_cd,
    '${load_id}' AS dwh_load_id
FROM
  etl_process.t_${src_input_table} AS src
  LEFT OUTER JOIN (
    SELECT DISTINCT
        t_real_estate.real_estate_nr
      FROM
        core_rel.t_real_estate
      WHERE t_real_estate.dwh_node_cd = 'LISY'
  ) AS re
    ON CONCAT(
         src.igl_isocode2,
         '|',
         LTRIM(SUBSTR(src.igl_number, 3, LENGTH(src.igl_number)), '0#')
       ) = re.real_estate_nr
  LEFT OUTER JOIN proj_selected AS proj
    ON proj.igl_accountnumber = src.igl_number
  LEFT OUTER JOIN marketing_sum AS mrkt
    ON src.igl_number = mrkt.account_number
WHERE src.igl_accounttypecode IN (
      NUMERIC '285540000', NUMERIC '285540009'
    )
  AND src.igl_number IS NOT NULL -- (only objects with assigned object number should be kept)
  AND src.deleted <> 'x' -- Real Estate associated with stores and 'special sale' stores
;
