/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_STORE_WRITEOFF_DAY_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-12    Ulrich ross          Remove eLWIS logic
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=488527
#  2.0  2024-04-24    Camila Arango        Netto/Brutto Anpassung aus INC6999325 & INC7961134
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_STORE_WRITEOFF_DAY_DELTA_2
AS										
SELECT						
	 client_ AS client_id					
  ,land_ AS country_lidl_cd						
  ,orig_store_nr AS store						
  ,receiptdate						
  ,item_2						
  ,CAST(SUM(writeoff_value_total)  AS DECIMAL(18,3)) AS writeoff_value_net						
  ,CAST(SUM(writeoff_amount_total) AS DECIMAL(18,5)) AS writeoff_pieces						
  ,storeform_type_ AS storeform_type						
  ,writeoff_zero_fg_net AS writeoff_zero_fg						
  ,MAX(load_id) AS load_id						
FROM						
(						
  SELECT						
     itm_mov.sfo_type_id                                                                    AS storeform_type_					
    ,itm_mov.client_id                                                                      AS client_						
    ,clients.src_country_lidl_cd                                                             AS land_						
    ,loc.src_wh_id                                                                          AS wh_id						
    ,loc.src_orig_store_nr                                                                  AS orig_store_nr						
    ,itm_mov.dwh_cal_dt                                                                     AS receiptdate						
    ,CAST(item.src_orig_item_nr AS INTEGER)                                                 AS item_2						
    ,item.src_case_size                                                                     AS inhaltkolli						
    ,SUM(itm_mov.case_qty)                                                                  AS mengekolli						
    ,SUM(CASE WHEN (itm_mov.piece_qty IS NULL) THEN 0 ELSE itm_mov.piece_qty END)           AS mengestck						
    ,mengekolli * inhaltkolli  + mengestck                                                  AS total_berechnet						
    ,SUM(itm_mov.total_qty) * -1                                                            AS writeoff_amount_total						
    ,itm_mov.wh_gross_price                                                                 AS wertstck						
    ,SUM(itm_mov.receipt_line_net_val) * -1                                                 AS writeoff_value_total						
    ,CASE WHEN ((itm_mov.wh_net_price <> 0 AND itm_mov.new_net_price  = 0)                        
     OR (itm_mov.wh_net_price = 0 AND itm_mov.new_net_price <> 0)) THEN 1 ELSE 0 END        AS writeoff_zero_fg_net						
    ,MAX(itm_mov.dwh_load_id)                                                               AS load_id						
  FROM p_lew_core_ac.v_store_form_2 itm_mov						
						
  INNER JOIN p_lew_core_ac.v_location_2 loc						
  ON itm_mov.loc_sid_store = loc.loc_sid						
	AND itm_mov.client_id = loc.client_id					
	AND loc.wh_store_mark = 'A'					
						
  INNER JOIN p_lew_core_ac.v_item_2 item_2						
  ON itm_mov.item_sid = item.item_sid						
	AND itm_mov.client_id = item.client_id					
						
  INNER JOIN p_lew_core_ac.v_client_2 clients 						
  ON itm_mov.client_id = clients.client_id						
						
  INNER JOIN						
  (						
	 SELECT					
        itm_mov.client_id						
       ,itm_mov.loc_sid_store						
	   ,itm_mov.dwh_cal_dt					
     FROM p_lew_core_ac.v_store_form_2 itm_mov						
						
	 INNER JOIN p_lew_process_ac.v_wfm_last_export_2 last_expo					
	 ON itm_mov.dwh_updated > last_expo.last_export_tmsp					
	   AND last_expo.process_name = 'export_wfm_store_writeoff_day'					
       AND last_expo.process_specification = 'delta'						
       AND itm_mov.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1						
       AND itm_mov.sfo_type_id IN (137,147,181,182,191,192)						
						
	 INNER JOIN p_lew_process_ac.v_wfm_export_specification_2 expo_spec					
	 ON last_expo.export_specification = expo_spec.export_specification					
       AND itm_mov.client_id = expo_spec.client_id						
						
	 GROUP BY					
	    itm_mov.client_id					
       ,itm_mov.loc_sid_store						
       ,itm_mov.dwh_cal_dt						
  ) AS delta_filter 						
  ON itm_mov.client_id = delta_filter.client_id						
    AND itm_mov.loc_sid_store = delta_filter.loc_sid_store						
    AND itm_mov.dwh_cal_dt = delta_filter.dwh_cal_dt						
						
  WHERE itm_mov.sfo_type_id IN (137,147,181,182,191,192)						
						
  GROUP BY 1,2,3,4,5,6,7,8,13,15						
) sub						
						
GROUP BY 1,2,3,4,5,8,9						
;