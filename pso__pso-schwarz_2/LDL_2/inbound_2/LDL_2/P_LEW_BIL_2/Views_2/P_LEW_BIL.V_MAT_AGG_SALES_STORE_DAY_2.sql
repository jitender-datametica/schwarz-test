CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_AGG_SALES_STORE_DAY_2
AS
SELECT
a.client_id,
a.loc_sid                                                             AS loc_sid_store,
Coalesce(a.src_store_id ,-1)                                          AS store_mis_sid,
a.src_orig_store_nr                                                   AS orig_store_nr,
cali.cal_dt                                                           AS dat_formdate,
--cali.cal_dt/100 + 190000                                              AS cy_month,

to_char(cali.cal_dt::date, 'YYYYMM') AS cy_month,

Coalesce(c.cnt_receipts_sales, b.cnt_customer)                        AS cnt_customer,
b.cnt_customer_wawi                                                   AS cnt_customer_wawi,
b.cnt_customer_pos_receipt                                            AS cnt_customer_ejr_he,
b.cnt_customer_pos_statistic                                          AS cnt_customer_ejr_st,
Coalesce(c.cnt_receipts_sales, b.cnt_customer_txj)                    AS cnt_customer_txj,
Coalesce(d.val_rtl_wawi, c.val_rtl_txj_item, b.sales_gross_val)       AS val_retail,
Coalesce(d.val_rtl_net_wawi, c.val_rtl_net_txj_item, b.sales_net_val) AS val_retail_net,
Coalesce(d.val_rtl_wawi * (-1), b.sales_gross_val_wawi)               AS val_rtl_wawi,
Coalesce(d.val_rtl_net_wawi * (-1), b.sales_net_val_wawi)             AS val_rtl_net_wawi,
b.sales_gross_val_pos                                                 AS val_rtl_ejr,
CASE WHEN Coalesce(c.client_id, d.client_id) IS NOT NULL
        THEN NULL
        ELSE b.sales_net_val_pos
   END                                                                   AS val_rtl_net_ejr,
CASE WHEN Coalesce(c.client_id, d.client_id) IS NOT NULL
        THEN NULL
        ELSE b.sales_gross_val_txj_store
   END                                                                   AS val_rtl_txj_str,
CASE WHEN Coalesce(c.client_id, d.client_id) IS NOT NULL
        THEN NULL
        ELSE b.sales_net_val_txj_store
   END                                                                   AS val_rtl_net_txj_str,
Coalesce(c.val_rtl_txj_item, b.vat_val_txj)                           AS val_rtl_txj_item,
Coalesce
   (
      c.val_rtl_net_txj_item
     ,CASE WHEN Coalesce(c.client_id, d.client_id) IS NOT NULL
           THEN NULL
           ELSE b.vat_val_txj_net
      END
   )                                                                     AS val_rtl_net_txj_item,
b.vat_val_pos                                                         AS val_vatamount_ejr,
Coalesce(c.val_rtl_txj_item, b.vat_val_txj)                           AS val_vatamount_txj,
CASE WHEN Coalesce(c.client_id,d.client_id) IS NOT NULL
        THEN NULL
        ELSE b.vat_val_txj_net
   END                                                                   AS val_vatamount_net_txj,
Coalesce(c.val_vatamount_vatsum_txj,b.vat_val_txj_vatsum)             AS val_vatamount_vatsum_txj
FROM p_lew_core_ac.v_location_2 AS a

INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cali
ON cali.cal_dt BETWEEN DATE'2014-01-01' AND Current_Date + 1

LEFT OUTER JOIN p_lew_bil.v_agg_pos_txj_wawi_store_day_2 AS b
ON b.client_id = a.client_id
  AND b.loc_sid = a.loc_sid
  AND b.dwh_cal_dt = cali.cal_dt

LEFT OUTER JOIN
(SELECT
y.client_id,
y.loc_sid,
y.dat_formdate,
y.val_rtl_txj_item,
y.val_rtl_net_txj_item,
y.val_vatamount_vatsum_txj,
z.cnt_receipts_sales
FROM
(SELECT
a.client_id,
a.loc_sid,
a.dwh_cal_dt AS dat_formdate,
Sum(a.actual_sales_val) AS val_rtl_txj_item,
Sum(a.actual_sales_val-x.tax_val) AS val_rtl_net_txj_item,
Sum(x.tax_val) AS val_vatamount_vatsum_txj
FROM p_lew_core_ac.v_pos_agg_sales_2 a

INNER JOIN p_lew_core_ac.v_item_hist_2 AS d
ON a.client_id = d.client_id
  AND a.item_sid = d.item_sid
  AND CURRENT_DATE BETWEEN d.dwh_valid_from AND d.dwh_valid_to

LEFT OUTER JOIN p_lew_core_ac.v_item_type_2 AS e
ON e.client_id = d.client_id
  AND e.item_type_sid = d.item_type_sid

/* Zu ignorierende Artikelarten */
LEFT OUTER JOIN p_lew_process_ac.v_item_type_ignore_2 ig
ON e.client_id = ig.client_id
  AND e.src_mtart = ig.item_type_cd
  AND (
    ig.item_type_grp_cd IN ('BAGLEVY')
    OR (ig.client_id = 33 AND ig.item_type_cd  IN ('ZGIF'))
  )

LEFT OUTER JOIN
(SELECT
client_id,
aggr_nr,
aggr_rec_nr,
Sum(tax_val) AS tax_val
FROM p_lew_core_ac.v_pos_agg_vat_2
      GROUP BY 1,2,3
    ) x
    ON x.client_id = a.client_id
      AND x.aggr_nr = a.aggr_nr
      AND x.aggr_rec_nr = a.aggr_rec_id

    WHERE ig.item_type_sid IS NULL /* Gefilterte Artikelarten */
    GROUP BY 1,2,3
  ) y

  LEFT OUTER JOIN
  (SELECT
client_id,
loc_sid,
dwh_cal_dt,
Sum(cnt_receipts_sales) AS cnt_receipts_sales
FROM p_lew_core_ac.v_pos_agg_bon_cnts_2
    GROUP BY 1,2,3
  ) z
  ON z.client_id = y.client_id
    AND z.loc_sid = y.loc_sid
    AND z.dwh_cal_dt = y.dat_formdate

) c
ON c.client_id = a.client_id
  AND c.loc_sid = a.loc_sid
  AND c.dat_formdate = cali.cal_dt

