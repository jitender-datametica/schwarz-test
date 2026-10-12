CREATE OR REPLACE VIEW p_lew_mart_msi.v_despatch_advice_item_wh_receiving AS
SELECT 
 rec.client_id                                      AS client_id
,loc.src_wh_id                                      AS wh_id
,rec.sup_sid                                        AS sup_sid
,rec.dat_entry_rcv                                  AS item_rcv_dt
,cal.cy_week                                        AS cy_week
,cal.cy_month                                       AS cy_month
,cal.busyear                                        AS byr
,gln.global_location_nr                             AS global_location_nr
,gln.name1                                          AS supplier_name
,CAST(gln.src_orig_supplier_nr AS DECIMAL(18,0))    AS src_orig_supplier_nr
,COUNT(DISTINCT rec.orig_receipt_id_rcv)            AS we_count_ges
FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving rec
INNER JOIN p_lew_core_ac.v_cal_calendarday cal
ON rec.dat_entry_rcv = cal.cal_dt
INNER JOIN p_lew_core_ac.v_location AS loc
ON rec.client_id = loc.client_id
AND rec.wh_loc_sid = loc.loc_sid
INNER JOIN p_lew_bil_ac.v_supplier AS gln
ON  rec.client_id = gln.client_id
AND rec.sup_sid = gln.sup_sid
WHERE rec.receipttype_id = 1  AND cal.cy_month_seq >= -24  
GROUP BY 
rec.client_id
, loc.src_wh_id
, rec.sup_sid
, rec.dat_entry_rcv
, cal.cy_week
, cal.cy_month
, cal.busyear
, gln.global_location_nr                                           
, gln.name1    
, gln.src_orig_supplier_nr
QUALIFY ROW_NUMBER() OVER(PARTITION BY rec.client_id,loc.src_wh_id,rec.sup_sid,rec.dat_entry_rcv
ORDER BY dat_entry_rcv) = 1
;