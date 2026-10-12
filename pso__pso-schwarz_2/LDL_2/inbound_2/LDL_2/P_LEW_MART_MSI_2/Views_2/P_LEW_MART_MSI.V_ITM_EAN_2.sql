CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_EAN_2 as
   /* 	
   #DescStart# 	
   #$Revision: 6806 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Artikelstamm 	
   #DescEnd# 	
   */	
	
   SELECT	
   ean.client_id,	
   ean.item_sid AS item_id,	
   ean.ean_2,	
   ean.ean_item_desc,	
   ean.language_id	
    FROM p_lew_core_ac.v_wawi_itm_ean_2 ean_2	
   INNER JOIN p_lew_mart_msi.v_ref_user_language_2 AS lg	
   ON lower(current_USER) = lower(lg.db_user)	
   AND ean.language_id = lg.language_id	
   WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end	
;