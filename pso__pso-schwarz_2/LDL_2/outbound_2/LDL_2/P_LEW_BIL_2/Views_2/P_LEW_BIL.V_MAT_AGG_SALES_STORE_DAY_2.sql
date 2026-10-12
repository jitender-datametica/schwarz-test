CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_sales_store_day_2 AS SELECT A.client_id,
 A.loc_sid AS loc_sid_store,
 COALESCE(A.src_store_id, - 1) AS store_mis_sid,
 A.src_orig_store_nr AS orig_store_nr,
 CALI.cal_dt AS dat_formdate,
 FORMAT_DATE('%Y%m', DATE(CALI.cal_dt)) AS cy_month,
 COALESCE(c.cnt_receipts_sales, B.cnt_customer) AS cnt_customer,
 B.cnt_customer_wawi,
 B.cnt_customer_pos_receipt AS cnt_customer_ejr_he,
 B.cnt_customer_pos_statistic AS cnt_customer_ejr_st,
 COALESCE(c.cnt_receipts_sales, B.cnt_customer_txj) AS cnt_customer_txj,
 COALESCE(d.val_rtl_wawi, c.val_rtl_txj_item, B.sales_gross_val) AS val_retail,
 COALESCE(d.val_rtl_net_wawi, c.val_rtl_net_txj_item, B.sales_net_val) AS val_retail_net,
 COALESCE(d.val_rtl_wawi * - 1, B.sales_gross_val_wawi) AS val_rtl_wawi,
 COALESCE(d.val_rtl_net_wawi * - 1, B.sales_net_val_wawi) AS val_rtl_net_wawi,
 B.sales_gross_val_pos AS val_rtl_ejr,
  CASE
  WHEN COALESCE(c.client_id, d.client_id) IS NOT NULL
  THEN NULL
  ELSE B.sales_net_val_pos
  END AS val_rtl_net_ejr,
  CASE
  WHEN COALESCE(c.client_id, d.client_id) IS NOT NULL
  THEN NULL
  ELSE B.sales_gross_val_txj_store
  END AS val_rtl_txj_str,
  CASE
  WHEN COALESCE(c.client_id, d.client_id) IS NOT NULL
  THEN NULL
  ELSE B.sales_net_val_txj_store
  END AS val_rtl_net_txj_str,
 COALESCE(c.val_rtl_txj_item, B.vat_val_txj) AS val_rtl_txj_item,
 COALESCE(c.val_rtl_net_txj_item, CASE
   WHEN COALESCE(c.client_id, d.client_id) IS NOT NULL
   THEN NULL
   ELSE B.vat_val_txj_net
   END) AS val_rtl_net_txj_item,
 B.vat_val_pos AS val_vatamount_ejr,
 COALESCE(c.val_rtl_txj_item, B.vat_val_txj) AS val_vatamount_txj,
  CASE
  WHEN COALESCE(c.client_id, d.client_id) IS NOT NULL
  THEN NULL
  ELSE B.vat_val_txj_net
  END AS val_vatamount_net_txj,
 COALESCE(c.val_vatamount_vatsum_txj, B.vat_val_txj_vatsum) AS val_vatamount_vatsum_txj
