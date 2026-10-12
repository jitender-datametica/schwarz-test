CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_SUBTOTAL_1 as
   /* 	
   #DescStart# 	
   #$Revision: 8128 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi) 	
   #DescEnd# 	
   */	
   SELECT	
      s.loc_sid AS store_id,	
   s.client_id AS client_id,	
   s.register_id AS pos_terminal_id,	
   s.dwh_cal_dt AS dat_formdate,	
   s.receipt_tmsp as time_receipt_ejr,	
   --Cast(Cast(Cast(s.receipt_tmsp AS DATE) AS TIMESTAMP) + (Cast(s.receipt_tmsp  AS TIME(6)) - TO_VARCHAR( TIME '00:00:00', 'HH24:MM_1:SS'))  AS TIME(0)) AS time_receipt_ejr,	
  	
  s.receipt_id AS orig_receipt_nr_ejr,	
   s.receiptline_nr AS orig_receipt_serial_nr_ejr,	
   s.timezone_id AS timezone_cd,	
   s.dwh_cal_dt AS dat_dayend,	
   s.cashier_id AS checker_id,	
   s.transaction_type_cd AS transactiontype_id,	
   Cast(SUBSTRING(Cast(s.transaction_begin_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP) AS timestamp_begin_ejr	
   FROM p_lew_core_ac.v_pos_ctrl_subtotal_1 s	
;