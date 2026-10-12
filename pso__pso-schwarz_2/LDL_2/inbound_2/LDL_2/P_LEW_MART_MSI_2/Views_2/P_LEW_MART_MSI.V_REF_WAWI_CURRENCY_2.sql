CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_WAWI_CURRENCY_2 as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Währung 	
   #DescEnd# 	
   */	
	
   SELECT	
   t1.client_id,	
   t1.currency_iso_cd,	
   t1.currency_nr,	
   t1.currency_sign1,	
   t1.currency_sign2,	
   t1.currency_tolerance,	
   t1.dat_valid_from,	
   t1.rate_currency_exchange	
	
    FROM p_lew_core_ac.v_wawi_ref_wawi_currency_2 AS t1_2;