create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_WFM.V_ITEMSALE_DAY_PERSIST_DELTA_2(
	CLIENT_ID,
	STORE,
	ITEM_2,
	RECEIPTDATE,
	SUM_QTY_WEIGHT,
	SUM_QTY_PIECE,
	SUM_TURNOVER_NET,
	TIMELASTSOLD,
	DISCOUNT_VALUE_NET,
	DISCOUNT_PIECES,
	DISCOUNT_TURNOVER_NET,
	DISCOUNT_WEIGHT_PIECE,
	DISCOUNT_PIECES_TXJ,
	DISCOUNT_PIECES_CASHPOINT,
	DISCOUNT_PIECES_SFO,
	DISCOUNT_UNITS,
	DISCOUNT_LW,
	DISCOUNT_EJR,
	LOAD_ID
) as
(SELECT
     ejr.client_id
    ,ejr.store
    ,ejr.item_2
    ,ejr.receiptdate
    ,ejr.sum_qty_weight
    ,ejr.sum_qty_piece
    ,ejr.sum_turnover_net
    ,ejr.timelastsold
    ,COALESCE (t2.discount_lw,0) AS discount_value_net
    ,COALESCE (t1.discount_units,0) AS discount_pieces
    ,ejr.discount_turnover_net
    ,ejr.discount_weight_piece
    ,COALESCE(txj.discount_pieces_txj, 0) AS discount_pieces_txj
    ,ejr.discount_pieces_cashpoint
    ,ejr.discount_pieces_sfo
    ,COALESCE (t1.discount_units,0) AS discount_units
    ,COALESCE (t2.discount_lw,0) AS discount_lw
    ,ROUND ((CASE WHEN COALESCE (t3.discount_ejr, 0)= 0 THEN 0 ELSE  COALESCE (t2.discount_lw, 0) / t3.discount_ejr END) *100,5) AS discount_ejr 
    ,NULL AS load_id
FROM (SELECT
          client_id                                       AS client_id
         ,store                                           AS store
         ,item_2                                            AS item_2
         ,receiptdate                                     AS receiptdate
         ,SUM(sum_qty_weight)                             AS sum_qty_weight
         ,SUM(sum_qty_piece)                              AS sum_qty_piece
         ,SUM(sum_turnover_net)                           AS sum_turnover_net
         ,MAX(timelastsold)                               AS timelastsold
         ,SUM(discount_value_net)                         AS discount_value_net
         ,SUM(discount_pieces)                            AS discount_pieces
         ,SUM(discount_turnover_net)                      AS discount_turnover_net
         ,SUM(discount_weight_piece)                      AS discount_weight_piece
         ,SUM(discount_pieces_pct)                        AS discount_pieces_cashpoint
         ,SUM(discount_pieces_sfo137*sum_qty_piece)       AS discount_pieces_sfo
      FROM (SELECT
                agg.client_id                                                               AS client_id
                ,loc.src_orig_store_nr                                                      AS store
                ,COALESCE(itmkey.dwh_orig_item_nr, itmkey.wawi_dwh_orig_item_nr)            AS item_2
                ,agg.dwh_cal_dt                                                             AS receiptdate
                ,CASE WHEN CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN agg.sales_weight_qty
                                          ELSE 0
                                     END <> 0
                THEN CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                THEN agg.sales_weight_qty
                ELSE 0
                END + CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                THEN agg.return_qty
                ELSE 0
                END + CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                THEN agg.sales_piece_qty
                ELSE 0
                END ELSE 0.000
                END                                                                                          AS sum_qty_weight
                ,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN agg.piece_weight_qty                     
                                          ELSE 0
                                     END + CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                THEN agg.return_piece_weight_qty
                ELSE 0
                END                                                                                          AS sum_qty_piece
                ,agg.sales_net_val + agg.return_net_val                                                      AS sum_turnover_net
                ,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN CAST(agg.last_sold_tmsp AS TIME)         
                                          ELSE NULL
                                     END                                                                     AS timelastsold
                ,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  
                                               AND agg.discount_weight_qty > 0
                                          THEN agg.discount_net_val * -1
                                          ELSE 0
                                     END                                                                     AS discount_value_net
                ,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  
                                               AND agg.discount_weight_qty > 0
                                          THEN agg.piece_weight_qty                     
                                          ELSE 0
                                     END                                                                     AS discount_pieces
                ,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  
                                               AND agg.discount_weight_qty > 0          
                                          THEN agg.sales_piece_qty + agg.sales_weight_qty - agg.return_qty
                                          ELSE 0
                                     END                                                                     AS discount_weight_piece
                ,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  
                                               AND agg.discount_weight_qty > 0
                                          THEN agg.piece_weight_qty                     
                                          ELSE 0
                                     END                                                                     AS qty_disc_piece_ejr_asis
                ,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  
                                               AND agg.discount_weight_qty > 0          
                                          THEN agg.sales_piece_qty + agg.sales_weight_qty - agg.return_qty
                                          ELSE 0
                                     END                                                                     AS qty_disc_weight_piece_ejr_asis
                ,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN agg.sales_piece_qty
                                          ELSE 0
                                     END                                                                     AS qty_piece_ejr_asis
                ,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN agg.return_qty
                                          ELSE 0
                                     END                                                                     AS qty_return_ejr_asis
                ,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN agg.sales_weight_qty
                                          ELSE 0
                                     END                                                                     AS qty_weight_ejr_asis
                ,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN CAST(agg.last_sold_tmsp AS TIME)         
                                          ELSE NULL
                                     END                                                                     AS time_last_sold_ejr_asis
                ,CASE WHEN     COALESCE(agg.discount_sid, -1) <> -1  
                                               AND agg.discount_weight_qty > 0
                                          THEN agg.discount_net_val * -1
                                          ELSE 0
                                     END                                                                     AS val_discount_net_ejr_asis
                ,agg.return_net_val                                                                          AS val_return_net_ejr_asis
                ,agg.sales_net_val                                                                           AS val_rtl_net_ejr_asis
                ,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN agg.piece_weight_qty                     
                                          ELSE 0
                                     END                                                                     AS qty_piece_weight_ejr_asis
                ,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN agg.return_piece_weight_qty
                                          ELSE 0
                                     END                                                                     AS qty_rt_piece_weight_ejr_asis
                ,CASE WHEN COALESCE(agg.discount_sid, -1) <> -1  
                                               AND agg.discount_weight_qty > 0
                                          THEN agg.discount_base_net_val + agg.discount_net_val
                                          ELSE 0
                                     END                                                                     AS discount_turnover_net
                ,CASE WHEN COALESCE(agg.discount_sid, -1) <> -1 AND COALESCE(dis.src_discount_pct, 0) > 0 
                                          THEN NVL(agg.piece_weight_qty, 0) 
                                          ELSE 0
                                     END                                                                     AS discount_pieces_pct
                ,CASE WHEN COALESCE(agg.discount_sid, -1) = -1       
                                          THEN NVL(sfo.sum_piece_qty_sfo137, 0)
                                          ELSE 0
                                     END                                                                     AS discount_pieces_sfo137
            FROM p_lew_bil_ac.v_agg_pos_store_item_day_2 agg
            
            
            INNER JOIN p_lew_core_ac.v_item_map_key_2 itmkey
            ON agg.client_id = itmkey.client_id
            AND agg.item_sid = itmkey.item_sid
            
            INNER JOIN p_lew_bil_ac.v_item_2 itm
            ON agg.client_id = itm.client_id
            AND agg.item_sid = itm.item_sid
            AND agg.dwh_cal_dt BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to
            
            INNER JOIN p_lew_bil_ac.v_store_2 loc
            ON agg.client_id = loc.client_id
            AND agg.loc_sid_store = loc.loc_sid_store
            AND agg.dwh_cal_dt BETWEEN loc.dwh_valid_from AND loc.dwh_valid_to

            
            INNER JOIN (SELECT
                            deltaview.client_id
                           ,deltaview.loc_sid
                           ,deltaview.dwh_cal_dt
                        FROM p_lew_process_ac.v_wfm_export_agg_delta_2 deltaview
                       WHERE deltaview.process_name          = 'export_wfm_itemsale_day_persist'
                         AND deltaview.process_specification = 'delta'
                         AND deltaview.aggregate_name        IN ('t_agg_pos_store_item_day_2','t_agg_store_day_item_sfo_2')
                         AND deltaview.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
                       GROUP BY  deltaview.client_id
                            ,deltaview.loc_sid
                            ,deltaview.dwh_cal_dt
                       ) AS delta_agg
             ON agg.client_id     = delta_agg.client_id
            AND agg.dwh_cal_dt    = delta_agg.dwh_cal_dt
            AND agg.loc_sid_store = delta_agg.loc_sid

            LEFT JOIN (SELECT 
                           client_id
                          ,loc_sid_store
                          ,item_sid
                          ,dwh_cal_dt
                          ,SUM(piece_qty) AS sum_piece_qty_sfo137
                       FROM p_lew_core.t_store_form_2 sfo
                       WHERE sfo_type_id    = 137
                         AND pcwo_reason_id = 5 
                       GROUP BY client_id
                               ,loc_sid_store
                               ,item_sid
                               ,dwh_cal_dt
                      ) AS sfo
             ON agg.client_id     = sfo.client_id
            AND agg.loc_sid_store = sfo.loc_sid_store
            AND agg.item_sid      = sfo.item_sid
            AND agg.dwh_cal_dt    = sfo.dwh_cal_dt

            LEFT JOIN p_lew_core.t_pos_discount_2 AS dis
             ON dis.client_id    = agg.client_id
            AND dis.discount_sid = agg.discount_sid
            AND dis.src_posart   = '@'

            
            WHERE agg.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1

            )aaa_2

GROUP BY client_id, store, item_2, receiptdate
)  ejr

LEFT JOIN (


SELECT
     client_ AS clients
    ,store AS store
    ,item_2 AS item_2
    ,receiptdate AS receiptdate
    ,SUM(discount_pieces_txj) AS discount_pieces_txj
FROM (SELECT
         t520.client_id AS client_
        ,org.src_orig_store_nr AS store
        ,CAST(t520.item_nr AS BIGINT) AS item_2
        ,t520.dwh_cal_dt AS receiptdate
        ,t520.sales_qty AS discount_pieces_txj
        ,sales_val / CASE WHEN COALESCE(sales_qty, 0) = 0 THEN 1 ELSE sales_qty END AS price
      FROM p_lew_core_ac.v_txj_520_2 t520

      JOIN p_lew_bil_ac.v_store_2 org
       ON org.client_id = t520.client_id
      AND org.loc_sid_store = t520.loc_sid
      AND t520.dwh_cal_dt BETWEEN org.dwh_valid_from AND org.dwh_valid_to

      
      INNER JOIN (SELECT
                     deltaview.client_id
                    ,deltaview.loc_sid
                    ,deltaview.dwh_cal_dt
                  FROM p_lew_process_ac.v_wfm_export_agg_delta_2 deltaview
                  WHERE deltaview.process_name          = 'export_wfm_itemsale_day_persist'
                    AND deltaview.process_specification = 'delta'
                    AND deltaview.aggregate_name        IN ('t_agg_pos_store_item_day_2','t_agg_store_day_item_sfo_2')
                  
                    AND deltaview.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
                  GROUP BY  deltaview.client_id
                          ,deltaview.loc_sid
                          ,deltaview.dwh_cal_dt
                 ) AS delta_txj
       ON t520.client_id    = delta_txj.client_id
      AND t520.dwh_cal_dt   = delta_txj.dwh_cal_dt
      AND t520.loc_sid      = delta_txj.loc_sid
      WHERE t520.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
      QUALIFY price < MAX(price)
      OVER (PARTITION BY t520.client_id, org.src_orig_store_nr, t520.item_nr, t520.dwh_cal_dt)
      ) b

GROUP BY client_, store, item_2, receiptdate
) txj
ON txj.clients = ejr.client_id
AND txj.store = ejr.store
AND txj.item_2 = ejr.item_2
AND txj.receiptdate = ejr.receiptdate







LEFT JOIN (

 
SELECT 

   client_         AS client_id
   ,store           AS store
   ,item_2            AS item_2
   ,receiptdate     AS receiptdate
   ,discount_units  AS discount_units


FROM (SELECT

  ab.client_id                                                      AS client_
  ,loc.src_orig_store_nr                                             AS store
  ,COALESCE(itmkey.dwh_orig_item_nr, itmkey.wawi_dwh_orig_item_nr)   AS item_2
  ,ab.booking_dat                                                   AS receiptdate 
  ,ROUND(SUM(COALESCE((CASE WHEN ab.sfotype_id IN (137, 147) AND ab.pcwo_reason_id IN (5) THEN ab.sfo_total_qty_asis ELSE 0 END),0)))                    AS discount_units 
  
  
  FROM P_LEW_BIL_AC.v_agg_store_day_item_sfo_asis_2 ab
  
  
        INNER JOIN p_lew_core_ac.v_item_map_key_2 itmkey
        ON ab.client_id = itmkey.client_id
        AND ab.item_sid = itmkey.item_sid
            
        INNER JOIN p_lew_bil_ac.v_item_2 itm
        ON ab.client_id = itm.client_id
        AND ab.item_sid = itm.item_sid
        AND ab.booking_dat BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to
  
        INNER JOIN p_lew_bil_ac.v_store_2 loc
        ON ab.client_id = loc.client_id
        AND ab.loc_sid_store = loc.loc_sid_store
        AND ab.booking_dat BETWEEN loc.dwh_valid_from AND loc.dwh_valid_to
		


      
      INNER JOIN (SELECT
                     deltaview.client_id
                    ,deltaview.loc_sid
                    ,deltaview.dwh_cal_dt
                  FROM p_lew_process_ac.v_wfm_export_agg_delta_2 deltaview
                  WHERE deltaview.process_name          = 'export_wfm_itemsale_day_persist'
                    AND deltaview.process_specification = 'delta'
                    AND deltaview.aggregate_name        IN ('t_agg_pos_store_item_day_2','t_agg_store_day_item_sfo_2')
                  
                    AND deltaview.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
                  GROUP BY  deltaview.client_id
                          ,deltaview.loc_sid
                          ,deltaview.dwh_cal_dt
                 ) AS delta_txj
       ON ab.client_id       =  delta_txj.client_id
      AND ab.booking_dat    = delta_txj.dwh_cal_dt
      AND ab.loc_sid_store   = delta_txj.loc_sid
      WHERE ab.booking_dat BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1

GROUP BY client_, store, item_2, receiptdate
) )t1_2

ON  t1.client_id   = ejr.client_id
AND t1.store       = ejr.store
AND t1.item_2        = ejr.item_2
AND t1.receiptdate = ejr.receiptdate





LEFT JOIN (

 
SELECT 
 client_                 AS client_id
 ,store                   AS store
 ,item_2                    AS item_2
 ,receiptdate             AS receiptdate
 ,discount_lw             AS discount_lw


FROM (SELECT

  ac.client_id                                                      AS client_
  ,loc.src_orig_store_nr                                             AS store
  ,COALESCE(itmkey.dwh_orig_item_nr, itmkey.wawi_dwh_orig_item_nr)   AS item_2
  ,ac.booking_dat                                                    AS receiptdate 
  ,SUM(ac.sfo_total_rtl_rl_net_val / w.rate_currency_exchange)       AS discount_lw
  
  
  FROM p_lew_bil.t_agg_store_day_item_sfo_2 ac
  
  
       INNER JOIN p_lew_core_ac.v_item_map_key_2 itmkey
        ON ac.client_id = itmkey.client_id
        AND ac.item_sid = itmkey.item_sid
		  
        INNER JOIN p_lew_bil_ac.v_item_2 itm
        ON ac.client_id = itm.client_id
        AND ac.item_sid = itm.item_sid
        AND ac.booking_dat BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to
  
        INNER JOIN p_lew_bil_ac.v_store_2 loc
        ON ac.client_id = loc.client_id
        AND ac.loc_sid_store = loc.loc_sid_store
        AND ac.booking_dat BETWEEN loc.dwh_valid_from AND loc.dwh_valid_to
		
		INNER JOIN p_lew_core.t_wawi_ref_client_currency_rate_2 AS w
		ON ac.client_id = w.client_id
        AND CURRENT_DATE BETWEEN w.dat_rec_start AND w.dat_rec_end	
		AND w.currency_iso_cd ='EUR'
		

      
      INNER JOIN (SELECT
                     deltaview.client_id
                    ,deltaview.loc_sid
                    ,deltaview.dwh_cal_dt
                  FROM p_lew_process_ac.v_wfm_export_agg_delta_2 deltaview
                  WHERE deltaview.process_name          = 'export_wfm_itemsale_day_persist'
                    AND deltaview.process_specification = 'delta'
                    AND deltaview.aggregate_name        IN ('t_agg_pos_store_item_day_2','t_agg_store_day_item_sfo_2')
                  
                    AND deltaview.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
                  GROUP BY  deltaview.client_id
                          ,deltaview.loc_sid
                          ,deltaview.dwh_cal_dt
                 ) AS delta_txj
       ON ac.client_id       =  delta_txj.client_id
      AND ac.booking_dat     = delta_txj.dwh_cal_dt
      AND ac.loc_sid_store   = delta_txj.loc_sid
       

     WHERE ac.sfotype_id IN (137, 147)
     AND  ac.pcwo_reason_id IN (5)
     AND ac.booking_dat BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1

GROUP BY client_, store, item_2, receiptdate
) )t2

ON  t2.client_id   = ejr.client_id
AND t2.store       = ejr.store
AND t2.item_2        = ejr.item_2
AND t2.receiptdate = ejr.receiptdate





LEFT JOIN (
 
SELECT 
 client_            AS client_id
 ,store              AS store
 ,item_2               AS item_2
 ,receiptdate        AS receiptdate
 ,discount_ejr       AS discount_ejr


FROM (SELECT

  ad.client_id                                                                                     AS client_
  ,loc.src_orig_store_nr                                                                            AS store
  ,COALESCE(itmkey.dwh_orig_item_nr, itmkey.wawi_dwh_orig_item_nr)                                  AS item_2
  ,ad.dwh_cal_dt                                                                                    AS receiptdate 
  ,SUM(ad.sales_net_val / w.rate_currency_exchange + ad.return_net_val / w.rate_currency_exchange ) AS discount_ejr
   
  
 FROM p_lew_bil.t_agg_pos_store_item_day_2 ad
  
  
        INNER JOIN p_lew_core_ac.v_item_map_key_2 itmkey
        ON ad.client_id = itmkey.client_id
        AND ad.item_sid = itmkey.item_sid
		  
        INNER JOIN p_lew_bil_ac.v_item_2 itm
        ON ad.client_id = itm.client_id
        AND ad.item_sid = itm.item_sid
        AND ad.dwh_cal_dt BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to
  
        INNER JOIN p_lew_bil_ac.v_store_2 loc
        ON ad.client_id = loc.client_id
        AND ad.loc_sid_store = loc.loc_sid_store
        AND ad.dwh_cal_dt BETWEEN loc.dwh_valid_from AND loc.dwh_valid_to
		
		INNER JOIN p_lew_core.t_wawi_ref_client_currency_rate_2 AS w
		ON ad.client_id = w.client_id
        AND CURRENT_DATE BETWEEN w.dat_rec_start AND w.dat_rec_end	
		AND w.currency_iso_cd ='EUR'
		

      
      INNER JOIN (SELECT
                     deltaview.client_id
                    ,deltaview.loc_sid
                    ,deltaview.dwh_cal_dt
                  FROM p_lew_process_ac.v_wfm_export_agg_delta_2 deltaview
                  WHERE deltaview.process_name          = 'export_wfm_itemsale_day_persist'
                  AND deltaview.process_specification   = 'delta'
                    AND deltaview.aggregate_name        IN ('t_agg_pos_store_item_day_2','t_agg_store_day_item_sfo_2')
                  
                    AND deltaview.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
                  GROUP BY  deltaview.client_id
                          ,deltaview.loc_sid
                          ,deltaview.dwh_cal_dt
                 ) AS delta_txj
      ON  ad.client_id       =  delta_txj.client_id
      AND ad.dwh_cal_dt      = delta_txj.dwh_cal_dt
      AND ad.loc_sid_store   = delta_txj.loc_sid
      WHERE ad.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
GROUP BY client_, store, item_2, receiptdate
) )t3

ON t3.client_id     = ejr.client_id
AND t3.store        = ejr.store
AND t3.item_2         = ejr.item_2
AND t3.receiptdate  = ejr.receiptdate

)
;
