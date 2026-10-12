CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sup_supplier_despatch_advice_rate_1 AS
/* put together the counts using full outer CROSS JOIN */ SELECT LOC.client_id,
 LOC.country_pol_cd,
 LOC.src_wh_id AS wh_id,
 LOC.loc_name AS location_name,
 CON.contact_medium_cd AS contact_medium,
 CON.contact_medium_descr AS contact_medium_desc,
 PUR.sup_contact_purpose_descr AS contact_medium_purpose,
 all_cnt.item_rcv_dt,
 CAL.cy_week,
 CAL.cy_month,
 CAL.busyear AS byr,
 HIST.sup_sid,
 ROUND(CAST(GLN.src_orig_supplier_nr AS BIGNUMERIC), 0) AS src_orig_supplier_nr,
 GLN.global_location_nr,
 GLN.name1 AS supplier_name,
 HIST.contact_last_changed_dt,
 COALESCE(SUM(all_cnt.avis_cnt), 0) AS avis_count,
 COALESCE(SUM(all_cnt.we_cnt), 0) AS we_count,
 SUM(CASE
   WHEN CON.contact_medium_descr = 'EDI' AND PUR.sup_contact_purpose_descr = 'EDI-Lieferavis' AND all_cnt.item_rcv_dt >=
     COALESCE(HIST.contact_last_changed_dt, DATE('9999-12-31'))
   THEN CAST(all_cnt.we_cnt AS INTEGER)
   ELSE 0
   END) AS we_count_edi,
 COALESCE(SUM(all_cnt.avis_used), 0) AS avis_used,
  (SELECT MAX(HIST1.contact_last_changed_dt)
  FROM ldl_p_lew_core_ac.v_supplier_contact_hist_1 AS HIST1
   INNER JOIN ldl_p_lew_core_ac.v_ref_contact_medium_1 AS MED0 ON HIST1.contact_medium_cd = MED0.contact_medium_cd
   INNER JOIN ldl_p_lew_core_ac.v_ref_supplier_contact_purpose_1 AS PP0 ON HIST1.sup_contact_purpose_sid = PP0.sup_contact_purpose_sid
    
  WHERE MED0.contact_medium_descr = 'EDI'
   AND PP0.sup_contact_purpose_descr = 'EDI-Lieferavis'
   AND HIST1.contact_active_fg > 0
   AND HIST1.sup_sid = all_cnt.sup_sid
   AND CURRENT_DATE BETWEEN HIST1.dwh_valid_from AND HIST1.dwh_valid_to) AS avis_valid_from,
  (SELECT MAX(HIST2.contact_last_changed_dt)
  FROM ldl_p_lew_core_ac.v_supplier_contact_hist_1 AS HIST2
   INNER JOIN ldl_p_lew_core_ac.v_ref_contact_medium_1 AS MED1 ON HIST2.contact_medium_cd = MED1.contact_medium_cd
   INNER JOIN ldl_p_lew_core_ac.v_ref_supplier_contact_purpose_1 AS PP1 ON HIST2.sup_contact_purpose_sid = PP1.sup_contact_purpose_sid
    
  WHERE MED1.contact_medium_descr = 'EDI'
   AND PP1.sup_contact_purpose_descr = 'EDI-Bestellung'
   AND HIST2.contact_active_fg > 0
   AND HIST2.sup_sid = all_cnt.sup_sid
   AND CURRENT_DATE BETWEEN HIST2.dwh_valid_from AND HIST2.dwh_valid_to) AS free_delivery_order_valid_from,
  (SELECT MAX(HIST3.contact_last_changed_dt)
  FROM ldl_p_lew_core_ac.v_supplier_contact_hist_1 AS HIST3
   INNER JOIN ldl_p_lew_core_ac.v_ref_contact_medium_1 AS MED2 ON HIST3.contact_medium_cd = MED2.contact_medium_cd
   INNER JOIN ldl_p_lew_core_ac.v_ref_supplier_contact_purpose_1 AS PP2 ON HIST3.sup_contact_purpose_sid = PP2.sup_contact_purpose_sid
    
  WHERE MED2.contact_medium_descr = 'EDI'
   AND PP2.sup_contact_purpose_descr = 'EDI-Sammellogistik'
   AND HIST3.contact_active_fg > 0
   AND HIST3.sup_sid = all_cnt.sup_sid
   AND CURRENT_DATE BETWEEN HIST3.dwh_valid_from AND HIST3.dwh_valid_to) AS crossdocking_order_valid_from,
  (SELECT MAX(HIST4.contact_last_changed_dt)
  FROM ldl_p_lew_core_ac.v_supplier_contact_hist_1 AS HIST4
   INNER JOIN ldl_p_lew_core_ac.v_ref_contact_medium_1 AS MED3 ON HIST4.contact_medium_cd = MED3.contact_medium_cd
   INNER JOIN ldl_p_lew_core_ac.v_ref_supplier_contact_purpose_1 AS PP3 ON HIST4.sup_contact_purpose_sid = PP3.sup_contact_purpose_sid
    
  WHERE MED3.contact_medium_descr = 'EDI'
   AND PP3.sup_contact_purpose_descr = 'EDI-Direktlogistik'
   AND HIST4.contact_active_fg > 0
   AND HIST4.sup_sid = all_cnt.sup_sid
   AND CURRENT_DATE BETWEEN HIST4.dwh_valid_from AND HIST4.dwh_valid_to) AS direct_order_valid_from
