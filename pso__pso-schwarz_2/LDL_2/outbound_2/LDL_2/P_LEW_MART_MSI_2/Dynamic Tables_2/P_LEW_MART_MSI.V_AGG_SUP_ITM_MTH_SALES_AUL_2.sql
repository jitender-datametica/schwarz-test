CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_agg_sup_itm_mth_sales_aul_2 AS
SELECT CL.client_id AS client_id,
 C.country_iso_cd AS country_iso_cd,
 MTH.cy_month AS cy_month,
 ITMP.item_sid_map AS item_id,
 IIS.orig_item_nr AS orig_item_nr,
 SLS.dat_valid_from_item AS dat_valid_from_item,
 IIS.case_size AS case_size,
 SLS.qty_total AS qty_total,
 SLS.val_rtl_ejr_asis AS val_rtl_ejr_asis,
 SLS.val_rtl_net_ejr_asis AS val_rtl_net_ejr_asis,
 SLS.val_rtl_str_days_w_sales_asis AS val_rtl_str_days_w_sales_asis,
 SLS.val_rtl_str_net_days_w_s_asis AS val_rtl_str_net_days_w_s_asis,
 SLS.avg_qty_sold_per_str_week AS avg_qty_sold_per_str_week,
 IW.wh_id AS wh_id,
 agg.supplier_id AS supplier_id,
 agg.orig_supplier_nr AS orig_supplier_nr,
 SLS.currency_iso_cd AS currency_iso_cd,
 agg.qty_total_rcv AS qty_total_rcv
FROM ldl_p_lew_mart_msi.v_ref_country_2 AS C
 INNER JOIN ldl_p_lew_mart_msi.v_ref_client_2 AS CL ON C.country_id = CL.country_id
 INNER JOIN ldl_p_lew_mart_msi.v_cal_month_2 AS MTH ON MTH.cy_month IS NOT NULL
 INNER JOIN ldl_p_lew_mart_msi.v_itm_item_skey_2 AS IIS ON CL.client_id = IIS.client_id
 INNER JOIN ldl_p_lew_mart_msi.v_itm_item_wh_2 AS IW ON CL.client_id = IW.client_id AND IIS.item_id = IW.item_id
 LEFT JOIN (SELECT IRW.client_id,
   IRW.wh_id,
   IRW.item_id,
   IRW.supplier_id,
   SUP.orig_supplier_nr,
   CAL.cy_month,
   IRW.currency_iso_cd,
   SUM(IRW.qty_total_rcv) AS qty_total_rcv
  FROM ldl_p_lew_mart_msi.v_cal_calendarday_2 AS CAL
   INNER JOIN ldl_p_lew_mart_msi.v_mov_item_receive_wh_2 AS IRW ON IRW.receipt_pos_nr_rcv BETWEEN 0 AND 499 AND CAL.dat_calendar
       = IRW.dat_entry_rcv AND IRW.currency_iso_cd = 'EUR'
   INNER JOIN ldl_p_lew_mart_msi.v_sup_supplier_skey_2 AS SUP ON IRW.client_id = SUP.client_id AND IRW.supplier_id = SUP.supplier_id
     
  GROUP BY CAL.cy_month,
   IRW.client_id,
   IRW.wh_id,
   IRW.item_id,
   IRW.supplier_id,
   IRW.currency_iso_cd,
   SUP.orig_supplier_nr) AS agg ON CL.client_id = agg.client_id AND IW.wh_id = agg.wh_id AND IW.item_id = agg.item_id
  AND MTH.cy_month = agg.cy_month
 LEFT JOIN ldl_p_lew_mart_msi.v_agg_wh_itm_mth_sales_asis_2 AS SLS ON CL.client_id = SLS.client_id AND IW.wh_id = SLS.wh_id
      AND MTH.cy_month = SLS.cy_month AND IIS.orig_item_nr = SLS.orig_item_nr
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON IIS.client_id = ITMP.client_id AND IIS.item_id = ITMP.item_sid
WHERE agg.orig_supplier_nr IS NOT NULL;