CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_agg_str_day_return AS
/* Als Basisview werden die Artikelbewegungen Positionsdaten verwendet */ 
SELECT IMRP.client_id AS client_id,
 LC_STR.src_orig_store_nr AS store_id,
 IMRP.loc_sid AS loc_sid_store,
 S_TO_WH.orig_wh_nr AS wh_id,
 IMRP.item_sid AS item_id,
 IHNS.src_subitemgrp_cd AS subitemgroup_id,
 IMRP.dwh_cal_dt AS booking_dat,
 ORP.return_reason_mark AS order_return_reason_cd,
 SUM(IMRP.ship_qty) AS return_qty,
 SUM(IMRP.ship_qty * COALESCE(ILSCD.cond_val_eff_calc, 0)) AS return_val,
 SUM(CAST(IMRP.ship_qty * COALESCE(ILSCD.cond_val_eff_calc, 0) * 100 / (100 + COALESCE(ILSCD.tax_rate_calc, 0)) AS NUMERIC)
  ) AS return_net_val,
 HCURR.curr_iso_cd AS currency_iso_cd
FROM ldl_p_lew_core_ac.v_item_movement_record_pos AS IMRP
 INNER JOIN ldl_p_lew_bil_ac.v_store AS LC_STR ON IMRP.client_id = LC_STR.client_id AND IMRP.loc_sid = LC_STR.loc_sid_store
   
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse AS S_TO_WH ON IMRP.client_id = S_TO_WH.client_id AND IMRP.loc_sid =
   S_TO_WH.loc_sid_store
 INNER JOIN ldl_p_lew_core_ac.v_item_hist AS ITMS ON IMRP.client_id = ITMS.client_id AND IMRP.item_sid = ITMS.item_sid
  AND CURRENT_DATE BETWEEN ITMS.dwh_valid_from AND ITMS.dwh_valid_to
 LEFT JOIN ldl_p_lew_bil_ac.v_item_hierarchy AS IHNS ON IMRP.client_id = IHNS.client_id AND IMRP.item_sid = IHNS.item_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_order_record_pos AS ORP ON IMRP.client_id = ORP.client_id AND IMRP.order_record_id = ORP
    .order_record_id AND IMRP.order_record_pos_id = ORP.order_record_pos_id
 LEFT JOIN ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm AS ILSCD ON IMRP.client_id = ILSCD.client_id AND IMRP.item_sid
      = ILSCD.item_sid AND IMRP.loc_sid = ILSCD.loc_sid AND IMRP.uom_sid_base = ILSCD.uom_sid_cond AND IMRP.dwh_cal_dt
   BETWEEN ILSCD.dwh_valid_from AND ILSCD.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_currency AS HCURR ON IMRP.client_id = HCURR.client_id AND IMRP.curr_sid = HCURR.curr_sid
 INNER JOIN ldl_p_lew_core_ac.v_order_record AS OREC ON ORP.client_id = OREC.client_id AND ORP.order_record_id
   -- 96X = WE Retoure o Vbr
 -- ZR01 = Filialinitiierte Rücksendungen Retoure
 = OREC.order_record_id
WHERE IMRP.move_type_cd = '96X'
 AND OREC.order_type_cd = 'ZR01'
GROUP BY IMRP.client_id,
 store_id,
 loc_sid_store,
 wh_id,
 item_id,
 subitemgroup_id,
 booking_dat,
 order_return_reason_cd,
 currency_iso_cd;