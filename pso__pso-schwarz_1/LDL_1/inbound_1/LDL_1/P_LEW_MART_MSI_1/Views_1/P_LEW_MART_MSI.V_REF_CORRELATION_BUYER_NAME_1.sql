CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_CORRELATION_BUYER_NAME_1 as
      /* 	
      #DescStart# 	
      #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
      #SubjectAreas#: Einkäufer_views 	
      #DescEnd# 	
      */	
      SELECT	
      manager_desc,	
      manager_login,	
      buyer_desc,	
      buyer_short_desc,	
      buyer_login	
	
      FROM p_lew_core_ac.v_wawi_ref_correlation_buyer_name_1 AS rcv	
;