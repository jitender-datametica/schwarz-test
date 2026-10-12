CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_retailspace_stock_nonfood AS WITH STORAGE_STOCK AS (SELECT STK.client_id,
   CNTRY.src_country_lidl_cd AS country_lidl_cd,
   SM.orig_store_nr,
   STK.loc_sid,
   ST2WH.src_wh_id AS wh_id,
   ITEM.orig_item_nr,
   STK.item_sid,
   STK.store_storage_qty,
   t0.dwh_valid_from_max AS valid_from_storestorage,
   STK.dwh_valid_to AS valid_to_storestorage
  FROM ldl_p_lew_core_ac.v_item_store_storage_stock_hist AS STK
   INNER JOIN (SELECT client_id,
     loc_sid,
     item_sid,
     MAX(dwh_valid_from) AS dwh_valid_from_max
    FROM ldl_p_lew_core_ac.v_item_store_storage_stock_hist
    GROUP BY client_id,
     item_sid,
     loc_sid) AS t0 ON STK.client_id = t0.client_id AND STK.loc_sid = t0.loc_sid AND STK.item_sid = t0.item_sid AND STK
     .dwh_valid_from = t0.dwh_valid_from_max
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge AS SM ON STK.client_id = SM.client_id AND STK.loc_sid = SM.store_id
     
   INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item AS ITEM ON STK.client_id = ITEM.client_id AND STK.item_sid = ITEM.item_id
     
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS ST2WH ON STK.client_id = ST2WH.client_id AND STK.loc_sid
       = ST2WH.loc_sid_store AND ST2WH.loc_sid_store <> ST2WH.loc_sid_wh -- Exclude stores which represent a warehouse

   INNER JOIN ldl_p_lew_core_ac.v_country AS CNTRY ON STK.client_id = CNTRY.country_sid
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act AS ITEM_ACT ON STK.item_sid = ITEM_ACT.item_sid AND STK.client_id =
     ITEM_ACT.client_id
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_subitemgroup AS SUIG ON ITEM_ACT.client_id = SUIG.client_id AND ITEM_ACT.subitemgroup_id
       = SUIG.subitemgroup_id AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN SUIG.dat_rec_start AND SUIG.dat_rec_end
     
  WHERE SM.aspect_id = 1
   AND SM.dashboard_relevant_fg = 1
   AND SUIG.itemgroup_int_id = 70
   AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN STK.dwh_valid_from AND STK.dwh_valid_to) (SELECT ss.client_id,
   ss.country_lidl_cd,
   ss.orig_store_nr,
   ss.loc_sid,
   ss.wh_id,
   ss.orig_item_nr,
   ss.item_sid,
    CASE
    WHEN IFNULL(HIST.diff_qty_inv_calc, 0) = 0
    THEN HIST.calc_qty
    ELSE HIST.inv_qty
    END AS stock_real_qty,
   max_dat.dwh_valid_from_max AS valid_from_stockreal,
   HIST.dwh_valid_to AS valid_to_stockreal,
   ss.store_storage_qty,
   ss.valid_from_storestorage,
   ss.valid_to_storestorage
  FROM STORAGE_STOCK AS ss
   INNER JOIN ldl_p_lew_core_ac.v_item_location_stock_hist AS HIST ON ss.client_id = HIST.client_id AND ss.loc_sid =
      HIST.loc_sid AND ss.item_sid = HIST.item_sid
   INNER JOIN (SELECT HIST0.client_id,
     HIST0.loc_sid,
     HIST0.item_sid,
     MAX(HIST0.dwh_valid_from) AS dwh_valid_from_max
    FROM STORAGE_STOCK AS ss
     LEFT JOIN ldl_p_lew_core_ac.v_item_location_stock_hist AS HIST0 ON ss.client_id = HIST0.client_id AND ss.loc_sid =
        HIST0.loc_sid AND ss.item_sid = HIST0.item_sid
    WHERE HIST0.dwh_valid_from > DATE_SUB(CURRENT_DATE, INTERVAL 200 DAY)
    GROUP BY HIST0.client_id,
     HIST0.loc_sid,
     HIST0.item_sid) AS max_dat ON HIST.client_id = max_dat.client_id AND HIST.loc_sid = max_dat.loc_sid AND HIST.item_sid
       = max_dat.item_sid AND HIST.dwh_valid_from = max_dat.dwh_valid_from_max -- NEU

   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge AS SM1 ON HIST.client_id = SM1.client_id AND HIST.loc_sid = SM1.store_id
     
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act AS ITEM_ACT1 ON HIST.item_sid = ITEM_ACT1.item_sid AND HIST.client_id
      = ITEM_ACT1.client_id
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_subitemgroup AS SUIG1 ON ITEM_ACT1.client_id = SUIG1.client_id AND ITEM_ACT1.subitemgroup_id
       = SUIG1.subitemgroup_id AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN SUIG1.dat_rec_start AND SUIG1.dat_rec_end
     -- NEU ENDE

  WHERE HIST.dwh_valid_from > DATE_SUB(CURRENT_DATE, INTERVAL 200 DAY)
   AND SUIG1.itemgroup_int_id = 70
   AND SM1.aspect_id = 1
   AND SM1.dashboard_relevant_fg = 1);