FROM ldl_p_lew_core_ac.v_location_1 AS LOC
 INNER JOIN ldl_p_lew_core_ac.v_supplier_contact_hist_1 AS HIST ON LOC.client_id = HIST.client_id AND LOC.loc_sid = HIST.loc_sid_wh
   
 INNER JOIN ldl_p_lew_core_ac.v_ref_contact_medium_1 AS CON ON HIST.contact_medium_cd = CON.contact_medium_cd
 INNER JOIN ldl_p_lew_core_ac.v_ref_supplier_contact_purpose_1 AS PUR ON HIST.sup_contact_purpose_sid = PUR.sup_contact_purpose_sid
  
 INNER JOIN ldl_p_lew_bil_ac.v_supplier_1 AS GLN ON LOC.client_id = GLN.client_id AND HIST.sup_sid = GLN.sup_sid
 INNER JOIN ((SELECT COALESCE(adv.client_id, cou.client_id) AS client_id,
    COALESCE(adv.loc_sid_wh, cou.wh_loc_sid) AS loc_sid_wh,
    COALESCE(adv.sup_sid, cou.sup_sid) AS sup_sid,
    COALESCE(adv.est_deliv_dt, cou.dat_formdate) AS item_rcv_dt,
    adv.avis_cnt,
    cou.we_cnt,
    dist_cou.avis_used
   FROM (SELECT client_id,
      loc_sid_wh,
      sup_sid,
      est_deliv_dt,
      COUNT(*) AS avis_cnt
     FROM ldl_p_lew_core_ac.v_despatch_advice_1
     GROUP BY client_id,
      loc_sid_wh,
      sup_sid,
      est_deliv_dt) AS adv
    FULL JOIN (SELECT client_id,
      wh_loc_sid,
      sup_sid,
      dat_formdate,
      COUNT(DISTINCT receipt_id_rcv) AS we_cnt
     FROM ldl_p_lew_core_ac.v_wawi_mov_item_wh_receiving_1
     WHERE receipt_id_rcv < 5000000
      AND receipttype_id = 1
     GROUP BY client_id,
      wh_loc_sid,
      sup_sid,
      dat_formdate
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_loc_sid AS STRING), CAST(sup_sid AS STRING)
           , dat_formdate ORDER BY dat_formdate IS NULL, dat_formdate)) = 1) AS cou ON adv.client_id = cou.client_id AND
        adv.loc_sid_wh = cou.wh_loc_sid AND adv.sup_sid = cou.sup_sid AND adv.est_deliv_dt = cou.dat_formdate
    LEFT JOIN (SELECT client_id,
      loc_sid_wh,
      sup_sid,
      item_rcv_dt,
      COUNT(DISTINCT rcv_receipt_id) AS avis_used
     FROM ldl_p_lew_core_ac.v_item_receiving_count_1
     WHERE rcv_receipt_id < 5000000
      AND despatch_advice_id IS NOT NULL
     GROUP BY client_id,
      loc_sid_wh,
      sup_sid,
      item_rcv_dt
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_wh AS STRING), CAST(sup_sid AS STRING)
           , item_rcv_dt ORDER BY item_rcv_dt IS NULL, item_rcv_dt)) = 1) AS dist_cou ON cou.client_id = dist_cou.client_id
         AND cou.wh_loc_sid = dist_cou.loc_sid_wh AND cou.sup_sid = dist_cou.sup_sid AND cou.dat_formdate = dist_cou.item_rcv_dt
      ) AS all_cnt INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON all_cnt.item_rcv_dt = CAL.cal_dt) ON HIST.client_id
     = all_cnt.client_id AND HIST.loc_sid_wh = all_cnt.loc_sid_wh AND HIST.sup_sid = all_cnt.sup_sid
WHERE (CON.contact_medium_descr = 'EDI' AND PUR.sup_contact_purpose_descr = 'EDI-Lieferavis' OR CON.contact_medium_descr
      <> 'EDI' AND (SELECT MAX(HIST0.contact_last_changed_dt)
     FROM ldl_p_lew_core_ac.v_supplier_contact_hist_1 AS HIST0
      INNER JOIN ldl_p_lew_core_ac.v_ref_contact_medium_1 AS MED ON HIST0.contact_medium_cd = MED.contact_medium_cd
      INNER JOIN ldl_p_lew_core_ac.v_ref_supplier_contact_purpose_1 AS PP ON HIST0.sup_contact_purpose_sid = PP.sup_contact_purpose_sid
       
     WHERE MED.contact_medium_descr = 'EDI'
      AND PP.sup_contact_purpose_descr = 'EDI-Lieferavis'
      AND HIST0.contact_active_fg > 0
      AND HIST0.sup_sid = all_cnt.sup_sid
      AND CURRENT_DATE BETWEEN HIST0.dwh_valid_from AND HIST0.dwh_valid_to) IS NULL)
 AND all_cnt.item_rcv_dt >= DATE '2020-03-01'
 AND HIST.contact_active_fg > 0
 AND GLN.actual_fg_supplier = 1
 AND CURRENT_DATE BETWEEN HIST.dwh_valid_from AND HIST.dwh_valid_to
GROUP BY LOC.client_id,
 LOC.country_pol_cd,
 wh_id,
 location_name,
 contact_medium,
 contact_medium_desc,
 contact_medium_purpose,
 all_cnt.item_rcv_dt,
 CAL.cy_week,
 CAL.cy_month,
 byr,
 HIST.sup_sid,
 GLN.src_orig_supplier_nr,
 GLN.global_location_nr,
 supplier_name,
 HIST.contact_last_changed_dt,
 avis_valid_from,
 free_delivery_order_valid_from,
 crossdocking_order_valid_from,
 direct_order_valid_from;