CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SUP_SUPPLIER_DESPATCH_ADVICE_RATE AS
SELECT
  loc.client_id                                                                         AS client_id         
, loc.country_pol_cd                                                                    AS country_pol_cd
, loc.src_wh_id                                                                         AS wh_id
, loc.loc_name                                                                          AS location_name
, con.contact_medium_cd                                                                 AS contact_medium
, con.contact_medium_descr                                                              AS contact_medium_desc 
, pur.sup_contact_purpose_descr                                                         AS contact_medium_purpose 
, all_cnt.item_rcv_dt                                                                   AS item_rcv_dt 
, cal.cy_week                                                                           AS cy_week
, cal.cy_month                                                                          AS cy_month
, cal.busyear                                                                           AS byr
, hist.sup_sid                                                                          AS sup_sid
, CAST(gln.src_orig_supplier_nr AS DECIMAL(18,0))                                       AS src_orig_supplier_nr
, gln.global_location_nr                                                                AS global_location_nr
, gln.name1                                                                             AS supplier_name
, hist.contact_last_changed_dt                                                          AS contact_last_changed_dt
, COALESCE(SUM(avis_cnt),0)                                                             AS avis_count
, COALESCE(SUM(we_cnt),0)                                                               AS we_count
, COALESCE(SUM(CASE WHEN con.contact_medium_descr = 'EDI' AND 
  pur.sup_contact_purpose_descr = 'EDI-Lieferavis' AND 
  all_cnt.item_rcv_dt >= COALESCE(hist.contact_last_changed_dt, 
  Cast('9999-12-31' AS DATE)) THEN we_cnt 
  ELSE 0 END),0)                                                                        AS we_count_edi
, COALESCE(SUM(avis_used),0)                                                            AS avis_used

, (SELECT MAX(hist.contact_last_changed_dt) 
  FROM p_lew_core_ac.v_supplier_contact_hist hist
  INNER JOIN p_lew_core_ac.v_ref_contact_medium AS med
  ON hist.contact_medium_cd = med.contact_medium_cd
  INNER JOIN p_lew_core_ac.v_ref_supplier_contact_purpose AS pp
  ON hist.sup_contact_purpose_sid = pp.sup_contact_purpose_sid
  WHERE med.contact_medium_descr = 'EDI' 
  AND pp.sup_contact_purpose_descr = 'EDI-Lieferavis' 
  AND hist.contact_active_fg > 0 AND hist.sup_sid = all_cnt.sup_sid
  AND CURRENT_DATE BETWEEN hist.dwh_valid_from AND hist.dwh_valid_to) AS avis_valid_from
  
, (SELECT MAX(hist.contact_last_changed_dt) 
  FROM p_lew_core_ac.v_supplier_contact_hist hist
  INNER JOIN p_lew_core_ac.v_ref_contact_medium AS med
  ON hist.contact_medium_cd = med.contact_medium_cd
  INNER JOIN p_lew_core_ac.v_ref_supplier_contact_purpose AS pp
  ON hist.sup_contact_purpose_sid = pp.sup_contact_purpose_sid
  WHERE med.contact_medium_descr = 'EDI' 
  AND pp.sup_contact_purpose_descr = 'EDI-Bestellung' 
  AND hist.contact_active_fg > 0 AND hist.sup_sid = all_cnt.sup_sid
  AND CURRENT_DATE BETWEEN hist.dwh_valid_from AND hist.dwh_valid_to) AS free_delivery_order_valid_from 

, (SELECT MAX(hist.contact_last_changed_dt) 
  FROM p_lew_core_ac.v_supplier_contact_hist hist
  INNER JOIN p_lew_core_ac.v_ref_contact_medium AS med
  ON hist.contact_medium_cd = med.contact_medium_cd
  INNER JOIN p_lew_core_ac.v_ref_supplier_contact_purpose AS pp
  ON hist.sup_contact_purpose_sid = pp.sup_contact_purpose_sid
  WHERE med.contact_medium_descr = 'EDI' 
  AND pp.sup_contact_purpose_descr = 'EDI-Sammellogistik' 
  AND hist.contact_active_fg > 0 AND hist.sup_sid = all_cnt.sup_sid
  AND CURRENT_DATE BETWEEN hist.dwh_valid_from AND hist.dwh_valid_to) AS crossdocking_order_valid_from

, (SELECT MAX(hist.contact_last_changed_dt) 
  FROM p_lew_core_ac.v_supplier_contact_hist hist
  INNER JOIN p_lew_core_ac.v_ref_contact_medium AS med
  ON hist.contact_medium_cd = med.contact_medium_cd
  INNER JOIN p_lew_core_ac.v_ref_supplier_contact_purpose AS pp
  ON hist.sup_contact_purpose_sid = pp.sup_contact_purpose_sid
  WHERE med.contact_medium_descr = 'EDI' 
  AND pp.sup_contact_purpose_descr = 'EDI-Direktlogistik' 
  AND hist.contact_active_fg > 0 AND hist.sup_sid = all_cnt.sup_sid
  AND CURRENT_DATE BETWEEN hist.dwh_valid_from AND hist.dwh_valid_to) AS direct_order_valid_from
  