FROM ldl_p_lew_core_ac.v_location_2 AS A
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CALI ON CALI.cal_dt BETWEEN DATE '2014-01-01' AND (DATE_ADD(CURRENT_DATE
    ,INTERVAL 1 DAY))
 LEFT JOIN ldl_p_lew_bil.v_agg_pos_txj_wawi_store_day_2 AS B ON A.client_id = B.client_id AND A.loc_sid = B.loc_sid AND
   CALI.cal_dt = B.dwh_cal_dt
 LEFT JOIN (SELECT y.client_id,
   y.loc_sid,
   y.dat_formdate,
   y.val_rtl_txj_item,
   y.val_rtl_net_txj_item,
   y.val_vatamount_vatsum_txj,
   z.cnt_receipts_sales
  FROM (SELECT A0.client_id,
     A0.loc_sid,
     A0.dwh_cal_dt AS dat_formdate,
     SUM(A0.actual_sales_val) AS val_rtl_txj_item,
     SUM(A0.actual_sales_val - x.tax_val) AS val_rtl_net_txj_item,
     SUM(x.tax_val) AS val_vatamount_vatsum_txj
    FROM ldl_p_lew_core_ac.v_pos_agg_sales_2 AS A0
     INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS D ON A0.client_id = D.client_id AND A0.item_sid = D.item_sid AND
       CURRENT_DATE BETWEEN D.dwh_valid_from AND D.dwh_valid_to
     LEFT JOIN ldl_p_lew_core_ac.v_item_type_2 AS E ON D.client_id = E.client_id AND D.item_type_sid = E.item_type_sid
     LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_2 AS IG ON E.client_id = IG.client_id AND E.src_mtart = IG.item_type_cd
         AND (IG.item_type_grp_cd IN ('BAGLEVY') OR IG.client_id = 33 AND IG.item_type_cd IN ('ZGIF'))
     LEFT JOIN (SELECT client_id,
       aggr_nr,
       aggr_rec_nr,
       SUM(tax_val) AS tax_val
      FROM ldl_p_lew_core_ac.v_pos_agg_vat_2
      GROUP BY client_id,
       aggr_nr,
       aggr_rec_nr) AS x ON A0.client_id = x.client_id AND A0.aggr_nr = x.aggr_nr AND A0.aggr_rec_id = x.aggr_rec_nr
    WHERE IG.item_type_sid IS NULL
    GROUP BY A0.client_id,
     A0.loc_sid,
     dat_formdate) AS y
   LEFT JOIN (SELECT client_id,
     loc_sid,
     dwh_cal_dt,
     SUM(cnt_receipts_sales) AS cnt_receipts_sales
    FROM ldl_p_lew_core_ac.v_pos_agg_bon_cnts_2
    GROUP BY client_id,
     loc_sid,
     dwh_cal_dt) AS z ON y.client_id = z.client_id AND y.loc_sid = z.loc_sid AND y.dat_formdate = z.dwh_cal_dt) AS c ON
    A.client_id = c.client_id AND A.loc_sid = c.loc_sid AND CALI.cal_dt = c.dat_formdate
 LEFT JOIN (SELECT B0.client_id,
   B0.loc_sid,
   B0.dwh_cal_dt AS dat_formdate,
   SUM(CASE
     WHEN C.cond_type_cd IN ('ZPRA', 'ZPRP') AND E0.src_mtart IN ('ZVM', 'ZKM') AND A1.invoice_class_cd = 'ZFPU'
     THEN B0.cond_subtotal_2 - B0.cond_subtotal_1
     WHEN E0.src_mtart IN ('ZVM', 'ZKM') AND A1.invoice_class_cd = 'ZFPU' AND B0.client_id NOT IN (33) OR B0.client_id
        IN (33) AND E0.src_mtart IN ('ZGIF')
     THEN 0
     ELSE B0.net_val + B0.tax_val
     END) AS val_rtl_wawi,
   SUM(CASE
     WHEN C.cond_type_cd IN ('ZPRA', 'ZPRP') AND E0.src_mtart IN ('ZVM', 'ZKM') AND A1.invoice_class_cd = 'ZFPU'
     THEN B0.cond_subtotal_2 - B0.cond_subtotal_1 - CASE
       WHEN B0.dwh_cal_dt < PARSE_DATE('%F', '2018-01-20')
       THEN 0
       ELSE B0.tax_val
       END
     WHEN E0.src_mtart IN ('ZVM', 'ZKM') AND A1.invoice_class_cd = 'ZFPU' AND B0.client_id NOT IN (33) OR B0.client_id
        IN (33) AND E0.src_mtart IN ('ZGIF')
     THEN 0
     ELSE B0.net_val
     END) AS val_rtl_net_wawi
  FROM ldl_p_lew_core_ac.v_retail_sales_record_2 AS A1
   INNER JOIN ldl_p_lew_core_ac.v_retail_sales_record_pos_2 AS B0 ON A1.client_id = B0.client_id AND A1.retail_sales_record_id
       = B0.retail_sales_record_id AND A1.dwh_cal_dt = B0.dwh_cal_dt
   LEFT JOIN ldl_p_lew_core_ac.v_retail_sales_record_pos_cond_2 AS C ON B0.client_id = C.client_id AND B0.retail_sales_record_id
         = C.retail_sales_record_id AND B0.retail_sales_record_pos_id = C.retail_sales_record_pos_id AND B0.dwh_cal_dt =
      C.dwh_cal_dt AND C.cond_type_cd IN ('ZPRA', 'ZPRP')
   LEFT JOIN ldl_p_lew_core_ac.v_item_hist_2 AS D0 ON B0.client_id = D0.client_id AND B0.item_sid = D0.item_sid AND
     CURRENT_DATE BETWEEN D0.dwh_valid_from AND D0.dwh_valid_to
   LEFT JOIN ldl_p_lew_core_ac.v_item_type_2 AS E0 ON D0.client_id = E0.client_id AND D0.item_type_sid = E0.item_type_sid
   LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_2 AS IG0 ON E0.client_id = IG0.client_id AND E0.src_mtart = IG0.item_type_cd
       AND (IG0.item_type_grp_cd IN ('BAGLEVY') OR IG0.client_id = 33 AND IG0.item_type_cd IN ('ZGIF'))
  WHERE IG0.item_type_sid IS NULL
   AND A1.invoice_class_cd NOT IN ('ZF91', 'ZS01', 'ZF92', 'ZS92')
  GROUP BY B0.client_id,
   B0.loc_sid,
   dat_formdate) AS d ON A.client_id = d.client_id AND A.loc_sid = d.loc_sid AND CALI.cal_dt = d.dat_formdate
WHERE B.loc_sid IS NOT NULL
 OR c.loc_sid IS NOT NULL
 OR d.loc_sid IS NOT NULL;