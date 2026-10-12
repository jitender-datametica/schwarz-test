CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_AGG_DEL_QTY_STR_DY as
   /*
   #DescStart#
   #$Revision: 8473 $, $LastChangedBy: knagmote $
   #SubjectAreas#: LEAD item delivered quantity to store on day level
   #DescEnd#
   */
   SELECT
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
   CURRENT_TIMESTAMP(6) AS dwh_updated
  FROM (
  SELECT
    adq.client_id,
   COALESCE(itmp.wawi_item_id, adq.item_sid) AS item_sid_,
   org.loc_sid_store_move_to,
   org.loc_sid_wh                            AS wh_loc_sid,
   wh.src_wh_id                              AS wh_id,
   org.aspect_id,
   adq.dat_formdate,
   adq.cy_month,
   cal.busyear,
   SUM(CAST(del_qty_nfv_val     AS DECIMAL(18,5))) AS del_qty_nfv_val,
   SUM(CAST(del_qty_fv_val      AS DECIMAL(18,5))) AS del_qty_fv_val,
   SUM(CAST(del_qty_brk_alc_val AS DECIMAL(18,5))) AS del_qty_brk_alc_val
  FROM (
  SELECT
    deli.client_id,
   deli.item_sid,
   deli.loc_sid_store,
   deli.dat_formdate,
   deli.cy_month,
   CASE WHEN deli.deliverytype_id <> 4 THEN COALESCE(CAST(deli.qty_total_del AS DECIMAL(18,5)), 0) ELSE 0 END AS del_qty_nfv_val,
   CASE WHEN deli.deliverytype_id  = 4 THEN COALESCE(CAST(deli.qty_total_del AS DECIMAL(18,5)), 0) ELSE 0 END AS del_qty_fv_val,
   CAST(0 AS DECIMAL(18,5)) AS del_qty_brk_alc_val
  FROM p_lew_bil_ac.v_agg_deliv_base deli

   UNION ALL

   SELECT
     sfo.client_id,
   sfo.item_sid,
   sfo.loc_sid_store,
   sfo.booking_dat AS dat_formdate,
   sfo.cy_month,
   0 AS del_qty_nfv_val,
   0 AS del_qty_fv_val,
   COALESCE(CAST(sfo_total_qty_asis AS DECIMAL(18,5)), 0) AS del_qty_brk_alc_val
  FROM p_lew_bil_ac.v_agg_store_day_item_sfo_asis sfo
   WHERE sfo.sfotype_id IN (135, 145)
   ) adq
   INNER JOIN p_lew_core_ac.v_cal_calendarday cal
   ON    cal.cal_dt         = adq.dat_formdate
   INNER JOIN p_lew_bil_ac.v_org_store_merge org
   ON    adq.client_id     = org.client_id
   AND   adq.loc_sid_store = org.loc_sid_store
   INNER JOIN p_lew_core_ac.v_location wh
   ON    org.loc_sid_wh    = wh.loc_sid
   AND   adq.client_id     = wh.client_id
   AND   wh.wh_store_mark  = 'B'
   LEFT OUTER JOIN
   (/* lew_mart_msi.v_item_2_wawi_item */
       SELECT
         a.client_id,
   a.item_sid AS item_id,
   a.item_sid_map AS wawi_item_id
       FROM p_lew_core_ac.v_item_map_key AS a
   WHERE (a.wawi_dwh_orig_item_nr IS NULL OR a.wawi_dwh_case_size = -1)
   AND a.item_sid_map IS NOT NULL
)itmp
   ON  itmp.client_id = adq.client_id
   AND itmp.item_id   = adq.item_sid

   WHERE cal.cy_month_seq BETWEEN -35 AND 1
   GROUP BY
     adq.client_id
   , item_sid_
   , org.loc_sid_store_move_to
   , org.loc_sid_wh
   , wh.src_wh_id
   , org.aspect_id
   , adq.dat_formdate
   , adq.cy_month
   , cal.busyear

   )tmp
;