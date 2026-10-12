CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_DST_TRANSACT_DEPOSIT_EAN as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi) 	
   #DescEnd# 	
   */	
   SELECT	
   DISTINCT	
   client_id,	
   store_id,	
   pos_terminal_id,	
   time_receipt_ejr,	
   dat_formdate,	
   orig_receipt_nr_ejr,	
   checker_id,	
   pfand_ean	
  FROM p_lew_mart_msi.v_ejr_transact_deposit_ean;