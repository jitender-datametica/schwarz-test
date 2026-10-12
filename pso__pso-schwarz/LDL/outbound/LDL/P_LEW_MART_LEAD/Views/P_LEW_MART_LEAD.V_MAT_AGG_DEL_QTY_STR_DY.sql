/* #DescStart#
   #$Revision: 8473 $, $LastChangedBy: knagmote $
   #SubjectAreas#: LEAD item delivered quantity to store on day level
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_agg_del_qty_str_dy AS /* lew_mart_msi.v_item_2_wawi_item */ SELECT
 client_id,
 item_sid_ AS item_sid,
 loc_sid_store_move_to,
 wh_loc_sid,
 wh_id,
 aspect_id,
 dat_formdate,
 cy_month,
 busyear,
 del_qty_nfv_val,
 del_qty_fv_val,
 del_qty_brk_alc_val,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM (SELECT adq.client_id,
   COALESCE(itmp.wawi_item_id, adq.item_sid) AS item_sid_,
   ORG.loc_sid_store_move_to,
   ORG.loc_sid_wh AS wh_loc_sid,
   WH.src_wh_id AS wh_id,
   ORG.aspect_id,
   adq.dat_formdate,
   adq.cy_month,
   CAL.busyear,
   SUM(CAST(adq.del_qty_nfv_val AS NUMERIC)) AS del_qty_nfv_val,
   SUM(CAST(adq.del_qty_fv_val AS NUMERIC)) AS del_qty_fv_val,
   SUM(adq.del_qty_brk_alc_val) AS del_qty_brk_alc_val
  FROM (SELECT client_id,
      item_sid,
      loc_sid_store,
      dat_formdate,
      cy_month,
       CASE
       WHEN deliverytype_id <> 4
       THEN COALESCE(CAST(qty_total_del AS NUMERIC), 0)
       ELSE 0
       END AS del_qty_nfv_val,
       CASE
       WHEN deliverytype_id = 4
       THEN COALESCE(CAST(qty_total_del AS NUMERIC), 0)
       ELSE 0
       END AS del_qty_fv_val,
      0 AS del_qty_brk_alc_val
     FROM ldl_p_lew_bil_ac.v_agg_deliv_base AS DELI
     UNION ALL
     SELECT client_id,
      item_sid,
      loc_sid_store,
      booking_dat AS dat_formdate,
      cy_month,
      0 AS del_qty_nfv_val,
      0 AS del_qty_fv_val,
      COALESCE(CAST(sfo_total_qty_asis AS NUMERIC), 0) AS del_qty_brk_alc_val
     FROM ldl_p_lew_bil_ac.v_agg_store_day_item_sfo_asis AS SFO
     WHERE sfotype_id IN (135, 145)) AS adq
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON adq.dat_formdate = CAL.cal_dt
   INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge AS ORG ON adq.client_id = ORG.client_id AND adq.loc_sid_store = ORG.loc_sid_store
     
   INNER JOIN ldl_p_lew_core_ac.v_location AS WH ON ORG.loc_sid_wh = WH.loc_sid AND adq.client_id = WH.client_id AND WH
     .wh_store_mark = 'B'
   LEFT JOIN (SELECT client_id,
     item_sid AS item_id,
     item_sid_map AS wawi_item_id
    FROM ldl_p_lew_core_ac.v_item_map_key AS A
    WHERE (wawi_dwh_orig_item_nr IS NULL OR wawi_dwh_case_size = - 1)
     AND item_sid_map IS NOT NULL) AS itmp ON adq.client_id = itmp.client_id AND adq.item_sid = itmp.item_id
  WHERE CAL.cy_month_seq BETWEEN - 35 AND 1
  GROUP BY adq.client_id,
   item_sid_,
   ORG.loc_sid_store_move_to,
   wh_loc_sid,
   wh_id,
   ORG.aspect_id,
   adq.dat_formdate,
   adq.cy_month,
   CAL.busyear) AS tmp;