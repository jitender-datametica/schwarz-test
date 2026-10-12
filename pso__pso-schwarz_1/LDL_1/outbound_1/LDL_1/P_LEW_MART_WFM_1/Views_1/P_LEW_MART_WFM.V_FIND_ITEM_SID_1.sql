/* !!!ATTENTION!!!

         This view can actually ONLY(!) used for WFM ITEM_1 exports and at the moment only(!) for WAWI countries!
         It is only able to determine the respective ITEM_SID for the actual point of time (CURRENT_DATE is used)!

         The "6-Stufen-Logik" is based on a 2 pair of corresponding warehouses of the item. The first one
         (name part is WH_CORRESP) is the input warehouse (the just eyed, corresponding warehouse) with ITEM_STATUS,
         the second one is another corresponding warehouse (name part is WH_OTHER) of the item_1 (each combination 
         is examined) for which the ITEM_STATUS is also used within application of the logic. For each combination 
         a so called CASE_ID is built to determine one ITEM_SID for one combination of CLIENT_ID, WH_ID and ORIG_ITEM_NR.
         The WH_ID and ITEM_STATUS of the other WH (name part is WH_OTHER) therefore is "responsible" for the 
         resulting ITEM_SID.

         The part for handling the SAP part is kept out because decision factors as ITEM_STATUS and CASE_SIZE
         are not available.

         USAGE:
           Following columns are relevant for CROSS JOIN conditions:
             - Country_1 level
                 CLIENT_ID                 for the affected country_1
                 COUNTRY_ISO_CD            ISO code of affected country_1
             - WH level
                 WH_CORRESP_WH_ID          WH_ID of the just eyed, corresponding warehouse (input warehouse)
                 WH_CORRESP_WH_LOC_SID     LOC_SID (surrogate key) of the just eyed, corresponding warehouse
                                           (input warehouse)
             - Item_1 level
                 ORIG_ITEM_NR              for the affected item_1
                 ITEM_SID                  by applied logic resulting surrogate key for 
                                           the variant of the based ORIG_ITEM_NR

           Following columns of this view is more or less "only information" coming out and should 
           increase transparency of decision criteria and logic:
             - WH_CORRESP_ITEM_STATUS    which status_1 does the affected item_1 have for the 
                                         just eyed, corresponding warehouse (input warehouse)
             - WH_OTHER_WH_LOC_SID       LOC_SID (surrogate key) of the "responsible" warehouse for 
                                         the determined ITEM_SID
             - WH_OTHER_WH_ID            WH_ID of the "responsible" warehouse (can also be equal to WH_ID_CORRESP)
                                         for the determined ITEM_SID
             - WH_OTHER_ITEM_STATUS      which status_1 does the affected item_1 have for the "responsible" warehouse
             - CASE_SIZE                 value of used case_size for the decision
             - SRC_DAT_VALID_FROM        functional validity_1 start date for the determined item_1 version (item_sid)
             - HIST_DELETED_FG           deletion flag from corresponding item_1 history entry for the determined 
                                         item_1 version (0: active; 1: deleted)
             - HIST_DWH_VALID_FROM       technical validity_1 start date for the determined item_1 version (item_sid)
             - WAWI_DWH_ITEM_ID          corresponding DWH1.0 surrogate key (ITEM_1-ID) for the determined item_1 version
             - CASE_ID                   determined CASE_ID of the "6-Stufen-Logik" */
/* View implementing "6-Stufen-Logik" for actual point of time

      Purpose: For a combination of CLIENT_ID, ORIG_ITEM_NR and WH_ID determine one ITEM_SID by a 
               logic based on ITEM_STATUS (WH level) and CASE_SIZE.

      For each ITEM_1 (ITEM_SID) and warehouse combination (WH_CORRESP terms) select ITEM_STATUS and CASE_SIZE 
      as decision criteria to apply the logic by loop over all warehouses (WH_OTHER terms).

      CASE_SIZE:
         a) WAWI
             1) p_lew_core_ac.v_item.src_case_size (for WAWI never empty)

      ITEM_STATUS:
         a) WAWI
             1) p_lew_core_ac.v_wawi_itm_item_wh.item_status  (for WAWI never empty) */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_find_item_sid_1 AS
