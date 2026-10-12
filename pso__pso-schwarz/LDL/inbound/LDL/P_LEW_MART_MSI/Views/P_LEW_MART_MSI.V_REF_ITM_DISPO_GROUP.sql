CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_ITM_DISPO_GROUP as
         /* 	
         #DescStart# 	
         #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
         #SubjectAreas#: Artikelstamm 	
         #DescEnd# 	
         */	
         SELECT * FROM p_lew_core_ac.v_wawi_ref_itm_dispo_group	
         WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end	
         AND language_id = 7	
;