LEFT OUTER JOIN
(SELECT
b.client_id,
b.loc_sid,
b.dwh_cal_dt AS dat_formdate,
Sum
     (
       CASE WHEN c.cond_type_cd IN('ZPRA','ZPRP')
                 AND e.src_mtart IN ('ZVM', 'ZKM')
                 AND a.invoice_class_cd = 'ZFPU'
            THEN (b.cond_subtotal_2 - b.cond_subtotal_1)
            WHEN b.client_id NOT IN (33)
                 AND e.src_mtart IN ('ZVM','ZKM')
                 AND a.invoice_class_cd = 'ZFPU'
            THEN 0
            WHEN b.client_id IN (33)
                 AND e.src_mtart IN ('ZGIF')
            THEN 0                 
            ELSE (b.net_val + b.tax_val)
       END
     ) AS val_rtl_wawi,
Sum
     (
       CASE WHEN c.cond_type_cd IN('ZPRA','ZPRP')
                 AND e.src_mtart IN ('ZVM', 'ZKM')
                 AND a.invoice_class_cd = 'ZFPU'
            -- for commission sales_2 which are condition= ZPRA (e.g. prepaid cell phone cards) no VAT is included, that is why gross = net in this CASE
            THEN (b.cond_subtotal_2 - b.cond_subtotal_1) - CASE WHEN b.dwh_cal_dt < TO_DATE('2018-01-20', 'YYYY-MM_2-DD') THEN 0 ELSE b.tax_val END  -- b.tax_val will be subtracted starting from 20.01.2018
            WHEN b.client_id NOT IN (33)
                 AND e.src_mtart IN ('ZVM','ZKM')
                 AND a.invoice_class_cd = 'ZFPU'
            THEN 0
            WHEN b.client_id IN (33)
                 AND e.src_mtart IN ('ZGIF')
            THEN 0        
            ELSE b.net_val
       END
     ) AS val_rtl_net_wawi
FROM p_lew_core_ac.v_retail_sales_record_2 AS a

INNER JOIN p_lew_core_ac.v_retail_sales_record_pos_2 AS b
ON b.client_id = a.client_id
  AND b.retail_sales_record_id = a.retail_sales_record_id
  AND b.dwh_cal_dt = a.dwh_cal_dt

LEFT OUTER JOIN p_lew_core_ac.v_retail_sales_record_pos_cond_2 AS c
ON c.client_id = b.client_id
  AND c.retail_sales_record_id = b.retail_sales_record_id
  AND c.retail_sales_record_pos_id = b.retail_sales_record_pos_id
  AND c.dwh_cal_dt = b.dwh_cal_dt
  AND c.cond_type_cd IN('ZPRA','ZPRP')

LEFT OUTER JOIN p_lew_core_ac.v_item_hist_2 AS d
ON b.client_id = d.client_id
  AND b.item_sid = d.item_sid
  AND CURRENT_DATE BETWEEN d.dwh_valid_from AND d.dwh_valid_to

LEFT OUTER JOIN p_lew_core_ac.v_item_type_2 AS e
ON e.client_id = d.client_id
  AND e.item_type_sid = d.item_type_sid

/* Zu ignorierende Artikelarten */
LEFT OUTER JOIN p_lew_process_ac.v_item_type_ignore_2 ig
ON e.client_id = ig.client_id
  AND e.src_mtart = ig.item_type_cd
  AND (
    ig.item_type_grp_cd IN ('BAGLEVY')
    OR (ig.client_id = 33 AND ig.item_type_cd  IN ('ZGIF'))
  )

/*
Inter-Company Umsätze mussen ausgeschlossen werden
ZF92 und ZS92 dürfen beim Umsatz nicht beruecksichtigt werden
ZF92: Retoure an Lieferant
ZS92: Storno-Retoure an Lieferant
*/
WHERE a.invoice_class_cd NOT IN ('ZF91','ZS01','ZF92','ZS92')
  AND ig.item_type_sid IS NULL /* Gefilterte Artikelarten */

GROUP BY 1,2,3
) d
ON d.client_id = a.client_id
AND d.loc_sid = a.loc_sid
AND d.dat_formdate = cali.cal_dt

WHERE b.loc_sid IS NOT NULL
OR c.loc_sid IS NOT NULL
OR d.loc_sid IS NOT NULL
;


