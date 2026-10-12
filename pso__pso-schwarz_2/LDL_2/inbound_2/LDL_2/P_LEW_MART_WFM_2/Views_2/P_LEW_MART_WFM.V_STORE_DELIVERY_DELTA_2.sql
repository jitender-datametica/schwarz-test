/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_STORE_DELIVERY_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-12    Ulrich ross          Remove eLWIS logic
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=488527
#  1.0  2023-07-17    Ulrich ross          Bugfix column name
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=503083
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_STORE_DELIVERY_DELTA_2						
AS		

SELECT						
   client_ AS client_id				
  ,land_2 AS country_lidl_cd				
  ,store AS store				
  ,receiptdate AS receiptdate				
  ,item_2 AS item_2				
  ,CAST(SUM(sum_qty_piece)  AS DECIMAL(18,5)) AS qty_piece_del				
  ,CAST(SUM(sum_qty_kolli)  AS DECIMAL(18,5)) AS qty_case_del				
  ,CAST(MIN(case_size_real) AS DECIMAL(18,5)) AS case_size_real				
  ,MIN(is_multiple_case_size) AS is_multiple_case_size				
  ,CAST(SUM(sum_qty_piece_real)  AS DECIMAL(18,5)) AS qty_piece_del_real				
  ,CAST(SUM(sum_qty_kolli_real)  AS DECIMAL(18,5)) AS qty_case_del_real				
  ,MAX(load_id) AS load_id				