FROM p_lew_core_ac.v_location AS loc 

INNER JOIN p_lew_core_ac.v_supplier_contact_hist  AS hist 
ON  loc.client_id = hist.client_id
AND loc.loc_sid = hist.loc_sid_wh

INNER JOIN p_lew_core_ac.v_ref_contact_medium AS con
ON  hist.contact_medium_cd = con.contact_medium_cd

INNER JOIN p_lew_core_ac.v_ref_supplier_contact_purpose AS pur  
ON  hist.sup_contact_purpose_sid = pur.sup_contact_purpose_sid

INNER JOIN p_lew_bil_ac.v_supplier AS gln
ON  loc.client_id = gln.client_id
AND hist.sup_sid = gln.sup_sid

INNER JOIN    
    /* put together the counts using full outer join */    
    (
    SELECT 
     COALESCE(adv.client_id,cou.client_id)      AS client_id
    ,COALESCE(adv.loc_sid_wh,cou.wh_loc_sid)    AS loc_sid_wh
    ,COALESCE(adv.sup_sid,cou.sup_sid)          AS sup_sid
    ,COALESCE(adv.est_deliv_dt,cou.dat_formdate) AS item_rcv_dt
    ,adv.avis_cnt
    ,cou.we_cnt
    ,dist_cou.avis_used
    FROM       
    (
    SELECT 
    client_id
    ,loc_sid_wh
    ,sup_sid
    ,est_deliv_dt
    ,COUNT(*)                                   AS avis_cnt 
    FROM p_lew_core_ac.v_despatch_advice 
    GROUP BY client_id,loc_sid_wh,sup_sid,est_deliv_dt
    ) adv   
    
    FULL OUTER JOIN    
    (
  SELECT 
  client_id,wh_loc_sid,sup_sid,dat_formdate 
    ,COUNT(DISTINCT receipt_id_rcv)            AS we_cnt 
    FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving
    WHERE receipt_id_rcv < 5000000 AND receipttype_id=1
       GROUP BY client_id, wh_loc_sid,sup_sid,dat_formdate
    QUALIFY ROW_NUMBER() OVER(PARTITION BY client_id,wh_loc_sid,sup_sid,dat_formdate
    ORDER BY dat_formdate) = 1
    ) cou
    ON  adv.client_id = cou.client_id
    AND adv.loc_sid_wh = cou.wh_loc_sid
    AND adv.sup_sid = cou.sup_sid
    AND adv.est_deliv_dt = cou.dat_formdate
    
    LEFT OUTER JOIN    
    (
   SELECT 
  client_id, loc_sid_wh,sup_sid,item_rcv_dt  
    ,COUNT(DISTINCT rcv_receipt_id)            AS avis_used 
    FROM p_lew_core_ac.v_item_receiving_count 
    WHERE rcv_receipt_id < 5000000 AND despatch_advice_id IS NOT NULL 
       GROUP BY client_id, loc_sid_wh,sup_sid,item_rcv_dt 
    QUALIFY ROW_NUMBER() OVER(PARTITION BY client_id, loc_sid_wh,sup_sid,item_rcv_dt     
    ORDER BY item_rcv_dt) = 1
    ) dist_cou
    ON  dist_cou.client_id = cou.client_id
    AND dist_cou.loc_sid_wh = cou.wh_loc_sid
    AND dist_cou.sup_sid = cou.sup_sid
    AND dist_cou.item_rcv_dt = cou.dat_formdate
    ) all_cnt

INNER JOIN p_lew_core_ac.v_cal_calendarday AS cal
ON cal.cal_dt = all_cnt.item_rcv_dt
    
ON  hist.client_id = all_cnt.client_id
AND hist.loc_sid_wh = all_cnt.loc_sid_wh
AND hist.sup_sid = all_cnt.sup_sid

WHERE ((con.contact_medium_descr = 'EDI' 
AND pur.sup_contact_purpose_descr = 'EDI-Lieferavis')  OR con.contact_medium_descr <> 'EDI' 
AND avis_valid_from IS NULL)  
AND all_cnt.item_rcv_dt >= '2020-03-01' 
AND hist.contact_active_fg > 0 AND gln.actual_fg_supplier = 1
AND CURRENT_DATE BETWEEN hist.dwh_valid_from AND hist.dwh_valid_to
GROUP BY
loc.client_id                  
, loc.country_pol_cd             
, loc.src_wh_id                  
, loc.loc_name                   
, con.contact_medium_cd          
, con.contact_medium_descr       
, pur.sup_contact_purpose_descr  
, all_cnt.item_rcv_dt
, cal.cy_week
, cal.cy_month
, cal.busyear
, hist.sup_sid   
, gln.src_orig_supplier_nr
, gln.global_location_nr         
, gln.name1                      
, hist.contact_last_changed_dt 
, avis_valid_from
, free_delivery_order_valid_from 
, crossdocking_order_valid_from
, direct_order_valid_from
;