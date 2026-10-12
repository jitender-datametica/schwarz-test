CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_PRICE_DAY_2 as
   /*	
   #DescStart#	
   #$Revision: 9114 $, $LastChangedBy: aarnold $	
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
   #DescEnd#	
   */	
   SELECT	
   pr.client_id,	
   pr.item_id,	
   wh.src_wh_id AS wh_id,	
   pr.currency_iso_cd,	
   pg.position_article_sales_rep,	
   pg.article_sales_rep_desc,	
   pr.price_retail,	
   (pr.price_retail* 100/ CASE WHEN Cast(100 AS DECIMAL(19,5))+ref.pct_vat = 0 THEN null ELSE Cast(100 AS DECIMAL(19,5))+ref.pct_vat END) AS price_retail_net,	
   c.dat_calendar	
   FROM p_lew_mart_msi.v_itm_price_2 AS pr	
   INNER JOIN p_lew_mart_msi.v_cal_calendarday_2 AS c	
   ON c.dat_calendar BETWEEN pr.dat_rec_start AND pr.dat_rec_end	
   AND c.dat_calendar < Current_Date	
   INNER JOIN p_lew_core_ac.v_wawi_ref_pricegrp_2 AS pg	
   ON pr.client_id = pg.client_id	
   AND pr.pricegroup_id = pg.pricegroup_id	
   INNER JOIN p_lew_core_ac.v_wawi_org_wh_act_2 AS owa	
   ON pr.client_id = owa.client_id	
   AND owa.language_id = 7	
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh	
   ON wh.client_id = owa.client_id	
   AND wh.loc_sid_wh =  owa.wh_loc_sid	
   AND wh.dwh_actual_fg = 1	
   LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS ref	
   ON ref.client_id=pr.client_id	
   AND ref.vat_id=pr.vat_id	
   AND c.dat_calendar BETWEEN ref.dat_rec_start AND ref.dat_rec_end	
	
   WHERE c.dat_calendar BETWEEN pg.dat_valid_from AND pg.dat_valid_until	
   AND pg.position_article_sales_rep = 1	
;