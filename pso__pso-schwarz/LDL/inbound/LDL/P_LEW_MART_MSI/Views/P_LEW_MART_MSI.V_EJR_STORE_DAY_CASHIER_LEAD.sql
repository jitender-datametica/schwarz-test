CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_STORE_DAY_CASHIER_LEAD
   /*	
   #DescStart#	
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
   #DescEnd#	
   */	
   (	
     client_id	
    ,store_id	
    ,dat_formdate	
    ,val_shouldbe_turnover	
    ,cnt_customer	
    ,cnt_pos_total	
    ,val_servicetime	
    ,val_avg_purchase	
    ,val_pos_per_minute	
    ,val_pos_per_purchase	
   )	
   AS	
	
      SELECT	
         v.client_id,	
      v.store_id,	
      v.dat_formdate,	
      Sum(v.val_shouldbe_turnover)                                                                                    AS val_shouldbe_turnover,	
      Sum(v.cnt_customer)                                                                                             AS cnt_customer,	
      Sum(v.cnt_pos_total)                                                                                            AS cnt_pos_total,	
      Sum(v.val_servicetime)                                                                                          AS val_servicetime,	
      Cast(Sum(v.val_shouldbe_turnover) AS DECIMAL(38,8)) / CASE WHEN Cast(Sum(v.cnt_customer)    AS DECIMAL(38,8)) = 0 THEN null ELSE Cast(Sum(v.cnt_customer)    AS DECIMAL(38,8)) END AS val_avg_purchase,	
      Cast(Sum(v.cnt_pos_total)         AS DECIMAL(38,8)) / CASE WHEN Cast(Sum(v.val_servicetime) AS DECIMAL(38,8)) = 0 THEN null ELSE Cast(Sum(v.val_servicetime) AS DECIMAL(38,8)) END AS val_pos_per_minute,	
      Cast(Sum(v.cnt_pos_total)         AS DECIMAL(38,8)) / CASE WHEN Cast(Sum(v.cnt_customer)    AS DECIMAL(38,8)) = 0 THEN null ELSE Cast(Sum(v.cnt_customer)    AS DECIMAL(38,8)) END AS val_pos_per_purchase	
      FROM p_lew_mart_msi.v_ejr_store_day_cashier_stat AS v	
	
      GROUP BY v.client_id, v.store_id, v.dat_formdate	
;