CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_EJR_RETURN_TEXT as
      /* 	
      #DescStart# 	
      #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
      #SubjectAreas#: Rückgaben 	
      #DescEnd# 	
      */	
      SELECT * FROM p_lew_core_ac.v_wawi_ref_ejr_return_text	
      WHERE dat_rec_end = DATE '9999-12-31';