/* CASE 1 item_1 has status_1 ACTIVE for corresponding wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
/* 19.11.2018, Stephan Krone: In the original logic (DWH1.0) the actual eyed warehouse con NOT be NULL */
/* 19.11.2018, Stephan Krone: In the original logic (DWH1.0) the actual eyed warehouse con NOT be NULL */ /*  */
/* start of WAWI part */ /*  */ /* Only items with positive ORIG_ITEM_NR */ /* Only items with positive ORIG_ITEM_NR */
/* QUALIFY implements the logic of "6-Stufen-Logik" and is considering prioritization of the latest item_1 version (combination of client_id, orig_item_id, case_size) */
/* no dat_formdate at this point as in DWH1.0, because we are only considering the actual state */ SELECT
 il3_item_with_wh_wawi.client_id,
 il3_item_with_wh_wawi.country_iso_cd,
 il3_item_with_wh_wawi.wh_loc_sid AS wh_corresp_wh_loc_sid,
 il3_item_with_wh_wawi.wh_id AS wh_corresp_wh_id,
 il3_item_with_wh_wawi.item_status AS wh_corresp_item_status,
 wh_other_wawi.wh_loc_sid AS wh_other_wh_loc_sid,
 wh_other_wawi.wh_id AS wh_other_wh_id,
 wh_other_wawi.item_status AS wh_other_item_status,
 isk_wawi.item_sid,
 isk_wawi.orig_item_nr,
 isk_wawi.case_size_isk AS case_size,
 isk_wawi.src_dat_valid_from_isk AS src_dat_valid_from,
 isk_wawi.hist_deleted_fg_isk AS hist_deleted_fg,
 isk_wawi.hist_dwh_valid_from_isk AS hist_dwh_valid_from,
 isk_wawi.wawi_dwh_item_id,
  CASE
  WHEN wh_other_wawi.item_status BETWEEN 6 AND 11 AND wh_other_wawi.wh_id = il3_item_with_wh_wawi.wh_id AND isk_wawi.case_size_isk
     <> - 1
  THEN 1
  /* CASE 2 item_1 has status_1 INACTIVE for corresponding wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
  WHEN wh_other_wawi.item_status NOT BETWEEN 6 AND 11 AND wh_other_wawi.wh_id = il3_item_with_wh_wawi.wh_id AND isk_wawi
    .case_size_isk <> - 1
  THEN 2
  /* CASE 3 item_1 has status_1 ACTIVE for another wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
  WHEN wh_other_wawi.item_status BETWEEN 6 AND 11 AND wh_other_wawi.wh_id <> COALESCE(il3_item_with_wh_wawi.wh_id, - 99
      ) AND isk_wawi.case_size_isk <> - 1
  THEN 3
  /* CASE 4 item_1 has status_1 INACTIVE for another wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
  WHEN wh_other_wawi.item_status NOT BETWEEN 6 AND 11 AND wh_other_wawi.wh_id <> COALESCE(il3_item_with_wh_wawi.wh_id, -
      99) AND isk_wawi.case_size_isk <> - 1
  THEN 4
  /* CASE 5 get item_1 ids for items that have a case size of -1
                     => real dummy_1 items, created previously or some time ago
               ACTION: use dummy_1 status_1 and dummy_1 case_size */
  WHEN isk_wawi.case_size_isk = - 1
  THEN 5
  /* CASE 6 The item_1 does not exists in item_1-warehouse table
               ACTION: take MIN(case_size) from t_itm_item_skey
               where dat_formdate between dat_rec_start and dat_rec_end
               and case_size <> -1 (no dummies) */
  WHEN isk_wawi.case_size_isk <> - 1 AND wh_other_wawi.wh_id IS NULL
  THEN 6
  ELSE 7777
  END AS case_id
