/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEM_DETAILS_WH_2
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-23    Jyoti Agarwal          Add dimension columns
#                                         https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/492641
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_DETAILS_WH_2
AS
   /* wawi NEW --the original SQL has inconstant result because of the lack of 
      order by columns in ROW_NUMBER function. And key differences come from 
      x_lew_core.v_item_hist_2(in x_lew_bil.v_item_2) */
SELECT
  skey.client_id                                                  AS client_id
  ,clnt.src_country_lidl_cd                                        AS country_iso_cd
  ,CAST(loc.src_wh_id          AS INTEGER)                         AS wh_id
  ,CAST(skey.src_orig_item_nr  AS BIGINT )                         AS orig_item_nr
  ,wh.order_area_cd                                                AS order_area_cd
  ,CAST(wh.item_status AS VARCHAR(2))                              AS item_status
  ,CASE  
         WHEN CAST(skey.src_case_size AS DECIMAL(15,2)) = -1  
         THEN CAST(skey_act.case_size AS DECIMAL(15,2)) 
         ELSE CAST(skey.src_case_size AS DECIMAL(15,2)) 
      END                                                          AS case_size 
  ,CAST(wh.case_factor_dd      AS DECIMAL(15,2))                   AS case_factor_dd
  ,CAST(wh.case_factor_euro    AS DECIMAL(15,2))                   AS case_factor_euro
  ,wh.case_factor_layer                                            AS case_factor_layer         --10
  ,wh.min_orderunit                                                AS min_orderunit
  ,wh.min_case_dd_wh                                               AS min_case_dd_wh
  ,wh.min_case_euro_wh                                             AS min_case_euro_wh
  ,wh.min_case_layer_wh                                            AS min_case_layer_wh
  ,wh.min_case_wh                                                  AS min_case_wh
  ,COALESCE(TRIM(act_item.item_actiongroup_id), '')                AS item_actiongroup_id
  ,COALESCE(TRIM(act_item.item_sub_actiongroup_id) , '')           AS item_sub_actiongroup_id
  ,CAST(COALESCE(act_item.dur_shelflife_day_wh , 0)   AS BIGINT)   AS dur_shelflife_day_wh
  ,CAST(COALESCE(act_item.dur_shelflife_day_store, 0) AS BIGINT)   AS dur_shelflife_day_store
  ,CAST(COALESCE(act_item.dur_shelflife_day_cust , 0) AS BIGINT)   AS dur_shelflife_day_cust    --20
  ,TO_NUMBER(NULL)                                                 AS smallest_unit
  ,COALESCE(act_item.item_plu_nr , '')                             AS item_plu_nr
  ,order_info.dispo_group_id                                       AS dispo_group_nr
  ,act_item.unitsize                                               AS unit_size
  --  ,ROW_NUMBER() OVER
  --  (PARTITION BY skey.client_id, loc.src_wh_id, skey.src_orig_item_nr 
  --   ORDER BY CASE WHEN wh.item_status BETWEEN 6 AND 11 THEN 1 ELSE 2 END ASC  
  --          --, wh.item_status desc, skey.src_case_size,act_item.unitsize  
  --   ) AS status_rank /* Valid status_2 (6-11) win, the others are fallbacks, ONLY BETWEEN 6 AND 11 WE HAVE UNIQUENESS! */
  ,itm.case_height    										                         AS case_height
  ,itm.case_depth    										                           AS case_depth
  ,itm.case_width    										                           AS case_width
  ,itm.case_volume    										                         AS case_volume
  ,itm.piece_height    										                         AS piece_height
  ,itm.piece_depth													                       AS piece_depth
  ,itm.piece_width													                       AS piece_width
  ,itm.piece_volume												                         AS piece_volume
FROM p_lew_bil_ac.v_item_2 AS skey
INNER JOIN p_lew_core_ac.v_client_2 AS clnt
  ON skey.client_id = clnt.client_id
INNER JOIN p_lew_core_ac.v_client_migration_per_2 AS mig
  ON mig.client_id = skey.client_id
  AND (    Current_Date < mig.migration_dat_valid_from
       OR Current_Date > mig.migration_dat_valid_to
     )
INNER JOIN p_lew_core_ac.v_wawi_itm_item_2 AS itm
  ON itm.client_id = skey.client_id
  AND itm.item_sid = skey.item_sid
INNER JOIN p_lew_core_ac.v_wawi_itm_item_wh_2 AS wh
  ON  wh.client_id = skey.client_id
  AND wh.item_sid  = skey.item_sid
INNER JOIN p_lew_core_ac.v_location_2 AS loc
  ON wh.client_id  = loc.client_id
  AND wh.wh_loc_sid = loc.loc_sid
INNER JOIN p_lew_core_ac.v_wawi_itm_wh_orderinformation_2 AS order_info
  ON order_info.client_id = skey.client_id
  AND order_info.item_sid  = skey.item_sid
-- Zusaetzliche Join-Bedingung zur Vermeidung von Duplikaten bei der Dispogruppe
  AND wh.client_id   = order_info.client_id
  AND wh.item_sid    = order_info.item_sid
  AND wh.wh_loc_sid  = order_info.wh_loc_sid
  AND skey.dwh_actual_fg = 1
  AND CURRENT_DATE BETWEEN order_info.dat_rec_start AND order_info.dat_rec_end
LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_act_2 AS act_item
  ON skey.client_id = act_item.client_id
  AND skey.item_sid  = act_item.item_sid
LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_skey_act_2 AS skey_act
  ON skey.client_id = skey_act.client_id
  AND skey.item_sid = skey_act.item_sid

WHERE skey.dwh_actual_fg = 1
  AND CURRENT_DATE BETWEEN itm.dat_rec_start AND itm.dat_rec_end
  AND CURRENT_DATE BETWEEN wh.dat_rec_start  AND wh.dat_rec_end
  AND wh.item_status BETWEEN 5 AND 13
QUALIFY ROW_NUMBER() Over
(PARTITION BY skey.client_id, loc.src_wh_id, skey.src_orig_item_nr, skey.src_case_size
ORDER BY CASE WHEN wh.item_status BETWEEN 6 AND 11 THEN 1 ELSE 2 END ASC
) = 1
;