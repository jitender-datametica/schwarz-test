/* !!!ATTENTION!!!

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
           Following columns are relevant for CROSS JOIN conditions:
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
             - CASE_ID                   determined CASE_ID of the "6-Stufen-Logik" */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_find_item_sid_2 AS SELECT *
FROM ldl_p_lew_mart_wfm.v_find_item_sid_2;