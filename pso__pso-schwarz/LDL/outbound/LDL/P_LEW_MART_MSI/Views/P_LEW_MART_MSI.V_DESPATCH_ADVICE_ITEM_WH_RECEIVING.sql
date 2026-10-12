CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_despatch_advice_item_wh_receiving AS SELECT REC.client_id,
 LOC.src_wh_id AS wh_id,
 REC.sup_sid,
 REC.dat_entry_rcv AS item_rcv_dt,
 CAL.cy_week,
 CAL.cy_month,
 CAL.busyear AS byr,
 GLN.global_location_nr,
 GLN.name1 AS supplier_name,
 ROUND(CAST(GLN.src_orig_supplier_nr AS BIGNUMERIC), 0) AS src_orig_supplier_nr,
 COUNT(DISTINCT REC.orig_receipt_id_rcv) AS we_count_ges
FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving AS REC
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON REC.dat_entry_rcv = CAL.cal_dt
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON REC.client_id = LOC.client_id AND REC.wh_loc_sid = LOC.loc_sid
 INNER JOIN ldl_p_lew_bil_ac.v_supplier AS GLN ON REC.client_id = GLN.client_id AND REC.sup_sid = GLN.sup_sid
WHERE REC.receipttype_id = 1
 AND CAL.cy_month_seq >= - 24
GROUP BY REC.client_id,
 wh_id,
 REC.sup_sid,
 item_rcv_dt,
 CAL.cy_week,
 CAL.cy_month,
 byr,
 GLN.global_location_nr,
 supplier_name,
 GLN.src_orig_supplier_nr
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(REC.client_id AS STRING), CAST(wh_id AS STRING), CAST(REC.sup_sid AS STRING)
      , item_rcv_dt ORDER BY item_rcv_dt IS NULL, item_rcv_dt)) = 1;