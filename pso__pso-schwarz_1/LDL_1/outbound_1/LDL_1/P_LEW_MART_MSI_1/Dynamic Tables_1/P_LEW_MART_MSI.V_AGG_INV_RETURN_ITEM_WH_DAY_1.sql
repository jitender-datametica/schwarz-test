CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_agg_inv_return_item_wh_day_1
AS
/* Take the sales_1 price from Sales_1 condition table */ /* Ungefilterte Artikelarten */ SELECT MOV.client_id,
 MOV.loc_sid,
 L.src_wh_id AS wh_id,
 D.item_sid AS item_id,
 MOV.dwh_cal_dt AS booking_dat,
 SUM(MOV.ship_qty) AS ship_qty,
 SUM(MOV.ship_qty * COALESCE(PRC.cond_val_eff_calc, 0)) AS gross_val,
 SUM(CAST(MOV.ship_qty * COALESCE(PRC.cond_val_eff_calc, 0) * 100 / (100 + COALESCE(PRC.tax_rate_calc, 0)) AS NUMERIC))
 AS sales_net_val
FROM ldl_p_lew_core_ac.v_item_movement_record_pos_1 AS MOV
 LEFT JOIN ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_1 AS PRC ON MOV.client_id = PRC.client_id AND MOV.item_sid = PRC
      .item_sid AND MOV.loc_sid = PRC.loc_sid AND MOV.uom_sid_base = PRC.uom_sid_cond AND MOV.dwh_cal_dt BETWEEN PRC.dwh_valid_from
   AND PRC.dwh_valid_to
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS L ON MOV.client_id = L.client_id AND MOV.loc_sid = L.loc_sid_wh
 INNER JOIN ldl_p_lew_mart_msi.v_org_wh_1 AS O ON L.client_id = O.client_id AND L.src_wh_id = O.wh_id AND L.dwh_actual_fg
     = 1 AND L.active_fg = 1 AND L.bges_active_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS D ON MOV.client_id = D.client_id AND MOV.item_sid = D.item_sid AND D.deleted_fg
     = 0 AND CURRENT_DATE BETWEEN D.dwh_valid_from AND D.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_item_type_1 AS ITM ON D.client_id = ITM.client_id AND D.item_type_sid
   /* Artikel_1 die zu ignorieren sind */ = ITM.item_type_sid
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_1 AS IG ON D.client_id = IG.client_id AND ITM.src_mtart = IG.item_type_cd
      AND (IG.client_id IN (33, 34) AND IG.item_type_cd NOT IN ('ZKM', 'ZVM') OR IG.client_id NOT IN (33, 34)) AND IG.item_type_grp_cd
    IN ('BAGLEVY', 'INV')
WHERE MOV.move_type_cd IN ('911', '912', '913', '914', '921', '922', '923', '924', '925', '926', '927', '928', '963',
   '964', '987', '988')
 AND IG.item_type_cd IS NULL
GROUP BY MOV.client_id,
 MOV.loc_sid,
 wh_id,
 item_id,
 booking_dat;