FROM	 					
  (SELECT				
     inner_unions.client_id AS client_		
    ,clients.src_country_lidl_cd    AS land_2		
    ,loc.src_orig_store_nr  AS store		
    ,inner_unions.dat_formdate AS receiptdate		
    ,CAST(item.src_orig_item_nr AS INTEGER) AS  item_2		
    ,CAST(COALESCE(MIN(case_size_real) OVER (PARTITION BY inner_unions.client_id,inner_unions.item_sid,inner_unions.st_loc_sid, inner_unions.dat_formdate),NULL) AS DECIMAL(18,5))  AS case_size_real		
    ,CASE WHEN  (inner_unions.deliverytype_id = 1) THEN CAST(inner_unions.qty_case_order AS DECIMAL(36,10)) ELSE CAST(inner_unions.qty_case_del AS DECIMAL(36,10)) END mengekolli		
    ,CASE WHEN  (inner_unions.deliverytype_id IN (1, 3)) THEN CAST(inner_unions.qty_piece_del AS DECIMAL(36,10)) ELSE 0.00000 END AS mengestck		
    ,CAST(mengekolli * CASE WHEN CAST(item.src_case_size AS DECIMAL(15,2)) = -1		
                THEN CAST(skey_act.case_size AS DECIMAL(15,2))						
                ELSE CAST(item.src_case_size AS DECIMAL(15,2))						
                   END						
                 + mengestck AS DECIMAL(36,10)) AS sum_qty_piece						
    ,CAST(mengekolli + (mengestck / COALESCE (CASE WHEN CAST(item.src_case_size AS DECIMAL(15,2)) = -1		
                               THEN CAST(skey_act.case_size AS DECIMAL(15,2))						
                               ELSE CAST(item.src_case_size AS DECIMAL(15,2))						
                           END , 1)) AS DECIMAL(36,10)) AS sum_qty_kolli						
    ,CASE WHEN MIN(case_size_real) OVER (PARTITION BY inner_unions.client_id,inner_unions.item_sid,inner_unions.st_loc_sid, inner_unions.dat_formdate) <> MAX(case_size_real) OVER (PARTITION BY inner_unions.client_id,inner_unions.item_sid,inner_unions.st_loc_sid, inner_unions.dat_formdate) THEN 1 ELSE 0 END AS is_multiple_case_size		
    ,CASE WHEN inner_unions.from_fvm = 1 THEN CAST(mengekolli * case_size_real + mengestck AS DECIMAL(18,5)) ELSE CAST(NULL AS DECIMAL(18,5)) END AS sum_qty_piece_real		
    ,CASE WHEN inner_unions.from_fvm = 1 THEN CAST(mengekolli + (mengestck / COALESCE (CASE WHEN case_size_real = 0 THEN NULL ELSE case_size_real END, 1)) AS DECIMAL(36,10)) ELSE CAST(NULL AS DECIMAL(36,10)) END AS sum_qty_kolli_real		
    ,inner_unions.load_id		
  FROM				
	( SELECT		
       mov.client_id
      ,mov.item_sid
      ,mov.dwh_cal_dt AS dat_formdate
      ,mov.receipt_id AS receipt_id_del
      ,mov.loc_sid_store AS st_loc_sid
      ,mov.loc_sid_wh AS wh_loc_sid
      ,mov.vat_id
      ,mov.order_area_cd
      ,mov.dayend_dt AS dat_dayend
      ,mov.delivery_type_id AS deliverytype_id
      ,mov.del_case_qty AS qty_case_del
      ,mov.ordered_case_qty AS qty_case_order
      ,mov.del_piece_qty AS qty_piece_del
      ,mov.act_del_piece_qty AS qty_piece_act_del
      ,CAST(NULL AS DECIMAL(18,6)) AS case_size_real
      ,0 from_fvm
      ,mov.dwh_load_id AS load_id
    FROM p_lew_core_ac.v_item_delivery_2 mov		
						
    INNER JOIN (						
    /* timestamp delta with key logic */						
      SELECT 						
         mov_delta.client_id						
       , mov_delta.item_sid						
       , mov_delta.dwh_cal_dt						
       , mov_delta.loc_sid_store						
      FROM p_lew_core_ac.v_item_delivery_2 mov_delta						
                  
      INNER JOIN p_lew_process_ac.v_wfm_last_export_2 delta_itm_mov						
      ON delta_itm_mov.process_name = 'export_wfm_store_delivery'						
      AND delta_itm_mov.process_specification = 'delta'						
      AND mov_delta.dwh_updated > delta_itm_mov.last_export_tmsp   						
                    
      INNER JOIN p_lew_process_ac.v_wfm_export_specification_2 expo_spec						
      ON delta_itm_mov.export_specification = expo_spec.export_specification						
      AND mov_delta.client_id = expo_spec.client_id    						
              
      GROUP BY mov_delta.client_id, mov_delta.item_sid, mov_delta.dwh_cal_dt, mov_delta.loc_sid_store 						
    ) AS delta						

  ON delta.client_id = mov.client_id						
  AND delta.loc_sid_store = mov.loc_sid_store						
  AND delta.dwh_cal_dt = mov.dwh_cal_dt						
  AND delta.item_sid = mov.item_sid						
                        
  UNION ALL		
      
  SELECT		
     mov.client_id
    ,mov.item_sid
    ,mov.dwh_cal_dt AS dat_formdate
    ,CAST(mov.dir_del_id AS VARCHAR(15))
    ,mov.loc_sid_store AS st_loc_sid	
    ,mov.loc_sid_wh AS wh_loc_sid
    ,mov.vat_id
    ,mov.order_area_cd
    ,mov.dayend_dt AS dat_dayend
    ,3                     -- deliverytype_id      in first select
    ,mov.case_qty  -- qty_case_del         in first select AS qty_case_dir_del  -- qty_case_del         in first select
    ,NULL                  -- qty_case_order       in first select
    ,mov.piece_qty -- qty_piece_del        in first select AS qty_piece_dir_del -- qty_piece_del        in first select
    ,NULL                  -- qty_piece_act_del    in first select
    ,NULL
    ,0 from_fvm
    ,mov.dwh_load_id AS load_id
  FROM p_lew_core_ac.v_item_direct_delivery_2 mov		
              
  INNER JOIN (						
  /* timestamp delta with key logic  */						
      SELECT 						
         mov_delta.client_id						
       , mov_delta.item_sid						
       , mov_delta.dwh_cal_dt						
       , mov_delta.loc_sid_store						
      FROM p_lew_core_ac.v_item_direct_delivery_2 mov_delta						
                  
      INNER JOIN p_lew_process_ac.v_wfm_last_export_2 delta_itm_mov						
         ON delta_itm_mov.process_name = 'export_wfm_store_delivery'						
        AND delta_itm_mov.process_specification = 'delta'						
        AND mov_delta.dwh_updated > delta_itm_mov.last_export_tmsp    						
                    
      INNER JOIN p_lew_process_ac.v_wfm_export_specification_2 expo_spec						
        ON delta_itm_mov.export_specification = expo_spec.export_specification						
        AND mov_delta.client_id = expo_spec.client_id    						
                  
      GROUP BY mov_delta.client_id, mov_delta.item_sid, mov_delta.dwh_cal_dt, mov_delta.loc_sid_store 						
  ) AS delta						

  ON delta.client_id = mov.client_id						
  AND delta.loc_sid_store = mov.loc_sid_store						
  AND delta.dwh_cal_dt = mov.dwh_cal_dt						
  AND delta.item_sid = mov.item_sid						


  UNION ALL		

  SELECT		
     mov.client_id
    ,mov.item_sid
    ,mov.dwh_cal_dt AS dat_formdate
    ,CAST(mov.fv_del_id AS VARCHAR(15))
    ,mov.loc_sid_store AS st_loc_sid
    ,mov.loc_sid_wh AS wh_loc_sid
    ,mov.vat_id
    ,mov.order_area_cd
    ,mov.dayend_dt AS dat_dayend
    ,4                     -- deliverytype_id       in first select
    ,mov.case_qty   -- qty_case_del          in first select AS qty_case_fv_del   -- qty_case_del          in first select
    ,NULL                  -- qty_case_order        in first select
    ,NULL                  -- qty_piece_del         in first select
    ,NULL                  -- qty_piece_act_del     in first select
    ,mov.case_size_dec AS case_size_real
    ,1 from_fvm
    ,mov.dwh_load_id AS load_id
  FROM p_lew_core_ac.v_item_fruits_vegetables_delivery_2 mov		

  INNER JOIN (						
  /* timestamp delta with key logic  */						
    SELECT 						
         mov_delta.client_id						
       , mov_delta.item_sid						
       , mov_delta.dwh_cal_dt						
       , mov_delta.loc_sid_store						
    FROM p_lew_core_ac.v_item_fruits_vegetables_delivery_2 mov_delta						
                
    INNER JOIN p_lew_process_ac.v_wfm_last_export_2 delta_itm_mov						
    ON delta_itm_mov.process_name = 'export_wfm_store_delivery'						
    AND delta_itm_mov.process_specification = 'delta'						
    AND mov_delta.dwh_updated > delta_itm_mov.last_export_tmsp    						
                  
    INNER JOIN p_lew_process_ac.v_wfm_export_specification_2 expo_spec						
    ON delta_itm_mov.export_specification = expo_spec.export_specification						
    AND mov_delta.client_id = expo_spec.client_id    						
                  
      GROUP BY mov_delta.client_id, mov_delta.item_sid, mov_delta.dwh_cal_dt, mov_delta.loc_sid_store 						
    ) AS delta						

  ON delta.client_id = mov.client_id						
  AND delta.loc_sid_store = mov.loc_sid_store						
  AND delta.dwh_cal_dt = mov.dwh_cal_dt						
  AND delta.item_sid = mov.item_sid						

  ) inner_unions				
              
  INNER JOIN p_lew_core_ac.v_location_2 loc				
  ON inner_unions.st_loc_sid = loc.loc_sid		
  AND inner_unions.client_id = loc.client_id		
  AND loc.wh_store_mark = 'A'		
          
  INNER JOIN p_lew_core_ac.v_item_2 item_2				
  ON inner_unions.item_sid = item.item_sid		
  AND  inner_unions.client_id = item.client_id		
          
  /* ""src_case_size"" aus der v_item_2 Tabelle wird bei Initialanlage ohne bekannter case_size mit -1 befuellt und in DWH2.0 nachtraeglich nicht korrigiert.					
    Enthaelt der Datensatz in t_item_2 -1 fuer src_case_size, muss die case_size aus dieser Tabelle bezogen (Siehe CASE BEDINGUNG FUER case_size Spalte im Selekt).			
  */				
  LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_skey_act_2 AS skey_act				
  ON inner_unions.client_id = skey_act.client_id		
  AND inner_unions.item_sid = skey_act.item_sid		
          
  INNER JOIN p_lew_core_ac.v_client_2 clients				
  ON  inner_unions.client_id = clients.client_id		
) row_result				
GROUP BY client_id,country_lidl_cd,store,receiptdate,item_2											
;						
						
/**** WARNING: MISSING DEPENDENT OBJECTS ""p_lew_core_ac.v_item_movement_record_2"", ""p_lew_core_ac.v_item_movement_record_pos_2"", ""p_lew_core_ac.v_location_2"", ""p_lew_core_ac.v_item_2"", ""p_lew_process_mstr_ac.v_wfm_export_config_2"", ""p_lew_core_ac.v_client_2"", ""p_lew_process_ac.v_wfm_export_core_delta_2"", ""p_lew_core_ac.v_store_form_2"", ""p_lew_process_ac.v_wfm_last_export_2"", ""p_lew_process_ac.v_wfm_export_specification_2"" ****/						
