CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_wh_storage AS SELECT *
FROM (SELECT IWS.client_id,
   LOC.src_wh_id AS wh_id,
    CASE
    WHEN ITM.src_orig_item_nr IS NULL
    THEN COALESCE(ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.src_matnr AS BIGNUMERIC), 0
      ), CAST(ITM.src_orig_item_nr AS BIGNUMERIC))
    ELSE ROUND(CAST(ITM.src_orig_item_nr AS BIGNUMERIC), 0)
    END AS orig_item_nr,
   IWS.wh_slot_case
  FROM ldl_p_lew_core_ac.v_wawi_itm_wh_slot AS IWS
   INNER JOIN ldl_p_lew_core_ac.v_item AS ITM ON IWS.client_id = ITM.client_id AND IWS.item_sid = ITM.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey_act AS ITM_SK ON IWS.client_id = ITM_SK.client_id AND IWS.item_sid
      = ITM_SK.item_sid AND ITM_SK.dat_deleted >= CURRENT_DATE
   INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON IWS.client_id = LOC.client_id AND IWS.wh_loc_sid = LOC.loc_sid
  WHERE CURRENT_DATE BETWEEN IWS.dat_rec_start AND IWS.dat_rec_end
   AND IWS.wh_slot_case > 0
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(IWS.client_id AS STRING), CAST(LOC.src_wh_id AS STRING), ITM.src_orig_item_nr
        ORDER BY ITM.src_dat_valid_from IS NULL, ITM.src_dat_valid_from)) = 1) AS details
GROUP BY client_id,
 wh_id,
 orig_item_nr,
 wh_slot_case;