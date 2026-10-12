CREATE OR REPLACE view P_LEW_BIL.V_MAT_AGG_STORE_DAY_RETURN as
   SELECT imrp.client_id,	
   lc_str.src_orig_store_nr,	
   imrp.loc_sid AS loc_sid_store,	
   s_to_wh.src_wh_id AS orig_wh_nr,	
   imrp.item_sid,	
   sig.src_subitemgrp_cd,	
   imrp.dwh_cal_dt,	
   orp.return_reason_mark,	
   Sum(imrp.ship_qty) AS ship_qty,	
   Sum(imrp.ship_qty * Coalesce(ilscd.cond_val_eff_calc, 0)) AS ship_val,	
   Sum(imrp.ship_qty * Coalesce(ilscd.cond_val_eff_calc, 0) * 100	
   / (100 + Coalesce(ilscd.tax_rate_calc, 0))	
) AS ship_net_val,	
   hcurr.curr_iso_cd	
  /* Als Basisview werden die Artikelbewegungen Positionsdaten verwendet*/	
  FROM	
   p_lew_core_ac.v_item_movement_record_pos AS imrp	
   INNER JOIN p_lew_bil.v_store AS lc_str	
   ON imrp.client_id = lc_str.client_id	
   AND imrp.loc_sid = lc_str.loc_sid_store	
   AND lc_str.dwh_actual_fg = 1	
   AND lc_str.active_fg = 1	
   INNER JOIN p_lew_bil.v_store_to_warehouse_lastknown AS s_to_wh	
   ON imrp.client_id = s_to_wh.client_id	
   AND imrp.loc_sid = s_to_wh.loc_sid_store	
   INNER JOIN p_lew_bil.v_item AS item	
   ON  imrp.client_id = item.client_id	
   AND imrp.item_sid = item.item_sid	
   AND item.dwh_actual_fg = 1	
   LEFT OUTER JOIN p_lew_bil.v_subitemgroup AS sig	
   ON  item.client_id = sig.client_id	
   AND item.sub_item_grp_sid_asis = sig.sub_item_grp_sid	
   INNER JOIN p_lew_core_ac.v_order_record AS orec	
   ON  imrp.client_id = orec.client_id	
   AND imrp.order_record_id = orec.order_record_id	
   INNER JOIN p_lew_core_ac.v_order_record_pos AS orp	
   ON  imrp.client_id = orp.client_id	
   AND imrp.order_record_id = orp.order_record_id	
   AND imrp.order_record_pos_id = orp.order_record_pos_id	
   LEFT OUTER JOIN p_lew_bil.v_item_loc_sales_cond_denorm AS ilscd	
   ON  imrp.client_id   = ilscd.client_id	
   AND imrp.item_sid = ilscd.item_sid	
   AND imrp.loc_sid = ilscd.loc_sid	
   AND imrp.uom_sid_base = ilscd.uom_sid_cond	
   AND imrp.dwh_cal_dt BETWEEN  ilscd.dwh_valid_from AND ilscd.dwh_valid_to	
   LEFT OUTER JOIN p_lew_core_ac.v_currency AS hcurr	
   ON  imrp.client_id = hcurr.client_id	
   AND imrp.curr_sid = hcurr.curr_sid	
WHERE imrp.move_type_cd = '96X' /* 96X = WE Retoure o Vbr */	
AND  orec.order_type_cd = 'ZR01' /* ZR01 = Filialinitiierte Rücksendungen Retoure */	
GROUP BY imrp.client_id	
, lc_str.src_orig_store_nr	
, imrp.loc_sid	
, s_to_wh.src_wh_id	
, imrp.item_sid	
, sig.src_subitemgrp_cd	
, imrp.dwh_cal_dt	
, orp.return_reason_mark	
, hcurr.curr_iso_cd /*	
   #DescStart#	
   #$Revision: 7049 $, $LastChangedBy: cmarose $	
   #SubjectAreas#: Rückgaben	
   #DescEnd#	
   */	
;