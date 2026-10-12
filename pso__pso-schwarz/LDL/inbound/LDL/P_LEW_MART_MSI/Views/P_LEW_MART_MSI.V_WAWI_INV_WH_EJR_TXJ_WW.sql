CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_WAWI_INV_WH_EJR_TXJ_WW as
      SELECT	
         dt_a.client_id,	
      dt_a.src_wh_id,	
      dt_a.inv_id,	
      dt_a.inv_start_date,	
      dt_a.inv_end_date,	
      dt_a.val_retail,	
      dt_a.val_retail_net	
	
      FROM	
      (	
        SELECT	
           inv1.client_id,	
      wh.src_wh_id,	
      inv1.inv_id,	
      inv2.dat_formdate+1       AS inv_start_date,	
      inv1.dat_formdate         AS inv_end_date,	
      Sum(agg.sales_gross_val)  AS val_retail,	
      Sum(agg.sales_net_val)    AS val_retail_net	
        -- the value has to be exchanged by using the standard join to the currency view	
        FROM	
        (	
          SELECT	
             client_id,	
      wh_loc_sid,	
      inv_id,	
      dat_formdate,	
      Rank ( ) Over (PARTITION BY client_id, wh_loc_sid ORDER   BY dat_formdate) AS sort	
          FROM p_lew_core_ac.v_wawi_inv_item_wh	
          WHERE inv_type = 'F'	
          GROUP BY	
             client_id	
            ,wh_loc_sid	
            ,inv_id	
            ,dat_formdate	
        ) inv1	
      LEFT OUTER JOIN	
      (	
        SELECT	
           client_id,	
      wh_loc_sid,	
      inv_id,	
      dat_formdate,	
      Rank ( ) Over (PARTITION BY client_id, wh_loc_sid ORDER   BY dat_formdate) AS sort	
          FROM p_lew_core_ac.v_wawi_inv_item_wh	
          WHERE inv_type = 'F'	
          GROUP BY	
             client_id	
            ,wh_loc_sid	
            ,inv_id	
            ,dat_formdate	
        ) inv2	
      ON inv1.client_id = inv2.client_id	
      AND inv1.wh_loc_sid = inv2.wh_loc_sid	
      AND inv1.sort = inv2.sort+1	
      INNER JOIN p_lew_core_ac.v_wawi_org_store_skey_act s	
      ON s.client_id = inv1.client_id	
      AND s.wh_loc_sid = inv1.wh_loc_sid	
      INNER JOIN p_lew_bil_ac.v_agg_pos_txj_wawi_store_day agg	
      ON agg.client_id = inv1.client_id	
      AND agg.loc_sid = s.st_loc_sid	
      AND agg.dwh_cal_dt BETWEEN inv2.dat_formdate+1 AND inv1.dat_formdate	
      INNER JOIN p_lew_bil_ac.v_warehouse AS wh	
      ON inv1.wh_loc_sid = wh.loc_sid_wh	
      AND inv1.client_id = wh.client_id	
      AND wh.dwh_actual_fg = 1	
      AND wh.active_fg = 1	
      AND wh.bges_active_fg = 1	
	
    GROUP BY	
       inv1.client_id	
      ,wh.src_wh_id	
      ,inv1.inv_id	
      ,inv2.dat_formdate+1	
      ,inv1.dat_formdate	
  ) AS dt_a	
;