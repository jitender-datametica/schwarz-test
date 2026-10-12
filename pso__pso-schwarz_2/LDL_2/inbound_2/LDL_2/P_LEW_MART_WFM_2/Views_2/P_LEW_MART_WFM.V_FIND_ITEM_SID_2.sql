CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_FIND_ITEM_SID_2
AS
   /*


                                                      !!!ATTENTION!!!

         This view can actually ONLY(!) used for WFM ITEM_2 exports and at the moment only(!) for WAWI countries!
         It is only able to determine the respective ITEM_SID for the actual point of time (CURRENT_DATE is used)!

         The "6-Stufen-Logik" is based on a 2 pair of corresponding warehouses of the item. The first one
         (name part is WH_CORRESP) is the input warehouse (the just eyed, corresponding warehouse) with ITEM_STATUS,
         the second one is another corresponding warehouse (name part is WH_OTHER) of the item_2 (each combination 
         is examined) for which the ITEM_STATUS is also used within application of the logic. For each combination 
         a so called CASE_ID is built to determine one ITEM_SID for one combination of CLIENT_ID, WH_ID and ORIG_ITEM_NR.
         The WH_ID and ITEM_STATUS of the other WH (name part is WH_OTHER) therefore is "responsible" for the 
         resulting ITEM_SID.

         The part for handling the SAP part is kept out because decision factors as ITEM_STATUS and CASE_SIZE
         are not available.

         USAGE:
           Following columns are relevant for JOIN conditions:
             - Country_2 level
                 CLIENT_ID                 for the affected country_2
                 COUNTRY_ISO_CD            ISO code of affected country_2
             - WH level
                 WH_CORRESP_WH_ID          WH_ID of the just eyed, corresponding warehouse (input warehouse)
                 WH_CORRESP_WH_LOC_SID     LOC_SID (surrogate key) of the just eyed, corresponding warehouse
                                           (input warehouse)
             - Item_2 level
                 ORIG_ITEM_NR              for the affected item_2
                 ITEM_SID                  by applied logic resulting surrogate key for 
                                           the variant of the based ORIG_ITEM_NR

           Following columns of this view is more or less "only information" coming out and should 
           increase transparency of decision criteria and logic:
             - WH_CORRESP_ITEM_STATUS    which status_2 does the affected item_2 have for the 
                                         just eyed, corresponding warehouse (input warehouse)
             - WH_OTHER_WH_LOC_SID       LOC_SID (surrogate key) of the "responsible" warehouse for 
                                         the determined ITEM_SID
             - WH_OTHER_WH_ID            WH_ID of the "responsible" warehouse (can also be equal to WH_ID_CORRESP)
                                         for the determined ITEM_SID
             - WH_OTHER_ITEM_STATUS      which status_2 does the affected item_2 have for the "responsible" warehouse
             - CASE_SIZE                 value of used case_size for the decision
             - SRC_DAT_VALID_FROM        functional validity_2 start date for the determined item_2 version (item_sid)
             - HIST_DELETED_FG           deletion flag from corresponding item_2 history entry for the determined 
                                         item_2 version (0: active; 1: deleted)
             - HIST_DWH_VALID_FROM       technical validity_2 start date for the determined item_2 version (item_sid)
             - WAWI_DWH_ITEM_ID          corresponding DWH1.0 surrogate key (ITEM_2-ID) for the determined item_2 version
             - CASE_ID                   determined CASE_ID of the "6-Stufen-Logik"



   */
   /*
      View implementing "6-Stufen-Logik" for actual point of time

      Purpose: For a combination of CLIENT_ID, ORIG_ITEM_NR and WH_ID determine one ITEM_SID by a 
               logic based on ITEM_STATUS (WH level) and CASE_SIZE.

      For each ITEM_2 (ITEM_SID) and warehouse combination (WH_CORRESP terms) select ITEM_STATUS and CASE_SIZE 
      as decision criteria to apply the logic by loop over all warehouses (WH_OTHER terms).

      CASE_SIZE:
         a) WAWI
             1) p_lew_core_ac.v_item.src_case_size (for WAWI never empty)

      ITEM_STATUS:
         a) WAWI
             1) p_lew_core_ac.v_wawi_itm_item_wh.item_status  (for WAWI never empty)
   */
   SELECT
           client_id,
   country_iso_cd,
   wh_corresp_wh_loc_sid,
   wh_corresp_wh_id,
   wh_corresp_item_status,
   wh_other_wh_loc_sid,
   wh_other_wh_id,
   wh_other_item_status,
   item_sid,
   orig_item_nr,
   case_size,
   src_dat_valid_from,
   hist_deleted_fg,
   hist_dwh_valid_from,
   wawi_dwh_item_id,
   CASE
               /*
               CASE 1 item_2 has status_2 ACTIVE for corresponding wh and case_size <> -1
               ACTION: use MIN(status_2) and MIN(case_size)
               */
               WHEN wh_other_item_status BETWEEN 6 AND 11
                AND wh_other_wh_id = wh_corresp_wh_id
                AND case_size <> -1
                    THEN 1

               /*
               CASE 2 item_2 has status_2 INACTIVE for corresponding wh and case_size <> -1
               ACTION: use MIN(status_2) and MIN(case_size)
               */
               WHEN wh_other_item_status NOT BETWEEN 6 AND 11
                AND wh_other_wh_id = wh_corresp_wh_id
                AND case_size <> -1
                   THEN 2
               /*
               CASE 3 item_2 has status_2 ACTIVE for another wh and case_size <> -1
               ACTION: use MIN(status_2) and MIN(case_size)
               */
               WHEN wh_other_item_status BETWEEN 6 AND 11
                AND wh_other_wh_id <> Coalesce(wh_corresp_wh_id, -99) /* 19.11.2018, Stephan Krone: In the original logic (DWH1.0) the actual eyed warehouse con NOT be NULL */
                AND case_size <> -1
                   THEN 3

               /*
               CASE 4 item_2 has status_2 INACTIVE for another wh and case_size <> -1
               ACTION: use MIN(status_2) and MIN(case_size)
               */
               WHEN wh_other_item_status NOT BETWEEN 6 AND 11
                AND wh_other_wh_id <> Coalesce(wh_corresp_wh_id, -99) /* 19.11.2018, Stephan Krone: In the original logic (DWH1.0) the actual eyed warehouse con NOT be NULL */
                AND case_size <> -1
                   THEN 4

               /*
               CASE 5 get item_2 ids for items that have a case size of -1
                     => real dummy_2 items, created previously or some time ago
               ACTION: use dummy_2 status_2 and dummy_2 case_size
               */
               WHEN case_size = -1 THEN 5

               /*
               CASE 6 The item_2 does not exists in item_2-warehouse table
               ACTION: take MIN(case_size) from t_itm_item_skey
               where dat_formdate between dat_rec_start and dat_rec_end
               and case_size <> -1 (no dummies)
               */
               WHEN case_size <> -1
                AND wh_other_wh_id IS NULL
                   THEN 6

               ELSE 7777
          END AS case_id
  FROM
  (
    /*---------------------*/
    /*  start of WAWI part */
    /*---------------------*/

    SELECT
           il3_item_with_wh_wawi.client_id                       AS client_id,
   il3_item_with_wh_wawi.country_iso_cd                  AS country_iso_cd,
   il3_item_with_wh_wawi.wh_loc_sid                      AS wh_corresp_wh_loc_sid,
   il3_item_with_wh_wawi.wh_id                           AS wh_corresp_wh_id,
   il3_item_with_wh_wawi.item_status                     AS wh_corresp_item_status,
   wh_other_wawi.wh_loc_sid                              AS wh_other_wh_loc_sid,
   wh_other_wawi.wh_id                                   AS wh_other_wh_id,
   wh_other_wawi.item_status                             AS wh_other_item_status,
   isk_wawi.item_sid                                     AS item_sid,
   isk_wawi.orig_item_nr                                 AS orig_item_nr,
   isk_wawi.case_size_isk                                AS case_size,
   isk_wawi.src_dat_valid_from_isk                       AS src_dat_valid_from,
   isk_wawi.hist_deleted_fg_isk                          AS hist_deleted_fg,
   isk_wawi.hist_dwh_valid_from_isk                      AS hist_dwh_valid_from,
   isk_wawi.hist_dwh_valid_to_isk                        AS hist_dwh_valid_to,
   isk_wawi.wawi_dwh_item_id                             AS wawi_dwh_item_id
       FROM (
               SELECT item_all_1.client_id             AS client_id,
   item_all_1.country_iso_cd        AS country_iso_cd,
   item_all_1.item_sid              AS item_sid,
   item_all_1.orig_item_nr          AS orig_item_nr,
   item_all_1.log_var_cd            AS log_var_cd,
   item_all_1.src_case_size_int     AS case_size_il3,
   item_all_1.wawi_dwh_item_id      AS wawi_dwh_item_id,
   item_all_1.hist_deleted_fg       AS hist_deleted_fg,
   item_wh_wawi.wh_loc_sid          AS wh_loc_sid,
   item_wh_wawi.wh_id               AS wh_id,
   item_wh_wawi.item_status         AS item_status
               FROM
               (
                   SELECT   item.client_id                 AS client_id,
   item.country_iso_cd            AS country_iso_cd,
   item.item_sid                  AS item_sid,
   item.orig_item_nr              AS orig_item_nr,
   item.log_var_cd                AS log_var_cd,
   item.src_case_size_int         AS src_case_size_int,
   item.item_src_dat_valid_from   AS src_dat_valid_from,
   item_hist.deleted_fg           AS hist_deleted_fg,
   item_hist.dwh_valid_from       AS hist_dwh_valid_from,
   item_hist.dwh_valid_to         AS hist_dwh_valid_to,
   map_key.wawi_dwh_item_id       AS wawi_dwh_item_id
                     FROM
                     (
                         SELECT   item.client_id                           AS client_id,
   client.src_country_lidl_cd               AS country_iso_cd,
   item.item_sid                            AS item_sid,
   TRY_CAST(item.src_orig_item_nr AS BIGINT) AS orig_item_nr,
   item.log_var_cd                          AS log_var_cd,
   TRY_CAST(item.src_case_size AS INTEGER)   AS src_case_size_int,
   item.src_dat_valid_from                  AS item_src_dat_valid_from
                           FROM p_lew_core_ac.v_item_2 item_2
   INNER JOIN p_lew_core_ac.v_client_2 client
   ON  item.client_id = client.client_id
   INNER JOIN p_lew_core_ac.v_client_migration_per_2  migration_client
   ON item.client_id = migration_client.client_id
   AND (    Current_Date < migration_client.migration_dat_valid_from
         OR Current_Date > migration_client.migration_dat_valid_to
       )

/* Only items with positive ORIG_ITEM_NR */
WHERE orig_item_nr >= 0
) item_2
   INNER JOIN p_lew_core_ac.v_item_hist_2  item_hist
   ON item.client_id = item_hist.client_id
   AND item.item_sid  = item_hist.item_sid
   AND Current_Date BETWEEN item_hist.dwh_valid_from AND item_hist.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_item_map_key_2 map_key
   ON item.client_id = map_key.client_id
   AND item.item_sid  = map_key.item_sid_map
/* Ensure that the record with the latest functional item_2 version is selected if there are more than one existent */
QUALIFY Row_Number() Over (PARTITION BY item.client_id, item.orig_item_nr, item.src_case_size_int ORDER BY item_hist.deleted_fg ASC, item.item_src_dat_valid_from DESC NULLS LAST, item_hist.dwh_valid_from DESC NULLS LAST) = 1
) item_all_1
   INNER JOIN (
   SELECT itm_item_wh.client_id          AS client_id,
   itm_item_wh.item_sid           AS item_sid,
   itm_item_wh.item_status        AS item_status,
   itm_item_wh.wh_loc_sid         AS wh_loc_sid,
   loc_iiwh.src_wh_id             AS wh_id

                               FROM p_lew_core_ac.v_wawi_itm_item_wh_2 itm_item_wh
   INNER JOIN p_lew_core_ac.v_location_2 loc_iiwh
   ON itm_item_wh.client_id = loc_iiwh.client_id
   AND itm_item_wh.wh_loc_sid = loc_iiwh.loc_sid
   AND loc_iiwh.wh_store_mark = 'B' -- only WH

   INNER JOIN p_lew_core_ac.v_client_migration_per_2  migration_client
   ON itm_item_wh.client_id = migration_client.client_id
   AND (    Current_Date < migration_client.migration_dat_valid_from
         OR Current_Date > migration_client.migration_dat_valid_to
       )

WHERE Current_Date BETWEEN itm_item_wh.dat_rec_start AND itm_item_wh.dat_rec_end
) item_wh_wawi
   ON item_all_1.client_id = item_wh_wawi.client_id
   AND item_all_1.item_sid  = item_wh_wawi.item_sid

) il3_item_with_wh_wawi
   INNER JOIN (
   SELECT item_all_2.client_id              AS client_id,
   item_all_2.item_sid               AS item_sid,
   item_all_2.orig_item_nr           AS orig_item_nr,
   item_all_2.src_case_size_int      AS case_size_isk,
   item_all_2.hist_deleted_fg        AS hist_deleted_fg_isk,
   item_all_2.src_dat_valid_from     AS src_dat_valid_from_isk,
   item_all_2.hist_dwh_valid_from    AS hist_dwh_valid_from_isk,
   item_all_2.hist_dwh_valid_to      AS hist_dwh_valid_to_isk,
   item_all_2.wawi_dwh_item_id       AS wawi_dwh_item_id
                           FROM
                           (
                               SELECT   item.client_id                 AS client_id,
   item.item_sid                  AS item_sid,
   item.orig_item_nr              AS orig_item_nr,
   item.log_var_cd                AS log_var_cd,
   item.src_case_size_int         AS src_case_size_int,
   item.item_src_dat_valid_from   AS src_dat_valid_from,
   item_hist.deleted_fg           AS hist_deleted_fg,
   item_hist.dwh_valid_from       AS hist_dwh_valid_from,
   item_hist.dwh_valid_to         AS hist_dwh_valid_to,
   map_key.wawi_dwh_item_id       AS wawi_dwh_item_id
                                 FROM
                                 (
                                     SELECT   item.client_id                           AS client_id,
   item.item_sid                            AS item_sid,
   TRY_CAST(item.src_orig_item_nr AS BIGINT) AS orig_item_nr,
   item.log_var_cd                          AS log_var_cd,
   TRY_CAST(item.src_case_size AS INTEGER)   AS src_case_size_int,
   item.src_dat_valid_from                  AS item_src_dat_valid_from
                                       FROM p_lew_core_ac.v_item_2 item_2
   INNER JOIN p_lew_core_ac.v_client_migration_per_2  migration_client
   ON item.client_id = migration_client.client_id
   AND (    Current_Date < migration_client.migration_dat_valid_from
         OR Current_Date > migration_client.migration_dat_valid_to
       )

/* Only items with positive ORIG_ITEM_NR */
WHERE orig_item_nr >= 0
) item_2
   INNER JOIN p_lew_core_ac.v_item_hist_2  item_hist
   ON item.client_id = item_hist.client_id
   AND item.item_sid  = item_hist.item_sid
   AND Current_Date BETWEEN item_hist.dwh_valid_from AND item_hist.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_item_map_key_2 map_key
   ON item.client_id = map_key.client_id
   AND item.item_sid  = map_key.item_sid_map
/* Ensure that the record with the latest functional item_2 version is selected if there are more than one existent */
QUALIFY Row_Number() Over (PARTITION BY item.client_id, item.orig_item_nr, item.src_case_size_int ORDER BY item_hist.deleted_fg ASC, item.item_src_dat_valid_from DESC NULLS LAST, item_hist.dwh_valid_from DESC NULLS LAST) = 1
) item_all_2

) isk_wawi
   ON il3_item_with_wh_wawi.client_id = isk_wawi.client_id
   AND il3_item_with_wh_wawi.orig_item_nr = isk_wawi.orig_item_nr
   LEFT OUTER JOIN (
   SELECT itm_item_wh.client_id                                 AS client_id,
   itm_item_wh.item_sid                                  AS item_sid,
   loc_iiwh.loc_sid                                      AS wh_loc_sid,
   itm_item_wh.item_status                               AS item_status,
   loc_iiwh.src_wh_id                                    AS wh_id
                                FROM p_lew_core_ac.v_wawi_itm_item_wh_2 itm_item_wh
   INNER JOIN p_lew_core_ac.v_location_2 loc_iiwh
   ON itm_item_wh.client_id = loc_iiwh.client_id
   AND itm_item_wh.wh_loc_sid = loc_iiwh.loc_sid
   AND loc_iiwh.wh_store_mark = 'B' -- only WH

   INNER JOIN p_lew_core_ac.v_client_migration_per_2  migration_client
   ON itm_item_wh.client_id = migration_client.client_id
   AND (    Current_Date < migration_client.migration_dat_valid_from
         OR Current_Date > migration_client.migration_dat_valid_to
       )

WHERE Current_Date BETWEEN itm_item_wh.dat_rec_start AND itm_item_wh.dat_rec_end
) AS wh_other_wawi
   ON isk_wawi.client_id = wh_other_wawi.client_id  /* IMPORTANT to JOIN to isk_wawi instead of il3_item_with_wh_wawi!!! */
   AND isk_wawi.item_sid  = wh_other_wawi.item_sid   /* IMPORTANT to JOIN to isk_wawi instead of il3_item_with_wh_wawi!!! */

  /*---------------------*/
  /*  end of WAWI part   */
  /*---------------------*/

) all_data
/* QUALIFY implements the logic of "6-Stufen-Logik" and is considering prioritization of the latest item_2 version (combination of client_id, orig_item_id, case_size) */
QUALIFY Row_Number() Over (PARTITION BY client_id, orig_item_nr, wh_corresp_wh_id /* no dat_formdate at this point as in DWH1.0, because we are only considering the actual state */
           ORDER BY hist_deleted_fg ASC, src_dat_valid_from DESC NULLS LAST, case_id ASC, Coalesce(wh_other_item_status, 9999) ASC, case_size ASC, wawi_dwh_item_id ASC, item_sid DESC NULLS LAST) = 1
;