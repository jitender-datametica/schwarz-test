/* Als Basisview werden die Artikelbewegungen Positionsdaten verwendet */
/* #DescStart#	
   #$Revision: 7049 $, $LastChangedBy: cmarose $	
   #SubjectAreas#: Rückgaben	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_store_day_return AS SELECT IMRP.client_id,
 LC_STR.src_orig_store_nr,
 IMRP.loc_sid AS loc_sid_store,
 S_TO_WH.src_wh_id AS orig_wh_nr,
 IMRP.item_sid,
 SIG.src_subitemgrp_cd,
 IMRP.dwh_cal_dt,
 ORP.return_reason_mark,
 SUM(IMRP.ship_qty) AS ship_qty,
 SUM(IMRP.ship_qty * COALESCE(ILSCD.cond_val_eff_calc, 0)) AS ship_val,
 SUM(IMRP.ship_qty * COALESCE(ILSCD.cond_val_eff_calc, 0) * 100 / (100 + COALESCE(ILSCD.tax_rate_calc, 0))) AS
 ship_net_val,
 HCURR.curr_iso_cd
FROM ldl_p_lew_core_ac.v_item_movement_record_pos AS IMRP
 INNER JOIN ldl_p_lew_bil.v_store AS LC_STR ON IMRP.client_id = LC_STR.client_id AND IMRP.loc_sid = LC_STR.loc_sid_store
      AND LC_STR.dwh_actual_fg = 1 AND LC_STR.active_fg = 1
 INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown AS S_TO_WH ON IMRP.client_id = S_TO_WH.client_id AND IMRP.loc_sid
    = S_TO_WH.loc_sid_store
 INNER JOIN ldl_p_lew_bil.v_item AS ITEM ON IMRP.client_id = ITEM.client_id AND IMRP.item_sid = ITEM.item_sid AND ITEM.dwh_actual_fg
    = 1
 LEFT JOIN ldl_p_lew_bil.v_subitemgroup AS SIG ON ITEM.client_id = SIG.client_id AND ITEM.sub_item_grp_sid_asis = SIG.sub_item_grp_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_order_record AS OREC ON IMRP.client_id = OREC.client_id AND IMRP.order_record_id = OREC
   .order_record_id
 INNER JOIN ldl_p_lew_core_ac.v_order_record_pos AS ORP ON IMRP.client_id = ORP.client_id AND IMRP.order_record_id = ORP
    .order_record_id AND IMRP.order_record_pos_id = ORP.order_record_pos_id
 LEFT JOIN ldl_p_lew_bil.v_item_loc_sales_cond_denorm AS ILSCD ON IMRP.client_id = ILSCD.client_id AND IMRP.item_sid =
      ILSCD.item_sid AND IMRP.loc_sid = ILSCD.loc_sid AND IMRP.uom_sid_base = ILSCD.uom_sid_cond AND IMRP.dwh_cal_dt
   BETWEEN ILSCD.dwh_valid_from AND ILSCD.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_currency AS HCURR ON IMRP.client_id = HCURR.client_id AND IMRP.curr_sid = HCURR.curr_sid
WHERE IMRP.move_type_cd = '96X' /* 96X = WE Retoure o Vbr */
 AND OREC.order_type_cd = 'ZR01' /* ZR01 = Filialinitiierte Rücksendungen Retoure */
GROUP BY IMRP.client_id,
 LC_STR.src_orig_store_nr,
 loc_sid_store,
 orig_wh_nr,
 IMRP.item_sid,
 SIG.src_subitemgrp_cd,
 IMRP.dwh_cal_dt,
 ORP.return_reason_mark,
 HCURR.curr_iso_cd;