FROM (SELECT item_all_1.client_id,
   item_all_1.country_iso_cd,
   item_all_1.item_sid,
   item_all_1.orig_item_nr,
   item_all_1.log_var_cd,
   item_all_1.src_case_size_int AS case_size_il3,
   item_all_1.wawi_dwh_item_id,
   item_all_1.hist_deleted_fg,
   item_wh_wawi.wh_loc_sid,
   item_wh_wawi.wh_id,
   item_wh_wawi.item_status
  FROM (SELECT item.client_id,
     item.country_iso_cd,
     item.item_sid,
     item.orig_item_nr,
     item.log_var_cd,
     item.src_case_size_int,
     item.item_src_dat_valid_from AS src_dat_valid_from,
     ITEM_HIST.deleted_fg AS hist_deleted_fg,
     ITEM_HIST.dwh_valid_from AS hist_dwh_valid_from,
     ITEM_HIST.dwh_valid_to AS hist_dwh_valid_to,
     MAP_KEY.wawi_dwh_item_id
    FROM (SELECT ITEM.client_id,
       CLIENT.src_country_lidl_cd AS country_iso_cd,
       ITEM.item_sid,
       ROUND(SAFE_CAST(ITEM.src_orig_item_nr AS BIGNUMERIC), 0) AS orig_item_nr,
       ITEM.log_var_cd,
       ROUND(SAFE_CAST(ITEM.src_case_size AS BIGNUMERIC), 0) AS src_case_size_int,
       ITEM.src_dat_valid_from AS item_src_dat_valid_from
      FROM ldl_p_lew_core_ac.v_item_1 AS ITEM_1
       INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLIENT ON ITEM.client_id = CLIENT.client_id
       INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIGRATION_CLIENT ON ITEM.client_id = MIGRATION_CLIENT.client_id
          AND (CURRENT_DATE < MIGRATION_CLIENT.migration_dat_valid_from OR CURRENT_DATE > MIGRATION_CLIENT.migration_dat_valid_to
           )
      WHERE ROUND(SAFE_CAST(ITEM.src_orig_item_nr AS BIGNUMERIC), 0) >= 0) AS item_1
     INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS ITEM_HIST ON item.client_id = ITEM_HIST.client_id AND item.item_sid =
        ITEM_HIST.item_sid AND CURRENT_DATE BETWEEN ITEM_HIST.dwh_valid_from AND ITEM_HIST.dwh_valid_to
     INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS MAP_KEY ON item.client_id = MAP_KEY.client_id AND item.item_sid =
       MAP_KEY.item_sid_map
       /* Ensure that the record with the latest functional item_1 version is selected if there are more than one existent */
       
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item.client_id AS STRING), CAST(item.orig_item_nr AS STRING), CAST(item.src_case_size_int AS STRING)
          ORDER BY ITEM_HIST.deleted_fg IS NULL, ITEM_HIST.deleted_fg, item.item_src_dat_valid_from IS NULL, item.item_src_dat_valid_from
          , ITEM_HIST.dwh_valid_from IS NULL, ITEM_HIST.dwh_valid_from)) = 1) AS item_all_1
   INNER JOIN (SELECT ITM_ITEM_WH.client_id,
     ITM_ITEM_WH.item_sid,
     ITM_ITEM_WH.item_status,
     ITM_ITEM_WH.wh_loc_sid,
     LOC_IIWH.src_wh_id AS wh_id
    FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh_1 AS ITM_ITEM_WH
     INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC_IIWH ON ITM_ITEM_WH.client_id = LOC_IIWH.client_id AND ITM_ITEM_WH.wh_loc_sid
         = LOC_IIWH.loc_sid AND LOC_IIWH.wh_store_mark = 'B' -- only WH

     INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIGRATION_CLIENT0 ON ITM_ITEM_WH.client_id =
       MIGRATION_CLIENT0.client_id AND (CURRENT_DATE < MIGRATION_CLIENT0.migration_dat_valid_from OR CURRENT_DATE >
         MIGRATION_CLIENT0.migration_dat_valid_to)
    WHERE CURRENT_DATE BETWEEN ITM_ITEM_WH.dat_rec_start AND ITM_ITEM_WH.dat_rec_end) AS item_wh_wawi ON item_all_1.client_id
      = item_wh_wawi.client_id AND item_all_1.item_sid = item_wh_wawi.item_sid) AS il3_item_with_wh_wawi
 INNER JOIN (SELECT item.client_id,
   item.item_sid,
   item.orig_item_nr,
   item.src_case_size_int AS case_size_isk,
   ITEM_HIST0.deleted_fg AS hist_deleted_fg_isk,
   item.item_src_dat_valid_from AS src_dat_valid_from_isk,
   ITEM_HIST0.dwh_valid_from AS hist_dwh_valid_from_isk,
   ITEM_HIST0.dwh_valid_to AS hist_dwh_valid_to_isk,
   MAP_KEY0.wawi_dwh_item_id
  FROM (SELECT ITEM0.client_id,
     ITEM0.item_sid,
     ROUND(SAFE_CAST(ITEM0.src_orig_item_nr AS BIGNUMERIC), 0) AS orig_item_nr,
     ITEM0.log_var_cd,
     ROUND(SAFE_CAST(ITEM0.src_case_size AS BIGNUMERIC), 0) AS src_case_size_int,
     ITEM0.src_dat_valid_from AS item_src_dat_valid_from
    FROM ldl_p_lew_core_ac.v_item_1 AS ITEM0
     INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIGRATION_CLIENT1 ON ITEM0.client_id = MIGRATION_CLIENT1.client_id
        AND (CURRENT_DATE < MIGRATION_CLIENT1.migration_dat_valid_from OR CURRENT_DATE > MIGRATION_CLIENT1.migration_dat_valid_to
         )
    WHERE ROUND(SAFE_CAST(ITEM0.src_orig_item_nr AS BIGNUMERIC), 0) >= 0) AS item_1
   INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS ITEM_HIST0 ON item.client_id = ITEM_HIST0.client_id AND item.item_sid =
      ITEM_HIST0.item_sid AND CURRENT_DATE BETWEEN ITEM_HIST0.dwh_valid_from AND ITEM_HIST0.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS MAP_KEY0 ON item.client_id = MAP_KEY0.client_id AND item.item_sid =
     MAP_KEY0.item_sid_map
     /* Ensure that the record with the latest functional item_1 version is selected if there are more than one existent */
     
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item.client_id AS STRING), CAST(item.orig_item_nr AS STRING), CAST(item.src_case_size_int AS STRING)
        ORDER BY ITEM_HIST0.deleted_fg IS NULL, ITEM_HIST0.deleted_fg, item.item_src_dat_valid_from IS NULL, item.item_src_dat_valid_from
        , ITEM_HIST0.dwh_valid_from IS NULL, ITEM_HIST0.dwh_valid_from)) = 1) AS isk_wawi ON il3_item_with_wh_wawi.client_id
    = isk_wawi.client_id AND il3_item_with_wh_wawi.orig_item_nr = isk_wawi.orig_item_nr
 LEFT JOIN (SELECT ITM_ITEM_WH0.client_id,
   ITM_ITEM_WH0.item_sid,
   LOC_IIWH0.loc_sid AS wh_loc_sid,
   ITM_ITEM_WH0.item_status,
   LOC_IIWH0.src_wh_id AS wh_id
  FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh_1 AS ITM_ITEM_WH0
   INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC_IIWH0 ON ITM_ITEM_WH0.client_id = LOC_IIWH0.client_id AND ITM_ITEM_WH0
      .wh_loc_sid = LOC_IIWH0.loc_sid AND LOC_IIWH0.wh_store_mark = 'B' -- only WH

   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIGRATION_CLIENT2 ON ITM_ITEM_WH0.client_id =
     MIGRATION_CLIENT2.client_id AND (CURRENT_DATE < MIGRATION_CLIENT2.migration_dat_valid_from OR CURRENT_DATE >
       MIGRATION_CLIENT2.migration_dat_valid_to)
  WHERE CURRENT_DATE BETWEEN ITM_ITEM_WH0.dat_rec_start AND ITM_ITEM_WH0.dat_rec_end) AS wh_other_wawi ON isk_wawi.client_id
    = wh_other_wawi.client_id /* IMPORTANT to CROSS JOIN to isk_wawi instead of il3_item_with_wh_wawi!!! */ AND isk_wawi
   .item_sid = wh_other_wawi.item_sid /* IMPORTANT to CROSS JOIN to isk_wawi instead of il3_item_with_wh_wawi!!! */
   /*  */ /* end of WAWI part */ /*  */
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(il3_item_with_wh_wawi.client_id AS STRING), CAST(isk_wawi.orig_item_nr AS STRING)
      , CAST(il3_item_with_wh_wawi.wh_id AS STRING) ORDER BY isk_wawi.hist_deleted_fg_isk IS NULL, isk_wawi.hist_deleted_fg_isk
      , isk_wawi.src_dat_valid_from_isk IS NULL, isk_wawi.src_dat_valid_from_isk, CASE
       WHEN wh_other_wawi.item_status BETWEEN 6 AND 11 AND wh_other_wawi.wh_id = il3_item_with_wh_wawi.wh_id AND
         isk_wawi.case_size_isk <> - 1
       THEN 1
       /* CASE 2 item_1 has status_1 INACTIVE for corresponding wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
       WHEN wh_other_wawi.item_status NOT BETWEEN 6 AND 11 AND wh_other_wawi.wh_id = il3_item_with_wh_wawi.wh_id AND
         isk_wawi.case_size_isk <> - 1
       THEN 2
       /* CASE 3 item_1 has status_1 ACTIVE for another wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
       WHEN wh_other_wawi.item_status BETWEEN 6 AND 11 AND wh_other_wawi.wh_id <> COALESCE(il3_item_with_wh_wawi.wh_id,
           - 99) AND isk_wawi.case_size_isk <> - 1
       THEN 3
       /* CASE 4 item_1 has status_1 INACTIVE for another wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
       WHEN wh_other_wawi.item_status NOT BETWEEN 6 AND 11 AND wh_other_wawi.wh_id <> COALESCE(il3_item_with_wh_wawi.wh_id
           , - 99) AND isk_wawi.case_size_isk <> - 1
       THEN 4
       /* CASE 5 get item_1 ids for items that have a case size of -1
                     => real dummy_1 items, created previously or some time ago
               ACTION: use dummy_1 status_1 and dummy_1 case_size */
       WHEN isk_wawi.case_size_isk = - 1
       THEN 5
       /* CASE 6 The item_1 does not exists in item_1-warehouse table
               ACTION: take MIN(case_size) from t_itm_item_skey
               where dat_formdate between dat_rec_start and dat_rec_end
               and case_size <> -1 (no dummies) */
       WHEN isk_wawi.case_size_isk <> - 1 AND wh_other_wawi.wh_id IS NULL
       THEN 6
       ELSE 7777
       END IS NULL, CASE
       WHEN wh_other_wawi.item_status BETWEEN 6 AND 11 AND wh_other_wawi.wh_id = il3_item_with_wh_wawi.wh_id AND
         isk_wawi.case_size_isk <> - 1
       THEN 1
       /* CASE 2 item_1 has status_1 INACTIVE for corresponding wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
       WHEN wh_other_wawi.item_status NOT BETWEEN 6 AND 11 AND wh_other_wawi.wh_id = il3_item_with_wh_wawi.wh_id AND
         isk_wawi.case_size_isk <> - 1
       THEN 2
       /* CASE 3 item_1 has status_1 ACTIVE for another wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
       WHEN wh_other_wawi.item_status BETWEEN 6 AND 11 AND wh_other_wawi.wh_id <> COALESCE(il3_item_with_wh_wawi.wh_id,
           - 99) AND isk_wawi.case_size_isk <> - 1
       THEN 3
       /* CASE 4 item_1 has status_1 INACTIVE for another wh and case_size <> -1
               ACTION: use MIN(status_1) and MIN(case_size) */
       WHEN wh_other_wawi.item_status NOT BETWEEN 6 AND 11 AND wh_other_wawi.wh_id <> COALESCE(il3_item_with_wh_wawi.wh_id
           , - 99) AND isk_wawi.case_size_isk <> - 1
       THEN 4
       /* CASE 5 get item_1 ids for items that have a case size of -1
                     => real dummy_1 items, created previously or some time ago
               ACTION: use dummy_1 status_1 and dummy_1 case_size */
       WHEN isk_wawi.case_size_isk = - 1
       THEN 5
       /* CASE 6 The item_1 does not exists in item_1-warehouse table
               ACTION: take MIN(case_size) from t_itm_item_skey
               where dat_formdate between dat_rec_start and dat_rec_end
               and case_size <> -1 (no dummies) */
       WHEN isk_wawi.case_size_isk <> - 1 AND wh_other_wawi.wh_id IS NULL
       THEN 6
       ELSE 7777
       END, COALESCE(wh_other_wawi.item_status, 9999) IS NULL, COALESCE(wh_other_wawi.item_status, 9999), isk_wawi.case_size_isk
      IS NULL, isk_wawi.case_size_isk, isk_wawi.wawi_dwh_item_id IS NULL, isk_wawi.wawi_dwh_item_id, isk_wawi.item_sid
      IS NULL, isk_wawi.item_sid)) = 1;