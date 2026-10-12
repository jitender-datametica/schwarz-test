/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEM_DETAILS_WH
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-23    Jyoti Agarwal          Add dimension columns
#                                         https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/492641
#----------------------------------------------------------------------------
*/


/* wawi NEW --the original SQL has inconstant result because of the lack of 
      order by columns in ROW_NUMBER function. And key differences come from LDL.x_lew_core.v_item_hist(in x_lew_bil.v_item) */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_details_wh AS -- 10
 -- 20
 -- ,ROW_NUMBER() OVER

-- (PARTITION BY skey.client_id, loc.src_wh_id, skey.src_orig_item_nr

-- ORDER BY CASE WHEN wh.item_status BETWEEN 6 AND 11 THEN 1 ELSE 2 END ASC

-- --, wh.item_status desc, skey.src_case_size,act_item.unitsize

-- ) AS status_rank /* Valid status (6-11) win, the others are fallbacks, ONLY BETWEEN 6 AND 11 WE HAVE UNIQUENESS!

SELECT SKEY.client_id,
 CLNT.src_country_lidl_cd AS country_iso_cd,
 CAST(LOC.src_wh_id AS BIGNUMERIC) AS wh_id,
 ROUND(CAST(SKEY.src_orig_item_nr AS BIGNUMERIC), 0) AS orig_item_nr,
 WH.order_area_cd,
 CAST(WH.item_status AS STRING) AS item_status,
  CASE
  WHEN ROUND(CAST(SKEY.src_case_size AS NUMERIC), 2) = - 1
  THEN CAST(SKEY_ACT.case_size AS NUMERIC)
  ELSE ROUND(CAST(SKEY.src_case_size AS NUMERIC), 2)
  END AS case_size,
 CAST(WH.case_factor_dd AS NUMERIC) AS case_factor_dd,
 CAST(WH.case_factor_euro AS NUMERIC) AS case_factor_euro,
 WH.case_factor_layer,
 WH.min_orderunit,
 WH.min_case_dd_wh,
 WH.min_case_euro_wh,
 WH.min_case_layer_wh,
 WH.min_case_wh,
 COALESCE(TRIM(SUBSTR(CAST(ACT_ITEM.item_actiongroup_id AS STRING), 1, 39)), '') AS item_actiongroup_id,
 COALESCE(TRIM(SUBSTR(CAST(ACT_ITEM.item_sub_actiongroup_id AS STRING), 1, 39)), '') AS item_sub_actiongroup_id,
 COALESCE(ACT_ITEM.dur_shelflife_day_wh, 0) AS dur_shelflife_day_wh,
 COALESCE(ACT_ITEM.dur_shelflife_day_store, 0) AS dur_shelflife_day_store,
 COALESCE(ACT_ITEM.dur_shelflife_day_cust, 0) AS dur_shelflife_day_cust,
 CAST(NULL AS BIGNUMERIC) AS smallest_unit,
 COALESCE(ACT_ITEM.item_plu_nr, '') AS item_plu_nr,
 ORDER_INFO.dispo_group_id AS dispo_group_nr,
 ACT_ITEM.unitsize AS unit_size,
 ITM.case_height,
 ITM.case_depth,
 ITM.case_width,
 ITM.case_volume,
 ITM.piece_height,
 ITM.piece_depth,
 ITM.piece_width,
 ITM.piece_volume
FROM ldl_p_lew_bil_ac.v_item AS SKEY
 INNER JOIN ldl_p_lew_core_ac.v_client AS CLNT ON SKEY.client_id = CLNT.client_id
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON SKEY.client_id = MIG.client_id AND (CURRENT_DATE < MIG.migration_dat_valid_from
      OR CURRENT_DATE > MIG.migration_dat_valid_to)
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item AS ITM ON SKEY.client_id = ITM.client_id AND SKEY.item_sid = ITM.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh AS WH ON SKEY.client_id = WH.client_id AND SKEY.item_sid = WH.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON WH.client_id = LOC.client_id AND WH.wh_loc_sid = LOC.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_wh_orderinformation AS ORDER_INFO ON SKEY.client_id = ORDER_INFO.client_id AND
        SKEY.item_sid -- Zusaetzliche CROSS JOIN-Bedingung zur Vermeidung von Duplikaten bei der Dispogruppe
 =
        ORDER_INFO.item_sid AND WH.client_id = ORDER_INFO.client_id AND WH.item_sid = ORDER_INFO.item_sid AND WH.wh_loc_sid
      = ORDER_INFO.wh_loc_sid AND SKEY.dwh_actual_fg = 1 AND CURRENT_DATE BETWEEN ORDER_INFO.dat_rec_start AND
   ORDER_INFO.dat_rec_end
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act AS ACT_ITEM ON SKEY.client_id = ACT_ITEM.client_id AND SKEY.item_sid =
   ACT_ITEM.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey_act AS SKEY_ACT ON SKEY.client_id = SKEY_ACT.client_id AND SKEY.item_sid
    = SKEY_ACT.item_sid
WHERE SKEY.dwh_actual_fg = 1
 AND CURRENT_DATE BETWEEN ITM.dat_rec_start AND ITM.dat_rec_end
 AND CURRENT_DATE BETWEEN WH.dat_rec_start AND WH.dat_rec_end
 AND WH.item_status BETWEEN 5 AND 13
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(SKEY.client_id AS STRING), CAST(LOC.src_wh_id AS STRING), SKEY.src_orig_item_nr
      , SKEY.src_case_size ORDER BY CASE
       WHEN WH.item_status BETWEEN 6 AND 11
       THEN 1
       ELSE 2
       END IS NULL, CASE
       WHEN WH.item_status BETWEEN 6 AND 11
       THEN 1
       ELSE 2
       END)) = 1;